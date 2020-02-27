import datetime
import logging
import os

from django.core.exceptions import ObjectDoesNotExist
from django.db import DataError

from ApiManager import separator
from ApiManager.models import ProjectInfo, ModuleInfo, TestCaseInfo, UserInfo, EnvInfo, TestReports, DebugTalk, \
    TestSuite, ServiceConfig, ServiceConfigDetail, TestCaseLogicInfo
import time
import io

logger = logging.getLogger('httprunnerMTO')


def add_register_data(**kwargs):
    """
    用户注册信息逻辑判断及落地
    :param kwargs: dict
    :return: ok or tips
    """
    user_info = UserInfo.objects
    try:
        username = kwargs.pop('account')
        password = kwargs.pop('password')
        email = kwargs.pop('email')

        if user_info.filter(username__exact=username).filter(status=1).count() > 0:
            logger.debug('{username} 已被其他用户注册'.format(username=username))
            return '该用户名已被注册，请更换用户名'
        if user_info.filter(email__exact=email).filter(status=1).count() > 0:
            logger.debug('{email} 昵称已被其他用户注册'.format(email=email))
            return '邮箱已被其他用户注册，请更换邮箱'
        user_info.create(username=username, password=password, email=email)
        logger.info('新增用户：{user_info}'.format(user_info=user_info))
        return 'ok'
    except DataError:
        logger.error('信息输入有误：{user_info}'.format(user_info=user_info))
        return '字段长度超长，请重新编辑'


def add_project_data(type, **kwargs):
    """
    项目信息落地 新建时必须默认添加debugtalk.py
    :param type: true: 新增， false: 更新
    :param kwargs: dict
    :return: ok or tips
    """
    project_opt = ProjectInfo.objects
    project_name = kwargs.get('project_name')
    if type:
        if project_opt.get_pro_name(project_name) < 1:
            try:
                project_opt.insert_project(**kwargs)
                belong_project = project_opt.get(project_name=project_name)
                DebugTalk.objects.create(belong_project=belong_project, debugtalk='# debugtalk.py')
            except DataError:
                return '项目信息过长'
            except Exception:
                logging.error('项目添加异常：{kwargs}'.format(kwargs=kwargs))
                return '添加失败，请重试'
            logger.info('项目添加成功：{kwargs}'.format(kwargs=kwargs))
        else:
            return '该项目已存在，请重新编辑'
    else:
        belong_project = project_opt.get(id=kwargs.get('index'))
        if project_name != belong_project.project_name and project_opt.get_pro_name(project_name) > 0:
            return '该项目已存在， 请重新命名'
        try:
            account = kwargs.get('account')
            user_type = kwargs.get('user_type')
            if not validate_operate(account, belong_project.creator, user_type, project_name):
                return '非创建人或负责人不能修改,请检查'

            project_opt.update_project(kwargs.pop('index'), **kwargs)  # testcaseinfo的belong_project也得更新，这个字段设计的有点坑了
        except DataError:
            return '项目信息过长'
        except Exception:
            logging.error('更新失败：{kwargs}'.format(kwargs=kwargs))
            return '更新失败，请重试'
        logger.info('项目更新成功：{kwargs}'.format(kwargs=kwargs))

    return 'ok'


'''模块数据落地'''


def add_module_data(type, **kwargs):
    """
    模块信息落地
    :param type: boolean: true: 新增， false: 更新
    :param kwargs: dict
    :return: ok or tips
    """
    module_opt = ModuleInfo.objects
    belong_project = kwargs.pop('belong_project')
    module_name = kwargs.get('module_name')
    if type:
        if module_opt.filter(belong_project__project_name__exact=belong_project) \
                .filter(module_name__exact=module_name).count() < 1:
            try:
                belong_project = ProjectInfo.objects.get_pro_name(belong_project, type=False)
            except ObjectDoesNotExist:
                logging.error('项目信息读取失败：{belong_project}'.format(belong_project=belong_project))
                return '项目信息读取失败，请重试'
            kwargs['belong_project'] = belong_project
            try:
                module_opt.insert_module(**kwargs)
            except DataError:
                return '模块信息过长'
            except Exception:
                logging.error('模块添加异常：{kwargs}'.format(kwargs=kwargs))
                return '添加失败，请重试'
            logger.info('模块添加成功：{kwargs}'.format(kwargs=kwargs))
        else:
            return '该模块已在项目中存在，请重新编辑'
    else:
        module_info = module_opt.get(id=kwargs.get('index'))
        if module_name != module_info.module_name \
                and module_opt.filter(belong_project__project_name__exact=belong_project) \
                .filter(module_name__exact=module_name).count() > 0:
            return '该模块已存在，请重新命名'
        try:
            account = kwargs.get('account')
            user_type = kwargs.get('user_type')
            if not validate_operate(account, module_info.creator, user_type, module_info.belong_project.project_name,
                                    module_info.id):
                return '非创建人或负责人不能修改,请检查'

            module_opt.update_module(kwargs.pop('index'), **kwargs)
        except DataError:
            return '模块信息过长'
        except Exception:
            logging.error('更新失败：{kwargs}'.format(kwargs=kwargs))
            return '更新失败，请重试'
        logger.info('模块更新成功：{kwargs}'.format(kwargs=kwargs))
    return 'ok'


'''用例数据落地'''


def add_case_data(type, **kwargs):
    """
    用例信息落地
    :param type: boolean: true: 添加新用例， false: 更新用例
    :param kwargs: dict
    :return: ok or tips
    """
    case_info = kwargs.get('test').get('case_info')
    case_opt = TestCaseInfo.objects
    name = kwargs.get('test').get('name')
    module = case_info.get('module')
    project = case_info.get('project')
    belong_module = ModuleInfo.objects.get_module_name(module, type=False)
    config = case_info.get('config', '')
    if config != '':
        case_info.get('include')[0] = eval(config)

    if '/' in name:
        return '用例名称中不能包含"/"符号，请检查'

    req = kwargs.get('test').get('request')
    method = req.get('headers', {}).get('method')
    service_name = case_info.get('service_name')
    if method and not service_name:
        apicode = str(method).split('.')
        service_name = apicode[0]
        if len(apicode) > 3:
            service_name = apicode[0] + '-' + apicode[1]
        # 设置服务名称
        kwargs['test']['case_info']['service_name'] = service_name

    try:
        if type:

            if case_opt.get_case_name(name, module, project) < 1:
                case_opt.insert_case(belong_module, **kwargs)
                logger.info('{name}用例添加成功: {kwargs}'.format(name=name, kwargs=kwargs))
            else:
                return '用例或配置已存在，请重新编辑'
        else:
            index = case_info.get('test_index')
            if name != case_opt.get_case_by_id(index, type=False) \
                    and case_opt.get_case_name(name, module, project) > 0:
                return '用例或配置已在该模块中存在，请重新命名'
            case_opt.update_case(belong_module, **kwargs)
            logger.info('{name}用例更新成功: {kwargs}'.format(name=name, kwargs=kwargs))

    except DataError:
        logger.error('用例信息：{kwargs}过长！！'.format(kwargs=kwargs))
        return '字段长度超长，请重新编辑'
    return 'ok'


'''配置数据落地'''


def add_config_data(type, **kwargs):
    """
    配置信息落地
    :param type: boolean: true: 添加新配置， fasle: 更新配置
    :param kwargs: dict
    :return: ok or tips
    """
    case_opt = TestCaseInfo.objects
    config_info = kwargs.get('config').get('config_info')
    name = kwargs.get('config').get('name')
    module = config_info.get('module')
    project = config_info.get('project')
    belong_module = ModuleInfo.objects.get_module_name(module, type=False)

    try:
        if type:
            if case_opt.get_case_name(name, module, project) < 1:
                case_opt.insert_config(belong_module, **kwargs)
                logger.info('{name}配置添加成功: {kwargs}'.format(name=name, kwargs=kwargs))
            else:
                return '用例或配置已存在，请重新编辑'
        else:
            index = config_info.get('test_index')
            if name != case_opt.get_case_by_id(index, type=False) \
                    and case_opt.get_case_name(name, module, project) > 0:
                return '用例或配置已在该模块中存在，请重新命名'
            case_opt.update_config(belong_module, **kwargs)
            logger.info('{name}配置更新成功: {kwargs}'.format(name=name, kwargs=kwargs))
    except DataError:
        logger.error('{name}配置信息过长：{kwargs}'.format(name=name, kwargs=kwargs))
        return '字段长度超长，请重新编辑'
    return 'ok'


def add_suite_data(**kwargs):
    belong_project = kwargs.pop('project')
    suite_name = kwargs.get('suite_name')
    kwargs['belong_project'] = ProjectInfo.objects.get(project_name=belong_project)

    try:
        if TestSuite.objects.filter(belong_project__project_name=belong_project, suite_name=suite_name).count() > 0:
            return 'Suite已存在, 请重新命名'
        TestSuite.objects.create(**kwargs)
        logging.info('suite添加成功: {kwargs}'.format(kwargs=kwargs))
    except Exception:
        return 'suite添加异常，请重试'
    return 'ok'


def edit_suite_data(account, user_type, **kwargs):
    id = kwargs.pop('id')
    project_name = kwargs.pop('project')
    suite_name = kwargs.get('suite_name')
    include = kwargs.pop('include')
    belong_project = ProjectInfo.objects.get(project_name=project_name)

    suite_obj = TestSuite.objects.get(id=id)
    try:
        if not validate_operate(account, suite_obj.creator, user_type, project_name):
            return '非创建人或负责人不能删除,请检查'

        if suite_name != suite_obj.suite_name and \
                TestSuite.objects.filter(belong_project=belong_project, suite_name=suite_name).count() > 0:
            return 'Suite已存在, 请重新命名'
        suite_obj.suite_name = suite_name
        suite_obj.belong_project = belong_project
        suite_obj.include = include
        suite_obj.save()
        logging.info('suite更新成功: {kwargs}'.format(kwargs=kwargs))
    except Exception:
        return 'suite添加异常，请重试'
    return 'ok'


'''环境信息落地'''


def env_data_logic(**kwargs):
    """
    环境信息逻辑判断及落地
    :param kwargs: dict
    :return: ok or tips
    """
    id = kwargs.get('id', None)
    if id:
        try:
            EnvInfo.objects.delete_env(id)
        except ObjectDoesNotExist:
            return '删除异常，请重试'
        return 'ok'
    index = kwargs.pop('index')
    env_name = kwargs.get('env_name')
    if env_name is '':
        return '环境名称不可为空'
    elif kwargs.get('base_url') is '':
        return '请求地址不可为空'
    elif kwargs.get('simple_desc') is '':
        return '请添加环境描述'

    if index == 'add':
        try:
            if EnvInfo.objects.filter(env_name=env_name).count() < 1:
                EnvInfo.objects.insert_env(**kwargs)
                logging.info('环境添加成功：{kwargs}'.format(kwargs=kwargs))
                return 'ok'
            else:
                return '环境名称重复'
        except DataError:
            return '环境信息过长'
        except Exception:
            logging.error('添加环境异常：{kwargs}'.format(kwargs=kwargs))
            return '环境信息添加异常，请重试'
    else:
        try:
            if EnvInfo.objects.get_env_name(index) != env_name and EnvInfo.objects.filter(
                    env_name=env_name).count() > 0:
                return '环境名称已存在'
            else:
                EnvInfo.objects.update_env(index, **kwargs)
                logging.info('环境信息更新成功：{kwargs}'.format(kwargs=kwargs))
                return 'ok'
        except DataError:
            return '环境信息过长'
        except ObjectDoesNotExist:
            logging.error('环境信息查询失败：{kwargs}'.format(kwargs=kwargs))
            return '更新失败，请重试'


def del_module_data(id, account,user_type):
    """
    根据模块索引删除模块数据，强制删除其下所有用例及配置
    :param id: str or int:模块索引
    :return: ok or tips
    """
    try:

        module = ModuleInfo.objects.get(id=id)
        if not validate_operate(account, module.creator, user_type, module.belong_project.project_name, module.id):
            return "非创建人或负责人不能删除，请检查"

        module_name = ModuleInfo.objects.get_module_name('', type=False, id=id)
        TestCaseInfo.objects.filter(belong_module__module_name=module_name).delete()
        module.delete()
    except ObjectDoesNotExist:
        return '删除异常，请重试'
    logging.info('{module_name} 模块已删除'.format(module_name=module_name))
    return 'ok'


def del_project_data(id, account, user_type):
    """
    根据项目索引删除项目数据，强制删除其下所有用例、配置、模块、Suite
    :param id: str or int: 项目索引
    :return: ok or tips
    """
    try:
        project_name = ProjectInfo.objects.get_pro_name('', type=False, id=id)

        project = ProjectInfo.objects.get(id=id)

        if not validate_operate(account, project.creator, user_type, project.project_name, None):
            return '非创建人或负责人不能删除,请检查'

        belong_modules = ModuleInfo.objects.filter(belong_project__project_name=project_name).values_list('module_name')
        for obj in belong_modules:
            TestCaseInfo.objects.filter(belong_module__module_name=obj).delete()

        TestSuite.objects.filter(belong_project__project_name=project_name).delete()

        ModuleInfo.objects.filter(belong_project__project_name=project_name).delete()

        DebugTalk.objects.filter(belong_project__project_name=project_name).delete()



        project.delete()

    except ObjectDoesNotExist:
        return '删除异常，请重试'
    logging.info('{project_name} 项目已删除'.format(project_name=project_name))
    return 'ok'


def del_test_data(id, account, user_type):
    """
    根据用例或配置索引删除数据
    :param id: str or int: test or config index
    :return: ok or tips
    """
    try:
        testinfo = TestCaseInfo.objects.get(id=id)
        if not validate_operate(account, testinfo.author, user_type, testinfo.belong_project,
                                testinfo.belong_module_id):
            return '非创建人或负责人不能删除,请检查'

        testinfo.delete()
        if testinfo.type == 2:
            ModuleInfo.objects.filter(config_id=id).update(config_id=None)
            ProjectInfo.objects.filter(config_id=id).update(config_id=None)
    except ObjectDoesNotExist:
        return '删除异常，请重试'

    logging.info('用例/配置已删除')
    return 'ok'


def del_suite_data(id, account, user_type):
    """
    根据Suite索引删除数据
    :param id: str or int: test or config index
    :return: ok or tips
    """
    try:
        suite = TestSuite.objects.get(id=id)
        if not validate_operate(account, suite.creator, user_type, suite.belong_project.project_name, None):
            return '非创建人或负责人不能删除,请检查!'

        suite.delete()
    except ObjectDoesNotExist:
        return '删除异常，请重试'
    logging.info('Suite已删除')
    return 'ok'


def del_report_data(id, account, user_type):
    """
    根据报告索引删除报告
    :param id:
    :return: ok or tips
    """
    try:
        report = TestReports.objects.get(id=id)
        if user_type != 1 and account != report.executor:
            return '非报表执行人不能删除当前数据'
        report.delete()
    except ObjectDoesNotExist:
        return '删除异常，请重试'
    return 'ok'


def copy_test_data(id, name, account):
    """
    复制用例信息，默认插入到当前项目、莫夸
    :param id: str or int: 复制源
    :param name: str：新用例名称
    :return: ok or tips
    """
    try:
        test = TestCaseInfo.objects.get(id=id)
        belong_module = test.belong_module
    except ObjectDoesNotExist:
        return '复制异常，请重试'
    if TestCaseInfo.objects.filter(name=name, belong_module=belong_module).count() > 0:
        return '用例/配置名称重复了哦'
    test.id = None
    test.name = name
    request = eval(test.request)
    if 'test' in request.keys():
        request.get('test')['name'] = name
    else:
        request.get('config')['name'] = name
    test.request = request
    test.author = account
    test.save()
    logging.info('{name}用例/配置添加成功'.format(name=name))
    return 'ok'


def copy_suite_data(id, name, account):
    """
    复制suite信息，默认插入到当前项目、莫夸
    :param id: str or int: 复制源
    :param name: str：新用例名称
    :return: ok or tips
    """
    try:
        suite = TestSuite.objects.get(id=id)
        belong_project = suite.belong_project
    except ObjectDoesNotExist:
        return '复制异常，请重试'
    if TestSuite.objects.filter(suite_name=name, belong_project=belong_project).count() > 0:
        return 'Suite名称重复了哦'
    suite.id = None
    suite.suite_name = name
    suite.creator = account
    suite.save()
    logging.info('{name}suite添加成功'.format(name=name))
    return 'ok'


def add_test_reports(runner, report_name=None, report_type=None, executor=None, report_data=None):
    """
    定时任务或者异步执行报告信息落地
    :param report_type:
    :param start_at: time: 开始时间
    :param report_name: str: 报告名称，为空默认时间戳命名
    :param kwargs: dict: 报告结果值
    :return:
    """
    time_stamp = int(runner.summary["time"]["start_at"])
    runner.summary['time']['start_datetime'] = datetime.datetime.fromtimestamp(time_stamp).strftime('%Y-%m-%d %H:%M:%S')
    report_name = report_name if report_name else runner.summary['time']['start_datetime']
    runner.summary['html_report_name'] = report_name

    report_dir_path = os.path.join(os.getcwd(), 'static', "reports")

    report_path = os.path.join(os.getcwd(), 'static', "reports{}{}.html".format(separator, time_stamp))
    runner.gen_html_report(
        html_report_template=os.path.join(os.getcwd(), "templates{}extent_report_template.html".format(separator)),
        report_dir_path=report_dir_path)

    # with open(report_path, encoding='utf-8') as stream:
    #     reports = stream.read()

    relative_path = "/static/reports/{}.html".format(time_stamp)
    status = 0
    if runner.summary.get('success'):
        status = 1
    test_reports = {
        'report_name': report_name,
        'status': status,
        'successes': runner.summary.get('stat').get('successes'),
        'testsRun': runner.summary.get('stat').get('testsRun'),
        'start_at': runner.summary['time']['start_datetime'],
        # 'reports': reports,
        'type': report_type,
        'executor': executor,
        'path': relative_path
    }

    if report_data:
        test_reports['execute_service'] = report_data.get('execute_service')
        test_reports['execute_source'] = report_data.get('execute_source')
        test_reports['execute_id'] = report_data.get('execute_id')

    TestReports.objects.create(**test_reports)
    return report_path


'''
校验操作权限
'''


def validate_operate(account, author, user_type, project=None, module_id=None):
    if author == account or user_type == 1:
        return True
    else:
        user = ''
        if project:
            project_info = ProjectInfo.objects.get_pro_name(project, type=False)
            if project_info.responsible_name:
                user += project_info.responsible_name
        if module_id:
            module_info = ModuleInfo.objects.get(id=module_id)
            if module_info.leader_user:
                user += ','+module_info.leader_user
        users = user.split(',')
        if account in users:
            return True
        return False


def add_service_config_data(**kwargs):
    service_name = kwargs.get('service_name')
    service_version = kwargs.get('service_version')
    creator = kwargs.get('creator')
    details = kwargs.pop('details')
    try:
        if ServiceConfig.objects.filter(service_name=service_name, service_version=service_version).count() > 0:
            return '服务关联已存在, 请重新命名'
        servcie = ServiceConfig.objects.create(**kwargs)
        if details:
            for detail in details:
                detail['service_config_id'] = servcie.id
                detail['creator'] =creator
                ServiceConfigDetail.objects.create(**detail)

        logging.info('服务关联配置添加成功: {kwargs}'.format(kwargs=kwargs))
    except Exception as e:
        print(e)
        return '服务关联配置添加异常，请重试'
    return 'ok'


def update_service_config_data(**kwargs):
    service_name = kwargs.get('service_name')
    service_version = kwargs.get('service_version')
    details = kwargs.pop('details')
    id = kwargs.get("id")
    try:
        servcies = ServiceConfig.objects.filter(service_name=service_name, service_version=service_version).all()
        servcies = list(servcies)
        if len(servcies) > 0:
            for service in servcies:
                if service.id != id:
                    return '服务关联已存在, 请重新命名'

        service_config = ServiceConfig.objects.get(id=id)
        kwargs['creator'] = service_config.creator
        kwargs['create_time'] = service_config.create_time

        # 先删除再新增
        ServiceConfig.objects.get(id=id).delete()
        ServiceConfigDetail.objects.filter(service_config_id=id).delete()

        servcie = ServiceConfig.objects.create(**kwargs)
        if details:
            for detail in details:
                detail['service_config_id'] = servcie.id
                detail['creator'] = service_config.creator
                ServiceConfigDetail.objects.create(**detail)

        logging.info('服务关联配置添加成功: {kwargs}'.format(kwargs=kwargs))
    except Exception as e:
        print(e)
        return '服务关联配置添加异常，请重试'
    return 'ok'


def del_service_config_data(**kwargs):
    id = kwargs.get("id")
    try:
        service_config = ServiceConfig.objects.get(id=id)
        # 先删除再新增
        ServiceConfig.objects.get(id=id).delete()
        ServiceConfigDetail.objects.filter(service_config_id=id).delete()
    except Exception as e:
        print(e)
        return '服务关联配置删除异常，请重试'
    return 'ok'


def copy_service_config_data(**kwargs):
    id = kwargs.pop("index")
    creator = kwargs.get('creator')
    try:
        service_configs = ServiceConfig.objects.get(id=id)

        service_config_details = ServiceConfigDetail.objects.filter(service_config_id=id).all()
        service_config_details = list(service_config_details)
        servcie = ServiceConfig.objects.create(**kwargs)
        if service_config_details:
            for detail in service_config_details:
                add_detail = {
                    'service_config_id': servcie.id,
                    'relation_id': detail.relation_id,
                    'relation_name': detail.relation_name,
                    'relation_type': detail.relation_type,
                    'creator': creator
                }
                ServiceConfigDetail.objects.create(**add_detail)
    except Exception as e:
        print(e)
        return '服务关联配置删除异常，请重试'
    return 'ok'


def add_error_reports(error_info, report_name=None, report_type=None, executor=None, report_data=None):
    if not report_name:
        report_name = '执行异常'

    time_stamp = int(round(time.time() * 1000))
    error_msg = error_info.get('error_msg')

    template_path = os.path.join(os.getcwd(), "templates{}{}.html".format(separator, 'error_template'))
    with open(template_path, encoding='utf-8') as stream:
        template_info = stream.read()

    template_info = template_info.replace('${error_info}', error_msg)

    report_path = os.path.join(os.getcwd(), 'static', "reports{}{}.html".format(separator, time_stamp))
    with io.open(report_path, 'w', encoding='utf-8') as fp_w:
        fp_w.write(template_info)

    relative_path = "/static/reports/{}.html".format(time_stamp)

    test_reports = {
        'report_name': report_name,
        'status': 2,
        'successes': 0,
        'testsRun': 0,
        'start_at': error_info.get('start_time'),
        'type': report_type,
        'executor': executor,
        'path': relative_path
    }

    if report_data:
        test_reports['execute_service'] = report_data.get('execute_service')
        test_reports['execute_source'] = report_data.get('execute_source')
        test_reports['execute_id'] = report_data.get('execute_id')

    TestReports.objects.create(**test_reports)
    return report_path


# 逻辑用例删除
def del_test_logic_data(id, account, user_type):
    try:
        testinfo = TestCaseLogicInfo.objects.get(id=id)
        if not validate_operate(account, testinfo.author, user_type, testinfo.belong_project,
                                testinfo.belong_module_id):
            return '非创建人或负责人不能删除,请检查'

        testinfo.delete()
    except ObjectDoesNotExist:
        return '删除异常，请重试'

    logging.info('用例/配置已删除')
    return 'ok'


# 逻辑用例负责
def copy_test_logic_data(id, name, account):
    try:
        test = TestCaseLogicInfo.objects.get(id=id)
        belong_module = test.belong_module
    except ObjectDoesNotExist:
        return '复制异常，请重试'
    if TestCaseLogicInfo.objects.filter(name=name, belong_module=belong_module).count() > 0:
        return '用例/配置名称重复了哦'
    test.id = None
    test.name = name
    request = eval(test.request)
    if 'test' in request.keys():
        request.get('test')['name'] = name
    else:
        request.get('config')['name'] = name
    test.request = request
    test.author = account
    test.save()
    logging.info('{name}用例/配置添加成功'.format(name=name))
    return 'ok'


# 新增修改逻辑用例数据
def add_logic_case_data(type, **kwargs):
    """
    用例信息落地
    :param type: boolean: true: 添加新用例， false: 更新用例
    :param kwargs: dict
    :return: ok or tips
    """
    case_info = kwargs.get('test').get('case_info')
    case_opt = TestCaseLogicInfo.objects
    name = kwargs.get('test').get('name')
    module = case_info.get('module')
    project = case_info.get('project')
    belong_module = ModuleInfo.objects.get_module_name(module, type=False)
    config = case_info.get('config', '')
    if config != '':
        case_info.get('include')[0] = eval(config)

    if '/' in name:
        return '用例名称中不能包含"/"符号，请检查'

    req = kwargs.get('test').get('request')
    method = req.get('headers', {}).get('method')
    service_name = case_info.get('service_name')
    if method and not service_name:
        apicode = str(method).split('.')
        service_name = apicode[0]
        if len(apicode) > 3:
            service_name = apicode[0] + '-' + apicode[1]
        # 设置服务名称
        kwargs['test']['case_info']['service_name'] = service_name

    try:
        if type:

            if case_opt.get_case_name(name, module, project) < 1:
                case_opt.insert_case(belong_module, **kwargs)
                logger.info('{name}用例添加成功: {kwargs}'.format(name=name, kwargs=kwargs))
            else:
                return '用例或配置已存在，请重新编辑'
        else:
            index = case_info.get('test_index')
            if name != case_opt.get_case_by_id(index, type=False) \
                    and case_opt.get_case_name(name, module, project) > 0:
                return '用例或配置已在该模块中存在，请重新命名'
            case_opt.update_case(belong_module, **kwargs)
            logger.info('{name}用例更新成功: {kwargs}'.format(name=name, kwargs=kwargs))

    except DataError:
        logger.error('用例信息：{kwargs}过长！！'.format(kwargs=kwargs))
        return '字段长度超长，请重新编辑'
    return 'ok'