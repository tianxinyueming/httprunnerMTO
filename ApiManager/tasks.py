# Create your tasks here
from __future__ import absolute_import, unicode_literals

import datetime
import os
import shutil

from celery import shared_task
from django.core.exceptions import ObjectDoesNotExist

from ApiManager.models import ProjectInfo, ServiceConfig
from ApiManager.utils.common import timestamp_to_datetime
from ApiManager.utils.emails import send_email_reports
from ApiManager.utils.operation import add_test_reports, add_error_reports
from ApiManager.utils.runner import run_by_project, run_by_module, run_by_suite, run_by_service, run_test_by_type, \
    run_by_batch
from ApiManager.utils.testcase import get_time_stamp
from httprunner import HttpRunner, logger


@shared_task
def main_hrun(testset_path, executor=None, request_data=None):
    """
    用例运行
    :param testset_path: dict or list
    :param report_name: str
    :return:
    """
    logger.setup_logger('INFO')
    kwargs = {
        "failfast": False,
    }
    runner = HttpRunner(**kwargs)
    error_info ={
        'start_time': datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    }
    report_type = 'test'
    report_name = '执行异常'

    try:
        id = request_data.pop('id')
        base_url = request_data.pop('env_name')
        type = request_data.pop('type')
        report_name = request_data.get('report_name', None)
        if type:
            report_type = type

        report_name2 = run_test_by_type(id, base_url, testset_path, type)

        if not report_name:
            report_name = report_name2

        runner.run2(testset_path)
        shutil.rmtree(testset_path)
        runner.summary = timestamp_to_datetime(runner.summary)
        report_path = add_test_reports(runner, report_name=report_name, report_type=report_type, executor=executor)
    except Exception as e:
        logger.log_info("出现异常: {0}".format(e))
        error_info['error_msg'] = "出现异常: {0}".format(e)
        add_error_reports(error_info, report_name=report_name, report_type=report_type, executor=executor)
    except BaseException as e:
        logger.log_info("出现异常: {0}".format(e))
        error_info['error_msg'] = "出现异常: {0}".format(e)
        add_error_reports(error_info, report_name=report_name, report_type=report_type, executor=executor)



@shared_task
def batch_main_hrun(testset_path, executor=None, request_data=None):
    """
    用例运行
    :param testset_path: dict or list
    :param report_name: str
    :return:
    """
    logger.setup_logger('INFO')
    kwargs = {
        "failfast": False,
    }
    runner = HttpRunner(**kwargs)
    error_info ={
        'start_time': datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    }

    report_type = 'test'
    report_name = '执行异常'

    try:
        test_list = request_data.pop('id')
        base_url = request_data.pop('env_name')
        type = request_data.pop('type')
        report_name = request_data.get('report_name', None)
        if type:
            report_type = type

        run_by_batch(test_list, base_url, testset_path, type=type)

        runner.run2(testset_path)
        shutil.rmtree(testset_path)

        runner.summary = timestamp_to_datetime(runner.summary)
        report_path = add_test_reports(runner, report_name=report_name, report_type=report_type, executor=executor)
    except Exception as e:
        logger.log_info("出现异常: {0}".format(e))
        error_info['error_msg'] = "出现异常: {0}".format(e)
        add_error_reports(error_info, report_name=report_name, report_type=report_type, executor=executor)
    except BaseException as e:
        logger.log_info("出现异常: {0}".format(e))
        error_info['error_msg'] = "出现异常: {0}".format(e)
        add_error_reports(error_info, report_name=report_name, report_type=report_type, executor=executor)




@shared_task
def project_hrun(name, base_url, project, receiver, executor=None):
    """
    异步运行整个项目
    :param env_name: str: 环境地址
    :param project: str
    :return:
    """
    logger.setup_logger('INFO')
    kwargs = {
        "failfast": False,
    }
    runner = HttpRunner(**kwargs)
    id = ProjectInfo.objects.get(project_name=project).id

    testcase_dir_path = os.path.join(os.getcwd(), "suite")
    testcase_dir_path = os.path.join(testcase_dir_path, get_time_stamp())

    run_by_project(id, base_url, testcase_dir_path)

    runner.run2(testcase_dir_path)
    shutil.rmtree(testcase_dir_path)

    runner.summary = timestamp_to_datetime(runner.summary)
    report_path = add_test_reports(runner, report_name=name, report_type='project', executor=executor)

    if receiver != '':
        send_email_reports(receiver, report_path)
    # os.remove(report_path)


@shared_task
def module_hrun(name, base_url, module, receiver, executor=None):
    """
    异步运行模块
    :param env_name: str: 环境地址
    :param project: str：项目所属模块
    :param module: str：模块名称
    :return:
    """
    logger.setup_logger('INFO')
    kwargs = {
        "failfast": False,
    }
    runner = HttpRunner(**kwargs)
    module = list(module)

    testcase_dir_path = os.path.join(os.getcwd(), "suite")
    testcase_dir_path = os.path.join(testcase_dir_path, get_time_stamp())

    try:
        for value in module:
            run_by_module(value[0], base_url, testcase_dir_path)
    except ObjectDoesNotExist:
        return '找不到模块信息'

    runner.run2(testcase_dir_path)

    shutil.rmtree(testcase_dir_path)
    runner.summary = timestamp_to_datetime(runner.summary)
    report_path = add_test_reports(runner, report_name=name, report_type='module', executor=executor)

    if receiver != '':
        send_email_reports(receiver, report_path)
    # os.remove(report_path)


@shared_task
def suite_hrun(name, base_url, suite, receiver, executor=None):
    """
    异步运行模块
    :param env_name: str: 环境地址
    :param project: str：项目所属模块
    :param module: str：模块名称
    :return:
    """
    logger.setup_logger('INFO')
    kwargs = {
        "failfast": False,
    }
    runner = HttpRunner(**kwargs)
    suite = list(suite)

    testcase_dir_path = os.path.join(os.getcwd(), "suite")
    testcase_dir_path = os.path.join(testcase_dir_path, get_time_stamp())

    try:
        for value in suite:
            run_by_suite(value[0], base_url, testcase_dir_path)
    except ObjectDoesNotExist:
        return '找不到Suite信息'

    runner.run2(testcase_dir_path)

    shutil.rmtree(testcase_dir_path)

    runner.summary = timestamp_to_datetime(runner.summary)
    report_path = add_test_reports(runner, report_name=name, report_type='suite', executor=executor)

    if receiver != '':
        send_email_reports(receiver, report_path)
    # os.remove(report_path)


"""
   异步执行用例
   :param data: 执行入参
   :return:
"""


@shared_task
def asyn_execute_case(data=None):
    logger.setup_logger('INFO')
    service_name = data.get('service_name')
    service_version = data.get('service_version')
    execute_source = data.get('execute_source')
    report_name = data.get('report_name')
    service_config_id = data.get('service_config_id')
    id = data.get('id')
    base_url = data.get('base_url')
    if base_url is None:
        base_url = ''

    if not service_config_id:
        service_configs = ServiceConfig.objects.filter(service_name=service_name, service_version=service_version).all()
        service_config_id = list(service_configs)[0].id

    report_runner = run_by_service(service_config_id, base_url)

    report_data = {
        'execute_service': service_name,
        'execute_source': execute_source,
        'execute_id': id
    }

    if not report_name:
        report_name = '禅道执行' + service_name + '服务'

    add_test_reports(report_runner, report_name=report_name, report_type='service', executor='system',
                                   report_data=report_data)
    return report_runner


