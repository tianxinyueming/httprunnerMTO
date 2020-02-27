import requests
from requests.exceptions import (InvalidSchema, InvalidURL, MissingSchema,
                                 RequestException)

from httprunner import logger


# 请求接口
def post(url, data, headers):
    try:
        msg = "processed request:\n"
        msg += "> {method} {url}\n".format(method='POST', url=url)
        msg += "> kwargs: {kwargs}".format(kwargs=data)
        logger.log_debug(msg)
        return requests.post(url, data=data, headers=headers, stream=False, timeout=120)
    except (MissingSchema, InvalidSchema, InvalidURL):
        raise
    except RequestException as ex:
        print(ex)

