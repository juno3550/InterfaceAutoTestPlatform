from django.urls import path, re_path
from . import views


urlpatterns = [
    path('', views.index),
    path('login/', views.login),
    path('logout/', views.logout),
    path('project/', views.project, name='project'),
    path('module/', views.module, name='module'),
    path('test_case/', views.test_case, name="test_case"),
    re_path('test_case_detail/(?P<test_case_id>[0-9]+)', views.test_case_detail, name="test_case_detail"),
    re_path('module_test_cases/(?P<module_id>[0-9]+)/$', views.module_test_cases, name="module_test_cases"),
    path('case_suite/', views.case_suite, name="case_suite"),
    re_path('add_case_in_suite/(?P<suite_id>[0-9]+)', views.add_case_in_suite, name="add_case_in_suite"),
    re_path('show_and_delete_case_in_suite/(?P<suite_id>[0-9]+)', views.show_and_delete_case_in_suite, name="show_and_delete_case_in_suite"),
    path('test_case_execute_record/', views.test_case_execute_record, name="test_case_execute_record"),
    re_path('case_result_diff/(?P<test_record_id>[0-9]+)', views.case_result_diff, name="case_result_diff"),
    re_path('show_exception/(?P<execute_id>[0-9]+)$', views.show_exception, name="show_exception"),
    path('case_suite_execute_record/', views.case_suite_execute_record, name="case_suite_execute_record"),
    re_path('suite_case_execute_record/(?P<suite_record_id>[0-9]+)', views.suite_case_execute_record, name="suite_case_execute_record"),
    re_path('suite_case_result_diff/(?P<suite_case_record_id>[0-9]+)', views.suite_case_result_diff, name="suite_case_result_diff"),
    re_path('suite_case_exception/(?P<suite_case_record_id>[0-9]+)', views.suite_case_exception, name="suite_case_exception"),
    re_path('suite_case_statistics/(?P<suite_id>[0-9]+)', views.suite_case_statistics, name="suite_case_statistics"),
    re_path('case_suite_statistics/(?P<suite_id>[0-9]+)', views.case_suite_statistics, name="case_suite_statistics"),
    re_path('module_statistics/(?P<module_id>[0-9]+)', views.module_statistics, name="module_statistics"),
    re_path('project_statistics/(?P<project_id>[0-9]+)', views.project_statistics, name="project_statistics"),
]