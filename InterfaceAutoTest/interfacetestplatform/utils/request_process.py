import requests
import json
# from Util.Log import logger


# 此函数封装了get请求、post和put请求的方法
def request_process(url, request_method, request_content):
    print("-------- 开始调用接口 --------")
    if request_method == "get":
        try:
            if isinstance(request_content, dict):
                print("接口地址：%s" % url)
                print("请求数据：%s" % request_content)
                r = requests.get(url, params=json.dumps(request_content))
            else:
                r = requests.get(url+str(request_content))
                print("接口地址：%s" % r.url)
                print("请求数据：%s" % request_content)

        except Exception as e:
            print("get方法请求发生异常：请求的url是%s, 请求的内容是%s\n发生的异常信息如下：%s" % (url, request_content, e))
            r = None
        return r
    elif request_method == "post":
        try:
            if isinstance(request_content, dict):
                print("接口地址：%s" % url)
                print("请求数据：%s" % json.dumps(request_content))
                r = requests.post(url, data=json.dumps(request_content))
            else:
                raise ValueError
        except ValueError as e:
            print("post方法请求发生异常：请求的url是%s, 请求的内容是%s\n发生的异常信息如下：%s" % (url, request_content, "请求参数不是字典类型"))
            r = None
        except Exception as e:
            print("post方法请求发生异常：请求的url是%s, 请求的内容是%s\n发生的异常信息如下：%s" % (url, request_content, e))
            r = None
        return r
    elif request_method == "put":
        try:
            if isinstance(request_content, dict):
                print("接口地址：%s" % url)
                print("请求数据：%s" % json.dumps(request_content))
                r = requests.put(url,  data=json.dumps(request_content))
            else:
                raise ValueError
        except ValueError as e:
            print("put方法请求发生异常：请求的url是%s, 请求的内容是%s\n发生的异常信息如下：%s" % (url,  request_content, "请求参数不是字典类型"))
            r = None
        except Exception as e:
            print("put方法请求发生异常：请求的url是%s, 请求的内容是%s\n发生的异常信息如下：%s" % (url, request_content, e))
            r = None
        return r
