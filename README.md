HttpRunnerMTO
=================

基于HttpRunnerManager为基础的接口自动化测试平台: `HttpRunner`_, `djcelery`_ and `Django`_. HttpRunnerManager: https://github.com/HttpRunner/HttpRunnerManager




#### 补充内容

- 优化界面ui
- 新增用户数据权限控制
- 优化根据实际场景优化用例执行，用例分类，参数传递
- 其实还好很多改动，继续完善文档中


#### 部署说明

- 先可参考httpRunnerManager说明
- 因增加了缓存，需要在settings.py配置连接redis，如需要异步或定时执行则还需要配置rabbitmq连接。
- 根目录的system-db.sql为系统数据库初始化脚本
