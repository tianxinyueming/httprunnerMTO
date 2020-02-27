# encoding: utf-8

import copy
import sys
import unittest

from httprunner import exceptions, logger, runner, testcase, utils
from httprunner.compat import is_py3
from httprunner.report import (HtmlTestResult, get_platform, get_summary,
                               render_html_report)
from httprunner.testcase import TestcaseLoader
from httprunner.utils import load_dot_env_file, print_output
from ApiManager.utils.case_cache import del_case_cache
from ApiManager.models import TestCaseInfo

class TestCase(unittest.TestCase):
    """ create a testcase.
    """
    def __init__(self, test_runner, testcase_dict):
        super(TestCase, self).__init__()
        self.test_runner = test_runner
        self.testcase_dict = copy.copy(testcase_dict)

    def runTest(self):
        """ run testcase and check result.
        """
        try:
            self.test_runner.run_test(self.testcase_dict)
        except exceptions.MyBaseFailure as ex:
            self.fail(repr(ex))
        finally:
            if hasattr(self.test_runner.http_client_session, "meta_data"):
                self.meta_data = self.test_runner.http_client_session.meta_data
                self.meta_data["validators"] = self.test_runner.context.evaluated_validators
                self.test_runner.http_client_session.init_meta_data()


class TestSuite(unittest.TestSuite):
    """ create test suite with a testset, it may include one or several testcases.
        each suite should initialize a separate Runner() with testset config.
    @param
        (dict) testset
            {
                "name": "testset description",
                "config": {
                    "name": "testset description",
                    "parameters": {},
                    "variables": [],
                    "request": {},
                    "output": []
                },
                "testcases": [
                    {
                        "name": "testcase description",
                        "parameters": {},
                        "variables": [],    # optional, override
                        "request": {},
                        "extract": {},      # optional
                        "validate": {}      # optional
                    },
                    testcase12
                ]
            }
        (dict) variables_mapping:
            passed in variables mapping, it will override variables in config block
    """
    def __init__(self, testset, variables_mapping=None, http_client_session=None):
        super(TestSuite, self).__init__()
        self.test_runner_list = []

        self.config = testset.get("config", {})
        self.output_variables_list = self.config.get("output", [])
        self.testset_file_path = self.config.get("path")
        config_dict_parameters = self.config.get("parameters", [])

        config_dict_variables = self.config.get("variables", [])
        variables_mapping = variables_mapping or {}
        config_dict_variables = utils.override_variables_binds(config_dict_variables, variables_mapping)

        config_parametered_variables_list = self._get_parametered_variables(
            config_dict_variables,
            config_dict_parameters
        )
        self.testcase_parser = testcase.TestcaseParser()
        testcases = testset.get("testcases", [])

        for config_variables in config_parametered_variables_list:
            # config level
            self.config["variables"] = config_variables
            test_runner = runner.Runner(self.config, http_client_session)

            for testcase_dict in testcases:
                testcase_dict = copy.copy(testcase_dict)
                # testcase level
                testcase_parametered_variables_list = self._get_parametered_variables(
                    testcase_dict.get("variables", []),
                    testcase_dict.get("parameters", [])
                )
                for testcase_variables in testcase_parametered_variables_list:
                    testcase_dict["variables"] = testcase_variables

                    # eval testcase name with bind variables
                    variables = utils.override_variables_binds(
                        config_variables,
                        testcase_variables
                    )
                    self.testcase_parser.update_binded_variables(variables)
                    try:
                        testcase_name = self.testcase_parser.eval_content_with_bindings(testcase_dict["name"])
                    except (AssertionError, exceptions.ParamsError):
                        logger.log_warning("failed to eval testcase name: {}".format(testcase_dict["name"]))
                        testcase_name = testcase_dict["name"]
                    self.test_runner_list.append((test_runner, variables))

                    self._add_test_to_suite(testcase_name, test_runner, testcase_dict)

    def _get_parametered_variables(self, variables, parameters):
        """ parameterize varaibles with parameters
        """
        cartesian_product_parameters = testcase.parse_parameters(
            parameters,
            self.testset_file_path
        ) or [{}]

        parametered_variables_list = []
        for parameter_mapping in cartesian_product_parameters:
            parameter_mapping = parameter_mapping or {}
            variables = utils.override_variables_binds(
                variables,
                parameter_mapping
            )

            parametered_variables_list.append(variables)

        return parametered_variables_list

    def _add_test_to_suite(self, testcase_name, test_runner, testcase_dict):
        if is_py3:
            TestCase.runTest.__doc__ = testcase_name
        else:
            TestCase.runTest.__func__.__doc__ = testcase_name

        test = TestCase(test_runner, testcase_dict)
        [self.addTest(test) for _ in range(int(testcase_dict.get("times", 1)))]

    @property
    def output(self):
        outputs = []

        for test_runner, variables in self.test_runner_list:
            out = test_runner.extract_output(self.output_variables_list)
            if not out:
                continue

            in_out = {
                "in": dict(variables),
                "out": out
            }
            if in_out not in outputs:
                outputs.append(in_out)

        return outputs


def init_test_suites(path_or_testsets, mapping=None, http_client_session=None):
    """ initialize TestSuite list with testset path or testset dict
    @params
        testsets (dict/list): testset or list of testset
            testset_dict
            or
            [
                testset_dict_1,
                testset_dict_2,
                {
                    "config": {},
                    "api": {},
                    "testcases": [testcase11, testcase12]
                }
            ]
        mapping (dict):
            passed in variables mapping, it will override variables in config block
    """
    if not testcase.is_testsets(path_or_testsets):
        TestcaseLoader.load_test_dependencies()
        testsets = TestcaseLoader.load_testsets_by_path(path_or_testsets)
    else:
        testsets = path_or_testsets

    # TODO: move comparator uniform here
    mapping = mapping or {}

    if not testsets:
        raise exceptions.TestcaseNotFound

    if isinstance(testsets, dict):
        testsets = [testsets]

    test_suite_list = []
    for testset in testsets:
        test_suite = TestSuite(testset, mapping, http_client_session)
        test_suite_list.append(test_suite)

    return test_suite_list


'''
重写初始化测试用例方法，进行排序和延迟创建TestSuite对象
'''


def init_test_suites2(path_or_testsets):

    if not testcase.is_testsets(path_or_testsets):
        TestcaseLoader.load_test_dependencies()
        testsets = TestcaseLoader.load_testsets_by_path(path_or_testsets)
    else:
        testsets = path_or_testsets

    if not testsets:
        raise exceptions.TestcaseNotFound

    if isinstance(testsets, dict):
        testsets = [testsets]

    order_case_dict = {}

    # 根据文件名称中的关键字'_sort_@'，按顺序加载
    for testset in testsets:
        testset_file_path = testset.get("config", {}).get("path")

        start_index = testset_file_path.rfind('\\')
        if start_index == -1:
            start_index = testset_file_path.rfind('/')
        testset_file_name = testset_file_path[start_index+1:]

        order_index = testset_file_name.find('_sort_@')
        if order_index != -1:
            order_key = int(testset_file_name[0:order_index])
        else:
            order_key = -1

        if order_key not in order_case_dict.keys():
            order_value = []
            order_value.append(testset)
            order_case_dict[order_key] = order_value
        else:
            order_case_dict[order_key].append(testset)

    # 对字典key进行排序
    order_keys = sorted(order_case_dict)
    # 按字典key顺序组装集合
    testset_list = []
    for key in order_keys:
        testset_list.extend(order_case_dict[key])

    return testset_list


class HttpRunner(object):

    def __init__(self, **kwargs):
        """ initialize test runner
        @param (dict) kwargs: key-value arguments used to initialize TextTestRunner
            - resultclass: HtmlTestResult or TextTestResult
            - failfast: False/True, stop the test run on the first error or failure.
            - dot_env_path: .env file path
        """
        dot_env_path = kwargs.pop("dot_env_path", None)
        load_dot_env_file(dot_env_path)

        kwargs.setdefault("resultclass", HtmlTestResult)
        self.runner = unittest.TextTestRunner(**kwargs)

    def run(self, path_or_testsets, mapping=None):
        """ start to run test with varaibles mapping
        @param path_or_testsets: YAML/JSON testset file path or testset list
            path: path could be in several type
                - absolute/relative file path
                - absolute/relative folder path
                - list/set container with file(s) and/or folder(s)
            testsets: testset or list of testset
                - (dict) testset_dict
                - (list) list of testset_dict
                    [
                        testset_dict_1,
                        testset_dict_2
                    ]
        @param (dict) mapping:
            if mapping specified, it will override variables in config block
        """
        try:
            test_suite_list = init_test_suites(path_or_testsets, mapping)
        except exceptions.TestcaseNotFound:
            logger.log_error("Testcases not found in {}".format(path_or_testsets))
            sys.exit(1)

        self.summary = {
            "success": True,
            "stat": {},
            "time": {},
            "platform": get_platform(),
            "details": []
        }

        def accumulate_stat(origin_stat, new_stat):
            """ accumulate new_stat to origin_stat
            """
            for key in new_stat:
                if key not in origin_stat:
                    origin_stat[key] = new_stat[key]
                elif key == "start_at":
                    # start datetime
                    origin_stat[key] = min(origin_stat[key], new_stat[key])
                else:
                    origin_stat[key] += new_stat[key]

        for test_suite in test_suite_list:
            result = self.runner.run(test_suite)
            test_suite_summary = get_summary(result)

            self.summary["success"] &= test_suite_summary["success"]
            test_suite_summary["name"] = test_suite.config.get("name")
            test_suite_summary["base_url"] = test_suite.config.get("request", {}).get("base_url", "")
            test_suite_summary["output"] = test_suite.output
            print_output(test_suite_summary["output"])

            accumulate_stat(self.summary["stat"], test_suite_summary["stat"])
            accumulate_stat(self.summary["time"], test_suite_summary["time"])

            self.summary["details"].append(test_suite_summary)

        return self

    '''
      重写运行，改为支持yml之间结果参数传输
    '''

    def run2(self, path_or_testsets, mapping=None):
        try:
            test_suite_list = init_test_suites2(path_or_testsets)
        except exceptions.TestcaseNotFound:
            logger.log_error("Testcases not found in {}".format(path_or_testsets))
            sys.exit(1)

        self.summary = {
            "success": True,
            "stat": {},
            "time": {},
            "platform": get_platform(),
            "details": []
        }

        mapping = mapping or {}

        def accumulate_stat(origin_stat, new_stat):
            """ accumulate new_stat to origin_stat
            """
            for key in new_stat:
                if key not in origin_stat:
                    origin_stat[key] = new_stat[key]
                elif key == "start_at":
                    # start datetime
                    origin_stat[key] = min(origin_stat[key], new_stat[key])
                else:
                    origin_stat[key] += new_stat[key]

        # 各用例提取的变量
        extract_parameter = {}

        for test_suite in test_suite_list:
            extract_list = test_suite.get('testcases', {})[0].get('extract')

            # # 合并各用例提取的变量
            # variables = test_suite.testcase_parser.variables
            # test_suite.testcase_parser.update_binded_variables(dict(variables, **extract_parameter))

            try:
                test_suite = TestSuite(test_suite, dict(extract_parameter, **mapping))
            except exceptions.ParamsError as e:
                raise Exception("出现异常，参数错误: {0}".format(e))
            except exceptions.VariableNotFound as e:
                raise Exception("出现异常，变量不存在: {0}".format(e))
            except BaseException as e:
                raise Exception("出现异常: {0}".format(e))

            result = self.runner.run(test_suite)
            test_suite_summary = get_summary(result)

            name = test_suite.config.get("name")
            test_infos = TestCaseInfo.objects.filter(name=name).all()
            test_infos = list(test_infos)
            if test_infos:
                # 清除get_cache_case的缓存
                del_case_cache(test_infos[0].id)

            self.summary["success"] &= test_suite_summary["success"]
            test_suite_summary["name"] = name
            test_suite_summary["base_url"] = test_suite.config.get("request", {}).get("base_url", "")
            test_suite_summary["output"] = test_suite.output
            print_output(test_suite_summary["output"])

            accumulate_stat(self.summary["stat"], test_suite_summary["stat"])
            accumulate_stat(self.summary["time"], test_suite_summary["time"])

            # 根据返回结果提取变量值
            if extract_list is not None and isinstance(extract_list, list):
                records = test_suite_summary.get('records')
                data_result = records[0].get('meta_data').get('response').get('json')

                if data_result is not None:
                    for extract in extract_list:
                        print(extract)
                        for key, value in extract.items():
                            try:
                                extract_value = {}
                                extract_value['content'] = data_result
                                fields = str(value).split('.')
                                extract_success = True
                                for field in fields:
                                    if isinstance(extract_value, dict):
                                        extract_value = extract_value.get(field)
                                    elif isinstance(extract_value, list):
                                        if extract_value:
                                            extract_value = extract_value[int(field)]
                                        else:
                                            extract_success = False
                                            # raise Exception('提取变量失败，', '路径：', value, '下的结果不存在,请检查')
                                if extract_success:
                                    extract_parameter[key] = extract_value
                            except AttributeError as e:
                                print('run运行错误：未提取到变量')
                            except Exception as e:
                                logger.log_error("出现错误.{0}".format(e))

            self.summary["details"].append(test_suite_summary)

        return self

    def gen_html_report(self, html_report_name=None, html_report_template=None, report_dir_path=None):
        """ generate html report and return report path
        @param (str) html_report_name:
            output html report file name
        @param (str) html_report_template:
            report template file path, template should be in Jinja2 format
        """
        return render_html_report(
            self.summary,
            html_report_name,
            html_report_template,
            report_dir_path
        )


class LocustTask(object):

    def __init__(self, path_or_testsets, locust_client, mapping=None):
        self.test_suite_list = init_test_suites(path_or_testsets, mapping, locust_client)

    def run(self):
        for test_suite in self.test_suite_list:
            for test in test_suite:
                try:
                    test.runTest()
                except exceptions.MyBaseError as ex:
                    from locust.events import request_failure
                    request_failure.fire(
                        request_type=test.testcase_dict.get("request", {}).get("method"),
                        name=test.testcase_dict.get("request", {}).get("url"),
                        response_time=0,
                        exception=ex
                    )
