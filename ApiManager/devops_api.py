import json
from ApiManager.utils import request
from ApiManager.utils import case_cache

# 获取token账号密码
username = 'callbackapi'
password = 'Ct@2018.com'

# 请求接口token
config = {
    'token': 'jwt eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyOTQsInVzZXJuYW1lIjoiY2FsbGJhY2thcGkiLCJleHAiOjE1NjU2OTAyOTEsImVtYWlsIjoiIn0.vzTj2Bt-kZMhVgXTV8tOv8Z3iMNUAEla2HhxgC7s7g0'
}

'''
运维自动化发布平台接口
'''


# 获取头信息
def get_headers():
    headers = {
        'Content-Type': 'application/json',
        'Authorization': config.get('token')
    }
    return headers


# 获取工程列表
def get_module(query_data):
    # # 增加缓存
    # key = "devops_api_auto_get_module"+str(query_data)
    # if case_cache.exists_key(key):
    #     return case_cache.get(key)
    #
    # url = 'http://10.121.35.30/api/auto/get/module/'
    # response = request.post(url, query_data, get_headers())
    # response_data = json.loads(response.text)
    # # 如果token失效，则重新调用一遍获取token
    # if response_data.get('code') == 5000:
    #     config['token'] = 'jwt ' + get_token()
    #     response = request.post(url, query_data, get_headers())
    #     response_data = json.loads(response.text)
    #
    # print(response.status_code)
    # print(response_data)
    # case_cache.set(key, response_data)
    return {}


# 获取token
def get_token():
    url = 'http://10.121.35.30/api/account/token-auth/'

    headers = {
        'Content-Type': 'application/json'
    }
    data = {
        "username": username,
        "password": password
    }
    response = request.post(url, json.dumps(data), headers)

    response_data = json.loads(response.text)

    return response_data.get('token')

