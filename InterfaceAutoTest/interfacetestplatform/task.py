from __future__ import absolute_import, unicode_literals
from celery import shared_task
import time
import os
import traceback
import json
from . import models
from .utils.data_process import data_preprocess, assert_result, data_postprocess
from .utils.request_process import request_process


# 测试用例执行
@shared_task
def case_task(test_case_id_list, server_address):
    global_key = 'case' + str(int(time.time() * 100000))
    os.environ[global_key] = '{}'
    print()
    print("全局变量标识符【global_key】: {}".format(global_key))
    print("全局变量内容【os.environ[global_key]】: {}".format(os.environ[global_key]))
    for test_case_id in test_case_id_list:

        test_case = models.TestCase.objects.filter(id=int(test_case_id))[0]
        last_execute_record_data = models.TestCaseExecuteResult.objects.filter(
            belong_test_case_id=test_case_id).order_by('-id')
        if last_execute_record_data:
            last_time_execute_response_data = last_execute_record_data[0].response_data
        else:
            last_time_execute_response_data = ''
        print("上一次响应结果: {}".format(last_execute_record_data))
        print("上一次响应时间: {}".format(last_time_execute_response_data))
        execute_record = models.TestCaseExecuteResult.objects.create(belong_test_case=test_case)
        execute_record.last_time_response_data = last_time_execute_response_data
        # 获取当前用例上一次执行结果
        execute_record.save()

        test_case = models.TestCase.objects.filter(id=int(test_case_id))[0]
        print("\n######### 开始执行用例【{}】 #########".format(test_case))
        execute_start_time = time.time()  # 记录时间戳，便于计算总耗时（毫秒）
        execute_record.execute_start_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(execute_start_time))

        request_data = test_case.request_data
        extract_var = test_case.extract_var
        assert_key = test_case.assert_key
        interface_name = test_case.uri
        belong_project = test_case.belong_project
        belong_module = test_case.belong_module
        maintainer = test_case.maintainer
        request_method = test_case.request_method
        print("初始请求数据: {}".format(request_data))
        print("关联参数: {}".format(extract_var))
        print("断言关键字: {}".format(assert_key))
        print("接口名称: {}".format(interface_name))
        print("所属项目: {}".format(belong_project))
        print("所属模块: {}".format(belong_module))
        print("用例维护人: {}".format(maintainer))
        print("请求方法: {}".format(request_method))
        url = "{}{}".format(server_address, interface_name)
        print("接口地址: {}".format(url))
        code, request_data, error_msg = data_preprocess(global_key, str(request_data))
        # 请求数据预处理异常，结束用例执行
        if code != 0:
            print("数据处理异常，error: {}".format(error_msg))
            execute_record.execute_result = "失败"
            execute_record.status = 1
            execute_record.exception_info = error_msg
            execute_end_time = time.time()
            execute_record.execute_end_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(execute_end_time))
            execute_record.execute_total_time = int(execute_end_time - execute_start_time) * 1000
            execute_record.save()
            return
        # 记录请求预处理结果
        else:
            execute_record.request_data = request_data
        # 调用接口
        try:
            res_data = request_process(url, request_method, json.loads(request_data))
            print("响应数据: {}".format(json.dumps(res_data.json(), ensure_ascii=False)))  # ensure_ascii：兼容中文
            result_flag, exception_info = assert_result(res_data, assert_key)
            # 结果记录保存
            if result_flag:
                print("用例【%s】执行成功！" % test_case)
                execute_record.execute_result = "成功"
                if extract_var.strip() != "None":
                    var_value = data_postprocess(global_key, json.dumps(res_data.json(), ensure_ascii=False), extract_var)
                    execute_record.extract_var = var_value
            else:
                print("用例【%s】执行失败！" % test_case)
                execute_record.execute_result = "失败"
                execute_record.exception_info = exception_info
            execute_record.response_data = json.dumps(res_data.json(), ensure_ascii=False)
            execute_record.status = 1
            execute_end_time = time.time()
            execute_record.execute_end_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(execute_end_time))
            print("执行结果结束时间: {}".format(execute_record.execute_end_time))
            execute_record.execute_total_time = int((execute_end_time - execute_start_time) * 1000)
            print("用例执行耗时: {}".format(execute_record.execute_total_time))
            execute_record.save()
        except Exception as e:
            print("接口请求异常，error: {}".format(traceback.format_exc()))
            execute_record.execute_result = "失败"
            execute_record.exception_info = traceback.format_exc()
            execute_record.status = 1
            execute_end_time = time.time()
            execute_record.execute_end_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(execute_end_time))
            print("执行结果结束时间: {}".format(execute_record.execute_end_time))
            execute_record.execute_total_time = int(execute_end_time - execute_start_time) * 1000
            print("用例执行耗时: {} 毫秒".format(execute_record.execute_total_time))
            execute_record.save()


# 用例集合执行
@shared_task
def suite_task(case_suite_record, case_suite, server_address):
    global_key = case_suite.suite_desc + str(int(time.time() * 100000))
    # global_vars = {"{}".format(global_key): {}}
    os.environ[global_key] = '{}'
    print("global_key: {}".format(global_key))
    print("os.environ[global_key]: {}".format(os.environ[global_key]))
    case_suite_test_cases = models.SuiteCase.objects.filter(case_suite=case_suite).order_by('id')
    print("用例集合的测试用例列表: {}".format(case_suite_test_cases))
    case_suite_record.test_result = "成功"
    case_suite_record.execute_start_time = time.strftime("%Y-%m-%d %H:%M:%S")

    for case_suite_test_case in case_suite_test_cases:
        test_case = case_suite_test_case.test_case
        print("\n######### 开始执行用例【{}】 #########".format(test_case))
        last_execute_record_data = models.CaseSuiteTestCaseExecuteRecord.objects.filter(
            test_case_id=test_case.id).order_by('-id')
        if last_execute_record_data:
            last_time_execute_response_data = last_execute_record_data[0].response_data
        else:
            last_time_execute_response_data = ''
        print("上一次响应结果: {}".format(last_execute_record_data))
        print("上一次响应时间: {}".format(last_time_execute_response_data))
        suite_case_execute_record = models.CaseSuiteTestCaseExecuteRecord.objects.create(case_suite_record=case_suite_record,
                                                                                  test_case=test_case)
        execute_start_time = time.time()  # 记录时间戳，便于计算总耗时（毫秒）
        suite_case_execute_record.execute_start_time = time.strftime("%Y-%m-%d %H:%M:%S",
                                                                     time.localtime(execute_start_time))
        print("用例集合开始执行时间: {}".format(suite_case_execute_record.execute_start_time))
        suite_case_execute_record.last_time_response_data = last_time_execute_response_data
        suite_case_execute_record.save()
        request_data = test_case.request_data
        extract_var = test_case.extract_var
        assert_key = test_case.assert_key
        interface_name = test_case.uri
        belong_project = test_case.belong_project
        belong_module = test_case.belong_module
        maintainer = test_case.maintainer
        request_method = test_case.request_method
        print("初始请求数据: {}".format(request_data))
        print("关联参数: {}".format(extract_var))
        print("断言关键字: {}".format(assert_key))
        print("接口名称: {}".format(interface_name))
        print("所属项目: {}".format(belong_project))
        print("所属模块: {}".format(belong_module))
        print("用例维护人: {}".format(maintainer))
        print("请求方法: {}".format(request_method))
        url = "{}{}".format(server_address, interface_name)
        print("接口地址: {}".format(url))
        # 请求数据预处理
        code, request_data, error_msg = data_preprocess(global_key, str(request_data))
        # 请求数据预处理异常，结束用例执行
        if code != 0:
            print("数据处理异常，error: {}".format(error_msg))
            suite_case_execute_record.execute_result = "失败"
            suite_case_execute_record.status = 1
            suite_case_execute_record.exception_info = error_msg
            execute_end_time = time.time()
            suite_case_execute_record.execute_end_time = time.strftime("%Y-%m-%d %H:%M:%S",
                                                                       time.localtime(execute_end_time))
            suite_case_execute_record.execute_total_time = int(execute_end_time - execute_start_time) * 1000
            suite_case_execute_record.save()
            case_suite_record.test_result = "失败"
        # 记录请求预处理的结果
        suite_case_execute_record.request_data = request_data
        try:
            # 调用接口
            res_data = request_process(url, request_method, json.loads(request_data))
            print("响应数据: {}".format(json.dumps(res_data.json(), ensure_ascii=False)))

            result_flag, exception_info = assert_result(res_data, assert_key)
            # 结果记录保存
            if result_flag:
                print("用例【%s】执行成功！" % test_case)
                suite_case_execute_record.execute_result = "成功"
                if extract_var.strip() != "None":
                    var_value = data_postprocess(global_key, json.dumps(res_data.json(), ensure_ascii=False),
                                                 extract_var)
                    suite_case_execute_record.extract_var = var_value
            else:
                print("用例【%s】执行失败！" % test_case)
                suite_case_execute_record.execute_result = "失败"
                suite_case_execute_record.exception_info = exception_info
                case_suite_record.test_result = "失败"
            suite_case_execute_record.response_data = json.dumps(res_data.json(), ensure_ascii=False)
            suite_case_execute_record.status = 1
            execute_end_time = time.time()
            suite_case_execute_record.execute_end_time = time.strftime("%Y-%m-%d %H:%M:%S",
                                                                       time.localtime(execute_end_time))
            suite_case_execute_record.execute_total_time = int((execute_end_time - execute_start_time) * 1000)
            print("用例执行耗时: {} 毫秒".format(
                suite_case_execute_record.execute_total_time))
            suite_case_execute_record.save()
        except Exception as e:
            print("接口请求异常，error: {}".format(e))
            suite_case_execute_record.execute_result = "失败"
            suite_case_execute_record.exception_info = traceback.format_exc()
            suite_case_execute_record.status = 1
            execute_end_time = time.time()
            suite_case_execute_record.execute_end_time = time.strftime("%Y-%m-%d %H:%M:%S",
                                                                       time.localtime(execute_end_time))
            suite_case_execute_record.execute_total_time = int(execute_end_time - execute_start_time) * 1000
            print("用例集合执行总耗时: {} 毫秒".format(suite_case_execute_record.execute_total_time))
            suite_case_execute_record.save()
            case_suite_record.test_result = "失败"

    case_suite_record.status = 1  # 执行完毕
    case_suite_record.save()
