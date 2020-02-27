
from httprunner.task import TestCase, TestSuite,HttpRunner,init_test_suites2
import copy
import sys
import unittest

from httprunner import exceptions, logger, runner, testcase, utils, testcase_extend
from httprunner.compat import is_py3
from httprunner.report import (HtmlTestResult, get_platform, get_summary,
                               render_html_report)
from httprunner.testcase import TestcaseLoader
from httprunner.utils import load_dot_env_file, print_output
from ApiManager.utils.case_cache import del_case_cache
from ApiManager.models import TestCaseInfo
import ast

'''
task扩展
'''


class TestCase_ext:
    def __init__(self):
        print(1)

    def test(self,tess):
        print(tess)


class HttpRunner_ext(HttpRunner):
    def __init__(self, **kwargs):
        dot_env_path = kwargs.pop("dot_env_path", None)
        load_dot_env_file(dot_env_path)

        kwargs.setdefault("resultclass", HtmlTestResult)
        self.runner = unittest.TextTestRunner(**kwargs)

    def run3(self, path_or_testsets, mapping=None):
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
                test_suite = TestSuite_ext(test_suite, dict(extract_parameter, **mapping))
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


class TestSuite_ext(TestSuite):
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

        config_parametered_variables_lists = self._get_parametered_variables(
            config_dict_variables,
            config_dict_parameters
        )

        config_parametered_variables_list = config_parametered_variables_lists[0]

        self.testcase_parser = testcase.TestcaseParser()
        testcases = testset.get("testcases", [])

        for config_variables in config_parametered_variables_list:
            # config level
            self.config["variables"] = config_variables
            test_runner = runner.Runner(self.config, http_client_session)

            for testcase_dict in testcases:
                testcase_dict = copy.copy(testcase_dict)
                # testcase level
                testcase_parametered_variables_lists = self._get_parametered_variables(
                    testcase_dict.get("variables", []),
                    testcase_dict.get("parameters", [])
                )
                testcase_parametered_variables_list = testcase_parametered_variables_lists[0]
                assert_list = testcase_parametered_variables_lists[1]
                testcase_index = 0
                if 'validate' not in testcase_dict.keys():
                    testcase_dict['validate'] = []

                basic_validate = testcase_dict['validate']

                for testcase_variables in testcase_parametered_variables_list:
                    testcase_dict["variables"] = testcase_variables

                    asserts_str = assert_list[testcase_index]
                    asserts = ast.literal_eval(asserts_str)
                    # validates = []
                    checks = {}
                    if isinstance(asserts, list):
                        for validate in asserts:
                            # validate = {
                            #     'check': 'content.code',
                            #     'comparator': 'equals',
                            #     'expected': '100201'
                            # }
                            # validates.append(validate)
                            checks[validate.get('check')] = 1
                    elif isinstance(asserts, dict):
                        checks[asserts.get('check')] = 1
                        asserts = [asserts]
                    else:
                        asserts = []

                    validates = []
                    validates.extend(asserts)
                    # 去重，以parameters中的断言优先
                    for validate in basic_validate:
                        check = validate.get('check')
                        if check not in checks.keys():
                            validates.append(validate)

                    testcase_dict['validate'] = validates

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

                    testcase_index = testcase_index + 1

    def _get_parametered_variables(self, variables, parameters):
        """ parameterize varaibles with parameters
        """
        cartesian_product_parameters_list = testcase_extend.parse_parameters2(
            parameters,
            self.testset_file_path
        )

        cartesian_product_parameters = cartesian_product_parameters_list[0] or [{}]
        assert_list = cartesian_product_parameters_list[1] or [{}]

        parametered_variables_list = []
        for parameter_mapping in cartesian_product_parameters:
            parameter_mapping = parameter_mapping or {}
            variables = utils.override_variables_binds(
                variables,
                parameter_mapping
            )

            parametered_variables_list.append(variables)

        return parametered_variables_list, assert_list

    def _add_test_to_suite(self, testcase_name, test_runner, testcase_dict):
        if is_py3:
            TestCase.runTest.__doc__ = testcase_name
        else:
            TestCase.runTest.__func__.__doc__ = testcase_name

        testcase_dict['test'] = "1111111111111111111"
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

