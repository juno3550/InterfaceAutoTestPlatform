from django.db import models
from smart_selects.db_fields import GroupedForeignKey  # pip install django-smart-selects：后台级联选择
from django.contrib.auth.models import User


# 项目
class Project(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField('项目名称', max_length=50, unique=True, null=False)
    proj_owner = models.CharField('项目负责人', max_length=20, null=False)
    test_owner = models.CharField('测试负责人', max_length=20, null=False)
    dev_owner = models.CharField('开发负责人', max_length=20, null=False)
    desc = models.CharField('项目描述', max_length=100, null=True)
    create_time = models.DateTimeField('项目创建时间', auto_now_add=True)
    update_time = models.DateTimeField('项目更新时间', auto_now=True, null=True)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = '项目信息表'
        verbose_name_plural = '项目信息表'


# 模块
class Module(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField('模块名称', max_length=50, null=False)
    belong_project = models.ForeignKey(Project, on_delete=models.CASCADE)
    test_owner = models.CharField('测试负责人', max_length=50, null=False)
    desc = models.CharField('简要描述', max_length=100, null=True)
    create_time = models.DateTimeField('创建时间', auto_now_add=True)
    update_time = models.DateTimeField('更新时间', auto_now=True, null=True)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = '模块信息表'
        verbose_name_plural = '模块信息表'


# 测试用例
class TestCase(models.Model):
    id = models.AutoField(primary_key=True)
    case_name = models.CharField('用例名称', max_length=50, null=False)  # 如 register
    belong_project = models.ForeignKey(Project, on_delete=models.CASCADE, verbose_name='所属项目')
    belong_module = GroupedForeignKey(Module, "belong_project", on_delete=models.CASCADE, verbose_name='所属模块')
    request_data = models.CharField('请求数据', max_length=1024, null=False, default='')
    uri = models.CharField('接口地址', max_length=1024, null=False, default='')
    assert_key = models.CharField('断言内容', max_length=1024, null=True)
    maintainer = models.CharField('编写人员', max_length=1024, null=False, default='')
    extract_var = models.CharField('提取变量表达式', max_length=1024, null=True)  # 示例：userid||userid": (\d+)
    request_method = models.CharField('请求方式', max_length=1024, null=True)
    status = models.IntegerField(null=True, help_text="0：表示有效，1：表示无效，用于软删除")
    created_time = models.DateTimeField('创建时间', auto_now_add=True)
    updated_time = models.DateTimeField('更新时间', auto_now=True, null=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name='责任人', null=True)

    def __str__(self):
        return self.case_name

    class Meta:
        verbose_name = '测试用例表'
        verbose_name_plural = '测试用例表'


# 用例集合
class CaseSuite(models.Model):
    id = models.AutoField(primary_key=True)
    suite_desc = models.CharField('用例集合描述', max_length=100, blank=True, null=True)
    if_execute = models.IntegerField(verbose_name='是否执行', null=False, default=0, help_text='0：执行；1：不执行')
    test_case_model = models.CharField('测试执行模式', max_length=100, blank=True, null=True, help_text='data/keyword')
    creator = models.CharField(max_length=50, blank=True, null=True)
    create_time = models.DateTimeField('创建时间', auto_now=True)  # 创建时间-自动获取当前时间

    class Meta:
        verbose_name = "用例集合表"
        verbose_name_plural = '用例集合表'


# 用例集合关联用例
class SuiteCase(models.Model):
    id = models.AutoField(primary_key=True)
    case_suite = models.ForeignKey(CaseSuite, on_delete=models.CASCADE, verbose_name='用例集合')
    test_case = models.ForeignKey(TestCase, on_delete=models.CASCADE, verbose_name='测试用例')
    status = models.IntegerField(verbose_name='是否有效', null=False, default=1, help_text='0：有效，1：无效')
    create_time = models.DateTimeField('创建时间', auto_now=True)  # 创建时间-自动获取当前时间


# 接口服务器配置
class InterfaceServer(models.Model):
    id = models.AutoField(primary_key=True)
    env = models.CharField('环境', max_length=50, null=False, default='')
    ip = models.CharField('ip', max_length=50, null=False, default='')
    port = models.CharField('端口', max_length=100, null=False, default='')
    remark = models.CharField('备注', max_length=100, null=True)
    create_time = models.DateTimeField('创建时间', auto_now_add=True)
    update_time = models.DateTimeField('更新时间', auto_now=True, null=True)

    def __str__(self):
        return self.env

    class Meta:
        verbose_name = '接口地址配置表'
        verbose_name_plural = '接口地址配置表'


# 测试用例执行记录
class TestCaseExecuteResult(models.Model):
    id = models.AutoField(primary_key=True)
    belong_test_case = GroupedForeignKey(TestCase, "belong_test_case", on_delete=models.CASCADE, verbose_name='所属用例')
    status = models.IntegerField(null=True, help_text="0：表示未执行，1：表示已执行")
    exception_info = models.CharField(max_length=2048, blank=True, null=True)
    request_data = models.CharField('请求体', max_length=1024, null=True)  # {"code": "00", "userid": 22889}
    response_data = models.CharField('响应字符串', max_length=1024, null=True)  # {"code": "00", "userid": 22889}
    execute_result = models.CharField('执行结果', max_length=1024, null=True)  # 成功/失败
    extract_var = models.CharField('关联参数', max_length=1024, null=True)  # 响应成功后提取变量
    last_time_response_data = models.CharField('上一次响应字符串', max_length=1024, null=True)  # {"code": "00", "userid": 22889}
    execute_total_time = models.CharField('执行耗时', max_length=1024, null=True)
    execute_start_time = models.CharField('执行开始时间', max_length=300, blank=True, null=True)
    execute_end_time = models.CharField('执行结束时间', max_length=300, blank=True, null=True)
    created_time = models.DateTimeField('创建时间', auto_now_add=True)
    updated_time = models.DateTimeField('更新时间', auto_now=True, null=True)

    def __str__(self):
        return str(self.id)

    class Meta:
        verbose_name = '用例执行结果记录表'
        verbose_name_plural = '用例执行结果记录表'


# 用例集合的执行记录
class CaseSuiteExecuteRecord(models.Model):
    id = models.AutoField(primary_key=True)
    case_suite = models.ForeignKey(CaseSuite, on_delete=models.CASCADE, verbose_name='测试集合')
    run_time_interval = models.IntegerField(verbose_name='延迟时间', null=True, default=0)
    status = models.IntegerField(verbose_name='执行状态', null=True, default=0)
    test_result = models.CharField(max_length=50, blank=True, null=True)
    creator = models.CharField(max_length=50, blank=True, null=True)
    create_time = models.DateTimeField('创建时间', auto_now=True)   # 创建时间-自动获取当前时间
    execute_start_time = models.CharField('执行开始时间', max_length=300, blank=True, null=True)


# 用例集合下的用例执行记录
class CaseSuiteTestCaseExecuteRecord(models.Model):
    id = models.AutoField(primary_key=True)
    case_suite_record = models.ForeignKey(CaseSuiteExecuteRecord, on_delete=models.CASCADE, verbose_name='测试集合执行记录')
    test_case = models.ForeignKey(TestCase, on_delete=models.CASCADE, verbose_name='测试用例')
    status = models.IntegerField(verbose_name='执行状态', null=True, default=0)
    exception_info = models.CharField(max_length=2048, blank=True, null=True)
    request_data = models.CharField('请求体', max_length=1024, null=True)  # {"code": "00", "userid": 22889}
    response_data = models.CharField('响应字符串', max_length=1024, null=True)  # {"code": "00", "userid": 22889}
    execute_result = models.CharField('执行结果', max_length=1024, null=True)  # 成功/失败
    extract_var = models.CharField('关联参数', max_length=1024, null=True)  # 响应成功后提取变量
    last_time_response_data = models.CharField('上一次响应字符串', max_length=1024,
                                               null=True)  # {"code": "00", "userid": 22889}
    execute_total_time = models.CharField('执行耗时', max_length=1024, null=True)
    execute_start_time = models.CharField('执行开始时间', max_length=300, blank=True, null=True)
    execute_end_time = models.CharField('执行结束时间', max_length=300, blank=True, null=True)
