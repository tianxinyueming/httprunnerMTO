import ast
import collections
import io
import itertools
import json
import os
import random
import re

from httprunner import exceptions, logger, utils
from httprunner.compat import (OrderedDict, basestring, builtin_str,
                               numeric_types, str)
from httprunner.utils import FileUtils
from httprunner.testcase import TestcaseParser

'''
testcase扩展
'''


# 重写解析parameters方法，改为1一对一形式，并且绑定断言
def parse_parameters2(parameters, testset_path=None):
    testcase_parser = TestcaseParser(file_path=testset_path)

    parsed_parameters_list = []
    parameter_index = 0
    assert_list = []
    for parameter in parameters:
        parameter_items = list(parameter.items())
        if len(parameter_items) == 0:
            continue
        parameter_name, parameter_content = parameter_items[0]

        assert_content =None
        for key, value in parameter_items:
            if key == '&assert&':
                assert_content = value
                continue
            parameter_name = key
            parameter_content = value

        parameter_name_list = parameter_name.split("-")

        assert_list.append(assert_content)

        i = 0
        parameter_content_list = []
        for parameter_key in parameter_name_list:
            parameter_item = None
            if isinstance(parameter_content, list):
                parameter_content_size = len(parameter_content)
                if i < parameter_content_size:
                    parameter_item = parameter_content[i]

            parameter_val = {
                parameter_key: parameter_item
            }

            parameter_content_list.append(parameter_val)
            i = i + 1

        parsed_parameters_list.append(parameter_content_list)
        parameter_index = parameter_index + 1

    return gen_cartesian_product(*parsed_parameters_list), assert_list


def gen_cartesian_product(*args):
    if not args:
        return []
    elif len(args) == 1:
        return args[0]

    product_list = []
    for product_item_tuple in args:
        product_item_dict = {}
        for item in product_item_tuple:
            product_item_dict.update(item)

        product_list.append(product_item_dict)

    return product_list