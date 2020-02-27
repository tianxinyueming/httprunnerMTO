import os

from django.core.exceptions import ObjectDoesNotExist

from ApiManager.models import TestCaseInfo, ModuleInfo, ProjectInfo, DebugTalk, TestSuite, ServiceConfigDetail, \
    TestCaseLogicInfo
from ApiManager.utils.testcase import dump_python_file, dump_yaml_file
import sys
import shutil
from httprunner import HttpRunner
from ApiManager.utils.common import timestamp_to_datetime
from ApiManager.utils.testcase import get_time_stamp
from ApiManager.utils.case_cache import del_case_cache


def run_by_single(index, base_url, path, order_prefix=''):
    """
    加载单个case用例信息
    :param index: int or str：用例索引
    :param base_url: str：环境地址
    :return: dict
    """
    config = {
        'config': {
            'name': '',
            'request': {
                'base_url': base_url
            }
        }
    }
    testcase_list = []

    testcase_list.append(config)

    try:
        obj = TestCaseInfo.objects.get(id=index)
    except ObjectDoesNotExist:
        return testcase_list

    include = eval(obj.include)
    request = eval(obj.request)
    name = obj.name
    project = obj.belong_project
    module = obj.belong_module.module_name

    project_info = ProjectInfo.objects.get_pro_name(project, type=False)

    # 获取工程关联的配置
    if project_info.config_id is not None:
        try:
            basic_config_request = TestCaseInfo.objects.get(id=project_info.config_id).request
            basic_request = eval(basic_config_request)
            if basic_request.get('config').get('request') is not None:
                basic_request.get('config').get('request').setdefault('base_url', base_url)
            basic_request['config']['name'] = name
            testcase_list[0] = basic_request
        except ObjectDoesNotExist:
            # raise ObjectDoesNotExist('项目关联的配置信息不存在，请检查')
            print('项目关联的配置信息不存在')

    # 获取模块关联的配置
    if obj.belong_module.config_id is not None:
        try:
            basic_config_request = TestCaseInfo.objects.get(id=obj.belong_module.config_id).request
            module_request = eval(basic_config_request)
            if module_request.get('config').get('request') is not None:
                module_request.get('config').get('request').setdefault('base_url', base_url)
            module_request['config']['name'] = name
            # 合并配置信息
            merge_config(testcase_list[0], module_request)
            testcase_list[0] = module_request
        except ObjectDoesNotExist:
            # raise ObjectDoesNotExist('模块关联的配置信息不存在，请检查')
            print('模块关联的配置信息不存在')

    config['config']['name'] = name

    testcase_dir_path = os.path.join(path, project)

    if not os.path.exists(testcase_dir_path):
        os.makedirs(testcase_dir_path)

        path = os.path.abspath(os.path.dirname(sys.argv[0]))
        w = open(path + '/' + 'ApiManager/utils/basic_function.py', encoding='utf8')
        basic_function = w.read()

        try:
            debugtalk = DebugTalk.objects.get(belong_project__project_name=project).debugtalk
        except ObjectDoesNotExist:
            debugtalk = ''

        dump_python_file(os.path.join(testcase_dir_path, 'debugtalk.py'), basic_function + '\n' + '\n' + debugtalk)

    testcase_dir_path = os.path.join(testcase_dir_path, module)

    if not os.path.exists(testcase_dir_path):
        os.mkdir(testcase_dir_path)

    for test_info in include:
        try:
            if isinstance(test_info, dict):
                config_id = test_info.pop('config')[0]
                config_request = eval(TestCaseInfo.objects.get(id=config_id).request)
                if config_request.get('config').get('request') is not None:
                    config_request.get('config').get('request').setdefault('base_url', base_url)
                config_request['config']['name'] = name
                # 合并配置信息
                merge_config(testcase_list[0], config_request)
                testcase_list[0] = config_request
            else:
                id = test_info[0]
                pre_request = eval(TestCaseInfo.objects.get(id=id).request)
                testcase_list.append(pre_request)
                # 清除get_cache_case的缓存
                del_case_cache(id)

        except ObjectDoesNotExist:
            return testcase_list

    if request['test']['request']['url'] != '':
        testcase_list.append(request)

    # 剔除备注使用的特殊关键字
    variables = testcase_list[0].get('config', {}).get('variables')
    if variables:
        for variab in variables:
            if isinstance(variab, dict):
                if '&remark&' in variab.keys():
                    variab.pop('&remark&')

    dump_yaml_file(os.path.join(testcase_dir_path, order_prefix + name + '.yml'), testcase_list)

    # 清除get_cache_case的缓存
    del_case_cache(obj.id)

    return obj.name


# 递归合并配置信息方法
def merge_config(basic_config, new_config):
    if type(basic_config) is dict and type(new_config) is dict:
        for config in basic_config:
            if config not in new_config:
                new_config[config] = basic_config[config]
            elif len(basic_config.keys()) > 0:
                merge_config(basic_config[config], new_config[config])


# 在线调试执行
def run_by_single2(request, base_url, path):
    config = {
        'config': {
            'name': '',
            'request': {
                'base_url': base_url
            }
        }
    }
    testcase_list = []

    testcase_list.append(config)

    case_info = request.get('test').get('case_info')
    module_id = case_info.get('module')
    belong_module = None
    try:
        belong_module = ModuleInfo.objects.get_module_name(module_id, type=False)
        module = belong_module.module_name
    except ObjectDoesNotExist:
        module = '缺省模块'

    include = eval(str(case_info.get('include')))
    name = request.get('test').get('name')
    project = case_info.get('project')

    project_info = ProjectInfo.objects.get_pro_name(project, type=False)

    # 获取工程关联的配置
    if project_info.config_id is not None:
        try:
            basic_config_request = TestCaseInfo.objects.get(id=project_info.config_id).request
            basic_request = eval(basic_config_request)
            if basic_request.get('config').get('request') is not None:
                basic_request.get('config').get('request').setdefault('base_url', base_url)

            basic_request['config']['name'] = name
            testcase_list[0] = basic_request
        except ObjectDoesNotExist:
            # raise ObjectDoesNotExist('项目关联的配置信息不存在，请检查')
            print('项目关联的配置信息不存在')

    # 获取模块关联的配置
    if belong_module is not None and belong_module.config_id is not None:
        try:
            basic_config_request = TestCaseInfo.objects.get(id=belong_module.config_id).request
            module_request = eval(basic_config_request)
            if module_request.get('config').get('request') is not None:
                module_request.get('config').get('request').setdefault('base_url', base_url)
            module_request['config']['name'] = name
            # 合并配置信息
            merge_config(testcase_list[0], module_request)
            testcase_list[0] = module_request
        except ObjectDoesNotExist:
            # raise ObjectDoesNotExist('模块关联的配置信息不存在，请检查')
            print('模块关联的配置信息不存在')

    config['config']['name'] = name

    testcase_dir_path = os.path.join(path, project)

    if not os.path.exists(testcase_dir_path):
        os.makedirs(testcase_dir_path)

        path = os.path.abspath(os.path.dirname(sys.argv[0]))
        w = open(path + '/' + 'ApiManager/utils/basic_function.py', encoding='utf8')
        basic_function = w.read()

        try:
            debugtalk = DebugTalk.objects.get(belong_project__project_name=project).debugtalk
        except ObjectDoesNotExist:
            debugtalk = ''

        dump_python_file(os.path.join(testcase_dir_path, 'debugtalk.py'),  basic_function + '\n' + '\n' + debugtalk)

    testcase_dir_path = os.path.join(testcase_dir_path, module)

    if not os.path.exists(testcase_dir_path):
        os.mkdir(testcase_dir_path)

    for test_info in include:
        try:
            if isinstance(test_info, dict):
                config_id = test_info.pop('config')[0]
                config_request = eval(TestCaseInfo.objects.get(id=config_id).request)
                if config_request.get('config').get('request') is not None:
                    config_request.get('config').get('request').setdefault('base_url', base_url)
                config_request['config']['name'] = name
                # 合并配置信息
                merge_config(testcase_list[0], config_request)
                testcase_list[0] = config_request
            else:
                id = test_info[0]
                case = TestCaseInfo.objects.get(id=id)
                pre_request = eval(case.request)
                if case.type == 2:
                    if pre_request.get('config').get('request') is not None:
                        pre_request.get('config').get('request').setdefault('base_url', base_url)
                    pre_request['config']['name'] = name
                    # 合并配置信息
                    merge_config(testcase_list[0], pre_request)
                    testcase_list[0] = pre_request
                else:
                    testcase_list.append(pre_request)
                    # 清除get_cache_case的缓存
                    del_case_cache(id)

        except ObjectDoesNotExist:
            return testcase_list

    if request['test']['request']['url'] != '':
        testcase_list.append(request)

    # 剔除备注使用的特殊关键字
    variables = testcase_list[0].get('config', {}).get('variables')
    if variables:
        for variab in variables:
            if isinstance(variab, dict):
                if '&remark&' in variab.keys():
                    variab.pop('&remark&')

    dump_yaml_file(os.path.join(testcase_dir_path, name + '.yml'), testcase_list)
    # 清除get_cache_case的缓存
    del_case_cache(case_info.get('test_index'))


# 单纯执行用例，不引入配置
def run_by_single3(index, base_url, path):
    config = {
        'config': {
            'name': '',
            'request': {
                'base_url': base_url
            }
        }
    }
    testcase_list = []

    testcase_list.append(config)

    try:
        obj = TestCaseInfo.objects.get(id=index)
    except ObjectDoesNotExist:
        return testcase_list

    include = eval(obj.include)
    request = eval(obj.request)
    name = obj.name
    project = obj.belong_project
    module = obj.belong_module.module_name

    project_info = ProjectInfo.objects.get_pro_name(project, type=False)

    # 获取工程关联的配置
    if project_info.config_id is not None:
        try:
            basic_config_request = TestCaseInfo.objects.get(id=project_info.config_id).request
            basic_request = eval(basic_config_request)
            if basic_request.get('config').get('request') is not None:
                basic_request.get('config').get('request').setdefault('base_url', base_url)
            basic_request['config']['name'] = name
            testcase_list[0] = basic_request
        except ObjectDoesNotExist:
            # raise ObjectDoesNotExist('项目关联的配置信息不存在，请检查')
            print('项目关联的配置信息不存在')

    # 获取模块关联的配置
    if obj.belong_module.config_id is not None:
        try:
            basic_config_request = TestCaseInfo.objects.get(id=obj.belong_module.config_id).request
            module_request = eval(basic_config_request)
            if module_request.get('config').get('request') is not None:
                module_request.get('config').get('request').setdefault('base_url', base_url)
            module_request['config']['name'] = name
            # 合并配置信息
            merge_config(testcase_list[0], module_request)
            testcase_list[0] = module_request
        except ObjectDoesNotExist:
            # raise ObjectDoesNotExist('模块关联的配置信息不存在，请检查')
            print('模块关联的配置信息不存在')

    config['config']['name'] = name

    testcase_dir_path = os.path.join(path, project)

    if not os.path.exists(testcase_dir_path):
        os.makedirs(testcase_dir_path)

        path = os.path.abspath(os.path.dirname(sys.argv[0]))
        w = open(path + '/' + 'ApiManager/utils/basic_function.py', encoding='utf8')
        basic_function = w.read()

        try:
            debugtalk = DebugTalk.objects.get(belong_project__project_name=project).debugtalk
        except ObjectDoesNotExist:
            debugtalk = ''

        dump_python_file(os.path.join(testcase_dir_path, 'debugtalk.py'), basic_function + '\n' + '\n' + debugtalk)

    testcase_dir_path = os.path.join(testcase_dir_path, module)

    if not os.path.exists(testcase_dir_path):
        os.mkdir(testcase_dir_path)

    for test_info in include:
        try:
            if isinstance(test_info, dict):
                config_id = test_info.pop('config')[0]
                config_request = eval(TestCaseInfo.objects.get(id=config_id).request)
                config_request.get('config').get('request').setdefault('base_url', base_url)
                config_request['config']['name'] = name
                # 合并配置信息
                merge_config(testcase_list[0], config_request)
                testcase_list[0] = config_request
            else:
                id = test_info[0]
                pre_request = eval(TestCaseInfo.objects.get(id=id).request)
                testcase_list.append(pre_request)

        except ObjectDoesNotExist:
            return testcase_list

    if request['test']['request']['url'] != '':
        testcase_list.append(request)

    # 剔除备注使用的特殊关键字
    variables = testcase_list[0].get('config', {}).get('variables')
    if variables:
        for variab in variables:
            if isinstance(variab, dict):
                if '&remark&' in variab.keys():
                    variab.pop('&remark&')

    # 剔除包含本用例的函数调用
    testcase_list[0] = recursive_config(testcase_list[0], obj.id)

    dump_yaml_file(os.path.join(testcase_dir_path, name + '.yml'), testcase_list)

    return obj.name


# 递归配置中的所有信息
def recursive_config(content, case_id):
    if content is None:
        return None

    if isinstance(content, (list, tuple)):
        return [
            recursive_config(item, case_id)
            for item in content
        ]

    if isinstance(content, dict):
        evaluated_data = {}
        for key, value in content.items():
            eval_key = recursive_config(key, case_id)
            eval_value = recursive_config(value, case_id)
            evaluated_data[eval_key] = eval_value

        return evaluated_data

    # 判断是否有使用get_case 或者get_cache_case方法调用本用例，如果有则剔除,避免循环调用
    if content is not None and isinstance(content, str) and content is not '':
        # ${get_cache_case(9,data.access_token)}
        # case_keyword = '${get_case(' + str(case_id) + ','
        # cache_case_keyword = '${get_cache_case(' + str(case_id) + ','

        # 2019-08-12 改为 只要包含${get_case 或者 ${get_cache_case 的调用都剔除
        case_keyword = '${get_case'
        cache_case_keyword = '${get_cache_case'

        # id关键字 替换的内容包含case_id就替换
        id_keyword = '(' + str(case_id) + ','
        if case_keyword in content:
            start_index = content.find(case_keyword)
            end_index = content.find(')}', start_index) + 2
            replace_content = content[start_index: end_index]
            if id_keyword in replace_content:
                content = content.replace(replace_content, '')
        if cache_case_keyword in content:
            start_index = content.find(cache_case_keyword)
            end_index = content.find(')}', start_index) + 2
            replace_content = content[start_index: end_index]
            if id_keyword in replace_content:
                content = content.replace(replace_content, '')

    return content


# 执行套件
def run_by_suite(index, base_url, path):
    obj = TestSuite.objects.get(id=index)

    include = eval(obj.include)

    # 套件运行需要按顺序执行，httprunner目前不支持，在生成的yml文件名称前增加序号，用于执行排序
    size = 1
    for val in include:
        order_prefix = str(size) + '_sort_@'
        run_by_single(val[0], base_url, path, order_prefix)
        size = size + 1

    return obj.suite_name



def run_by_batch(test_list, base_url, path, type=None, mode=False):
    """
    批量组装用例数据
    :param test_list:
    :param base_url: str: 环境地址
    :param type: str：用例级别
    :param mode: boolean：True 同步 False: 异步
    :return: list
    """

    if mode:
        for index in range(len(test_list) - 2):
            form_test = test_list[index].split('=')
            value = form_test[1]
            if type == 'project':
                run_by_project(value, base_url, path)
            elif type == 'module':
                run_by_module(value, base_url, path)
            elif type == 'suite':
                run_by_suite(value, base_url, path)
            else:
                run_by_single(value, base_url, path)

    else:
        if type == 'project':
            for value in test_list.values():
                run_by_project(value, base_url, path)

        elif type == 'module':
            for value in test_list.values():
                run_by_module(value, base_url, path)
        elif type == 'suite':
            for value in test_list.values():
                run_by_suite(value, base_url, path)

        else:
            for index in range(len(test_list) - 1):
                form_test = test_list[index].split('=')
                index = form_test[1]
                run_by_single(index, base_url, path)


def run_by_module(id, base_url, path):
    """
    组装模块用例
    :param id: int or str：模块索引
    :param base_url: str：环境地址
    :return: list
    """
    obj = ModuleInfo.objects.get(id=id)
    test_list = TestCaseInfo.objects.filter(belong_module=obj, type=1).all()
    for index in test_list:
        # 只运行运行类型=独立的用例
        if index.run_type == 1:
            run_by_single(index.id, base_url, path)



    return obj.module_name


def run_by_project(id, base_url, path):
    """
    组装项目用例
    :param id: int or str：项目索引
    :param base_url: 环境地址
    :return: list
    """
    obj = ProjectInfo.objects.get(id=id)
    module_index_list = ModuleInfo.objects.filter(belong_project=obj).values_list('id')
    for index in module_index_list:
        module_id = index[0]
        run_by_module(module_id, base_url, path)

    return obj.project_name


def run_test_by_type(id, base_url, path, type):
    if type == 'project':
        name = run_by_project(id, base_url, path)
    elif type == 'module':
        name = run_by_module(id, base_url, path)
    elif type == 'suite':
        name = run_by_suite(id, base_url, path)
    else:
        name = run_by_single(id, base_url, path)

    return name


# 根据用例Id执行用例返回执行结果
def run_test_ty_id(case_id):
    kwargs = {
        "failfast": False,
    }
    runner = HttpRunner(**kwargs)

    testcase_dir_path = os.path.join(os.getcwd(), "suite")
    testcase_dir_path = os.path.join(testcase_dir_path, get_time_stamp())

    run_by_single3(case_id, '', testcase_dir_path)

    runner.run2(testcase_dir_path)
    shutil.rmtree(testcase_dir_path)

    runner.summary = timestamp_to_datetime(runner.summary, type=False)

    details = runner.summary.get('details')
    return details


# 运行服务关联
def run_by_service(service_config_id, base_url):
    service_config_details = ServiceConfigDetail.objects.filter(service_config_id=service_config_id).all()
    service_config_details = list(service_config_details)

    # 用例ID集合
    test_case_alls = []
    # 套件ID集合
    suite_alls = []
    for service_config_detail in service_config_details:
        type = service_config_detail.relation_type
        relation_id = service_config_detail.relation_id
        if type == 1:
            modules = ModuleInfo.objects.filter(belong_project_id=relation_id).values(
                'id').all()
            modules = list(modules)
            for module in modules:
                test_cases = TestCaseInfo.objects.filter(belong_module_id=module.get('id'), type=1, run_type=1).values('id').all()
                test_cases = list(test_cases)
                test_case_alls.extend(test_cases)
        if type == 2:
            test_cases = TestCaseInfo.objects.filter(belong_module_id=relation_id, type=1, run_type=1).values('id').all()
            test_case_alls.extend(list(test_cases))
        if type == 3:
            suite = {
                'id': relation_id
            }
            suite_alls.append(suite)
        if type == 4:
            test_case = {
                'id': relation_id
            }
            test_case_alls.append(test_case)
        if type == 5:
            test_cases = TestCaseInfo.objects.filter(service_name=relation_id, type=1, run_type=1).values('id').all()
            test_case_alls.extend(list(test_cases))

    runners = []
    # 已执行用例id，用于去除重复
    present_ids = []
    if test_case_alls:
        testcase_dir_path = os.path.join(os.getcwd(), "suite")
        testset_path = os.path.join(testcase_dir_path, get_time_stamp())
        # 运行用例
        for test_case in test_case_alls:
            case_id = test_case.get('id')
            if case_id not in present_ids:
                run_by_single(case_id, base_url, testset_path)
                present_ids.append(case_id)

        kwargs = {
            "failfast": False,
        }
        runner = HttpRunner(**kwargs)
        runner.run2(testset_path)
        shutil.rmtree(testset_path)

        runner.summary = timestamp_to_datetime(runner.summary)
        runners.append(runner)

    if suite_alls:
        for suite in suite_alls:
            testcase_dir_path = os.path.join(os.getcwd(), "suite")
            testset_path = os.path.join(testcase_dir_path, get_time_stamp())

            run_by_suite(suite.get('id'), base_url, testset_path)

            kwargs = {
                "failfast": False,
            }
            runner = HttpRunner(**kwargs)
            runner.run2(testset_path)
            shutil.rmtree(testset_path)

            runner.summary = timestamp_to_datetime(runner.summary)
            runners.append(runner)

    # 合并运行结果并生成报告
    report_runner = None
    for runn in runners:
        if report_runner is None:
            report_runner = runn
        else:
            # 合并结果
            report_runner.summary = merge_summary(report_runner.summary, runn.summary)
    return report_runner


# 合并运行结果
def merge_summary(summary1, summary2):
    if not summary2.get('success'):
        summary1['success'] = False
    for key in summary1.get('stat').keys():
        summary1['stat'][key] = summary1.get('stat').get(key) + summary2.get('stat').get(key)
    summary1.get('details').extend(summary2.get('details'))
    return summary1


# 运行逻辑用例
def run_by_logic_test(index, base_url, path, order_prefix=''):
    config = {
        'config': {
            'name': '',
            'request': {
                'base_url': base_url
            }
        }
    }
    testcase_list = []

    testcase_list.append(config)

    try:
        obj = TestCaseLogicInfo.objects.get(id=index)
    except ObjectDoesNotExist:
        return testcase_list

    include = eval(obj.include)
    request = eval(obj.request)
    name = obj.name
    project = obj.belong_project
    module = obj.belong_module.module_name

    project_info = ProjectInfo.objects.get_pro_name(project, type=False)

    # 获取工程关联的配置
    if project_info.config_id is not None:
        try:
            basic_config_request = TestCaseLogicInfo.objects.get(id=project_info.config_id).request
            basic_request = eval(basic_config_request)
            if basic_request.get('config').get('request') is not None:
                basic_request.get('config').get('request').setdefault('base_url', base_url)
            basic_request['config']['name'] = name
            testcase_list[0] = basic_request
        except ObjectDoesNotExist:
            # raise ObjectDoesNotExist('项目关联的配置信息不存在，请检查')
            print('项目关联的配置信息不存在')

    # 获取模块关联的配置
    if obj.belong_module.config_id is not None:
        try:
            basic_config_request = TestCaseLogicInfo.objects.get(id=obj.belong_module.config_id).request
            module_request = eval(basic_config_request)
            if module_request.get('config').get('request') is not None:
                module_request.get('config').get('request').setdefault('base_url', base_url)
            module_request['config']['name'] = name
            # 合并配置信息
            merge_config(testcase_list[0], module_request)
            testcase_list[0] = module_request
        except ObjectDoesNotExist:
            # raise ObjectDoesNotExist('模块关联的配置信息不存在，请检查')
            print('模块关联的配置信息不存在')

    config['config']['name'] = name

    testcase_dir_path = os.path.join(path, project)

    if not os.path.exists(testcase_dir_path):
        os.makedirs(testcase_dir_path)

        path = os.path.abspath(os.path.dirname(sys.argv[0]))
        w = open(path + '/' + 'ApiManager/utils/basic_function.py', encoding='utf8')
        basic_function = w.read()

        try:
            debugtalk = DebugTalk.objects.get(belong_project__project_name=project).debugtalk
        except ObjectDoesNotExist:
            debugtalk = ''

        dump_python_file(os.path.join(testcase_dir_path, 'debugtalk.py'), basic_function + '\n' + '\n' + debugtalk)

    testcase_dir_path = os.path.join(testcase_dir_path, module)

    if not os.path.exists(testcase_dir_path):
        os.mkdir(testcase_dir_path)

    for test_info in include:
        try:
            if isinstance(test_info, dict):
                config_id = test_info.pop('config')[0]
                config_request = eval(TestCaseInfo.objects.get(id=config_id).request)
                if config_request.get('config').get('request') is not None:
                    config_request.get('config').get('request').setdefault('base_url', base_url)
                config_request['config']['name'] = name
                # 合并配置信息
                merge_config(testcase_list[0], config_request)
                testcase_list[0] = config_request
            else:
                id = test_info[0]
                pre_request = eval(TestCaseInfo.objects.get(id=id).request)
                testcase_list.append(pre_request)
                # 清除get_cache_case的缓存
                del_case_cache(id)

        except ObjectDoesNotExist:
            return testcase_list

    if request['test']['request']['url'] != '':
        testcase_list.append(request)

    # 剔除备注使用的特殊关键字
    variables = testcase_list[0].get('config', {}).get('variables')
    if variables:
        for variab in variables:
            if isinstance(variab, dict):
                if '&remark&' in variab.keys():
                    variab.pop('&remark&')

    dump_yaml_file(os.path.join(testcase_dir_path, order_prefix + name + '.yml'), testcase_list)

    # 清除get_cache_case的缓存
    del_case_cache(obj.id)

    return obj.name