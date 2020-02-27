
from django.core.cache import cache

SYSTEM_KEY_PREFIX = 'httpRunnerManager_'

# 用例缓存key前缀
TEST_CASE_KEY_PREFIX = '#test_key_'
# 流水号code缓存key前缀
SERIAL_NUMBER_KEY_PREFIX = "#serial_number_"
# 子增长ID缓存key前缀
AUTO_INCREMENT_ID_KEY_PREFIX = "#auto_incrementid_"

# 用于全局缓存用例执行结果--临时方案
# 用例运行状态缓存
CASE_RUN_STATUS = {
    'DEFAULT': 1
}


# 根据key获取缓存结果
def get(key):
    key = SYSTEM_KEY_PREFIX + str(key)
    return cache.get(key)


# 添加缓存,默认30分钟超时
def set(key=None, value=None, timeout=1800):
    if key:
        key = SYSTEM_KEY_PREFIX + str(key)
        cache.set(key, value, timeout=timeout)


# 判断key是否在缓存中存在
def exists_key(key):
    key = SYSTEM_KEY_PREFIX + str(key)
    return cache.has_key(key)


# 删除对应缓存
def del_cache(id):
    if id:
        key = SYSTEM_KEY_PREFIX + str(id)
        cache.delete(key)


# 删除case缓存
def del_case_cache(id):
    if id:
        key = SYSTEM_KEY_PREFIX + TEST_CASE_KEY_PREFIX + str(id)
        cache.delete(key)
