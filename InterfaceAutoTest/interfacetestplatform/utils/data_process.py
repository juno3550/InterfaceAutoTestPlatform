import re
import hashlib
import os
import json
import traceback
import redis
from InterfaceAutoTest.settings import redis_port


# 连接redis
pool = redis.ConnectionPool(host='127.0.0.1', port=redis_port, decode_responses=True)
redis_obj = redis.Redis(connection_pool=pool)


# 初始化框架工程中的全局变量，存储在测试数据中的唯一值数据
# 框架工程中若要使用字典中的任意一个变量，则每次使用后，均需要将字典中的value值进行加1操作。
def get_unique_number_value(unique_number):
    data = None
    try:
        redis_value = redis_obj.get(unique_number)  # {"unique_number"：666}
        if redis_value:
            data = redis_value
            print("全局唯一数当前生成的值是：%s" % data)
            # 把redis中key为unique_number的值进行加一操作，以便下提取时保持唯一
            redis_obj.set(unique_number, int(redis_value) + 1)
        else:
            data = 20300  # 初始化递增数值
            redis_obj.set(unique_number, data)
    except Exception as e:
        print("获取全局唯一数变量值失败，请求的全局唯一数变量是%s,异常原因如下：%s" % (unique_number, traceback.format_exc()))
        data = None
    finally:
        return data


def md5(s):
    m5 = hashlib.md5()
    m5.update(s.encode("utf-8"))
    md5_value = m5.hexdigest()
    return md5_value


# 请求数据预处理：参数化、函数化
# 将请求数据中包含的${变量名}的字符串部分，替换为唯一数或者全局变量字典中对应的全局变量
def data_preprocess(global_key, requestData):
    try:
        # 匹配注册用户名参数，即"${unique_num...}"的格式，并取出本次请求的随机数供后续接口的用户名参数使用
        if re.search(r"\$\{unique_num\d+\}", requestData):
            var_name = re.search(r"\$\{(unique_num\d+)\}", requestData).group(1)  # 获取用户名参数
            print("用户名变量：%s" % var_name)
            var_value = get_unique_number_value(var_name)
            print("用户名变量值：%s" % var_value)
            requestData = re.sub(r"\$\{unique_num\d+\}", str(var_value), requestData)
            var_name = var_name.split("_")[1]
            print("关联的用户名变量：%s" % var_name)
            # "xxxkey" ："{'var_name'：var_value}"
            global_var = json.loads(os.environ[global_key])
            global_var[var_name] = var_value
            os.environ[global_key] = json.dumps(global_var)
            print("用户名唯一数参数化后的全局变量【os.environ[global_key]】：{}".format(os.environ[global_key]))
        # 函数化，如密码加密"${md5(...)}"的格式
        if re.search(r"\$\{\w+\(.+\)\}", requestData):
            var_pass = re.search(r"\$\{(\w+\(.+\))\}", requestData).group(1)  # 获取密码参数
            print("需要函数化的变量：%s" % var_pass)
            print("函数化后的结果：%s" % eval(var_pass))
            requestData = re.sub(r"\$\{\w+\(.+\)\}", eval(var_pass), requestData)  # 将requestBody里面的参数内容通过eval修改为实际变量值
            print("函数化后的请求数据：%s" % requestData)  # requestBody是拿到的请求时发送的数据
        # 其余变量参数化
        if re.search(r"\$\{(\w+)\}", requestData):
            print("需要参数化的变量：%s" % (re.findall(r"\$\{(\w+)\}", requestData)))
            for var_name in re.findall(r"\$\{(\w+)\}", requestData):
                requestData = re.sub(r"\$\{%s\}" % var_name, str(json.loads(os.environ[global_key])[var_name]), requestData)
        print("变量参数化后的最终请求数据：%s" % requestData)
        print("数据参数后的最终全局变量【os.environ[global_key]】：{}".format(os.environ[global_key]))
        return 0, requestData, ""
    except Exception as e:
        print("请求数据预处理发生异常，error：{}".format(traceback.format_exc()))
        return 1, {}, traceback.format_exc()


# 响应数据提取关联参数
def data_postprocess(global_key, response_data, extract_var):
    print("需提取的关联变量：%s" % extract_var)
    var_name = extract_var.split("||")[0]
    print("关联变量名：%s" % var_name)
    regx_exp = extract_var.split("||")[1]
    print("关联变量正则：%s" % regx_exp)
    if re.search(regx_exp, response_data):
        global_vars = json.loads(os.environ[global_key])
        print("关联前的全局变量：{}".format(global_vars))
        var_value = re.search(regx_exp, response_data).group(1)
        global_vars[var_name] = var_value
        os.environ[global_key] = json.dumps(global_vars)
        print("关联前的全局变量：{}".format(os.environ[global_key]))
    return var_name+"："+var_value


# 响应数据 断言处理
def assert_result(response_obj, key_word):
    try:
        # 多个断言关键字
        if '&&' in key_word:
            key_word_list = key_word.split('&&')
            print("断言关键字列表：%s" % key_word_list)
            # 断言结果标识符
            flag = True
            exception_info = ''
            # 遍历分隔出来的断言关键词列表
            for key_word in key_word_list:
                # 如果断言词非空，则进行断言
                if key_word:
                    # 没查到断言词则认为是断言失败
                    if not (key_word in json.dumps(response_obj.json(), ensure_ascii=False)):
                        print("断言关键字【{}】匹配失败".format(key_word))
                        flag = False  # 只要有一个断言词匹配失败，则整个接口断言失败
                        exception_info = "keyword：{} not matched from response, assert failed".format(key_word)
                    else:
                        print("断言关键字【{}】匹配成功".format(key_word))
            if flag:
                print("接口断言成功！")
            else:
                print("接口断言失败！")
            return flag, exception_info
        # 单个断言关键字
        else:
            if key_word in json.dumps(response_obj.json(), ensure_ascii=False):
                print("接口断言【{}】匹配成功！".format(key_word))
                return True, ''
            else:
                print("接口断言【{}】匹配失败！".format(key_word))
                return False, ''
    except Exception as e:
        return False, traceback.format_exc()


# 测试代码
if __name__ == "__main__":
    print(get_unique_number_value("unique_num1"))
