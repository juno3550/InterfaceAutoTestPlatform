from django.contrib import admin
from .import models


class ProjectAdmin(admin.ModelAdmin):
    list_display = ("id", "name", "proj_owner", "test_owner", "dev_owner", "desc", "create_time", "update_time")

admin.site.register(models.Project, ProjectAdmin)


class ModuleAdmin(admin.ModelAdmin):
    list_display = ("id", "name", "belong_project", "test_owner", "desc", "create_time", "update_time")

admin.site.register(models.Module, ModuleAdmin)


class TestCaseAdmin(admin.ModelAdmin):
    list_display = (
        "id", "case_name", "belong_project", "belong_module", "request_data", "uri", "assert_key", "maintainer",
        "extract_var", "request_method", "status", "created_time", "updated_time", "user")

admin.site.register(models.TestCase, TestCaseAdmin)


class CaseSuiteAdmin(admin.ModelAdmin):
    list_display = ("id", "suite_desc", "creator", "create_time")

admin.site.register(models.CaseSuite, CaseSuiteAdmin)


class InterfaceServerAdmin(admin.ModelAdmin):
    list_display = ("id", "env", "ip", "port", "remark", "create_time")

admin.site.register(models.InterfaceServer, InterfaceServerAdmin)
