from django.db import models

from ApiManager.managers import UserTypeManager, UserInfoManager, ProjectInfoManager, ModuleInfoManager, \
    TestCaseInfoManager, EnvInfoManager, ServiceConfigManager, ServiceConfigDetailManager


# Create your models here.


class BaseTable(models.Model):
    create_time = models.DateTimeField('创建时间', auto_now_add=True)
    update_time = models.DateTimeField('更新时间', auto_now=True)

    class Meta:
        abstract = True
        verbose_name = "公共字段表"
        db_table = 'BaseTable'


class UserType(BaseTable):
    class Meta:
        verbose_name = '用户类型'
        db_table = 'UserType'

    type_name = models.CharField(max_length=20)
    type_desc = models.CharField(max_length=50)
    objects = UserTypeManager()


class UserInfo(BaseTable):
    class Meta:
        verbose_name = '用户信息'
        db_table = 'UserInfo'

    username = models.CharField('用户名', max_length=20, unique=True, null=False)
    password = models.CharField('密码', max_length=20, null=False)
    email = models.EmailField('邮箱', null=False, unique=True)
    status = models.IntegerField('有效/无效', default=1)
    # user_type = models.ForeignKey(UserType, on_delete=models.CASCADE)
    user_type = models.IntegerField('用户类型(0:用户,1:管理员)', default=0)

    objects = UserInfoManager()


class ProjectInfo(BaseTable):
    class Meta:
        verbose_name = '项目信息'
        db_table = 'ProjectInfo'

    project_name = models.CharField('项目名称', max_length=50, unique=True, null=False)
    responsible_name = models.CharField('负责人', max_length=20, null=False)
    test_user = models.CharField('测试人员', max_length=100, null=False)
    dev_user = models.CharField('开发人员', max_length=100, null=False)
    publish_app = models.CharField('发布应用', max_length=100, null=False)
    simple_desc = models.CharField('简要描述', max_length=100, null=True)
    other_desc = models.CharField('其他信息', max_length=100, null=True)

    config_id = models.IntegerField('关联配置id', null=True)

    creator = models.CharField('创建人', max_length=20, null=False)

    objects = ProjectInfoManager()


class ModuleInfo(BaseTable):
    class Meta:
        verbose_name = '模块信息'
        db_table = 'ModuleInfo'

    module_name = models.CharField('模块名称', max_length=50, null=False)
    belong_project = models.ForeignKey(ProjectInfo, on_delete=models.CASCADE)
    test_user = models.CharField('测试负责人', max_length=50, null=False)
    simple_desc = models.CharField('简要描述', max_length=100, null=True)
    other_desc = models.CharField('其他信息', max_length=100, null=True)

    config_id = models.IntegerField('关联配置id', null=True)
    creator = models.CharField('创建人', max_length=20, null=False)
    leader_user = models.CharField('负责人', max_length=20, null=False)

    objects = ModuleInfoManager()


class TestCaseInfo(BaseTable):
    class Meta:
        verbose_name = '用例信息'
        db_table = 'TestCaseInfo'

    type = models.IntegerField('test/config', default=1)
    name = models.CharField('用例/配置名称', max_length=50, null=False)
    belong_project = models.CharField('所属项目', max_length=50, null=False)
    belong_module = models.ForeignKey(ModuleInfo, on_delete=models.CASCADE)
    include = models.CharField('前置config/test', max_length=1024, null=True)
    author = models.CharField('编写人员', max_length=20, null=False)
    request = models.TextField('请求信息', null=False)

    service_name = models.TextField('所属服务名称', null=True)

    run_type = models.IntegerField('运行方式(0:集成运行,1:独立运行)', default=1)

    objects = TestCaseInfoManager()


class TestReports(BaseTable):
    class Meta:
        verbose_name = "测试报告"
        db_table = 'TestReports'

    report_name = models.CharField(max_length=40, null=False)
    start_at = models.CharField(max_length=40, null=True)
    status = models.IntegerField()
    testsRun = models.IntegerField()
    successes = models.IntegerField()
    reports = models.TextField()
    type = models.TextField()
    executor = models.CharField('执行人员', max_length=20, null=True)

    execute_service = models.TextField('执行服务', null=True)
    execute_source = models.TextField('执行来源', null=True)
    execute_id = models.TextField('执行id', null=True)

    path = models.TextField('报表路径', null=True)


class EnvInfo(BaseTable):
    class Meta:
        verbose_name = '环境管理'
        db_table = 'EnvInfo'

    env_name = models.CharField(max_length=40, null=False, unique=True)
    base_url = models.CharField(max_length=40, null=False)
    simple_desc = models.CharField(max_length=50, null=False)
    objects = EnvInfoManager()


class DebugTalk(BaseTable):
    class Meta:
        verbose_name = '驱动py文件'
        db_table = 'DebugTalk'

    belong_project = models.ForeignKey(ProjectInfo, on_delete=models.CASCADE)
    debugtalk = models.TextField(null=True, default='#debugtalk.py')


class TestSuite(BaseTable):
    class Meta:
        verbose_name = '用例集合'
        db_table = 'TestSuite'

    belong_project = models.ForeignKey(ProjectInfo, on_delete=models.CASCADE)
    suite_name = models.CharField(max_length=100, null=False)
    include = models.TextField(null=False)
    creator = models.CharField('创建人', max_length=20, null=False)


class ServiceConfig(BaseTable):
    class Meta:
        verbose_name = '服务关联配置'
        db_table = 'service_config'

    service_name = models.CharField('所属服务名称', max_length=50, null=False, unique=False)
    service_version = models.CharField('所属服务版本', max_length=30, null=True)
    creator = models.CharField('创建人', max_length=20, null=False)
    modifier = models.CharField('修改人', max_length=20, null=True)

    remark = models.CharField('描述', max_length=200, null=True)

    objects = ServiceConfigManager()


class ServiceConfigDetail(BaseTable):
    class Meta:
        verbose_name = '服务关联配置明细'
        db_table = 'service_config_detail'

    service_config_id = models.IntegerField('服务配置ID', null=False)
    relation_id = models.CharField('关联配置id', max_length=32, null=True)
    relation_name = models.CharField('关联名称', max_length=100, null=True)
    relation_type = models.IntegerField('关联类型(1-项目,2-模块,3-套件,4-用例,5-服务)', null=False)
    creator = models.CharField('创建人', max_length=20, null=False)
    modifier = models.CharField('修改人', max_length=20, null=True)

    objects = ServiceConfigDetailManager()


class TestCaseLogicInfo(BaseTable):
    class Meta:
        verbose_name = '用例逻辑信息'
        db_table = 'testcase_logic_info'

    type = models.IntegerField('test/config', default=1)
    name = models.CharField('用例/配置名称', max_length=50, null=False)
    belong_project = models.CharField('所属项目', max_length=50, null=False)
    belong_module = models.ForeignKey(ModuleInfo, on_delete=models.CASCADE)
    include = models.CharField('前置config/test', max_length=1024, null=True)
    author = models.CharField('编写人员', max_length=20, null=False)
    request = models.TextField('请求信息', null=False)

    service_name = models.TextField('所属服务名称', null=True)

    run_type = models.IntegerField('运行方式(0:集成运行,1:独立运行)', default=1)

    objects = TestCaseInfoManager()