from django.shortcuts import render, redirect, HttpResponse
from django.contrib import auth  # Django用户认证（Auth）组件一般用在用户的登录注册上，用于判断当前的用户是否合法
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator, PageNotAnInteger, InvalidPage
from .form import UserForm
import traceback
import json
from . import models
from .task import case_task, suite_task


# 封装分页处理
def get_paginator(request, data):
    paginator = Paginator(data, 10)  # 默认每页展示10条数据
    # 获取 url 后面的 page 参数的值, 首页不显示 page 参数, 默认值是 1
    page = request.GET.get('page')
    try:
        paginator_pages = paginator.page(page)
    except PageNotAnInteger:
        # 如果请求的页数不是整数, 返回第一页。
        paginator_pages = paginator.page(1)
    except InvalidPage:
        # 如果请求的页数不存在, 重定向页面
        return HttpResponse('找不到页面的内容')
    return paginator_pages


# 项目菜单项
@login_required
def project(request):
    print("request.user.is_authenticated: ", request.user.is_authenticated)
    projects = models.Project.objects.filter().order_by('-id')
    print("projects:", projects)
    return render(request, 'project.html', {'projects': get_paginator(request, projects)})


# 模块菜单项
@login_required
def module(request):
    if request.method == "GET":  # 请求get时候，id倒序查询所有的模块数据
        modules = models.Module.objects.filter().order_by('-id')
        return render(request, 'module.html', {'modules': get_paginator(request, modules)})
    else:  # 否则就是Post请求，会根据输入内容，使用模糊的方式查找所有的项目
        proj_name = request.POST['proj_name']
        projects = models.Project.objects.filter(name__contains=proj_name.strip())
        projs = [proj.id for proj in projects]
        modules = models.Module.objects.filter(belong_project__in=projs)  # 把项目中所有的模块都找出来
        return render(request, 'module.html', {'modules': get_paginator(request, modules), 'proj_name': proj_name})


# 获取测试用例执行的接口地址
def get_server_address(env):
    if env:  # 环境处理
        env_data = models.InterfaceServer.objects.filter(env=env[0])
        print("env_data: {}".format(env_data))
        if env_data:
            ip = env_data[0].ip
            port = env_data[0].port
            print("ip: {}, port: {}".format(ip, port))
            server_address = "http://{}:{}".format(ip, port)
            print("server_address: {}".format(server_address))
            return server_address
        else:
            return ""
    else:
        return ""


# 测试用例菜单项
@login_required
def test_case(request):
    print("request.session['is_login']: {}".format(request.session['is_login']))
    test_cases = ""
    if request.method == "GET":
        test_cases = models.TestCase.objects.filter().order_by('id')
        print("testcases: {}".format(test_cases))
    elif request.method == "POST":
        print("request.POST: {}".format(request.POST))
        test_case_id_list = request.POST.getlist('test_cases_list')
        env = request.POST.getlist('env')
        print("env: {}".format(env))
        server_address = get_server_address(env)
        if not server_address:
            return HttpResponse("提交的运行环境为空，请选择环境后再提交！")
        if test_case_id_list:
            test_case_id_list.sort()
            print("test_case_id_list: {}".format(test_case_id_list))
            print("获取到用例，开始用例执行")
            # 普通执行
            # case_task(test_case_id_list, server_address)
            # celery 执行
            case_task.apply_async((test_case_id_list, server_address))
        else:
            print("运行测试用例失败")
            return HttpResponse("提交的运行测试用例为空，请选择用例后在提交！")
        test_cases = models.TestCase.objects.filter().order_by('id')
    return render(request, 'test_case.html', {'test_cases': get_paginator(request, test_cases)})


# 用例详情页
@login_required
def test_case_detail(request, test_case_id):
    test_case_id = int(test_case_id)
    test_case = models.TestCase.objects.get(id=test_case_id)
    print("test_case: {}".format(test_case))
    print("test_case.id: {}".format(test_case.id))
    print("test_case.belong_project: {}".format(test_case.belong_project))

    return render(request, 'test_case_detail.html', {'test_case': test_case})


# 模块页展示测试用例
@login_required
def module_test_cases(request, module_id):
    module = ""
    if module_id:  # 访问的时候，会从url中提取模块的id，根据模块id查询到模块数据，在模板中展现
        module = models.Module.objects.get(id=int(module_id))
    test_cases = models.TestCase.objects.filter(belong_module=module).order_by('-id')
    print("test_case in module_test_cases: {}".format(test_cases))
    return render(request, 'test_case.html', {'test_cases': get_paginator(request, test_cases)})


# 用例集合菜单项
@login_required
def case_suite(request):
    if request.method == "POST":
        count_down_time = 0
        if request.POST['delay_time']:
            print("输入的延迟时间是: {}".format(request.POST['delay_time']))
            try:
                count_down_time = int(request.POST['delay_time'])
            except:
                print("输入的延迟时间是非数字！")
        else:
            print("没有输入延迟时间")
        env = request.POST.getlist('env')
        print("env: {}".format(env))
        server_address = get_server_address(env)
        if not server_address:
            return HttpResponse("提交的运行环境为空，请选择环境后再提交！")
        case_suite_list = request.POST.getlist('case_suite_list')
        if case_suite_list:
            print("所需执行的用例集合列表：", case_suite_list)
            for suite_id in case_suite_list:
                test_suite = models.CaseSuite.objects.get(id=int(suite_id))
                print("所需执行的用例集合: {}".format(test_suite))
                username = request.user.username
                test_suite_record = models.CaseSuiteExecuteRecord.objects.create(case_suite=test_suite,
                                                                               run_time_interval=count_down_time,
                                                                               creator=username)
                # 普通执行
                # suite_task(test_suite_record, test_suite, server_address)
                # celery 执行
                suite_task.apply_async((test_suite_record, test_suite, server_address), countdown=count_down_time)
        else:
            print("运行测试集合用例失败")
            return HttpResponse("运行的测试集合为空，请选择测试集合后再运行！")
    case_suites = models.CaseSuite.objects.filter()
    return render(request, 'case_suite.html', {'case_suites': get_paginator(request, case_suites)})


# 用例集合-添加测试用例页
@login_required
def add_case_in_suite(request, suite_id):
    # 查询指定的用例集合
    case_suite = models.CaseSuite.objects.get(id=suite_id)
    # 根据id号查询所有的用例
    test_cases = models.TestCase.objects.filter().order_by('id')
    if request.method == "GET":
        print("test cases:", test_cases)
    elif request.method == "POST":
        test_cases_list = request.POST.getlist('testcases_list')
        # 如果页面勾选了用例
        if test_cases_list:
            print("勾选用例id：", test_cases_list)
            # 根据页面勾选的用例与查询出的所有用例一一比较
            for test_case in test_cases_list:
                test_case = models.TestCase.objects.get(id=int(test_case))
                # 匹配成功则添加用例
                models.SuiteCase.objects.create(case_suite=case_suite, test_case=test_case)
        # 未勾选用例
        else:
            print("添加测试用例失败")
            return HttpResponse("添加的测试用例为空，请选择用例后再添加！")
    return render(request, 'add_case_in_suite.html',
          {'test_cases': get_paginator(request, test_cases), 'case_suite': case_suite})


# 用例集合页-查看/删除用例
@login_required
def show_and_delete_case_in_suite(request, suite_id):
    case_suite = models.CaseSuite.objects.get(id=suite_id)
    test_cases = models.SuiteCase.objects.filter(case_suite=case_suite)
    if request.method == "POST":
        test_cases_list = request.POST.getlist('test_cases_list')
        if test_cases_list:
            print("勾选用例：", test_cases_list)
            for test_case in test_cases_list:
                test_case = models.TestCase.objects.get(id=int(test_case))
                models.SuiteCase.objects.filter(case_suite=case_suite, test_case=test_case).first().delete()
        else:
            print("测试用例删除失败")
            return HttpResponse("所选测试用例为空，请选择用例后再进行删除！")
    case_suite = models.CaseSuite.objects.get(id=suite_id)
    return render(request, 'show_and_delete_case_in_suite.html',
                  {'test_cases': get_paginator(request, test_cases), 'case_suite': case_suite})


# 用例执行结果-菜单项
@login_required
def test_case_execute_record(request):
    test_case_execute_records = models.TestCaseExecuteResult.objects.filter().order_by('-id')
    return render(request, 'test_case_execute_records.html', {'test_case_execute_records':
                                                                  get_paginator(request, test_case_execute_records)})


# 用例执行结果-对比差异
@login_required
def case_result_diff(request, test_record_id):
    test_record_data = models.TestCaseExecuteResult.objects.get(id=test_record_id)
    print("用例执行结果记录: {}".format(test_record_data))
    present_response = test_record_data.response_data
    if present_response:
        present_response = json.dumps(json.loads(present_response), sort_keys=True, indent=4,
                                      ensure_ascii=False)  # 中文字符不转ascii编码
        print("当前响应结果: {}".format(present_response))
    last_time_execute_response = test_record_data.last_time_response_data
    if last_time_execute_response:
        last_time_execute_response = json.dumps(json.loads(last_time_execute_response), sort_keys=True, indent=4,
                                                ensure_ascii=False)
    print("上一次响应结果: {}".format(last_time_execute_response))
    return render(request, 'case_result_diff.html', locals())


# 用例执行结果-异常信息展示
@login_required
def show_exception(request, execute_id):
    test_record = models.TestCaseExecuteResult.objects.get(id=execute_id)
    return render(request, 'show_exception.html', {'exception_info': test_record.exception_info})


# 用例集合执行结果
@login_required
def case_suite_execute_record(request):
    case_suite_execute_record = models.CaseSuiteExecuteRecord.objects.filter().order_by('-id')
    return render(request, 'case_suite_execute_record.html',
                  {'case_suite_execute_records': get_paginator(request, case_suite_execute_record)})


# 用例集合执行结果-包含用例结果展示
@login_required
def suite_case_execute_record(request, suite_record_id):
    case_suite_execute_record = models.CaseSuiteExecuteRecord.objects.get(id=suite_record_id)
    suite_case_execute_records = models.CaseSuiteTestCaseExecuteRecord.objects.filter(case_suite_record=case_suite_execute_record)
    return render(request, 'suite_case_execute_record.html',
                  {'suite_case_execute_records': get_paginator(request, suite_case_execute_records)})


# 用例集合执行结果-包含用例结果展示-差异比对
@login_required
def suite_case_result_diff(request, suite_case_record_id):
    suite_record_data = models.CaseSuiteTestCaseExecuteRecord.objects.get(id=suite_case_record_id)
    present_response = suite_record_data.response_data
    if present_response:
        present_response = json.dumps(json.loads(present_response),sort_keys=True, indent=4, ensure_ascii=False)
        print("当前响应: {}".format(present_response))
    last_time_execute_response = suite_record_data.last_time_response_data
    if last_time_execute_response:
        last_time_execute_response = json.dumps(json.loads(last_time_execute_response), sort_keys=True,
                                                indent=4, ensure_ascii=False)
    print("上一次响应: {}".format(last_time_execute_response))
    return render(request, 'case_result_diff.html', locals())


# 用例集合执行结果-包含用例结果展示-异常信息展示
@login_required
def suite_case_exception(request, suite_case_record_id):
    test_record = models.CaseSuiteTestCaseExecuteRecord.objects.get(id=suite_case_record_id)
    return render(request, 'show_exception.html', {'exception_info': test_record.exception_info})


# 用例集合执行结果单次统计
def suite_case_statistics(request, suite_id):
    success_num = len(models.CaseSuiteTestCaseExecuteRecord.objects.filter(case_suite_record=suite_id, execute_result="成功"))
    fail_num = len(models.CaseSuiteTestCaseExecuteRecord.objects.filter(case_suite_record=suite_id, execute_result="失败"))
    suite_case_records = models.CaseSuiteTestCaseExecuteRecord.objects.filter(case_suite_record=suite_id).order_by('-id')
    return render(request, 'suite_case_statistics.html',
                  {'suite_case_records': get_paginator(request, suite_case_records), 'success_num': success_num,
                   'fail_num': fail_num})


# 用例集合执行结果历史统计
def case_suite_statistics(request, suite_id):
    case_suite = models.CaseSuite.objects.get(id=suite_id)
    success_num = len(models.CaseSuiteExecuteRecord.objects.filter(case_suite=case_suite, test_result="成功"))
    fail_num = len(models.CaseSuiteExecuteRecord.objects.filter(case_suite=case_suite, test_result="失败"))
    case_suite_records = models.CaseSuiteExecuteRecord.objects.filter(case_suite=case_suite).order_by('-id')
    return render(request, 'case_suite_statistics.html',
                  {'case_suite_records': get_paginator(request, case_suite_records), 'success_num': success_num,
                   'fail_num': fail_num})


# 模块测试结果统计
@login_required
def module_statistics(request, module_id):
    test_module = models.Module.objects.get(id=int(module_id))
    test_cases = models.TestCase.objects.filter(belong_module=test_module)
    test_suit_success_num = len(
        models.CaseSuiteTestCaseExecuteRecord.objects.filter(test_case__in=test_cases, execute_result="成功"))
    test_suit_fail_num = len(
        models.CaseSuiteTestCaseExecuteRecord.objects.filter(test_case__in=test_cases, execute_result="失败"))
    test_case_success_num = len(
        models.TestCaseExecuteResult.objects.filter(belong_test_case__in=test_cases, execute_result="成功"))
    test_case_fail_num = len(
        models.TestCaseExecuteResult.objects.filter(belong_test_case__in=test_cases, execute_result="失败"))
    success_num = test_suit_success_num + test_case_success_num
    fail_num = test_suit_fail_num + test_case_fail_num
    return render(request, 'module_statistics.html',
                  {'test_module': test_module, 'success_num': success_num, 'fail_num': fail_num})


# 项目测试结果统计
@login_required
def project_statistics(request, project_id):
    test_project = models.Project.objects.get(id=int(project_id))
    test_cases = models.TestCase.objects.filter(belong_project=test_project)
    test_suit_success_num = len(
        models.CaseSuiteTestCaseExecuteRecord.objects.filter(test_case__in=test_cases, execute_result="成功"))
    test_suit_fail_num = len(
        models.CaseSuiteTestCaseExecuteRecord.objects.filter(test_case__in=test_cases, execute_result="失败"))
    test_case_success_num = len(
        models.TestCaseExecuteResult.objects.filter(belong_test_case__in=test_cases, execute_result="成功"))
    test_case_fail_num = len(
        models.TestCaseExecuteResult.objects.filter(belong_test_case__in=test_cases, execute_result="失败"))
    success_num = test_suit_success_num + test_case_success_num
    fail_num = test_suit_fail_num + test_case_fail_num
    return render(request, 'project_statistics.html',
                  {'test_project': test_project, 'success_num': success_num, 'fail_num': fail_num})


# 默认页的视图函数
@login_required
def index(request):
    return render(request, 'index.html')


# 登录页的视图函数
def login(request):
    print("request.session.items(): {}".format(request.session.items()))  # 打印session信息
    if request.session.get('is_login', None):
        return redirect('/')
    # 如果是表单提交行为，则进行登录校验
    if request.method == "POST":
        login_form = UserForm(request.POST)
        message = "请检查填写的内容！"
        if login_form.is_valid():
            username = login_form.cleaned_data['username']
            password = login_form.cleaned_data['password']
            try:
                # 使用django提供的身份验证功能
                user = auth.authenticate(username=username, password=password)  # 从auth_user表中匹配信息，匹配到则返回用户对象
                if user is not None:
                    print("用户【%s】登录成功" % username)
                    auth.login(request, user)
                    request.session['is_login'] = True
                    # 登录成功，跳转主页
                    return redirect('/')
                else:
                    message = "用户名不存在或者密码不正确！"
            except:
                traceback.print_exc()
                message = "登录程序出现异常"
        # 用户名或密码为空，返回登录页和错误提示信息
        else:
            return render(request, 'login.html', locals())
    # 不是表单提交，代表只是访问登录页
    else:
        login_form = UserForm()
        return render(request, 'login.html', locals())


# 注册页的视图函数
def register(request):
    return render(request, 'register.html')


# 登出的视图函数：重定向至login视图函数
@login_required
def logout(request):
    auth.logout(request)
    request.session.flush()
    return redirect("/login/")
