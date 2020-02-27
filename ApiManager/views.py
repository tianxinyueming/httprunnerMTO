import json
import logging
import os
import shutil
import sys

import paramiko
import requests
from django.http import HttpResponse, HttpResponseRedirect, JsonResponse, StreamingHttpResponse
from django.shortcuts import render_to_response
from djcelery.models import PeriodicTask
from dwebsocket import accept_websocket

from ApiManager import devops_api
from ApiManager import separator
from ApiManager.models import ProjectInfo, ModuleInfo, TestCaseInfo, UserInfo, EnvInfo, TestReports, DebugTalk, \
    TestSuite, ServiceConfig, ServiceConfigDetail, TestCaseLogicInfo
from ApiManager.tasks import main_hrun, asyn_execute_case, batch_main_hrun
from ApiManager.utils import case_cache
from ApiManager.utils.common import module_info_logic, project_info_logic, case_info_logic, config_info_logic, \
    set_filter_session, get_ajax_msg, register_info_logic, task_logic, load_modules, upload_file_logic, \
    init_filter_session, get_total_values, timestamp_to_datetime, run_request_case,logic_test_case
from ApiManager.utils.operation import env_data_logic, del_module_data, del_project_data, del_test_data, copy_test_data, \
    del_report_data, add_suite_data, copy_suite_data, del_suite_data, edit_suite_data, add_test_reports, \
    validate_operate, add_service_config_data, update_service_config_data, del_service_config_data, \
    copy_service_config_data, del_test_logic_data, copy_test_logic_data
from ApiManager.utils.pagination import get_pager_info
from ApiManager.utils.runner import run_by_batch, run_test_by_type, run_by_single2, run_by_service, run_by_logic_test
from ApiManager.utils.task_opt import delete_task, change_task_status
from ApiManager.utils.testcase import get_time_stamp
from httprunner import HttpRunner
from django.core.cache import cache
from httprunnerMTO.settings import SERVER_URL

from httprunner.task_extend import HttpRunner_ext

logger = logging.getLogger('httprunnerMTO')

# Create your views here.



def login_check(func):
    def wrapper(request, *args, **kwargs):
        if not request.session.get('login_status'):
            return HttpResponseRedirect('/api/login/')
        return func(request, *args, **kwargs)

    return wrapper


def login(request):
    """
    登录
    :param request:
    :return:
    """
    if request.method == 'POST':
        username = request.POST.get('account')
        password = request.POST.get('password')

        result = UserInfo.objects.filter(username__exact=username).filter(password__exact=password)
        if result.count() == 1:
            userinfo = result.values()[0]

            logger.info('{username} 登录成功'.format(username=username))
            request.session["login_status"] = True
            request.session["now_account"] = username
            request.session['user_type'] = userinfo.get('user_type')
            return HttpResponseRedirect('/api/index/')
        else:
            logger.info('{username} 登录失败, 请检查用户名或者密码'.format(username=username))
            request.session["login_status"] = False
            return render_to_response("login.html")
    elif request.method == 'GET':
        return render_to_response("login.html")


def register(request):
    """
    注册
    :param request:
    :return:
    """
    if request.is_ajax():
        user_info = json.loads(request.body.decode('utf-8'))
        msg = register_info_logic(**user_info)
        return HttpResponse(get_ajax_msg(msg, '恭喜您，账号已成功注册'))
    elif request.method == 'GET':
        return render_to_response("register.html")


@login_check
def log_out(request):
    """
    注销登录
    :param request:
    :return:
    """
    if request.method == 'GET':
        logger.info('{username}退出'.format(username=request.session['now_account']))
        try:
            del request.session['now_account']
            del request.session['login_status']
            del request.session['user_type']
            init_filter_session(request, type=False)
        except KeyError:
            logging.error('session invalid')
        return HttpResponseRedirect("/api/login/")


@login_check
def index(request):
    """
    首页
    :param request:
    :return:
    """
    project_length = ProjectInfo.objects.count()
    module_length = ModuleInfo.objects.count()
    test_length = TestCaseInfo.objects.filter(type__exact=1).count()
    suite_length = TestSuite.objects.count()

    total = get_total_values()
    manage_info = {
        'project_length': project_length,
        'module_length': module_length,
        'test_length': test_length,
        'suite_length': suite_length,
        'account': request.session["now_account"],
        'total': total
    }

    init_filter_session(request)
    return render_to_response('index.html', manage_info)


@login_check
def add_project(request):
    """
    新增项目
    :param request:
    :return:
    """
    account = request.session["now_account"]
    if request.is_ajax():
        project_info = json.loads(request.body.decode('utf-8'))
        project_info['creator'] = account
        msg = project_info_logic(**project_info)
        return HttpResponse(get_ajax_msg(msg, '/api/project_list/1/'))

    elif request.method == 'GET':
        manage_info = {
            'account': account,
            'configs': TestCaseInfo.objects.filter(type=2).order_by('-create_time')
        }
        return render_to_response('add_project.html', manage_info)


@login_check
def add_module(request):
    """
    新增模块
    :param request:
    :return:
    """
    account = request.session["now_account"]
    if request.is_ajax():
        module_info = json.loads(request.body.decode('utf-8'))
        module_info['creator'] = account
        msg = module_info_logic(**module_info)
        return HttpResponse(get_ajax_msg(msg, '/api/module_list/1/'))
    elif request.method == 'GET':
        manage_info = {
            'account': account,
            'data': ProjectInfo.objects.all().values('project_name'),
            'configs': TestCaseInfo.objects.filter(type=2).order_by('-create_time')
        }
        return render_to_response('add_module.html', manage_info)


@login_check
def add_case(request):
    """
    新增用例
    :param request:
    :return:
    """
    account = request.session["now_account"]
    if request.is_ajax():
        testcase_info = json.loads(request.body.decode('utf-8'))
        msg = case_info_logic(**testcase_info)
        return HttpResponse(get_ajax_msg(msg, '/api/test_list/1/'))
    elif request.method == 'GET':
        query_data = {}
        devops_modules =devops_api.get_module(query_data).get('data')
        # devops_modules =[]
        manage_info = {
            'account': account,
            'project': ProjectInfo.objects.all().values('project_name').order_by('-create_time'),
            'env': EnvInfo.objects.all().order_by('-create_time'),
            'devops_modules': devops_modules
        }
        return render_to_response('add_case.html', manage_info)


@login_check
def add_config(request):
    """
    新增配置
    :param request:
    :return:
    """
    account = request.session["now_account"]
    if request.is_ajax():
        testconfig_info = json.loads(request.body.decode('utf-8'))
        msg = config_info_logic(**testconfig_info)
        return HttpResponse(get_ajax_msg(msg, '/api/config_list/1/'))
    elif request.method == 'GET':
        manage_info = {
            'account': account,
            'project': ProjectInfo.objects.all().values('project_name').order_by('-create_time')
        }
        return render_to_response('add_config.html', manage_info)


@login_check
def run_test(request):
    """
    运行用例
    :param request:
    :return:
    """
    account = request.session["now_account"]

    kwargs = {
        "failfast": False,
    }
    runner = HttpRunner(**kwargs)

    testcase_dir_path = os.path.join(os.getcwd(), "suite")
    testcase_dir_path = os.path.join(testcase_dir_path, get_time_stamp())

    if request.is_ajax():
        request_data = json.loads(request.body.decode('utf-8'))
        # report_name = kwargs.get('report_name', None)
        main_hrun.delay(testcase_dir_path, account, request_data)
        return HttpResponse('用例执行中，请稍后查看报告即可,默认时间戳命名报告')
    else:
        id = request.POST.get('id')
        base_url = request.POST.get('env_name')
        type = request.POST.get('type', 'test')

        report_name = run_test_by_type(id, base_url, testcase_dir_path, type)
        runner.run2(testcase_dir_path)
        shutil.rmtree(testcase_dir_path)
        runner.summary = timestamp_to_datetime(runner.summary, type=False)

        add_test_reports(runner, report_name=report_name, report_type=type, executor=account)

        return render_to_response('report_template.html', runner.summary)


@login_check
def run_batch_test(request):
    """
    批量运行用例
    :param request:
    :return:
    """

    account = request.session["now_account"]

    kwargs = {
        "failfast": False,
    }
    runner = HttpRunner(**kwargs)

    testcase_dir_path = os.path.join(os.getcwd(), "suite")
    testcase_dir_path = os.path.join(testcase_dir_path, get_time_stamp())

    if request.is_ajax():
        request_data = json.loads(request.body.decode('utf-8'))
        batch_main_hrun.delay(testcase_dir_path, account, request_data)
        return HttpResponse('用例执行中，请稍后查看报告即可,默认时间戳命名报告')
    else:
        type = request.POST.get('type', None)
        base_url = request.POST.get('env_name')
        report_name = request.POST.get('report_name')
        test_list = request.body.decode('utf-8').split('&')
        if type:
            run_by_batch(test_list, base_url, testcase_dir_path, type=type, mode=True)
        else:
            run_by_batch(test_list, base_url, testcase_dir_path)

        runner.run2(testcase_dir_path)

        shutil.rmtree(testcase_dir_path)
        runner.summary = timestamp_to_datetime(runner.summary, type=False)

        if not report_name:
            report_name = '批量执行'
            if type == 'project':
                report_name = report_name + '项目'
            elif type == 'module':
                report_name = report_name + '模块'
            elif type == 'suite':
                report_name = report_name + '套件'
            elif type is None:
                report_name = report_name + '用例'

        if type is None:
            type = 'test'
        add_test_reports(runner, report_name=report_name, report_type=type, executor=account)

        return render_to_response('report_template.html', runner.summary)


@login_check
def project_list(request, id):
    """
    项目列表
    :param request:
    :param id: str or int：当前页
    :return:
    """

    account = request.session["now_account"]
    user_type = request.session['user_type']
    if request.is_ajax():
        project_info = json.loads(request.body.decode('utf-8'))
        project_info['account'] = account
        project_info['user_type'] = user_type
        if 'mode' in project_info.keys():
            msg = del_project_data(project_info.pop('id'), account, user_type)
        else:
            msg = project_info_logic(type=False, **project_info)
        return HttpResponse(get_ajax_msg(msg, 'ok'))
    else:
        filter_query = set_filter_session(request)
        project_name = request.POST.get('project_name')
        if project_name is None:
            project_name = ''
        filter_query['project_name'] = project_name
        pro_list = get_pager_info(
            ProjectInfo, filter_query, '/api/project_list/', id)
        manage_info = {
            'account': account,
            'project': pro_list[1],
            'projects': ProjectInfo.objects.all().order_by('-update_time'),
            'page_list': pro_list[0],
            'info': filter_query,
            'sum': pro_list[2],
            'env': EnvInfo.objects.all().order_by('-create_time'),
            'project_all': ProjectInfo.objects.all().order_by('-update_time'),
            'configs': TestCaseInfo.objects.filter(type=2).order_by('-create_time')
        }
        return render_to_response('project_list.html', manage_info)


@login_check
def module_list(request, id):
    """
    模块列表
    :param request:
    :param id: str or int：当前页
    :return:
    """
    account = request.session["now_account"]
    user_type = request.session['user_type']
    if request.is_ajax():
        module_info = json.loads(request.body.decode('utf-8'))
        module_info['account'] = account
        module_info['user_type'] = user_type
        if 'mode' in module_info.keys():  # del module
            msg = del_module_data(module_info.pop('id'), account, user_type)
        else:
            msg = module_info_logic(type=False, **module_info)
        return HttpResponse(get_ajax_msg(msg, 'ok'))
    else:
        filter_query = set_filter_session(request)
        module_list = get_pager_info(
            ModuleInfo, filter_query, '/api/module_list/', id)
        manage_info = {
            'account': account,
            'module': module_list[1],
            'page_list': module_list[0],
            'info': filter_query,
            'sum': module_list[2],
            'env': EnvInfo.objects.all().order_by('-create_time'),
            'project': ProjectInfo.objects.all().order_by('-update_time'),
            'configs': TestCaseInfo.objects.filter(type=2).order_by('-create_time')
        }
        return render_to_response('module_list.html', manage_info)


@login_check
def test_list(request, id):
    """
    用例列表
    :param request:
    :param id: str or int：当前页
    :return:
    """

    account = request.session["now_account"]
    user_type = request.session['user_type']
    if request.is_ajax():
        test_info = json.loads(request.body.decode('utf-8'))

        if test_info.get('mode') == 'del':
            msg = del_test_data(test_info.pop('id'), account, user_type)
        elif test_info.get('mode') == 'copy':
            msg = copy_test_data(test_info.get('data').pop('index'), test_info.get('data').pop('name'), account)
        return HttpResponse(get_ajax_msg(msg, 'ok'))

    else:
        filter_query = set_filter_session(request)

        if 'case_id' in request.POST.keys():
            filter_query['case_id'] = request.POST.get('case_id')
        if 'service_name' in request.POST.keys():
            filter_query['service_name'] = request.POST.get('service_name')

        test_list = get_pager_info(
            TestCaseInfo, filter_query, '/api/test_list/', id)
        manage_info = {
            'account': account,
            'test': test_list[1],
            'page_list': test_list[0],
            'info': filter_query,
            'env': EnvInfo.objects.all().order_by('-create_time'),
            'projects': ProjectInfo.objects.all().order_by('-update_time')
        }

        # 添加模块下拉
        modules = []
        if filter_query.get('belong_project') != 'All':
            modules = ModuleInfo.objects.filter(
                belong_project__project_name=filter_query.get('belong_project')).order_by('-create_time')

        manage_info['modules'] = modules

        return render_to_response('test_list.html', manage_info)


@login_check
def config_list(request, id):
    """
    配置列表
    :param request:
    :param id: str or int：当前页
    :return:
    """
    account = request.session["now_account"]
    user_type = request.session['user_type']
    if request.is_ajax():
        test_info = json.loads(request.body.decode('utf-8'))

        if test_info.get('mode') == 'del':
            msg = del_test_data(test_info.pop('id'), account, user_type)
        elif test_info.get('mode') == 'copy':
            msg = copy_test_data(test_info.get('data').pop('index'), test_info.get('data').pop('name'), account)
        return HttpResponse(get_ajax_msg(msg, 'ok'))
    else:
        filter_query = set_filter_session(request)
        test_list = get_pager_info(
            TestCaseInfo, filter_query, '/api/config_list/', id)
        manage_info = {
            'account': account,
            'test': test_list[1],
            'page_list': test_list[0],
            'info': filter_query,
            'project': ProjectInfo.objects.all().order_by('-update_time')
        }
        return render_to_response('config_list.html', manage_info)


@login_check
def edit_case(request, id=None):
    """
    编辑用例
    :param request:
    :param id:
    :return:
    """

    account = request.session["now_account"]
    user_type = request.session['user_type']
    if request.is_ajax():
        testcase_lists = json.loads(request.body.decode('utf-8'))
        tastcase = testcase_lists.get('test').get('name')
        author = tastcase.get('author')
        project = tastcase.get('project')
        module = tastcase.get('module')
        if not validate_operate(account, author, user_type, project, module):
            return HttpResponse(get_ajax_msg("非创建人或负责人不能修改,请检查", '/api/test_list/1/'))

        msg = case_info_logic(type=False, **testcase_lists)
        return HttpResponse(get_ajax_msg(msg, '/api/test_list/1/'))

    test_info = TestCaseInfo.objects.get_case_by_id(id)
    request = eval(test_info[0].request)
    include = eval(test_info[0].include)

    project = test_info[0].belong_project
    module = test_info[0].belong_module

    module_info = ModuleInfo.objects.filter(belong_project__project_name=project).order_by('-create_time')
    modules = list(module_info)

    case_info = TestCaseInfo.objects.filter(belong_project=project, belong_module=module, type=1).order_by('-create_time')
    cases = list(case_info)

    configs = TestCaseInfo.objects.filter(belong_project=project, belong_module=module, type=2).order_by('-create_time')
    configs = list(configs)
    query_data = {}
    devops_modules = devops_api.get_module(query_data).get('data')
    # devops_modules = []
    manage_info = {
        'account': account,
        'info': test_info[0],
        'request': request['test'],
        'include': include,
        'project': ProjectInfo.objects.all().values('project_name').order_by('-create_time'),
        'modules': modules,
        'cases': cases,
        'configs': configs,
        'env': EnvInfo.objects.all().order_by('-create_time'),
        'devops_modules': devops_modules
    }
    return render_to_response('edit_case.html', manage_info)


@login_check
def edit_config(request, id=None):
    """
    编辑配置
    :param request:
    :param id:
    :return:
    """

    account = request.session["now_account"]
    user_type = request.session['user_type']
    if request.is_ajax():
        testconfig_lists = json.loads(request.body.decode('utf-8'))
        tastcase = testconfig_lists.get('config').get('name')
        author = tastcase.get('author')
        project = tastcase.get('project')
        module = tastcase.get('module')
        if not validate_operate(account, author, user_type, project, module):
            return HttpResponse(get_ajax_msg("非创建人或负责人不能修改,请检查", '/api/test_list/1/'))

        msg = config_info_logic(type=False, **testconfig_lists)
        return HttpResponse(get_ajax_msg(msg, '/api/config_list/1/'))

    config_info = TestCaseInfo.objects.get_case_by_id(id)
    request = eval(config_info[0].request)
    manage_info = {
        'account': account,
        'info': config_info[0],
        'request': request['config'],
        'project': ProjectInfo.objects.all().values(
            'project_name').order_by('-create_time')
    }
    return render_to_response('edit_config.html', manage_info)


@login_check
def env_set(request):
    """
    环境设置
    :param request:
    :return:
    """

    account = request.session["now_account"]
    if request.is_ajax():
        env_lists = json.loads(request.body.decode('utf-8'))
        msg = env_data_logic(**env_lists)
        return HttpResponse(get_ajax_msg(msg, 'ok'))

    elif request.method == 'GET':
        return render_to_response('env_list.html', {'account': account})


@login_check
def env_list(request, id):
    """
    环境列表
    :param request:
    :param id: str or int：当前页
    :return:
    """

    account = request.session["now_account"]
    if request.method == 'GET':
        env_lists = get_pager_info(
            EnvInfo, None, '/api/env_list/', id)
        manage_info = {
            'account': account,
            'env': env_lists[1],
            'page_list': env_lists[0],
        }
        return render_to_response('env_list.html', manage_info)


@login_check
def report_list(request, id):
    """
    报告列表
    :param request:
    :param id: str or int：当前页
    :return:
    """
    account = request.session["now_account"]
    user_type = request.session['user_type']
    if request.is_ajax():
        report_info = json.loads(request.body.decode('utf-8'))

        if report_info.get('mode') == 'del':
            msg = del_report_data(report_info.pop('id'), account, user_type)
        return HttpResponse(get_ajax_msg(msg, 'ok'))
    else:
        filter_query = set_filter_session(request)

        report_list = get_pager_info(
            TestReports, filter_query, '/api/report_list/', id)
        manage_info = {
            'account': request.session["now_account"],
            'report': report_list[1],
            'page_list': report_list[0],
            'info': filter_query
        }
        return render_to_response('report_list.html', manage_info)


@login_check
def view_report(request, id):
    """
    查看报告
    :param request:
    :param id: str or int：报告名称索引
    :return:
    """
    reports = TestReports.objects.get(id=id)
    return HttpResponseRedirect(reports.path)


@login_check
def periodictask(request, id):
    """
    定时任务列表
    :param request:
    :param id: str or int：当前页
    :return:
    """

    account = request.session["now_account"]
    if request.is_ajax():
        kwargs = json.loads(request.body.decode('utf-8'))
        mode = kwargs.pop('mode')
        id = kwargs.pop('id')
        msg = delete_task(id) if mode == 'del' else change_task_status(id, mode)
        return HttpResponse(get_ajax_msg(msg, 'ok'))
    else:
        filter_query = set_filter_session(request)
        task_list = get_pager_info(
            PeriodicTask, filter_query, '/api/periodictask/', id)
        manage_info = {
            'account': account,
            'task': task_list[1],
            'page_list': task_list[0],
            'info': filter_query
        }
    return render_to_response('periodictask_list.html', manage_info)


@login_check
def add_task(request):
    """
    添加任务
    :param request:
    :return:
    """

    account = request.session["now_account"]
    if request.is_ajax():
        kwargs = json.loads(request.body.decode('utf-8'))
        kwargs['executor'] = account
        msg = task_logic(**kwargs)
        return HttpResponse(get_ajax_msg(msg, '/api/periodictask/1/'))
    elif request.method == 'GET':
        info = {
            'account': account,
            'env': EnvInfo.objects.all().order_by('-create_time'),
            'project': ProjectInfo.objects.all().order_by('-create_time')
        }
        return render_to_response('add_task.html', info)


@login_check
def upload_file(request):
    account = request.session["now_account"]
    if request.method == 'POST':
        try:
            project_name = request.POST.get('project')
            module_name = request.POST.get('module')
        except KeyError as e:
            return JsonResponse({"status": e})

        if project_name == '请选择' or module_name == '请选择':
            return JsonResponse({"status": '项目或模块不能为空'})

        upload_path = sys.path[0] + separator + 'upload' + separator

        if os.path.exists(upload_path):
            shutil.rmtree(upload_path)

        os.mkdir(upload_path)

        upload_obj = request.FILES.getlist('upload')
        file_list = []
        for i in range(len(upload_obj)):
            temp_path = upload_path + upload_obj[i].name
            file_list.append(temp_path)
            try:
                with open(temp_path, 'wb') as data:
                    for line in upload_obj[i].chunks():
                        data.write(line)
            except IOError as e:
                return JsonResponse({"status": e})

        upload_file_logic(file_list, project_name, module_name, account)

        return JsonResponse({'status': '/api/test_list/1/'})


@login_check
def get_project_info(request):
    """
     获取项目相关信息
     :param request:
     :return:
     """

    if request.is_ajax():
        project_info = json.loads(request.body.decode('utf-8'))

        msg = load_modules(**project_info.pop('task'))
        return HttpResponse(msg)


@login_check
def download_report(request, id):
    if request.method == 'GET':
        report = TestReports.objects.get(id=id)
        start_at = report.start_at
        boot_path = os.getcwd()
        path = report.path.replace('/', separator)
        report_path = boot_path+path

        def file_iterator(file_name, chunk_size=512):
            with open(file_name, encoding='utf-8') as f:
                while True:
                    c = f.read(chunk_size)
                    if c:
                        yield c
                    else:
                        break

        response = StreamingHttpResponse(file_iterator(report_path))
        response['Content-Type'] = 'application/octet-stream'
        response['Content-Disposition'] = 'attachment;filename="{0}"'.format(start_at.replace(":", "-") + '.html')
        return response


@login_check
def debugtalk(request, id=None):
    if request.method == 'GET':
        debugtalk = DebugTalk.objects.values('id', 'debugtalk').get(id=id)
        return render_to_response('debugtalk.html', debugtalk)
    else:
        id = request.POST.get('id')
        debugtalk = request.POST.get('debugtalk')
        code = debugtalk.replace('new_line', '\r\n')
        obj = DebugTalk.objects.get(id=id)
        obj.debugtalk = code
        obj.save()
        return HttpResponseRedirect('/api/debugtalk_list/1/')


@login_check
def debugtalk_list(request, id):
    """
       debugtalk.py列表
       :param request:
       :param id: str or int：当前页
       :return:
       """

    account = request.session["now_account"]
    debugtalk = get_pager_info(
        DebugTalk, None, '/api/debugtalk_list/', id)
    manage_info = {
        'account': account,
        'debugtalk': debugtalk[1],
        'page_list': debugtalk[0],
    }
    return render_to_response('debugtalk_list.html', manage_info)


@login_check
def suite_list(request, id):
    account = request.session["now_account"]
    user_type = request.session['user_type']
    if request.is_ajax():
        suite_info = json.loads(request.body.decode('utf-8'))

        if suite_info.get('mode') == 'del':
            msg = del_suite_data(suite_info.pop('id'), account,user_type)
        elif suite_info.get('mode') == 'copy':
            msg = copy_suite_data(suite_info.get('data').pop('index'), suite_info.get('data').pop('name'), account)
        return HttpResponse(get_ajax_msg(msg, 'ok'))
    else:
        filter_query = set_filter_session(request)
        pro_list = get_pager_info(
            TestSuite, filter_query, '/api/suite_list/', id)
        manage_info = {
            'account': account,
            'suite': pro_list[1],
            'page_list': pro_list[0],
            'info': filter_query,
            'sum': pro_list[2],
            'env': EnvInfo.objects.all().order_by('-create_time'),
            'project': ProjectInfo.objects.all().order_by('-update_time')
        }
        return render_to_response('suite_list.html', manage_info)


@login_check
def add_suite(request):
    account = request.session["now_account"]
    if request.is_ajax():
        kwargs = json.loads(request.body.decode('utf-8'))
        kwargs['creator'] = account
        msg = add_suite_data(**kwargs)
        return HttpResponse(get_ajax_msg(msg, '/api/suite_list/1/'))

    elif request.method == 'GET':
        manage_info = {
            'account': account,
            'project': ProjectInfo.objects.all().values('project_name').order_by('-create_time')
        }
        return render_to_response('add_suite.html', manage_info)


@login_check
def edit_suite(request, id=None):
    account = request.session["now_account"]
    user_type = request.session['user_type']
    if request.is_ajax():
        kwargs = json.loads(request.body.decode('utf-8'))
        msg = edit_suite_data(account, user_type, **kwargs)
        return HttpResponse(get_ajax_msg(msg, '/api/suite_list/1/'))

    suite_info = TestSuite.objects.get(id=id)
    manage_info = {
        'account': account,
        'info': suite_info,
        'project': ProjectInfo.objects.all().values(
            'project_name').order_by('-create_time'),
        'module': ModuleInfo.objects.filter(belong_project_id=suite_info.belong_project_id).values(
            'module_name','id').order_by('-create_time')
    }
    return render_to_response('edit_suite.html', manage_info)


@login_check
@accept_websocket
def echo(request):
    if not request.is_websocket():
        return render_to_response('echo.html')
    else:
        servers = []
        for message in request.websocket:
            try:
                servers.append(message.decode('utf-8'))
            except AttributeError:
                pass
            if len(servers) == 4:
                break
        client = paramiko.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        client.connect(servers[0], 22, username=servers[1], password=servers[2], timeout=10)
        while True:
            cmd = servers[3]
            stdin, stdout, stderr = client.exec_command(cmd)
            for i, line in enumerate(stdout):
                request.websocket.send(bytes(line, encoding='utf8'))
            client.close()


@login_check
def dashboard(request, id):
    account = request.session["now_account"]
    manage_info = {
        'account': account,
        'debugtalk': "test",
        'page_list': [0, 2],
    }
    return JsonResponse(manage_info)


@login_check
def debug_case(request):

    try:
        testcase_info = json.loads(request.body.decode('utf-8'))

        case_test = run_request_case(**testcase_info)

        kwargs = {
            "failfast": False,
        }
        runner = HttpRunner(**kwargs)

        testcase_dir_path = os.path.join(os.getcwd(), "suite")
        testcase_dir_path = os.path.join(testcase_dir_path, get_time_stamp())

        base_url = testcase_info.get('test').get('env_name')

        run_by_single2(case_test, base_url, testcase_dir_path)

        runner.run2(testcase_dir_path)
        shutil.rmtree(testcase_dir_path)

        runner.summary = timestamp_to_datetime(runner.summary, type=False)

        details = runner.summary.get('details')

        result = {}

        detail_size = len(details)
        if detail_size > 0:
            detail = details[detail_size - 1]
            records = detail.get('records')
            success = detail.get('success')
            if success:
                records_len = len(records)
                if records_len > 0:
                    result = records[records_len - 1].get('meta_data').get('response').get('json')
                    view_data = str.replace(str(result), ',', ',\n')
                    view_data = str.replace(view_data, '{', '{\n')
                    view_data = str.replace(view_data, '}', '\n}')
            else:
                records_len = len(records)
                if records_len > 0:
                    reason = ''
                    for validate in records[records_len - 1]['meta_data']['validators']:
                        if validate.get('check_result') == 'fail':
                            reason += validate['comparator']+':'+str([validate['expect'],validate['check_value']])+'\n'

                    view_data = '验证异常：异常信息如下: \n\n'
                    # 断言提示
                    if reason:
                        view_data += '断言结果：\n' + str(reason) + '\n\n'
                        view_data += '---------------------------------------------'
                        view_data += '---------------------------------------------------\n'
                    # 返回信息提示
                    result_data = records[records_len - 1].get('meta_data').get('response').get('json')
                    if result_data:
                        result_data = str.replace(str(result_data), ',', ',\n')
                        result_data = str.replace(result_data, '{', '{\n')
                        result_data = str.replace(result_data, '}', '\n}')
                        view_data += '返回信息：\n' + str(result_data) + '\n\n'
                        view_data += '---------------------------------------------'
                        view_data += '---------------------------------------------------\n'

                    result = records[records_len - 1].get('attachment')
                    view_data += str(result)

        # result = json.dumps(runner.summary, cls=MyEncoder)
    except Exception as e:
        result = "调试出现异常，异常信息如下: {0}".format(e)
        view_data = str.replace(str(result), ': ', ': \n')

    result = {
        'data': str(result),
        'view_data': view_data
    }

    return JsonResponse(result)


class MyEncoder(json.JSONEncoder):
    def default(self, obj):
        """
        只要检查到了是bytes类型的数据就把它转为str类型
        :param obj:
        :return:
        """
        if isinstance(obj, bytes):
            return str(obj, encoding='utf-8')
        if type(obj) == type(requests.cookies.RequestsCookieJar()):
            return None
        return json.JSONEncoder.default(self, obj)


'''
获取运维系统模块列表
'''


def list_devops_module(request):
    query_data = json.loads(request.body.decode('utf-8'))
    result = devops_api.get_module(query_data)
    return JsonResponse(result)


'''
运行指定服务用例
'''


def run_task(request):
    result = {
        "code": 0,
        "msg": "OK"
    }

    data = json.loads(request.body.decode('utf-8'))
    service_name = data.get('service_name')
    service_version = data.get('service_version')

    # test_count = TestCaseInfo.objects.filter(service_name=service_name, type=1).count()
    if service_version:
        test_count = ServiceConfig.objects.filter(service_name=service_name, service_version=service_version).count()
    else:
        test_count = ServiceConfig.objects.filter(service_name=service_name).count()

    if test_count == 0:
        result = {
            "code": 1,
            "msg": "该服务不存在测试用例，请检查" + str(service_name) + '：' + str(service_version)
        }
    else:
        # 修改缓存状态
        case_cache.CASE_RUN_STATUS[data.get('id')] = 0

        asyn_execute_case.delay(data)

    return JsonResponse(result)


'''获取运行状态'''


def get_run_status(request):
    # 默认执行中
    result = {
        'status': 0
    }
    data = json.loads(request.body.decode('utf-8'))
    execute_id = data.get('id')
    if execute_id:
        # cache_status = case_cache.CASE_RUN_STATUS.get(execute_id)
        # if cache_status is None or cache_status == 1:
        reports = TestReports.objects.filter(execute_id=execute_id).order_by('-create_time')
        if reports:
            report = list(reports)[0]
            report_url = SERVER_URL + report.path
            result = {
                'status': 1,
                'result': report.status,
                'successes_num': report.successes,
                'case_num': report.testsRun,
                'execute_id': report.execute_id,
                'report_url': report_url
            }

    return JsonResponse(result)


def update_server_name(request):
    test_list = TestCaseInfo.objects.filter(type__exact=1).all()
    case_tests = list(test_list)
    i = 0
    for test in case_tests:
        i = i + 1
        print(i)
        kwargs = eval(test.request)
        req = kwargs.get('test').get('request')
        method = req.get('headers', {}).get('method')
        service_name = test.service_name
        if method and service_name is None:
            apicode = str(method).split('.')
            service_name = apicode[0]
            if len(apicode) > 3:
                service_name = apicode[0] + '.' + apicode[1]
            # 设置服务名称
            TestCaseInfo.objects.filter(id=test.id).update(service_name=service_name)

    print('执行完成----------------------------------------')


def get_test_cache(request):
    data = json.loads(request.body.decode('utf-8'))
    key = data.get('key')
    type = data.get('type')
    value = data.get('value')
    timeout = data.get('timeout')
    if not timeout:
        timeout = 10

    if not type:
        type = 'get'

    if type == 'get':
        result = case_cache.get(key)
    elif type == 'set':
        case_cache.set(key, value, timeout=timeout)
        result = '添加完成'
    elif type == 'delete':
        case_cache.del_cache(key)
        result = '删除完成' + str(case_cache.exists_key(key))
    result = {
        'result': result
    }
    return JsonResponse(result)


@login_check
def service_config_list(request, id):
    filter_query = {
        'service_name': request.POST.get('service_name', ''),
        'service_version': request.POST.get('service_version', '')
    }

    service_list = get_pager_info(ServiceConfig, filter_query, '/api/service_config_list/', id)

    manage_info = {
        'account': request.session["now_account"],
        'service': service_list[1],
        'page_list': service_list[0],
        'info': filter_query
    }
    return render_to_response('service_config_list.html', manage_info)


@login_check
def add_service_config(request):
    account = request.session["now_account"]
    if request.method == 'GET':
        info = {
            'account': account,
            'env': EnvInfo.objects.all().order_by('-create_time'),
            'project': ProjectInfo.objects.all().order_by('-create_time')
        }
        return render_to_response('add_service_config.html', info)
    elif request.is_ajax():
        kwargs = json.loads(request.body.decode('utf-8'))
        kwargs['creator'] = account
        msg = add_service_config_data(**kwargs)
        return HttpResponse(get_ajax_msg(msg, '/api/service_config_list/1/'))


@login_check
def edit_service_config(request):
    account = request.session["now_account"]
    if request.method == 'GET':
        id = request.GET.get('id')
        service_info = ServiceConfig.objects.get(id=id)
        details = ServiceConfigDetail.objects.filter(service_config_id=id)
        details = list(details)
        info = {
            'account': account,
            'info': service_info,
            'details': details,
            'env': EnvInfo.objects.all().order_by('-create_time'),
            'project': ProjectInfo.objects.all().order_by('-create_time')
        }
        return render_to_response('edit_service_config.html', info)
    elif request.is_ajax():
        kwargs = json.loads(request.body.decode('utf-8'))
        kwargs['modifier'] = account
        msg = update_service_config_data(**kwargs)
        return HttpResponse(get_ajax_msg(msg, '/api/service_config_list/1/'))


@login_check
def del_service_config(request):
    kwargs = json.loads(request.body.decode('utf-8'))
    msg = del_service_config_data(**kwargs)
    return HttpResponse(get_ajax_msg(msg, 'ok'))


@login_check
def copy_service_config(request):
    account = request.session["now_account"]
    kwargs = json.loads(request.body.decode('utf-8'))
    kwargs = kwargs.get('data')
    kwargs['creator'] = account
    msg = copy_service_config_data(**kwargs)
    return HttpResponse(get_ajax_msg(msg, 'ok'))


@login_check
def load_suite(request):
    account = request.session["now_account"]
    if request.is_ajax():
        params = json.loads(request.body.decode('utf-8'))
        project = params.get('test', {}).get('name', {}).get('project')
        if not project:
            return ''
        project_info = ProjectInfo.objects.get(project_name__exact=project)

        suites = TestSuite.objects.filter(belong_project_id=project_info.id). \
            values_list('id', 'suite_name').order_by('-create_time')
        suites = list(suites)
        string = ''
        for value in suites:
            string = string + str(value[0]) + '^=' + value[1] + 'replaceFlag'
        result = string[:len(string) - 11]

        return HttpResponse(get_ajax_msg(result, '/api/test_list/1/'))


def init_data_service_config(request):
    query_data = {}
    result = devops_api.get_module(query_data)
    data_list = result.get('data')
    i =1
    for data in data_list:
        servcie_name = data.get('mod_name')
        kwargs = {
            'id': None,
            'service_name': servcie_name,
            'remark': data.get('bus_name') + '->' + data.get('prj_name') + '->' + data.get('prj_tag'),
            'creator': 'system'
        }

        servcie = ServiceConfig.objects.create(**kwargs)
        add_detail = {
            'service_config_id': servcie.id,
            'relation_id': servcie_name,
            'relation_name': servcie_name,
            'relation_type': 5,
            'creator': 'system',
        }
        ServiceConfigDetail.objects.create(**add_detail)
        i =i+1
        print(i)

    result = {'code': '1'}
    return JsonResponse(result)


# 运行服务
@login_check
def run_service(request):
    account = request.session["now_account"]
    base_url = ''
    if request.is_ajax():
        data = json.loads(request.body.decode('utf-8'))
        id = data.get('id')
        mode = data.get('mode')
        service_config = ServiceConfig.objects.get(id=id)
        # 异步执行
        data['service_config_id'] = id
        data['report_name'] = '异步执行' + service_config.service_name + '服务'
        asyn_execute_case.delay(data)
        return HttpResponse('正在执行中，请稍后查看报告即可,默认时间戳命名报告')
    else:
        id = request.POST.get('id')
        mode = request.POST.get('mode')
        service_config = ServiceConfig.objects.get(id=id)
        report_runner = run_by_service(id, base_url)
        report_name = '执行' + service_config.service_name + '服务'

        add_test_reports(report_runner, report_name=report_name, report_type='service', executor=account)

        return render_to_response('report_template.html', report_runner.summary)


# 账号信息
@login_check
def edit_account_info(request):
    account = request.session["now_account"]
    if request.method == 'GET':
        user_info = {}
        userinfos = UserInfo.objects.filter(username=account).all()
        userinfos = list(userinfos)
        if userinfos:
            user_info = userinfos[0]

        info = {
            'account_info': user_info,
        }
        return render_to_response('account_info.html', info)
    elif request.is_ajax():
        kwargs = json.loads(request.body.decode('utf-8'))
        UserInfo.objects.filter(username=account).update(password=kwargs.get('password'))
        return HttpResponse('/api/edit_account_info')


@login_check
def test_logic_list(request, id):
    account = request.session["now_account"]
    user_type = request.session['user_type']
    if request.is_ajax():
        test_info = json.loads(request.body.decode('utf-8'))

        if test_info.get('mode') == 'del':
            msg = del_test_logic_data(test_info.pop('id'), account, user_type)
        elif test_info.get('mode') == 'copy':
            msg = copy_test_logic_data(test_info.get('data').pop('index'), test_info.get('data').pop('name'), account)
        return HttpResponse(get_ajax_msg(msg, 'ok'))

    else:
        filter_query = set_filter_session(request)

        if 'case_id' in request.POST.keys():
            filter_query['case_id'] = request.POST.get('case_id')
        if 'service_name' in request.POST.keys():
            filter_query['service_name'] = request.POST.get('service_name')

        test_list = get_pager_info(
            TestCaseLogicInfo, filter_query, '/api/test_logic_list/', id)

        manage_info = {
            'account': account,
            'test': test_list[1],
            'page_list': test_list[0],
            'info': filter_query,
            'env': EnvInfo.objects.all().order_by('-create_time'),
            'projects': ProjectInfo.objects.all().order_by('-update_time')
        }

        # 添加模块下拉
        modules = []
        if filter_query.get('belong_project') != 'All':
            modules = ModuleInfo.objects.filter(
                belong_project__project_name=filter_query.get('belong_project')).order_by('-create_time')

        manage_info['modules'] = modules

        return render_to_response('test_logic_list.html', manage_info)

# 逻辑用例运行
@login_check
def run_logic_test(request):
    account = request.session["now_account"]

    kwargs = {
        "failfast": False,
    }
    runner = HttpRunner_ext(**kwargs)

    testcase_dir_path = os.path.join(os.getcwd(), "suite")
    testcase_dir_path = os.path.join(testcase_dir_path, get_time_stamp())

    if request.is_ajax():
        request_data = json.loads(request.body.decode('utf-8'))
        # report_name = kwargs.get('report_name', None)
        main_hrun.delay(testcase_dir_path, account, request_data)
        return HttpResponse('用例执行中，请稍后查看报告即可,默认时间戳命名报告')
    else:
        id = request.POST.get('id')
        base_url = request.POST.get('env_name')
        type = request.POST.get('type', 'test')

        report_name = run_by_logic_test(id, base_url, testcase_dir_path)
        runner.run3(testcase_dir_path)
        shutil.rmtree(testcase_dir_path)
        runner.summary = timestamp_to_datetime(runner.summary, type=False)

        add_test_reports(runner, report_name=report_name, report_type=type, executor=account)

        return render_to_response('report_template.html', runner.summary)


# 编辑逻辑用例
@login_check
def edit_logic_case(request, id=None):
    account = request.session["now_account"]
    user_type = request.session['user_type']
    if request.is_ajax():
        testcase_lists = json.loads(request.body.decode('utf-8'))
        tastcase = testcase_lists.get('test').get('name')
        author = tastcase.get('author')
        project = tastcase.get('project')
        module = tastcase.get('module')
        if not validate_operate(account, author, user_type, project, module):
            return HttpResponse(get_ajax_msg("非创建人或负责人不能修改,请检查", '/api/test_list/1/'))

        msg = logic_test_case(type=False, **testcase_lists)
        return HttpResponse(get_ajax_msg(msg, '/api/test_logic_list/1/'))

    test_info = TestCaseLogicInfo.objects.get_case_by_id(id)
    request = eval(test_info[0].request)
    include = eval(test_info[0].include)

    project = test_info[0].belong_project
    module = test_info[0].belong_module

    module_info = ModuleInfo.objects.filter(belong_project__project_name=project).order_by('-create_time')
    modules = list(module_info)

    case_info = TestCaseLogicInfo.objects.filter(belong_project=project, belong_module=module, type=1).order_by('-create_time')
    cases = list(case_info)

    configs = TestCaseLogicInfo.objects.filter(belong_project=project, belong_module=module, type=2).order_by('-create_time')
    configs = list(configs)
    query_data = {}
    devops_modules = devops_api.get_module(query_data).get('data')
    # devops_modules = []
    manage_info = {
        'account': account,
        'info': test_info[0],
        'request': request['test'],
        'include': include,
        'project': ProjectInfo.objects.all().values('project_name').order_by('-create_time'),
        'modules': modules,
        'cases': cases,
        'configs': configs,
        'env': EnvInfo.objects.all().order_by('-create_time'),
        'devops_modules': devops_modules
    }
    return render_to_response('edit_logic_case.html', manage_info)


@login_check
def add_logic_case(request):
    account = request.session["now_account"]
    if request.is_ajax():
        testcase_info = json.loads(request.body.decode('utf-8'))
        msg = logic_test_case(**testcase_info)
        return HttpResponse(get_ajax_msg(msg, '/api/test_logic_list/1/'))
    elif request.method == 'GET':
        query_data = {}
        devops_modules =devops_api.get_module(query_data).get('data')
        # devops_modules =[]
        manage_info = {
            'account': account,
            'project': ProjectInfo.objects.all().values('project_name').order_by('-create_time'),
            'env': EnvInfo.objects.all().order_by('-create_time'),
            'devops_modules': devops_modules
        }
        return render_to_response('add_logic_case.html', manage_info)


# 逻辑用例复制用例信息
@login_check
def copy_logic_case(request, id=None):
    account = request.session["now_account"]
    user_type = request.session['user_type']

    test_info = TestCaseInfo.objects.get_case_by_id(id)
    request = eval(test_info[0].request)
    include = eval(test_info[0].include)

    project = test_info[0].belong_project
    module = test_info[0].belong_module

    module_info = ModuleInfo.objects.filter(belong_project__project_name=project).order_by('-create_time')
    modules = list(module_info)

    case_info = TestCaseInfo.objects.filter(belong_project=project, belong_module=module, type=1).order_by('-create_time')
    cases = list(case_info)

    configs = TestCaseLogicInfo.objects.filter(belong_project=project, belong_module=module, type=2).order_by('-create_time')
    configs = list(configs)
    query_data = {}
    devops_modules = devops_api.get_module(query_data).get('data')
    # devops_modules = []

    testinfo = test_info[0]
    testinfo.id = None
    testinfo.author = account
    manage_info = {
        'account': account,
        'info': testinfo,
        'request': request['test'],
        'include': include,
        'project': ProjectInfo.objects.all().values('project_name').order_by('-create_time'),
        'modules': modules,
        'cases': cases,
        'configs': configs,
        'env': EnvInfo.objects.all().order_by('-create_time'),
        'devops_modules': devops_modules
    }
    return render_to_response('edit_logic_case.html', manage_info)