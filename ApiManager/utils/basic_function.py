"""
基本函数实现
提供使用中使用的获取随机数，时间等基本方法
"""
import random
import time
import datetime
import math
import uuid
from ApiManager.utils.runner import run_test_ty_id
from ApiManager.utils import case_cache


# 生成当前时间字符
# type 时间格式类型 day 增加天数 add_time_unit 增加时间单位
def get_time(time_type=1, day=0, add_time_unit='days'):
    format_json = {
        1: '%Y-%m-%d %H:%M:%S',
        2: '%Y-%m-%d %H:%M',
        3: '%Y-%m-%d %H',
        4: '%Y-%m-%d',
        5: '%Y-%m',
        6: '%Y',
        7: '%Y%m%d%H%M%S',
        8: '%Y%m%d%H%M',
        9: '%Y%m%d%H',
        10: '%Y%m%d',
        11: '%Y%m',
        12: '%M',
        13: '%d',
        14: '%H',
        15: '%M',
        16: '%S'
    }

    data_format = format_json.get(time_type)
    if add_time_unit == 'hours':
        return (datetime.datetime.now() + datetime.timedelta(hours=day)).strftime(data_format)
    if add_time_unit == 'minutes':
        return (datetime.datetime.now() + datetime.timedelta(minutes=day)).strftime(data_format)
    if add_time_unit == 'seconds':
        return (datetime.datetime.now() + datetime.timedelta(seconds=day)).strftime(data_format)
    if add_time_unit == 'weeks':
        return (datetime.datetime.now() + datetime.timedelta(weeks=day)).strftime(data_format)

    return (datetime.datetime.now() + datetime.timedelta(days=day)).strftime(data_format)


# 生成当前时间戳
def get_timestamp():
    return int(round(time.time() * 1000))


# 生成指定范围随机整数
def get_randint(min_num=0, max_num=100):
    return random.randint(min_num, max_num)


# 生成指定位数随机数
def get_rand(size=5):
    value = int(random.random() * math.pow(10, size))
    if len(str(value)) < size:
        value = value * math.pow(10, size - len(str(value)))
    return int(value)


# 生成指定位数随机中文
def get_rand_chinese(size=1):
    rand_str = ''
    for i in range(size):
        head = random.randint(0xb0, 0xf7)
        body = random.randint(0xa1, 0xf9)  # 在head区号为55的那一块最后5个汉字是乱码,为了方便缩减下范围
        val = f'{head:x}{body:x}'
        rand_str = rand_str + bytes.fromhex(val).decode('gb2312')
    return rand_str


# 生成随机字符,默认32位
def get_uuid(size=32):
    return str(uuid.uuid1()).replace('-', '')[0:size]


# 获取用例结果 case_id：用例Id，result_field 返回字段路径：如data.token
def get_case(case_id, result_field):
    details = run_test_ty_id(case_id)
    detail_size = len(details)
    if detail_size > 0:
        records = details[detail_size - 1].get('records')
        records_len = len(records)
        if records_len > 0:
            try:
                result = records[records_len - 1].get('meta_data').get('response').get('json')

                fields = str(result_field).split('.')
                for field in fields:
                    if isinstance(result, dict):
                        result = result.get(field)
                    elif isinstance(result, list):
                        if result:
                            result = result[int(field)]
                        else:
                            raise AttributeError

                return str(result)
            except AttributeError as e:
                raise RuntimeError('获取get_case结果失败，用例', case_id, '路径：', result_field, '下的结果不存在,请检查', e)

    raise RuntimeError('获取get_case结果失败，请检查')


# 获取用例结果(结果加缓存) case_id：用例Id，result_field 返回字段路径：如data.token
def get_cache_case(case_id, result_field, expire_time=1800):
    # 先读取缓存结果，如果环境没哟或者过期，则重新获取
    try:
        key = case_cache.TEST_CASE_KEY_PREFIX + str(case_id)
        if case_cache.exists_key(key):
            result_data = case_cache.get(key)
            result = private_get_result(result_data, result_field)
            return result

        details = run_test_ty_id(case_id)
        detail_size = len(details)
        if detail_size > 0:
            records = details[detail_size - 1].get('records')
            records_len = len(records)
            if records_len > 0:
                result_data = records[records_len - 1].get('meta_data').get('response').get('json')
                result = private_get_result(result_data, result_field)
                # 添加缓存
                case_cache.set(key, result_data, expire_time)
                return result
    except AttributeError as e:
        raise RuntimeError('获取get_cache_case结果失败，用例', case_id, '路径：', result_field, '下的结果不存在,请检查', e)

    raise RuntimeError('获取get_cache_case结果失败，请检查')


# 循环获取结果
def private_get_result(result, result_field):
    result_data = result
    fields = str(result_field).split('.')
    for field in fields:
        if isinstance(result_data, dict):
            result_data = result_data.get(field)
        elif isinstance(result_data, list):
            if result_data:
                result_data = result_data[int(field)]
            else:
                raise AttributeError
    return str(result_data)






'''
生成流水号
 prefix：前缀，如ZC-
 code：流水号code,用于区分不同业务流水号
 time_format_str:日期格式 具体参照：https://www.runoob.com/python/python-date-time.html
 serial_size：自增长流水位数
'''


def get_serial_number(prefix='', code='common', time_format_str='Ymd', serial_size=5):
    # 支持日期格式化符号
    format_key = 'yYmdHIMSaAbBcjpUwWxXZ'

    time_format = ''
    time_str = ''
    if not time_format_str:
        for format in time_format_str:
            if format in format_key:
                time_format = time_format + '%' + format
        time_str = datetime.datetime.now().strftime(time_format)

    cache_value = 1
    key = case_cache.SERIAL_NUMBER_KEY_PREFIX + code
    if case_cache.exists_key(key):
        cache_value = case_cache.get(key) + 1
    # 缓存设置1000天，暂时表示永久
    case_cache.set(key, cache_value, timeout=60 * 60 * 24 * 1000)

    serial_value = ''
    value_str = str(cache_value)
    value_size = len(value_str)
    if value_size >= serial_size:
        serial_value = value_str
    else:
        size = serial_size - value_size
        for ze in range(size):
            serial_value = serial_value + '0'
        serial_value = serial_value + value_str

    result = prefix + time_str + serial_value
    return result


# 线程睡眠，对进程挂起,seconds:秒数
def time_sleep(seconds=0):
    time.sleep(seconds)


# 获取自增长id
def get_auto_incrementid(code='common', weight=1):
    cache_value = 0
    key = case_cache.AUTO_INCREMENT_ID_KEY_PREFIX + code
    if case_cache.exists_key(key):
        cache_value = case_cache.get(key) + weight
    # 缓存设置1000天，暂时表示永久
    case_cache.set(key, cache_value, timeout=60 * 60 * 24 * 1000)

    return cache_value


# 批量提取用例结果
def batch_extract_case(case_id, result_field, cycle_index=1):
    results = []
    for i in range(cycle_index):
        result = get_case(case_id, result_field)
        results.append(result)
    return results
