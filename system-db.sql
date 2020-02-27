

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('5', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('8', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('9', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('10', 'Can add user', '4', 'add_user');
INSERT INTO `auth_permission` VALUES ('11', 'Can change user', '4', 'change_user');
INSERT INTO `auth_permission` VALUES ('12', 'Can delete user', '4', 'delete_user');
INSERT INTO `auth_permission` VALUES ('13', 'Can add content type', '5', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('14', 'Can change content type', '5', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete content type', '5', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('16', 'Can add session', '6', 'add_session');
INSERT INTO `auth_permission` VALUES ('17', 'Can change session', '6', 'change_session');
INSERT INTO `auth_permission` VALUES ('18', 'Can delete session', '6', 'delete_session');
INSERT INTO `auth_permission` VALUES ('19', 'Can add 驱动py文件', '7', 'add_debugtalk');
INSERT INTO `auth_permission` VALUES ('20', 'Can change 驱动py文件', '7', 'change_debugtalk');
INSERT INTO `auth_permission` VALUES ('21', 'Can delete 驱动py文件', '7', 'delete_debugtalk');
INSERT INTO `auth_permission` VALUES ('22', 'Can add 环境管理', '8', 'add_envinfo');
INSERT INTO `auth_permission` VALUES ('23', 'Can change 环境管理', '8', 'change_envinfo');
INSERT INTO `auth_permission` VALUES ('24', 'Can delete 环境管理', '8', 'delete_envinfo');
INSERT INTO `auth_permission` VALUES ('25', 'Can add 模块信息', '9', 'add_moduleinfo');
INSERT INTO `auth_permission` VALUES ('26', 'Can change 模块信息', '9', 'change_moduleinfo');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete 模块信息', '9', 'delete_moduleinfo');
INSERT INTO `auth_permission` VALUES ('28', 'Can add 项目信息', '10', 'add_projectinfo');
INSERT INTO `auth_permission` VALUES ('29', 'Can change 项目信息', '10', 'change_projectinfo');
INSERT INTO `auth_permission` VALUES ('30', 'Can delete 项目信息', '10', 'delete_projectinfo');
INSERT INTO `auth_permission` VALUES ('31', 'Can add 用例信息', '11', 'add_testcaseinfo');
INSERT INTO `auth_permission` VALUES ('32', 'Can change 用例信息', '11', 'change_testcaseinfo');
INSERT INTO `auth_permission` VALUES ('33', 'Can delete 用例信息', '11', 'delete_testcaseinfo');
INSERT INTO `auth_permission` VALUES ('34', 'Can add 测试报告', '12', 'add_testreports');
INSERT INTO `auth_permission` VALUES ('35', 'Can change 测试报告', '12', 'change_testreports');
INSERT INTO `auth_permission` VALUES ('36', 'Can delete 测试报告', '12', 'delete_testreports');
INSERT INTO `auth_permission` VALUES ('37', 'Can add 用例集合', '13', 'add_testsuite');
INSERT INTO `auth_permission` VALUES ('38', 'Can change 用例集合', '13', 'change_testsuite');
INSERT INTO `auth_permission` VALUES ('39', 'Can delete 用例集合', '13', 'delete_testsuite');
INSERT INTO `auth_permission` VALUES ('40', 'Can add 用户信息', '14', 'add_userinfo');
INSERT INTO `auth_permission` VALUES ('41', 'Can change 用户信息', '14', 'change_userinfo');
INSERT INTO `auth_permission` VALUES ('42', 'Can delete 用户信息', '14', 'delete_userinfo');
INSERT INTO `auth_permission` VALUES ('43', 'Can add 用户类型', '15', 'add_usertype');
INSERT INTO `auth_permission` VALUES ('44', 'Can change 用户类型', '15', 'change_usertype');
INSERT INTO `auth_permission` VALUES ('45', 'Can delete 用户类型', '15', 'delete_usertype');
INSERT INTO `auth_permission` VALUES ('46', 'Can add crontab', '16', 'add_crontabschedule');
INSERT INTO `auth_permission` VALUES ('47', 'Can change crontab', '16', 'change_crontabschedule');
INSERT INTO `auth_permission` VALUES ('48', 'Can delete crontab', '16', 'delete_crontabschedule');
INSERT INTO `auth_permission` VALUES ('49', 'Can add interval', '17', 'add_intervalschedule');
INSERT INTO `auth_permission` VALUES ('50', 'Can change interval', '17', 'change_intervalschedule');
INSERT INTO `auth_permission` VALUES ('51', 'Can delete interval', '17', 'delete_intervalschedule');
INSERT INTO `auth_permission` VALUES ('52', 'Can add periodic task', '18', 'add_periodictask');
INSERT INTO `auth_permission` VALUES ('53', 'Can change periodic task', '18', 'change_periodictask');
INSERT INTO `auth_permission` VALUES ('54', 'Can delete periodic task', '18', 'delete_periodictask');
INSERT INTO `auth_permission` VALUES ('55', 'Can add periodic tasks', '19', 'add_periodictasks');
INSERT INTO `auth_permission` VALUES ('56', 'Can change periodic tasks', '19', 'change_periodictasks');
INSERT INTO `auth_permission` VALUES ('57', 'Can delete periodic tasks', '19', 'delete_periodictasks');
INSERT INTO `auth_permission` VALUES ('58', 'Can add task state', '20', 'add_taskmeta');
INSERT INTO `auth_permission` VALUES ('59', 'Can change task state', '20', 'change_taskmeta');
INSERT INTO `auth_permission` VALUES ('60', 'Can delete task state', '20', 'delete_taskmeta');
INSERT INTO `auth_permission` VALUES ('61', 'Can add saved group result', '21', 'add_tasksetmeta');
INSERT INTO `auth_permission` VALUES ('62', 'Can change saved group result', '21', 'change_tasksetmeta');
INSERT INTO `auth_permission` VALUES ('63', 'Can delete saved group result', '21', 'delete_tasksetmeta');
INSERT INTO `auth_permission` VALUES ('64', 'Can add task', '22', 'add_taskstate');
INSERT INTO `auth_permission` VALUES ('65', 'Can change task', '22', 'change_taskstate');
INSERT INTO `auth_permission` VALUES ('66', 'Can delete task', '22', 'delete_taskstate');
INSERT INTO `auth_permission` VALUES ('67', 'Can add worker', '23', 'add_workerstate');
INSERT INTO `auth_permission` VALUES ('68', 'Can change worker', '23', 'change_workerstate');
INSERT INTO `auth_permission` VALUES ('69', 'Can delete worker', '23', 'delete_workerstate');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES ('1', 'pbkdf2_sha256$100000$xonwt87fFdnN$DVLNl/WfXMDHcihD8tY9YLEZR8NcyBJw4Rkl4bzx/VU=', '2019-07-09 15:07:36.935295', '1', 'admin', '', '', '', '1', '1', '2019-06-25 18:03:58.430060');
INSERT INTO `auth_user` VALUES ('2', 'pbkdf2_sha256$100000$1O1IbZGJcE9U$GQ5Li2QsEECIQIAxT7b+i1kJR5feOmmLEaQvwMtIpHI=', null, '0', 'test', '', '', '', '0', '1', '2019-07-04 17:12:42.604262');

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for celery_taskmeta
-- ----------------------------
DROP TABLE IF EXISTS `celery_taskmeta`;
CREATE TABLE `celery_taskmeta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL,
  `result` longtext,
  `date_done` datetime(6) NOT NULL,
  `traceback` longtext,
  `hidden` tinyint(1) NOT NULL,
  `meta` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_id` (`task_id`),
  KEY `celery_taskmeta_hidden_23fd02dc` (`hidden`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of celery_taskmeta
-- ----------------------------
INSERT INTO `celery_taskmeta` VALUES ('91', '34ba9d74-e0bc-444f-9867-9e613a533319', 'SUCCESS', null, '2019-08-29 11:44:44.145413', null, '0', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9');
INSERT INTO `celery_taskmeta` VALUES ('92', 'da99c589-08ee-48dc-98f3-c99e22dfcb98', 'SUCCESS', null, '2019-08-29 11:45:03.506512', null, '0', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9');
INSERT INTO `celery_taskmeta` VALUES ('93', '5c748de7-4779-4563-83fa-371ee9aa86a5', 'SUCCESS', null, '2019-08-29 15:44:27.342722', null, '0', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9');
INSERT INTO `celery_taskmeta` VALUES ('94', 'ad1d7ae3-1671-4bbc-b839-3b6817217d24', 'FAILURE', 'gAJ9cQAoWAgAAABleGNfdHlwZXEBWBEAAABVbmJvdW5kTG9jYWxFcnJvcnECWAsAAABleGNfbWVzc2FnZXEDWDkAAABsb2NhbCB2YXJpYWJsZSAncmVwb3J0X25hbWUnIHJlZmVyZW5jZWQgYmVmb3JlIGFzc2lnbm1lbnRxBHUu', '2019-09-06 18:24:05.647242', 'Traceback (most recent call last):\nOSError: [Errno 22] Invalid argument: \'D:\\\\python\\\\HttpRunnerManager\\\\suite\\\\2019-09-06 18-24-05-256\\\\测试项目2\\\\模块名称\\\\登录\\r.yml\'\n\nDuring handling of the above exception, another exception occurred:\n\nTraceback (most recent call last):\nUnboundLocalError: local variable \'report_name\' referenced before assignment\n', '0', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9');
INSERT INTO `celery_taskmeta` VALUES ('95', 'da56573a-4ea6-44d6-8fd6-fb64d0eef3ed', 'SUCCESS', null, '2019-09-06 18:37:17.216363', null, '0', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9');
INSERT INTO `celery_taskmeta` VALUES ('96', '8142fafa-b006-4ed7-96af-fda3655929ba', 'SUCCESS', null, '2019-09-06 18:37:38.980201', null, '0', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9');
INSERT INTO `celery_taskmeta` VALUES ('97', '5d8188e9-db63-4dc5-b135-ee5f742d04aa', 'SUCCESS', null, '2019-09-06 18:41:30.550715', null, '0', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9');
INSERT INTO `celery_taskmeta` VALUES ('98', '23542479-2ccd-4b80-b2ab-84b7cbd306d4', 'SUCCESS', null, '2019-09-06 18:42:12.334968', null, '0', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9');
INSERT INTO `celery_taskmeta` VALUES ('99', '1ac0c352-4b52-4308-b538-6d7ac8a91ba8', 'SUCCESS', null, '2019-09-06 18:42:45.265703', null, '0', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9');
INSERT INTO `celery_taskmeta` VALUES ('100', 'd28a2a89-576a-4d27-be31-3b81aee34391', 'SUCCESS', null, '2019-09-06 18:43:38.170397', null, '0', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9');
INSERT INTO `celery_taskmeta` VALUES ('101', '1a054c4e-9de6-459e-825d-3c7998f6e90d', 'SUCCESS', null, '2019-09-06 18:43:50.819392', null, '0', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9');
INSERT INTO `celery_taskmeta` VALUES ('102', '262f89da-3c9f-4d29-b6df-68ed1fd9447c', 'SUCCESS', null, '2019-09-06 18:43:59.077800', null, '0', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9');
INSERT INTO `celery_taskmeta` VALUES ('103', '4d6a318d-26e4-4dd1-914b-c508ef244f17', 'SUCCESS', null, '2019-09-06 18:44:07.976849', null, '0', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9');
INSERT INTO `celery_taskmeta` VALUES ('104', 'f3703b49-2c55-4a44-97d8-c842690e20e5', 'SUCCESS', null, '2019-09-06 18:44:16.384269', null, '0', 'eJxrYKotZIjgYGBgSM7IzEkpSs0rZIwtZCrWAwBWnQb9');

-- ----------------------------
-- Table structure for celery_tasksetmeta
-- ----------------------------
DROP TABLE IF EXISTS `celery_tasksetmeta`;
CREATE TABLE `celery_tasksetmeta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taskset_id` varchar(255) NOT NULL,
  `result` longtext NOT NULL,
  `date_done` datetime(6) NOT NULL,
  `hidden` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `taskset_id` (`taskset_id`),
  KEY `celery_tasksetmeta_hidden_593cfc24` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of celery_tasksetmeta
-- ----------------------------

-- ----------------------------
-- Table structure for debugtalk
-- ----------------------------
DROP TABLE IF EXISTS `debugtalk`;
CREATE TABLE `debugtalk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `debugtalk` longtext,
  `belong_project_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `DebugTalk_belong_project_id_0957612a_fk_ProjectInfo_id` (`belong_project_id`),
  CONSTRAINT `DebugTalk_belong_project_id_0957612a_fk_ProjectInfo_id` FOREIGN KEY (`belong_project_id`) REFERENCES `projectinfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of debugtalk
-- ----------------------------
INSERT INTO `debugtalk` VALUES ('1', '2019-06-25 18:08:05.222010', '2019-08-27 16:21:22.164378', '# debugtalk.py\r\nimport MySQLdb\r\n\r\n\r\ndef replace_chars(data, start_char, end_char):\r\n    if data:\r\n        data = str(data)\r\n        start_index = data.find(start_char)\r\n        end_index = data.find(end_char)\r\n        if start_index != -1 and end_char != -1:\r\n            return data[start_index + len(start_char):end_index]\r\n    return data\r\n\r\n\r\n\r\n\r\n\r\ndef get_db_test2():\r\n    # 打开数据库连接\r\n    db = MySQLdb.connect(\"localhost\", \"root\", \"123456\", \"httprunner\", charset=\'utf8\')\r\n\r\n    # 使用cursor()方法获取操作游标\r\n    cursor = db.cursor()\r\n\r\n    # 使用execute方法执行SQL语句\r\n    cursor.execute(\"select *from userinfo\")\r\n\r\n    # 使用 fetchone() 方法获取一条数据\r\n    data = cursor.fetchone()\r\n\r\n    print(\"Database version : %s \" % data[6])\r\n\r\n    # 关闭数据库连接\r\n    db.close()\r\n    return str(data[6])\r\n', '1');
INSERT INTO `debugtalk` VALUES ('2', '2019-06-25 18:47:54.671120', '2019-06-25 18:47:54.671120', '# debugtalk.py', '2');
INSERT INTO `debugtalk` VALUES ('3', '2019-06-26 15:58:17.037554', '2019-06-28 17:11:42.300041', '# debugtalk.py\r\n', '3');
INSERT INTO `debugtalk` VALUES ('4', '2019-06-26 18:18:38.256286', '2019-06-26 18:18:38.256286', '# debugtalk.py', '4');
INSERT INTO `debugtalk` VALUES ('7', '2019-06-28 17:54:38.056469', '2019-06-28 17:54:38.056469', '# debugtalk.py', '7');
INSERT INTO `debugtalk` VALUES ('8', '2019-07-01 17:53:22.227727', '2019-07-04 11:04:39.308583', '# debugtalk.py\r\n\r\n#-*- coding:utf-8 -*-\r\nimport random\r\nimport time\r\n   def get_mobile():\r\n       No_list=[\"130\",\"134\",\"131\",\"135\",\"136\",\"137\",\"138\",\"139\",\"150\",\"151\",\"152\",\"153\",\"154\",\"155\",\"156\",\"157\"]\r\n       begin=random.choice(No_list)\r\n       end=random.randint(10000000,99999999)\r\n       mobile=str(begin)+str(end)\r\n    return mobile\r\n\r\n    def _regiun():\r\n         \'\'\'生成身份证前六位\'\'\'\r\n        #列表里面的都是一些地区的前六位号码\r\n         first_list = [\'362402\',\'362421\',\'362422\',\'362423\',\'362424\',\'362425\',\'362426\',\'362427\',\'362428\',\'362429\',\'362430\',\'362432\',\'110100\',\'110101\',\'110102\',\'110103\',\'110104\',\'110105\',\'110106\',\'110107\',\'110108\',\'110109\',\'110111\']\r\n         first = random.choice(first_list)\r\n         return first\r\n\r\n    def _year():\r\n        \'\'\'生成年份\'\'\'\r\n        now = time.strftime(\'%Y\')\r\n        #1948为第一代身份证执行年份,now-18直接过滤掉小于18岁出生的年份\r\n        second = random.randint(1948,int(now)-18)\r\n        age = int(now) - second\r\n        print(\'随机生成的身份证人员年龄为：\'+str(age))\r\n        return second,age\r\n\r\n\r\n    def _month():\r\n       \'\'\'生成月份\'\'\'\r\n       three = random.randint(1,12)\r\n       #月份小于10以下，前面加上0填充\r\n       if three < 10:\r\n          three = \'0\' + str(three)\r\n          return three\r\n       else:\r\n          return three\r\n\r\n\r\n    def _day():\r\n        \'\'\'生成日期\'\'\'\r\n        four = random.randint(1,31)\r\n        #日期小于10以下，前面加上0填充\r\n        if four < 10:\r\n           four = \'0\' + str(four)\r\n           return four\r\n        else:\r\n           return four\r\n\r\n\r\n    def _randoms():\r\n       \'\'\'生成身份证后四位\'\'\'\r\n       #后面序号低于相应位数，前面加上0填充\r\n       five = random.randint(1,9999)\r\n       if five < 10:\r\n          five = \'000\' + str(five)\r\n          return five\r\n       elif 10 < five < 100:\r\n          five = \'00\' + str(five)\r\n          return five\r\n       elif 100 < five < 1000:\r\n          five = \'0\' + str(five)\r\n          return five\r\n       else:\r\n         return five\r\n\r\n\r\n    def get_identity():\r\n         first = self._regiun()\r\n         second,age = self._year()\r\n         three = self._month()\r\n         four = self._day()\r\n         last = self._randoms()\r\n         IDcard = str(first)+str(second)+str(three)+str(four)+str(last)\r\n         birthday=str(second)+\"-\"+str(three)+\"-\"+str(four)\r\n         sex=\"\"\r\n         flag =str(last)[:-1]\r\n         if int(flag)%2 == 0 :\r\n             sex=\"20\"\r\n         else:\r\n             sex=\"10\"\r\n\r\n         return IDcard,birthday,age,sex\r\n', '8');
INSERT INTO `debugtalk` VALUES ('10', '2019-07-04 19:03:58.086605', '2019-08-12 11:39:01.154694', '# debugtalk.py\r\n\r\n\r\n# 生成随机字符,默认32位\r\ndef get_uuid2(size=32):\r\n    return str(uuid.uuid1()).replace(\'-\', \'\')[0:size]\r\n\r\n\r\n\r\n\r\ndef get_cache_case2(case_id, result_field, expire_time=1800):\r\n    data = get_cache_case(case_id,result_field,expire_time)\r\n    start_char =\'b\'\r\n    end_char = \'a\'\r\n    print(\'------------------------------------------------进入=----------------\')\r\n    print(data)\r\n    if data:\r\n        data = str(data)\r\n        start_index = data.find(start_char)\r\n        end_index = data.find(end_char)\r\n        if start_index != -1 and end_char != -1:\r\n            return data[start_index + len(start_char):end_index]\r\n    return data\r\n', '10');
INSERT INTO `debugtalk` VALUES ('11', '2019-07-04 19:05:28.320966', '2019-07-06 14:36:14.739490', 'print(\"hello\")\r\n', '11');
INSERT INTO `debugtalk` VALUES ('12', '2019-07-08 11:43:29.276599', '2019-07-08 11:43:29.276599', '# debugtalk.py', '12');
INSERT INTO `debugtalk` VALUES ('17', '2019-07-20 11:34:48.256285', '2019-07-20 11:34:48.256285', '# debugtalk.py', '17');
INSERT INTO `debugtalk` VALUES ('19', '2019-07-23 17:12:06.735097', '2019-07-23 17:12:06.735097', '# debugtalk.py', '19');
INSERT INTO `debugtalk` VALUES ('20', '2019-07-23 17:30:03.070381', '2019-07-23 17:30:03.070381', '# debugtalk.py', '20');
INSERT INTO `debugtalk` VALUES ('21', '2019-07-25 15:33:22.089437', '2019-07-25 15:33:22.089437', '# debugtalk.py', '21');
INSERT INTO `debugtalk` VALUES ('23', '2019-08-07 18:49:21.826266', '2019-08-07 18:49:21.826768', '# debugtalk.py', '23');
INSERT INTO `debugtalk` VALUES ('24', '2019-08-08 11:30:36.156223', '2019-08-08 11:30:36.156724', '# debugtalk.py', '24');
INSERT INTO `debugtalk` VALUES ('26', '2019-09-03 19:03:13.363416', '2019-09-03 19:03:13.363917', '# debugtalk.py', '26');
INSERT INTO `debugtalk` VALUES ('27', '2019-09-04 15:21:33.224392', '2019-09-04 15:21:33.224392', '# debugtalk.py', '27');

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES ('1', '2019-07-04 17:12:42.889494', '2', 'test', '1', '[{\"added\": {}}]', '4', '1');

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('7', 'ApiManager', 'debugtalk');
INSERT INTO `django_content_type` VALUES ('8', 'ApiManager', 'envinfo');
INSERT INTO `django_content_type` VALUES ('9', 'ApiManager', 'moduleinfo');
INSERT INTO `django_content_type` VALUES ('10', 'ApiManager', 'projectinfo');
INSERT INTO `django_content_type` VALUES ('11', 'ApiManager', 'testcaseinfo');
INSERT INTO `django_content_type` VALUES ('12', 'ApiManager', 'testreports');
INSERT INTO `django_content_type` VALUES ('13', 'ApiManager', 'testsuite');
INSERT INTO `django_content_type` VALUES ('14', 'ApiManager', 'userinfo');
INSERT INTO `django_content_type` VALUES ('15', 'ApiManager', 'usertype');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('4', 'auth', 'user');
INSERT INTO `django_content_type` VALUES ('5', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('16', 'djcelery', 'crontabschedule');
INSERT INTO `django_content_type` VALUES ('17', 'djcelery', 'intervalschedule');
INSERT INTO `django_content_type` VALUES ('18', 'djcelery', 'periodictask');
INSERT INTO `django_content_type` VALUES ('19', 'djcelery', 'periodictasks');
INSERT INTO `django_content_type` VALUES ('20', 'djcelery', 'taskmeta');
INSERT INTO `django_content_type` VALUES ('21', 'djcelery', 'tasksetmeta');
INSERT INTO `django_content_type` VALUES ('22', 'djcelery', 'taskstate');
INSERT INTO `django_content_type` VALUES ('23', 'djcelery', 'workerstate');
INSERT INTO `django_content_type` VALUES ('6', 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'ApiManager', '0001_initial', '2019-06-25 17:58:20.520545');
INSERT INTO `django_migrations` VALUES ('2', 'contenttypes', '0001_initial', '2019-06-25 17:58:23.494149');
INSERT INTO `django_migrations` VALUES ('3', 'auth', '0001_initial', '2019-06-25 17:58:47.309990');
INSERT INTO `django_migrations` VALUES ('4', 'admin', '0001_initial', '2019-06-25 17:58:53.735966');
INSERT INTO `django_migrations` VALUES ('5', 'admin', '0002_logentry_remove_auto_add', '2019-06-25 17:58:53.852867');
INSERT INTO `django_migrations` VALUES ('6', 'contenttypes', '0002_remove_content_type_name', '2019-06-25 17:58:57.129410');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0002_alter_permission_name_max_length', '2019-06-25 17:58:59.887325');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0003_alter_user_email_max_length', '2019-06-25 17:59:00.192945');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0004_alter_user_username_opts', '2019-06-25 17:59:00.266217');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0005_alter_user_last_login_null', '2019-06-25 17:59:02.643638');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0006_require_contenttypes_0002', '2019-06-25 17:59:02.741658');
INSERT INTO `django_migrations` VALUES ('12', 'auth', '0007_alter_validators_add_error_messages', '2019-06-25 17:59:02.872183');
INSERT INTO `django_migrations` VALUES ('13', 'auth', '0008_alter_user_username_max_length', '2019-06-25 17:59:11.235553');
INSERT INTO `django_migrations` VALUES ('14', 'auth', '0009_alter_user_last_name_max_length', '2019-06-25 17:59:15.872318');
INSERT INTO `django_migrations` VALUES ('15', 'djcelery', '0001_initial', '2019-06-25 17:59:41.104832');
INSERT INTO `django_migrations` VALUES ('16', 'sessions', '0001_initial', '2019-06-25 18:03:05.224725');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('0372shj4e47r9oca2x7jbf6s8j2uz9h3', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-09-04 16:34:40.616696');
INSERT INTO `django_session` VALUES ('04na8mbs1g7vuyehedhoz6xg7zxvu979', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-23 21:07:26.045699');
INSERT INTO `django_session` VALUES ('0d41q54hwqbhj1ozax41577kc3jusf0j', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-12 20:10:31.972596');
INSERT INTO `django_session` VALUES ('0fp6cp9bc26nlygd1y89m5my4g3buw2e', 'NGYyMjVmZTc2NjRjZmY1ODFiNDMwMWFlNTk5ZTIwYmMxOWM4MjZmNzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxZTA4ZTQ0OWU0MTEwZDNkNGMzMjMzMjZlYmI4MDFhYjRlY2VlZjY3In0=', '2019-06-25 23:27:30.002357');
INSERT INTO `django_session` VALUES ('0gdmdgyx4yl6qtsymbf3qjtq8me052ua', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-22 16:45:15.167713');
INSERT INTO `django_session` VALUES ('0kvmda2bfv5w06jk21n4hjqyz0v20h0d', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-05 19:27:32.408177');
INSERT INTO `django_session` VALUES ('0r1q8hh3q7c134811fikpi5lfl587zre', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-26 02:41:13.685529');
INSERT INTO `django_session` VALUES ('0xs2uhwyxn1jd3nxh29w5y7txjjxl6ej', 'MjAxNzNmNzRhMWU3ZGZhOWM0NDJlM2ZkZjVlY2Q2N2YwYWZmYjk1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyMSIsInVzZXJfdHlwZSI6MCwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-18 15:25:43.607925');
INSERT INTO `django_session` VALUES ('13i4ztwmhhbarr8g3rbbfrekffn2u050', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-27 19:59:54.427736');
INSERT INTO `django_session` VALUES ('1k5ono9rpcuvnlwzulwvsju5xgl3jihk', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-27 21:12:45.451435');
INSERT INTO `django_session` VALUES ('22edkcbsk9j65p55gjdmprubxma3gkdd', 'YzRhODRiNTQ4ODk1NzI5N2FjMzBkZTE0ZDM5NzUwMjIyZWE1MDZhYTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ3ZWlzaGlndW8iLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJcdTgxZWFcdTUyYThcdTkxNGRcdThkMjciLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-08 21:56:23.451912');
INSERT INTO `django_session` VALUES ('2655dtqxoge7iheq1lss8kzg8659mxvw', 'YTZiNTgzMDE0MGI4NGI2NzA4ZDBmYzFjYWNjM2U4YzRmNTVkYWNmZDp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ6b3VjaHVuIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-27 17:16:06.707719');
INSERT INTO `django_session` VALUES ('26yuc6rpvkq4va6utcuehv56ylbjsq5g', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-09-05 16:02:05.486377');
INSERT INTO `django_session` VALUES ('2dzgmo1wc1vegqi5p2p1zhh1coix0v8o', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-03 01:48:40.129485');
INSERT INTO `django_session` VALUES ('2fpf0yrf0y7v4u1ggg2dpac5mtqhezio', 'YzUyNTRmZDU3Y2E2MTY0NjQ2MWMzMjE0NmNhMThkZWMwNTI4MDhjZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ0aWFueWluaGUiLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-06-27 01:34:13.522512');
INSERT INTO `django_session` VALUES ('2su7x6e2fwee3x1abauwgzty5k3xsfut', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-26 21:04:18.204758');
INSERT INTO `django_session` VALUES ('2vwcuwouro66v252cd20bqtfhse42262', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-09-04 21:21:20.493760');
INSERT INTO `django_session` VALUES ('2yirgameha3dqkbgpdtfggktkgh5jlay', 'MjAxNzNmNzRhMWU3ZGZhOWM0NDJlM2ZkZjVlY2Q2N2YwYWZmYjk1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyMSIsInVzZXJfdHlwZSI6MCwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-17 22:56:26.986894');
INSERT INTO `django_session` VALUES ('3dpoe2pn7it7swncan31ktvpwh7n85mg', 'NmUzMTljNTBmOGMzNDI2Y2ZlMzBhYTM5YjZjYTBlMDExMDhhYjI1MTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiXHU0ZTAwXHU3OTY4XHU4ZDI3IiwibW9kdWxlIjoiVE1TXHU0ZTAwXHU3OTY4XHU4ZDI3XHU3NmY4XHU1MTczIiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-01 23:15:16.488513');
INSERT INTO `django_session` VALUES ('3rg7ssv0vj2iytp2gepbmoq06z53f7lb', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-31 22:52:23.156707');
INSERT INTO `django_session` VALUES ('3zy10zcnz8o8zaz7xtyk7nt9275mkfj2', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-09-02 23:51:47.433520');
INSERT INTO `django_session` VALUES ('412io4ps0sowq80rfgbfac8zixg32yie', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-29 02:00:43.086004');
INSERT INTO `django_session` VALUES ('4lesbptlk3zgg7ed6q8mpg5kz83m7ddg', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-26 19:21:38.588165');
INSERT INTO `django_session` VALUES ('4lhg1abdcadx99ixynf6e7npyqncnduv', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-27 00:03:45.243547');
INSERT INTO `django_session` VALUES ('4r218kornlzo7n6eysbjptesijts1v6t', 'Y2M1N2FiMjAzMzQ2OGIzMmI5ODgzMjFhZDVjY2IxYzY3NzQ4NGM3Njp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ4aWFvYmFpIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-20 16:35:16.980552');
INSERT INTO `django_session` VALUES ('4utwmek204gb7ico85r98324ao9cb87j', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-30 20:02:31.942048');
INSERT INTO `django_session` VALUES ('5avbo1698fol80akddanpkczltzlo926', 'ODIyY2IwNzhkMjAyNGQ4YzY4YmFiNGUyODRlM2IyNTU0Njk5YTQ3NDp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ3YW5namluZ2ZhbmciLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJcdTgxZWFcdTUyYThcdTVlNzJcdTdlYmYiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-09 17:00:29.160327');
INSERT INTO `django_session` VALUES ('6jjm9fwjdupqubuls1k0je98ay1brmt0', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-04 16:26:45.136863');
INSERT INTO `django_session` VALUES ('78ag7rnsrjltltmbv7x0024czn7b07xl', 'YTZiNTgzMDE0MGI4NGI2NzA4ZDBmYzFjYWNjM2U4YzRmNTVkYWNmZDp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ6b3VjaHVuIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-08 22:26:28.483072');
INSERT INTO `django_session` VALUES ('7hudm7rgr4i0122364750cd6sj2t2bo6', 'ZTAzODVmYWIzYTVmMTI4MGZlNzMxYTNhYzY4ZDFkZWZiMWFhODYxOTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6Ilx1NTE3M1x1OTVlZCIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-18 23:22:50.027121');
INSERT INTO `django_session` VALUES ('7ioj4zbos2qx1hq4yztzgl6chcltm8t9', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-31 20:39:47.554660');
INSERT INTO `django_session` VALUES ('7ju637orzrq39juh9teu1q6j4nsxr59l', 'YThiMzQ0YzhlZTdiNjJmN2Y4YThmNTk0YzlhODM2NzQ4MTU2Y2E5YTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiSFJNUyIsIm1vZHVsZSI6Ilx1OGJmN1x1OTAwOVx1NjJlOSIsInJlcG9ydF9uYW1lIjoiIn0=', '2019-07-01 23:56:56.278279');
INSERT INTO `django_session` VALUES ('7laevk0jrzoifrgf7nirljbbfjuxls21', 'YzUyNTRmZDU3Y2E2MTY0NjQ2MWMzMjE0NmNhMThkZWMwNTI4MDhjZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ0aWFueWluaGUiLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-04 15:01:15.554026');
INSERT INTO `django_session` VALUES ('80paufcnh3d2ze9hh6hj2vwtvflj13yh', 'ZWNmMDlkNWY1Zjg3NTYzNWU2MDQwODJkNmI1NjExNGU5MDFlODRkNzp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiIsIm1vZHVsZV9uYW1lIjoiXHU2ZDRiXHU4YmQ1XHU2YTIxXHU1NzU3XHU1MTczXHU4MDU0XHU5MTRkXHU3ZjZlIn0=', '2019-08-26 21:00:02.784971');
INSERT INTO `django_session` VALUES ('81gpx4b7g9iqfujlbdhlhqytriwespqw', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-28 21:25:53.333534');
INSERT INTO `django_session` VALUES ('83wx986ert5ibtzw1tnrounhgaxc8uli', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-14 21:15:56.825818');
INSERT INTO `django_session` VALUES ('88cb8ri8t8xrbz1s8b6ku4oyuj3m78jh', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-29 23:45:01.255179');
INSERT INTO `django_session` VALUES ('8c98w5nb0lu3v8j1gjg0a7boxixrt7gw', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-29 00:40:11.696748');
INSERT INTO `django_session` VALUES ('8fmvnib8ywjpn4eevfp3c8dqu5bmruig', 'MzMwOTQwZjJjMjczZDY1MGI2Y2ZmZmM4ODVlMmYyZTI3YjUxYjU0Yjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiIxMDEwMzAiLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-09 19:06:44.598692');
INSERT INTO `django_session` VALUES ('8qk6wmin7wkld5bv99341cxpdc9i8qmu', 'M2JkOTM2OWY4ZWZjY2YyNGM4ZWMzYjhlNGNmMzZmMzZiZTcwMjdkNjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxZTA4ZTQ0OWU0MTEwZDNkNGMzMjMzMjZlYmI4MDFhYjRlY2VlZjY3IiwibG9naW5fc3RhdHVzIjp0cnVlLCJub3dfYWNjb3VudCI6Inpob3VqaWFuMDEiLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJcdTZkNGJcdThiZDVcdTk4NzlcdTc2ZWUyIiwibW9kdWxlIjoiXHU2YTIxXHU1NzU3XHU1NDBkXHU3OWYwIiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-09 20:18:15.804313');
INSERT INTO `django_session` VALUES ('965cbbp4czj5vwglq6grmlp1r1ceyyv3', 'MDkzOTdiNmYxOTE3N2I1OWEyNGE5NmIwNTA2YTNmMGZlM2VhMmQ5MDp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ6aG91amlhbjAxIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-09 20:19:51.893067');
INSERT INTO `django_session` VALUES ('96zcyhvnsb5izck7nw41ttcpj073a4v1', 'YzUyNTRmZDU3Y2E2MTY0NjQ2MWMzMjE0NmNhMThkZWMwNTI4MDhjZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ0aWFueWluaGUiLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-08 16:14:31.058581');
INSERT INTO `django_session` VALUES ('9g1sv0y8z6vkcfeynvuzi0swllzvknuy', 'YTZiNTgzMDE0MGI4NGI2NzA4ZDBmYzFjYWNjM2U4YzRmNTVkYWNmZDp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ6b3VjaHVuIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-27 00:56:03.687317');
INSERT INTO `django_session` VALUES ('9jwbx773wkyk0n0eubc4mo1bwvc0bh01', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-21 16:55:27.196544');
INSERT INTO `django_session` VALUES ('9u71ep5rjn4o7egonpl2ffe3f3oj3f0u', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2020-02-14 22:30:23.363269');
INSERT INTO `django_session` VALUES ('9wtji6pkffk1m30wgn4xzzg66h7k0soy', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-25 23:39:53.260473');
INSERT INTO `django_session` VALUES ('9z5mkhqhr2peziwknibs4zro96f589n7', 'M2UyYTMxNDVkNGVmY2FjMTg5NTQxZmM0M2MxNDdiYzgwYzI2YTNkOTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJcdTZkNGJcdThiZDVcdTk4NzlcdTc2ZWUxIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIiLCJtb2R1bGVfbmFtZSI6IiJ9', '2019-08-27 20:16:37.777497');
INSERT INTO `django_session` VALUES ('a11ybpl3zh5h1llqi0v6d5hb48s0nlbk', 'ODdlODNkYTliZGE4MGYwYTI5OGZkMDM5ZWJmODE1MzgzZmVkNjkzZDp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoidGFuZ3RpYW50aWFuIiwibmFtZSI6IiIsInByb2plY3QiOiJcdTgxZWFcdTUyYThcdTVlNzJcdTdlYmYiLCJtb2R1bGUiOiJcdTUxNmNcdTUxNzFcdTY3MGRcdTUyYTEiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-26 19:12:20.065106');
INSERT INTO `django_session` VALUES ('a15v7ufyjwc8svzvuxtf6nqgjyq9nfva', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-23 16:04:41.409579');
INSERT INTO `django_session` VALUES ('a6xti93a7jjz7ps4yuyg8o230n93jnxu', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-16 19:42:23.694207');
INSERT INTO `django_session` VALUES ('a92pbzgybws0qva5vhmmprxsnftzdmx5', 'ZjgwNGIzNTRmMTQ0Njc0NGM2ZDVjZWFkZTk5MzEyN2JlNjRiM2U0NDp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiIsIm1vZHVsZV9uYW1lIjoiIn0=', '2019-08-21 22:20:00.895249');
INSERT INTO `django_session` VALUES ('alf72ugb6h0eyt2vht1kvt0vgak4uxug', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-03 16:49:58.756114');
INSERT INTO `django_session` VALUES ('ambjqy807i2uywt49x1lbq24yxttkqgn', 'YWYwMTZjMzQyZTM0NTJjNjhjMWVjMzM1NDg1YjlhYzdlOTZjOTE4Mzp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoidGVzdDEiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-04 23:38:12.566299');
INSERT INTO `django_session` VALUES ('b1ws7e86xg6x4p2jlir2qq8x91h188o7', 'ZGI3NWU2MzlmMzJiMjRmYTRkMjE0NDZhMGM0OTNlN2Q2Y2NlNTMzMDp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ3YW5namluZ2ZhbmciLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-09 22:09:12.691595');
INSERT INTO `django_session` VALUES ('b4xrjqknj69wftvs3zla32add831gvjw', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-03 20:52:45.567316');
INSERT INTO `django_session` VALUES ('baez8m7h4g6zjurc99bi6pz5qrv4qr81', 'ZmE5NGM5OWMzY2U2ZTVjYmE2MTg4YzVkZmFhNGFjNDBhOWI0OTRkZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiIsImV4ZWN1dG9yIjoiIiwic3RhdHVzIjoiIiwidHlwZSI6IiJ9', '2019-09-06 23:44:43.023208');
INSERT INTO `django_session` VALUES ('begoak0khxwsqm3jjco38cqbl1zpj1ak', 'MWUxNjQ0Yzg5OTgxNWJkZmQ1MzM1ZDI5NWM5ZmU3MTMwZjFhZGFjMjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJhZG1pbiIsInVzZXJfdHlwZSI6MSwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2020-02-27 23:23:42.914484');
INSERT INTO `django_session` VALUES ('bf5f26aok1w8keokpet0ak7d8yfquu42', 'YTkyOGQ1NmQzN2VmZTg5YzRmYmRmYzk1ODU2OGM4ZTljN2NjYTVhYTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoidXNlciIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiXHU4MWVhXHU1MmE4XHU1ZTcyXHU3ZWJmIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-08-19 22:47:13.346409');
INSERT INTO `django_session` VALUES ('bik43gds93a8l4b5nxga5yhofrwhr8qn', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-05 16:26:13.177943');
INSERT INTO `django_session` VALUES ('bkih5b1fgkhu6bysa8fkddqzehtwffe8', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-03 16:46:17.093240');
INSERT INTO `django_session` VALUES ('bkpwtme15hck9jfdxw43tu3wql8a4czq', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-15 16:07:00.668293');
INSERT INTO `django_session` VALUES ('c9p8k4oyvjsvu2nb9mp8qu4dtmc0mymx', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-29 20:19:02.649318');
INSERT INTO `django_session` VALUES ('ci93ugd647h7lqpeb57cofa72wodlqsg', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-08 20:57:37.141883');
INSERT INTO `django_session` VALUES ('cjtf3m0rkos24882pqtwezl2edgasout', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-31 22:36:44.156603');
INSERT INTO `django_session` VALUES ('clvcp1tevx4nhinjz9fo84y2uw88i29h', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-01 22:33:33.327112');
INSERT INTO `django_session` VALUES ('cn1i589grl48mj132wu492eajvjzhnue', 'YjMxYjNmOTE3MGU0OTExMzViMjcxMWRhODIwMGFmNDlmYzA2ODIyNTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJcdTgxZWFcdTUyYThcdTVlNzJcdTdlYmYiLCJtb2R1bGUiOiJcdTUxNmNcdTUxNzFcdTY3MGRcdTUyYTEiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-21 00:09:38.804566');
INSERT INTO `django_session` VALUES ('cxlelilx1a9c8gg0ov09jsrnhjx4zgy9', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-26 23:26:52.192190');
INSERT INTO `django_session` VALUES ('d57oov9274luspc84ok19xp5qvujxqtq', 'MjZhYmJmOWE3MGNhMWNlYmNjNmM4YmUzNjk3MzExZDQwZDJiODU2ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ5dXpoYW5naGFuZzAxIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-06 16:34:18.083194');
INSERT INTO `django_session` VALUES ('d8e4zssc0t3dntekke83isnbtnbdx55v', 'YzUyNTRmZDU3Y2E2MTY0NjQ2MWMzMjE0NmNhMThkZWMwNTI4MDhjZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ0aWFueWluaGUiLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-06-27 19:07:12.317168');
INSERT INTO `django_session` VALUES ('didotuiv4ptpfa77r79nt2rt29i8doqf', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-22 22:31:13.154085');
INSERT INTO `django_session` VALUES ('dpmlf26w4rwcajg30arjx138cdh5d16x', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-22 15:55:06.695024');
INSERT INTO `django_session` VALUES ('e2pttcorth8ypsk6ga7f2j0kn103g3qc', 'ZjgwNGIzNTRmMTQ0Njc0NGM2ZDVjZWFkZTk5MzEyN2JlNjRiM2U0NDp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiIsIm1vZHVsZV9uYW1lIjoiIn0=', '2019-09-02 20:37:42.539378');
INSERT INTO `django_session` VALUES ('e4yq91z1gyr9xv09twujzjunqnom9wz8', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-17 22:08:39.890179');
INSERT INTO `django_session` VALUES ('e9h99h985zagyywgqkxyg1yf08gpuya6', 'MzMwOTQwZjJjMjczZDY1MGI2Y2ZmZmM4ODVlMmYyZTI3YjUxYjU0Yjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiIxMDEwMzAiLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-08 22:34:02.918845');
INSERT INTO `django_session` VALUES ('ebjr03xqx8s2kfmpk8cnkhlbamxrxk54', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-07 23:53:27.284244');
INSERT INTO `django_session` VALUES ('efaff7l0hk79xvb4m18rcyemzu423bt5', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-02 23:58:12.151801');
INSERT INTO `django_session` VALUES ('ei1q4q69r0d4071xqfasax1zf9or825v', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-22 22:23:25.183489');
INSERT INTO `django_session` VALUES ('ej28w392nj1t64mcxlpi8s6fca6x6q0f', 'YzUyNTRmZDU3Y2E2MTY0NjQ2MWMzMjE0NmNhMThkZWMwNTI4MDhjZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ0aWFueWluaGUiLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-09 00:01:47.614152');
INSERT INTO `django_session` VALUES ('el1t15lh78x2i4d636rag7yqjbzl5if4', 'MGYzNzRhMDI4Y2JhODgxNzM5YTdjMjQwNGI3NmU0OTM2ZGExOTZjNDp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiJpbXMuc2l0ZU1hbmFnZW1lbnQuZGV0YWlsIiwicHJvamVjdCI6IkFsbCIsIm1vZHVsZSI6Ilx1OGJmN1x1OTAwOVx1NjJlOSIsInJlcG9ydF9uYW1lIjoiIn0=', '2019-07-16 21:02:25.847939');
INSERT INTO `django_session` VALUES ('exu4m730l8qylr1egsbhfgjkfc0sp5ik', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-23 00:21:23.036569');
INSERT INTO `django_session` VALUES ('f2jd662kck0n771x7anjwh8zixfkaoex', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-13 21:20:30.880897');
INSERT INTO `django_session` VALUES ('f35qm942fakr5h4ccu9a6gdlqvmj0twc', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-04 00:30:00.359426');
INSERT INTO `django_session` VALUES ('fcu9r4vnhepnb9yc4hsa5oy89w5035xy', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-19 15:59:59.046840');
INSERT INTO `django_session` VALUES ('fdkxet99x67ynwtr6maitzu5cvsoe7fu', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-09-11 15:48:40.918717');
INSERT INTO `django_session` VALUES ('fdw9640rwzmfzh3wpybbrcnxgfoqk1k7', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-25 21:26:52.720959');
INSERT INTO `django_session` VALUES ('fnefj5t68an8yipulbiv64v1sxk74t9y', 'MDE1YmE5OWU1NDQxY2E3OTFjYjQyYjgzMzhhZjQzZGUxMzk1ZjdjNTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiXHU2ZDRiXHU4YmQ1XHU5ODc5XHU3NmVlMSIsIm1vZHVsZSI6Ilx1OGJmN1x1OTAwOVx1NjJlOSIsInJlcG9ydF9uYW1lIjoiIn0=', '2019-06-28 22:44:25.533161');
INSERT INTO `django_session` VALUES ('fpe06827zcrlhyp0tig8exo2qlfhtdc1', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-09 23:46:05.801172');
INSERT INTO `django_session` VALUES ('fz5rjsr4gapvzzlizwgtig3vmxxujs39', 'YzUyNTRmZDU3Y2E2MTY0NjQ2MWMzMjE0NmNhMThkZWMwNTI4MDhjZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ0aWFueWluaGUiLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-06-28 20:01:47.746614');
INSERT INTO `django_session` VALUES ('g0bsgmyghw03jtom9ru08h1odz9dleif', 'YTZiNTgzMDE0MGI4NGI2NzA4ZDBmYzFjYWNjM2U4YzRmNTVkYWNmZDp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ6b3VjaHVuIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-28 01:43:05.983403');
INSERT INTO `django_session` VALUES ('g2hr286rmzm038wbmodo8zeswkmitehj', 'MjM2ZGM4YTA4OGZjZTQxZjJjNDFkOTViNTBkZjliM2QyNzJiYmQ4Njp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiIsImV4ZWN1dG9yIjoiIiwic3RhdHVzIjoiIiwidHlwZSI6IiIsIm1vZHVsZV9uYW1lIjoiIn0=', '2019-09-03 23:23:56.760843');
INSERT INTO `django_session` VALUES ('ggp7bc33xprtqocaj7x85sxnpnjcm6ui', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-17 17:05:48.029154');
INSERT INTO `django_session` VALUES ('hc2r9f3g4pafcex88iqitv6c8lxfopwf', 'NzZhZDIwMmRiNjE1ZmY3MTI2NzFmNDdlMmFmNmJhZTE1YzJhMTcxYjp7ImxvZ2luX3N0YXR1cyI6ZmFsc2V9', '2019-06-28 02:30:26.621117');
INSERT INTO `django_session` VALUES ('hf4qge4pm6sam1tjxoecay9gfr6qubb3', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-02 21:19:59.099571');
INSERT INTO `django_session` VALUES ('hz2fn216n1iu0p0ab1553kpo7k0k9gpr', 'Y2M1N2FiMjAzMzQ2OGIzMmI5ODgzMjFhZDVjY2IxYzY3NzQ4NGM3Njp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ4aWFvYmFpIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-22 22:02:54.923623');
INSERT INTO `django_session` VALUES ('i0pkhaeglx6cl01pm4n1gm79bsm0ndhc', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-25 23:42:25.790926');
INSERT INTO `django_session` VALUES ('i5iydc84ybnuk4upleef6xrd8irngbzv', 'N2ZiNDliMTQ3NTRhZTVkZWVlZmY5NjY3NTI3NzAzNzU1ODA1MzExNjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJcdTZkNGJcdThiZDVcdTk4NzlcdTc2ZWUyIiwibW9kdWxlIjoiXHU2YTIxXHU1NzU3XHU1NDBkXHU3OWYwIiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-26 23:46:46.761570');
INSERT INTO `django_session` VALUES ('i8pj6qyxzswa0cyzbmltyoj6ot631cqs', 'OGRiNmRlOTA0OWEzZDAzZmY5MmNlMzZiYmIwYmJkZmM1NGJlYzdlMzp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ4aWFvYmFpIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJcdTgxZWFcdTUyYThcdTkxNGRcdThkMjciLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-20 20:24:13.787434');
INSERT INTO `django_session` VALUES ('ig7rv9bj6e08rki4e8zq2qtsa7z7sogl', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-10 01:11:02.634078');
INSERT INTO `django_session` VALUES ('igmgz7nynj1usv749g8g4788zss3tbfe', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-27 02:29:53.982049');
INSERT INTO `django_session` VALUES ('j45vnxuhtmkvmh3k9ncy2n007v0wf6sv', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-19 22:16:03.040078');
INSERT INTO `django_session` VALUES ('j4dju5e7rxo3fbs8nmfb93qzixk2lg4s', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-06 23:38:32.577956');
INSERT INTO `django_session` VALUES ('j87lpftheo244lyddhlgwjs0lc37ee5x', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-14 23:42:41.809385');
INSERT INTO `django_session` VALUES ('jp2tj9240belcxk3wabn2c492bf3c89d', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-08 22:47:17.333243');
INSERT INTO `django_session` VALUES ('jv8o5onhuvpwsay9tyv4m34dc4ndjy5o', 'NDBkZGQxNGI5NTFkNjA1NzBlYmUyMTNjNGExMGVhNmExYzI2ZDE5Yjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ3ZWlzaGlndW8iLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-05 00:02:37.451599');
INSERT INTO `django_session` VALUES ('k211mxujj0v9d79vlopvoaqbcfjup6t4', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-09-05 23:45:50.232259');
INSERT INTO `django_session` VALUES ('kf4snxg3ihtld5cjxqs6kz3k62erhqyg', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-09-04 19:21:49.855203');
INSERT INTO `django_session` VALUES ('kkvu82y44rv9efrjww8k4dmp2ljty4ge', 'Y2M1N2FiMjAzMzQ2OGIzMmI5ODgzMjFhZDVjY2IxYzY3NzQ4NGM3Njp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ4aWFvYmFpIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-20 16:09:29.529045');
INSERT INTO `django_session` VALUES ('km6o9efunocpfnqyzd1go5438oc7z0n1', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-19 15:52:53.691636');
INSERT INTO `django_session` VALUES ('kp1nua49ji7e64seycsh3qem4xj0885n', 'OWQxODE1M2RhZWM3N2M2YWRkNmY5NGU4MWI4Njk0OTI1ZTI5ZGU5MTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ0dHQxMjM0NTYiLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-05 00:07:49.570355');
INSERT INTO `django_session` VALUES ('l0exq5rgxvap5oxmx1fz86o80l78elca', 'YThiMzQ0YzhlZTdiNjJmN2Y4YThmNTk0YzlhODM2NzQ4MTU2Y2E5YTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiSFJNUyIsIm1vZHVsZSI6Ilx1OGJmN1x1OTAwOVx1NjJlOSIsInJlcG9ydF9uYW1lIjoiIn0=', '2019-07-02 21:35:01.583961');
INSERT INTO `django_session` VALUES ('lafo9zk5judu7udi0mvmwl8xydi5qnn8', 'MWMyNDJhNzcyYWM0NTVlYjZkNTYyODljNGViOGE2MTViZjE5MWVmMjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMWUwOGU0NDllNDExMGQzZDRjMzIzMzI2ZWJiODAxYWI0ZWNlZWY2NyJ9', '2019-06-26 00:17:24.520578');
INSERT INTO `django_session` VALUES ('lqkcb3pkeu97pg5r1vss1q8m8nt3488n', 'YTJlNzZhYWYzMDcyZTQ4YjIyMjcwMGM1MTdhNzEwODg4MjliYzU0Njp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxZTA4ZTQ0OWU0MTEwZDNkNGMzMjMzMjZlYmI4MDFhYjRlY2VlZjY3IiwibG9naW5fc3RhdHVzIjp0cnVlLCJub3dfYWNjb3VudCI6InVzZXIiLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-05 00:21:10.525465');
INSERT INTO `django_session` VALUES ('lsegzzv53myve3iytz7cyw3292l4bdsx', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-24 23:48:47.228374');
INSERT INTO `django_session` VALUES ('ly8d4t3ahwxpzrbpwgm9683g67rroesl', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-27 23:58:05.868117');
INSERT INTO `django_session` VALUES ('m0nf1mpeouf06svg1da6nt3r785seara', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-15 22:26:43.389533');
INSERT INTO `django_session` VALUES ('m2zfke5sohmg7zn1yu94ri3zi4h7v7tz', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-30 15:49:03.864577');
INSERT INTO `django_session` VALUES ('m3nxmuq4ywd9ulucn1h646nzy9kok0uw', 'YTJlNzZhYWYzMDcyZTQ4YjIyMjcwMGM1MTdhNzEwODg4MjliYzU0Njp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxZTA4ZTQ0OWU0MTEwZDNkNGMzMjMzMjZlYmI4MDFhYjRlY2VlZjY3IiwibG9naW5fc3RhdHVzIjp0cnVlLCJub3dfYWNjb3VudCI6InVzZXIiLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-04 00:30:04.983081');
INSERT INTO `django_session` VALUES ('m5yt05q0agc5e997wptwwkco646msfwo', 'YTZiNTgzMDE0MGI4NGI2NzA4ZDBmYzFjYWNjM2U4YzRmNTVkYWNmZDp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ6b3VjaHVuIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-27 01:34:14.884449');
INSERT INTO `django_session` VALUES ('m70j5l0v3ybzl1r6h8o3tqlda8sripg7', 'YzUyNTRmZDU3Y2E2MTY0NjQ2MWMzMjE0NmNhMThkZWMwNTI4MDhjZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ0aWFueWluaGUiLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-04 23:57:26.352231');
INSERT INTO `django_session` VALUES ('mg4cj4i3gqpd77f2zoisvpv1ur15x368', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-02 16:06:27.358602');
INSERT INTO `django_session` VALUES ('muvylrwrt3r7lhv25wam0pquf6lxjxpk', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-08 16:32:01.049258');
INSERT INTO `django_session` VALUES ('n3wnw9x7dhz28c5ewnipj2td7iln9m75', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-29 01:47:16.681809');
INSERT INTO `django_session` VALUES ('ncuza6muwnij2avzf0nmbxm440gx91uc', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-11 16:51:39.324824');
INSERT INTO `django_session` VALUES ('nfqr1t6w07jfmgjz0jdc3qk0oucn36gu', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-26 21:08:31.796523');
INSERT INTO `django_session` VALUES ('o7p4eo3829aogumysp97dab6hvwimeet', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2020-02-20 04:43:40.735297');
INSERT INTO `django_session` VALUES ('ofo7ep0vh3v7rdoyrf4sxakp26esx7jw', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-01 21:31:26.905340');
INSERT INTO `django_session` VALUES ('oknrwokyk8nru9lf0ldwlg99ixrkcpj2', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-24 15:25:10.448356');
INSERT INTO `django_session` VALUES ('oohk3dwg8za5kp0swwmnwq0t7c93i0dw', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-19 23:47:27.156442');
INSERT INTO `django_session` VALUES ('p4kapwtqlh94cnghnrigr0qaxehpigff', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-25 23:22:14.218496');
INSERT INTO `django_session` VALUES ('pc7hsjcd3ggxqh6z606ksgw6w9orsc6m', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-01 15:45:09.715516');
INSERT INTO `django_session` VALUES ('pcy4qpoa8fjjhkfq6hqw2atf325t01do', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-06 21:30:34.053726');
INSERT INTO `django_session` VALUES ('pdn40raorlj4c71dekwzh4cbmqw32akl', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-13 21:16:02.972461');
INSERT INTO `django_session` VALUES ('plxt7r4v59p15tf5kehxpjkc1lx8cufh', 'YzUyNTRmZDU3Y2E2MTY0NjQ2MWMzMjE0NmNhMThkZWMwNTI4MDhjZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ0aWFueWluaGUiLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-09 15:52:22.556654');
INSERT INTO `django_session` VALUES ('prp0w83ao3ef2m8zvhsg9sobvjijx5xx', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-02 15:36:25.401029');
INSERT INTO `django_session` VALUES ('q1qyxack1okl6zwh7i0crpi8ec3ncsx4', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-09-04 00:45:15.725362');
INSERT INTO `django_session` VALUES ('q4zc365m7htrswek62eq3b7luzvnvdcu', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-08 22:18:43.185599');
INSERT INTO `django_session` VALUES ('qfj5gjikpsg4z6qy2nf3nkgjhuir8nix', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-09-11 22:47:17.090482');
INSERT INTO `django_session` VALUES ('qn1gw3tf1nun53avtgb0erd0gpaaayn0', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-09-11 00:10:55.889723');
INSERT INTO `django_session` VALUES ('r8g1jesiiccyk2zgjwdcd51i0aoiv87j', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-29 16:18:09.832672');
INSERT INTO `django_session` VALUES ('rbv6m50q76e4bunt4ljp7jqail6urzet', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-26 19:16:03.364188');
INSERT INTO `django_session` VALUES ('rc0c8tro27ohukx69zlngai9mlru8431', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-01 21:36:38.041378');
INSERT INTO `django_session` VALUES ('rul8r1n2nps5nql3624ykxy2gp17g0ah', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-09-06 21:52:36.289609');
INSERT INTO `django_session` VALUES ('s1bsnins8qgg76835ss4kwlud3sim8s9', 'OGUzMTM4OGY3ZjYxOWEzM2FmNzg1YzhhNDI2NTBhOGFmMzFkNzE0Mjp7fQ==', '2019-07-04 00:12:27.203277');
INSERT INTO `django_session` VALUES ('s2qgpsbt37oqyiv62vi9qnsvnpp0hxpq', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-06 19:12:17.932663');
INSERT INTO `django_session` VALUES ('s5lt67b3t07dg1d63i3xuawk58ymxjsk', 'ZGI3NWU2MzlmMzJiMjRmYTRkMjE0NDZhMGM0OTNlN2Q2Y2NlNTMzMDp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ3YW5namluZ2ZhbmciLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-08 23:46:49.172964');
INSERT INTO `django_session` VALUES ('sjc2t32y6xsl3wc9b60r4msefgangecp', 'YTZiNTgzMDE0MGI4NGI2NzA4ZDBmYzFjYWNjM2U4YzRmNTVkYWNmZDp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ6b3VjaHVuIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-09 20:04:25.153753');
INSERT INTO `django_session` VALUES ('skebngiqm35679g9df1gqt2a7g1chcy7', 'N2VhYWVjODY1OGIwYjc4OGI3MDUyYzE5NWVlYmZhNjlkY2I4NDdkNjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiIxMDM5MjgiLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-08 23:51:55.424324');
INSERT INTO `django_session` VALUES ('sxxtuy8xjgsk9lrpqxm0y4adq4nbb3ua', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-26 21:06:29.297392');
INSERT INTO `django_session` VALUES ('t3f3qvgs08fcba89uh23fvyxy23xo0kx', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-23 16:27:49.711413');
INSERT INTO `django_session` VALUES ('t4w3hd4hknj47q98kx4yu5927wvg3nha', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-09 23:06:19.945345');
INSERT INTO `django_session` VALUES ('t9svm13l1bbo01l7tgo737sauuboq259', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-04 00:10:44.353081');
INSERT INTO `django_session` VALUES ('tdbzzhqv48j3d8clwa8i1stuex2ki4os', 'YzUyNTRmZDU3Y2E2MTY0NjQ2MWMzMjE0NmNhMThkZWMwNTI4MDhjZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ0aWFueWluaGUiLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-06-26 16:06:38.969710');
INSERT INTO `django_session` VALUES ('tedqgxwtfd2hexvc35tq7s9n1xb4xwoi', 'OGYzZmY1MDA2Njg5NzBlY2E0NTZkNDcxZGE3NjE2YTQwNWRjYzFhZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiIxMTEiLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-05 00:03:26.424537');
INSERT INTO `django_session` VALUES ('tq8db63flbvehmr74t5m00eg8wq5pjp5', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-09 16:10:52.917267');
INSERT INTO `django_session` VALUES ('tqmks0yeivd75mstq2q5zbjv8ueuzjs4', 'N2VhYWVjODY1OGIwYjc4OGI3MDUyYzE5NWVlYmZhNjlkY2I4NDdkNjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiIxMDM5MjgiLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-05 19:17:14.741741');
INSERT INTO `django_session` VALUES ('tuidh6qlcw74cbhfnbsr8fcj1pmool67', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-02 21:35:35.659686');
INSERT INTO `django_session` VALUES ('u0djqlsouekop5k5yihv6izrsdau0rby', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-29 20:57:14.800276');
INSERT INTO `django_session` VALUES ('u7g1fz46g3tv2a4fzyix1trixthy3xld', 'YzUyNTRmZDU3Y2E2MTY0NjQ2MWMzMjE0NmNhMThkZWMwNTI4MDhjZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ0aWFueWluaGUiLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-08 23:56:48.440528');
INSERT INTO `django_session` VALUES ('u7o0h6arbn0xogkq0yvkd32hezhdgbpu', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-31 15:32:43.553685');
INSERT INTO `django_session` VALUES ('uov7qkn0ejggjktctmc9irfiql2q8pzw', 'NWVkMjhhNTQ0ZDNjODY1MzA0NDRmZGM4OWFkMWFiMTViYWQ1ODdkZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6Ilx1N2VlOVx1NjU0OFx1Njc0M1x1OTY1MFx1N2JhMVx1NzQwNi1cdTY4MzhcdTdiOTdcdTkwZThcdTk1ZTgtXHU1MjA2XHU5ODc1XHU2N2U1XHU4YmUyIiwicHJvamVjdCI6Ilx1ODFlYVx1NTJhOFx1NWU3Mlx1N2ViZiIsIm1vZHVsZSI6Ilx1OGJmN1x1OTAwOVx1NjJlOSIsInJlcG9ydF9uYW1lIjoiIn0=', '2019-07-25 16:29:23.515844');
INSERT INTO `django_session` VALUES ('v0kkk7er4flj8kkfytbzn3zv00nsj7v0', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-28 22:45:56.224109');
INSERT INTO `django_session` VALUES ('v14bnzozq9wgprksm4q6co360aoy3kk7', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-27 02:21:14.620851');
INSERT INTO `django_session` VALUES ('ve8ik9eepcqzhsfep9enroow1s662lod', 'NDBkZGQxNGI5NTFkNjA1NzBlYmUyMTNjNGExMGVhNmExYzI2ZDE5Yjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ3ZWlzaGlndW8iLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-05 15:40:29.380757');
INSERT INTO `django_session` VALUES ('vgwgaeynco5pdvv6o3d0lnqabvt6dxf5', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-02 19:13:09.628445');
INSERT INTO `django_session` VALUES ('vozd2q4znryaiawiaxoaocpbf26310wm', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-26 21:15:11.807199');
INSERT INTO `django_session` VALUES ('vt52zoscrd94gybpao71ry1rkstpmhw4', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-01 23:19:47.441696');
INSERT INTO `django_session` VALUES ('warrbp0h2dc2748lnh6f6j4513h1ue4a', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-29 23:24:34.123801');
INSERT INTO `django_session` VALUES ('wgwctqib1hmp85sd7sotfh4gac9jyg7q', 'ZTA3MWQwNGRhMWQ5YmM0NDdmMTliNzBkMDlkM2M2ZGExZDUwZmZlYjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJcdTgxZWFcdTUyYThcdTVlNzJcdTdlYmYiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-21 17:16:26.930377');
INSERT INTO `django_session` VALUES ('wh87dpmuuof8af7an7272huwsbzgm7xx', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-02 23:34:06.133875');
INSERT INTO `django_session` VALUES ('wk7737bnm43icvex1jp8fqhowadqgnwf', 'YTZiNTgzMDE0MGI4NGI2NzA4ZDBmYzFjYWNjM2U4YzRmNTVkYWNmZDp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ6b3VjaHVuIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-10 15:30:12.873671');
INSERT INTO `django_session` VALUES ('wo90qjoh34dp0ku7iwy22i89pnbep29n', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-05 23:28:01.662495');
INSERT INTO `django_session` VALUES ('wssus8ck9k0cysnz8f6v2h73np2pq7da', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-09 16:42:46.478390');
INSERT INTO `django_session` VALUES ('wuijiouw6y6qovpbud8pkm9qnvo8x4ly', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-11 01:47:49.853471');
INSERT INTO `django_session` VALUES ('x12r8ybj8v52x3nfhydttbx2phugor4s', 'YTZiNTgzMDE0MGI4NGI2NzA4ZDBmYzFjYWNjM2U4YzRmNTVkYWNmZDp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ6b3VjaHVuIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-06 00:22:28.590398');
INSERT INTO `django_session` VALUES ('x22xb805qg027pjlha15fcak70rma0d0', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-26 22:53:28.157495');
INSERT INTO `django_session` VALUES ('x4hpxjm3iaglyjy76b57oalrdbl44p72', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-14 15:41:10.001848');
INSERT INTO `django_session` VALUES ('x6094a7ouzbfq30uavrgrkffm5z8kb0b', 'Y2Q1NDdmNWIxYWNjZDk5Mjg4M2EwZDk0MGRmODk1NjdmZjRjZDY1ZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-08-14 23:25:35.451219');
INSERT INTO `django_session` VALUES ('xct0ky1t2r55kj8kkdeva41drz8svqb2', 'ZGI3NWU2MzlmMzJiMjRmYTRkMjE0NDZhMGM0OTNlN2Q2Y2NlNTMzMDp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ3YW5namluZ2ZhbmciLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-05 15:34:26.074079');
INSERT INTO `django_session` VALUES ('xdk2ysux9tzpvw9y537rn9mhicti41vq', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-29 20:59:22.480157');
INSERT INTO `django_session` VALUES ('xi2r66xnwi0g9uacqcarziom2fb08kpa', 'YTJlNzZhYWYzMDcyZTQ4YjIyMjcwMGM1MTdhNzEwODg4MjliYzU0Njp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxZTA4ZTQ0OWU0MTEwZDNkNGMzMjMzMjZlYmI4MDFhYjRlY2VlZjY3IiwibG9naW5fc3RhdHVzIjp0cnVlLCJub3dfYWNjb3VudCI6InVzZXIiLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-06-27 00:20:28.300949');
INSERT INTO `django_session` VALUES ('xj5w4gn2k59fvmq5zq0ylqg5l1pasuil', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-25 22:59:48.555897');
INSERT INTO `django_session` VALUES ('xj7br1biawm56l1rwwm8q68jat1lm01e', 'YzUyNTRmZDU3Y2E2MTY0NjQ2MWMzMjE0NmNhMThkZWMwNTI4MDhjZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ0aWFueWluaGUiLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-06-29 23:36:30.549087');
INSERT INTO `django_session` VALUES ('xjq9tqn1le9xjvn3enjwv06qb8ltq0vh', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-29 16:20:31.971445');
INSERT INTO `django_session` VALUES ('xjuik1fhfodn8cv79qxnellb23w2d1ut', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-04 15:48:55.544197');
INSERT INTO `django_session` VALUES ('ymoekgbimrytzad3o0j4xtq8jajv05oq', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-25 21:44:34.018866');
INSERT INTO `django_session` VALUES ('ymvg8uvjr14imksnor5sop5o9na2mj6c', 'NjUyOWE2NTc5NzJkOGQyMTMyYWUwMzY1YjJmNTg3MzllZTE0OTU5Yzp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyMSIsInVzZXJfdHlwZSI6MH0=', '2019-07-18 23:00:03.361581');
INSERT INTO `django_session` VALUES ('ysf0j4s1o6fot8wdqoip0x6dtad2w2hn', 'NWQxOGY0Nzk5ODFkMDAzODQyZWNhNDE2ZjBkMmM0NTE5NzcxODQxZjp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-07-05 00:16:16.823785');
INSERT INTO `django_session` VALUES ('yym32yh7yqjij1p94oeod365jcqgjsq6', 'YTZiNTgzMDE0MGI4NGI2NzA4ZDBmYzFjYWNjM2U4YzRmNTVkYWNmZDp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ6b3VjaHVuIiwidXNlciI6IiIsIm5hbWUiOiIiLCJwcm9qZWN0IjoiQWxsIiwibW9kdWxlIjoiXHU4YmY3XHU5MDA5XHU2MmU5IiwicmVwb3J0X25hbWUiOiIifQ==', '2019-06-27 20:30:12.387429');
INSERT INTO `django_session` VALUES ('zc0u5242edm3i1makxz27wr0fyi8n71x', 'N2NjZjhlMzY5MjdmZjI2OTBkZmYwYjkyMTA4MjgyMGQxMGM3NDQzODp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjoxLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiJ9', '2019-07-23 21:00:19.751424');
INSERT INTO `django_session` VALUES ('zd7hhw8f62leppq7r9on9fg5w3whcdi7', 'ZmE5NGM5OWMzY2U2ZTVjYmE2MTg4YzVkZmFhNGFjNDBhOWI0OTRkZTp7ImxvZ2luX3N0YXR1cyI6dHJ1ZSwibm93X2FjY291bnQiOiJ1c2VyIiwidXNlcl90eXBlIjowLCJ1c2VyIjoiIiwibmFtZSI6IiIsInByb2plY3QiOiJBbGwiLCJtb2R1bGUiOiJcdThiZjdcdTkwMDlcdTYyZTkiLCJyZXBvcnRfbmFtZSI6IiIsImV4ZWN1dG9yIjoiIiwic3RhdHVzIjoiIiwidHlwZSI6IiJ9', '2019-09-09 23:17:49.266084');

-- ----------------------------
-- Table structure for djcelery_crontabschedule
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_crontabschedule`;
CREATE TABLE `djcelery_crontabschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `minute` varchar(64) NOT NULL,
  `hour` varchar(64) NOT NULL,
  `day_of_week` varchar(64) NOT NULL,
  `day_of_month` varchar(64) NOT NULL,
  `month_of_year` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of djcelery_crontabschedule
-- ----------------------------
INSERT INTO `djcelery_crontabschedule` VALUES ('1', 'H/5', '*', '*', '*', '*');
INSERT INTO `djcelery_crontabschedule` VALUES ('2', '0', '4', '*', '*', '*');
INSERT INTO `djcelery_crontabschedule` VALUES ('3', '*', '*', '*', '*', '*');

-- ----------------------------
-- Table structure for djcelery_intervalschedule
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_intervalschedule`;
CREATE TABLE `djcelery_intervalschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `every` int(11) NOT NULL,
  `period` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of djcelery_intervalschedule
-- ----------------------------

-- ----------------------------
-- Table structure for djcelery_periodictask
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_periodictask`;
CREATE TABLE `djcelery_periodictask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `task` varchar(200) NOT NULL,
  `args` longtext NOT NULL,
  `kwargs` longtext NOT NULL,
  `queue` varchar(200) DEFAULT NULL,
  `exchange` varchar(200) DEFAULT NULL,
  `routing_key` varchar(200) DEFAULT NULL,
  `expires` datetime(6) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `last_run_at` datetime(6) DEFAULT NULL,
  `total_run_count` int(10) unsigned NOT NULL,
  `date_changed` datetime(6) NOT NULL,
  `description` longtext NOT NULL,
  `crontab_id` int(11) DEFAULT NULL,
  `interval_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `djcelery_periodictas_crontab_id_75609bab_fk_djcelery_` (`crontab_id`),
  KEY `djcelery_periodictas_interval_id_b426ab02_fk_djcelery_` (`interval_id`),
  CONSTRAINT `djcelery_periodictas_crontab_id_75609bab_fk_djcelery_` FOREIGN KEY (`crontab_id`) REFERENCES `djcelery_crontabschedule` (`id`),
  CONSTRAINT `djcelery_periodictas_interval_id_b426ab02_fk_djcelery_` FOREIGN KEY (`interval_id`) REFERENCES `djcelery_intervalschedule` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of djcelery_periodictask
-- ----------------------------
INSERT INTO `djcelery_periodictask` VALUES ('2', '托尔斯泰2', 'ApiManager.tasks.project_hrun', '[]', '{\"name\": \"托尔斯泰2\", \"base_url\": \"\", \"project\": \"测试项目2\", \"receiver\": \"2855832063@qq.com\"}', null, null, null, null, '0', null, '0', '2019-08-08 15:10:58.843202', 'H/5 * * * *', '1', null);
INSERT INTO `djcelery_periodictask` VALUES ('3', '测试一下', 'ApiManager.tasks.module_hrun', '[]', '{\"name\": \"测试一下\", \"base_url\": \"\", \"module\": [[\"2\", \"模块名称\"]], \"receiver\": \"2855832063@qq.com\"}', null, null, null, null, '1', null, '0', '2019-06-26 17:02:45.822408', 'H/5 * * * *', '1', null);
INSERT INTO `djcelery_periodictask` VALUES ('4', 'celery.backend_cleanup', 'celery.backend_cleanup', '[]', '{}', null, null, null, null, '1', '2019-09-05 20:00:00.002065', '24', '2019-09-06 18:43:15.510522', '', '2', null);

-- ----------------------------
-- Table structure for djcelery_periodictasks
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_periodictasks`;
CREATE TABLE `djcelery_periodictasks` (
  `ident` smallint(6) NOT NULL,
  `last_update` datetime(6) NOT NULL,
  PRIMARY KEY (`ident`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of djcelery_periodictasks
-- ----------------------------
INSERT INTO `djcelery_periodictasks` VALUES ('1', '2019-09-06 18:43:15.394955');

-- ----------------------------
-- Table structure for djcelery_taskstate
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_taskstate`;
CREATE TABLE `djcelery_taskstate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(64) NOT NULL,
  `task_id` varchar(36) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `tstamp` datetime(6) NOT NULL,
  `args` longtext,
  `kwargs` longtext,
  `eta` datetime(6) DEFAULT NULL,
  `expires` datetime(6) DEFAULT NULL,
  `result` longtext,
  `traceback` longtext,
  `runtime` double DEFAULT NULL,
  `retries` int(11) NOT NULL,
  `hidden` tinyint(1) NOT NULL,
  `worker_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_id` (`task_id`),
  KEY `djcelery_taskstate_state_53543be4` (`state`),
  KEY `djcelery_taskstate_name_8af9eded` (`name`),
  KEY `djcelery_taskstate_tstamp_4c3f93a1` (`tstamp`),
  KEY `djcelery_taskstate_hidden_c3905e57` (`hidden`),
  KEY `djcelery_taskstate_worker_id_f7f57a05_fk_djcelery_workerstate_id` (`worker_id`),
  CONSTRAINT `djcelery_taskstate_worker_id_f7f57a05_fk_djcelery_workerstate_id` FOREIGN KEY (`worker_id`) REFERENCES `djcelery_workerstate` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of djcelery_taskstate
-- ----------------------------

-- ----------------------------
-- Table structure for djcelery_workerstate
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_workerstate`;
CREATE TABLE `djcelery_workerstate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hostname` varchar(255) NOT NULL,
  `last_heartbeat` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hostname` (`hostname`),
  KEY `djcelery_workerstate_last_heartbeat_4539b544` (`last_heartbeat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of djcelery_workerstate
-- ----------------------------

-- ----------------------------
-- Table structure for envinfo
-- ----------------------------
DROP TABLE IF EXISTS `envinfo`;
CREATE TABLE `envinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `env_name` varchar(40) NOT NULL,
  `base_url` varchar(40) NOT NULL,
  `simple_desc` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `env_name` (`env_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of envinfo
-- ----------------------------
INSERT INTO `envinfo` VALUES ('4', '2019-07-09 11:42:32.841911', '2020-02-27 17:24:20.583730', 'ApiTest', 'http://10.125.215.6:9101', '测试运行环境');

-- ----------------------------
-- Table structure for moduleinfo
-- ----------------------------
DROP TABLE IF EXISTS `moduleinfo`;
CREATE TABLE `moduleinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `module_name` varchar(50) NOT NULL,
  `test_user` varchar(50) NOT NULL,
  `simple_desc` varchar(100) DEFAULT NULL,
  `other_desc` varchar(100) DEFAULT NULL,
  `belong_project_id` int(11) NOT NULL,
  `creator` varchar(20) NOT NULL COMMENT '创建人',
  `config_id` int(22) DEFAULT NULL COMMENT '关联配置id',
  `leader_user` varchar(300) DEFAULT NULL COMMENT '负责人(多个","号隔开)',
  PRIMARY KEY (`id`),
  KEY `ModuleInfo_belong_project_id_7a17e510_fk_ProjectInfo_id` (`belong_project_id`),
  CONSTRAINT `ModuleInfo_belong_project_id_7a17e510_fk_ProjectInfo_id` FOREIGN KEY (`belong_project_id`) REFERENCES `projectinfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of moduleinfo
-- ----------------------------

-- ----------------------------
-- Table structure for projectinfo
-- ----------------------------
DROP TABLE IF EXISTS `projectinfo`;
CREATE TABLE `projectinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `project_name` varchar(50) NOT NULL,
  `responsible_name` varchar(300) DEFAULT NULL COMMENT '负责人(多个","号隔开)',
  `test_user` varchar(100) NOT NULL,
  `dev_user` varchar(100) NOT NULL,
  `publish_app` varchar(100) NOT NULL,
  `simple_desc` varchar(100) DEFAULT NULL,
  `other_desc` varchar(100) DEFAULT NULL,
  `creator` varchar(20) NOT NULL COMMENT '创建人',
  `config_id` int(22) DEFAULT NULL COMMENT '关联配置id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_name` (`project_name`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of projectinfo
-- ----------------------------
INSERT INTO `projectinfo` VALUES ('1', '2019-06-25 18:08:04.842766', '2019-08-07 18:52:32.875457', '测试项目1', 'zhangxu', '张三', '张三', '张三', '阿斯顿发水电费', '阿斯蒂芬', 'zhangxu', null);

-- ----------------------------
-- Table structure for service_config
-- ----------------------------
DROP TABLE IF EXISTS `service_config`;
CREATE TABLE `service_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `service_name` varchar(50) NOT NULL COMMENT '所属服务名称',
  `service_version` varchar(30) DEFAULT NULL COMMENT '所属服务版本',
  `env_id` int(11) DEFAULT NULL COMMENT '运行环境',
  `remark` varchar(200) DEFAULT NULL COMMENT '描述',
  `creator` varchar(20) NOT NULL COMMENT '创建人',
  `create_time` datetime(6) NOT NULL COMMENT '创建人',
  `modifier` varchar(20) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(6) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=647 DEFAULT CHARSET=utf8mb4 COMMENT='服务关联配置';


-- ----------------------------
-- Table structure for service_config_detail
-- ----------------------------
DROP TABLE IF EXISTS `service_config_detail`;
CREATE TABLE `service_config_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `service_config_id` int(11) NOT NULL COMMENT '服务配置ID',
  `relation_id` varchar(32) DEFAULT NULL COMMENT '关联id',
  `relation_name` varchar(100) DEFAULT NULL COMMENT '关联名称',
  `relation_type` int(4) NOT NULL COMMENT '关联类型(1-项目,2-模块,3-套件,4-用例,5-服务)',
  `creator` varchar(20) NOT NULL COMMENT '创建人',
  `create_time` datetime(6) NOT NULL COMMENT '创建人',
  `modifier` varchar(20) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(6) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1087 DEFAULT CHARSET=utf8mb4 COMMENT='服务关联配置明细';


-- ----------------------------
-- Table structure for testcaseinfo
-- ----------------------------
DROP TABLE IF EXISTS `testcaseinfo`;
CREATE TABLE `testcaseinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `type` int(11) NOT NULL,
  `name` varchar(120) NOT NULL,
  `belong_project` varchar(50) NOT NULL,
  `include` longtext,
  `author` varchar(20) NOT NULL,
  `request` longtext NOT NULL,
  `belong_module_id` int(11) NOT NULL,
  `run_type` int(2) NOT NULL DEFAULT '1' COMMENT '运行方式(0:集成运行,1:独立运行)',
  `service_name` varchar(50) DEFAULT NULL COMMENT '所属服务名称',
  PRIMARY KEY (`id`),
  KEY `TestCaseInfo_belong_module_id_040b8702_fk_ModuleInfo_id` (`belong_module_id`),
  CONSTRAINT `TestCaseInfo_belong_module_id_040b8702_fk_ModuleInfo_id` FOREIGN KEY (`belong_module_id`) REFERENCES `moduleinfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=332 DEFAULT CHARSET=utf8mb4;


-- ----------------------------
-- Table structure for testcase_logic_info
-- ----------------------------
DROP TABLE IF EXISTS `testcase_logic_info`;
CREATE TABLE `testcase_logic_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `type` int(11) NOT NULL,
  `name` varchar(120) NOT NULL,
  `belong_project` varchar(50) NOT NULL,
  `include` longtext,
  `author` varchar(20) NOT NULL,
  `request` longtext NOT NULL,
  `belong_module_id` int(11) NOT NULL,
  `run_type` int(2) NOT NULL DEFAULT '1' COMMENT '运行方式(0:集成运行,1:独立运行)',
  `service_name` varchar(50) DEFAULT NULL COMMENT '所属服务名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=338 DEFAULT CHARSET=utf8mb4 COMMENT='逻辑用例信息';

-- ----------------------------
-- Records of testcase_logic_info
-- ----------------------------
INSERT INTO `testcase_logic_info` VALUES ('322', '2019-09-04 16:21:15.186325', '2019-09-04 16:21:15.186325', '1', '循环提取测试', '测试项目1', '[]', 'user', '{\'test\': {\'request\': {\'url\': \'http://edge.uat.kye-erp.com/router/rest\', \'method\': \'POST\', \'json\': [{\'xpath\': \'xxxx15645588289151189\', \'action\': \'首页\', \'userId\': \'140072\', \'menuId\': \'\', \'startTime\': \'1564558828915\', \'endTime\': \'0\', \'url\': \'/\', \'requestHeaders\': \'140072--1564558828915\', \'requestBody\': \'\', \'responseHeaders\': \'\', \'responseData\': \'\', \'httpStatus\': \'\', \'webTraceId\': \'xxxx-1564558828915-1189-\', \'resCode\': \'\', \'location\': \'/\', \'navigator\': \'5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36\'}, {\'xpath\': \'14007215645588378221309\', \'action\': \'单位管理\', \'userId\': \'140072\', \'menuId\': \'1005036734308749312\', \'startTime\': \'1564558837822\', \'endTime\': \'0\', \'url\': \'/ims/unit-management/list\', \'requestHeaders\': \'140072-1005036734308749312-1564558837822\', \'requestBody\': \'\', \'responseHeaders\': \'\', \'responseData\': \'\', \'httpStatus\': \'\', \'webTraceId\': \'140072-1564558837822-1309-1005036734308749312\', \'resCode\': \'\', \'location\': \'/ims/unit-management/list\', \'navigator\': \'5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36\'}, {\'xpath\': \'14007215645588408101048\', \'action\': \'查询(Q)\', \'userId\': \'140072\', \'menuId\': \'1005036734308749312\', \'startTime\': \'1564558840812\', \'endTime\': \'1564558841025\', \'url\': \'/router/rest?ims.basicUnit.search\', \'requestHeaders\': \'140072-1005036734308749312-1564558837822\', \'requestBody\': \'\', \'responseHeaders\': \'\', \'responseData\': \'\', \'httpStatus\': \'200\', \'webTraceId\': \'140072-1564558840812-2456-1005036734308749312\', \'resCode\': \'0\', \'location\': \'http://edge.uat.kye-erp.com/#/ims/unit-management/list\', \'navigator\': \'5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36\'}], \'headers\': {\'sign\': \'497154FAED7D5B64EAE326CB2AC943C1\', \'method\': \'cts.trace.uploadWebActionLog\', \'User-Agent\': \'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36\', \'format\': \'JSON\', \'Content-Type\': \'application/json;charset=UTF-8\', \'timestamp\': \'1564558841026\', \'token\': \'17fe3d26-357b-4d37-a57e-ea7c0f688193\', \'appkey\': \'50159\'}}, \'name\': \'循环提取测试\'}}', '26', '0', 'cts');
INSERT INTO `testcase_logic_info` VALUES ('323', '2019-09-05 11:07:41.519196', '2019-09-05 11:07:41.519196', '1', 'ims.basicUnit.search', '测试项目1', '[]', 'user', '{\'test\': {\'name\': \'ims.basicUnit.search\', \'request\': {\'url\': \'http://10.125.201.2/router/rest\', \'params\': {\'ims.basicUnit.search\': \'\'}, \'method\': \'POST\', \'headers\': {\'webTraceId\': \'140072-1567652813169-5045-1005036734308749312\', \'X-menu-id\': \'1005036734308749312\', \'sign\': \'0D13115A3E9ACC5C428D367902FB4571\', \'method\': \'ims.basicUnit.search\', \'User-Agent\': \'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36\', \'format\': \'JSON\', \'Content-Type\': \'application/json;charset=UTF-8\', \'timestamp\': \'1567652813169\', \'token\': \'6c17c266-81d3-4ab1-8334-7c0553fcfbf9\', \'appkey\': \'10164\'}, \'json\': {\'page\': 1, \'pageSize\': 200, \'elasticsearchFlag\': \'N\', \'generic\': {\'vos\': []}, \'ERPSearchCacheFlag\': True, \'forceCache\': True, \'menuId\': \'1005036734308749312\', \'genericSearchCode\': \'basicUnit_general_search\'}}, \'validate\': []}}', '31', '1', 'ims');
INSERT INTO `testcase_logic_info` VALUES ('324', '2019-09-05 11:07:41.684005', '2019-09-05 11:07:41.684005', '1', 'system.genericSearch.listByMenuId', '测试项目1', '[]', 'user', '{\'test\': {\'name\': \'system.genericSearch.listByMenuId\', \'request\': {\'url\': \'http://10.125.201.2/router/rest\', \'params\': {\'system.genericSearch.listByMenuId\': \'\'}, \'method\': \'POST\', \'headers\': {\'webTraceId\': \'140072-1567652816478-8454-1005037427371347968\', \'X-menu-id\': \'1005037427371347968\', \'sign\': \'71D183DBD66E357E245426F04684FB0F\', \'method\': \'system.genericSearch.listByMenuId\', \'User-Agent\': \'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36\', \'format\': \'JSON\', \'Content-Type\': \'application/json;charset=UTF-8\', \'timestamp\': \'1567652816478\', \'token\': \'6c17c266-81d3-4ab1-8334-7c0553fcfbf9\', \'appkey\': \'10124\'}, \'json\': {\'menuId\': \'1005037427371347968\', \'time\': \'1567652817977\'}}, \'validate\': []}}', '31', '1', 'system');
INSERT INTO `testcase_logic_info` VALUES ('327', '2019-09-05 11:07:42.080686', '2019-09-05 11:07:42.080686', '1', 'cts.trace.uploadWebActionLog', '测试项目1', '[]', 'user', '{\'test\': {\'name\': \'cts.trace.uploadWebActionLog\', \'request\': {\'url\': \'http://10.125.201.2/router/rest\', \'params\': {\'cts.trace.uploadWebActionLog\': \'\'}, \'method\': \'POST\', \'headers\': {\'sign\': \'E315F58A7C9624A4A1296B8EE55B2BC7\', \'method\': \'cts.trace.uploadWebActionLog\', \'User-Agent\': \'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36\', \'format\': \'JSON\', \'Content-Type\': \'application/json;charset=UTF-8\', \'timestamp\': \'1567652821372\', \'token\': \'6c17c266-81d3-4ab1-8334-7c0553fcfbf9\', \'appkey\': \'50159\'}, \'json\': [{\'xpath\': \'14007215676528100751665\', \'action\': \'单位管理\', \'userId\': \'140072\', \'menuId\': \'1005036734308749312\', \'startTime\': \'1567652810075\', \'endTime\': \'0\', \'url\': \'/ims/basis-unit/list\', \'requestHeaders\': \'140072-1005036734308749312-1567652810075\', \'requestBody\': \'\', \'responseHeaders\': \'\', \'responseData\': \'\', \'httpStatus\': \'\', \'webTraceId\': \'140072-1567652810075-1665-1005036734308749312\', \'resCode\': \'\', \'location\': \'/ims/basis-unit/list\', \'navigator\': \'5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36\'}, {\'xpath\': \'14007215676528131621324\', \'action\': \'查询(Q)\', \'userId\': \'140072\', \'menuId\': \'1005036734308749312\', \'startTime\': \'1567652813169\', \'endTime\': \'1567652813326\', \'url\': \'/router/rest?ims.basicUnit.search\', \'requestHeaders\': \'140072-1005036734308749312-1567652810075\', \'requestBody\': \'\', \'responseHeaders\': \'\', \'responseData\': \'\', \'httpStatus\': \'200\', \'webTraceId\': \'140072-1567652813169-5045-1005036734308749312\', \'resCode\': \'0\', \'location\': \'http://10.125.201.2/#/ims/basis-unit/list\', \'navigator\': \'5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36\'}, {\'xpath\': \'14007215676528164091999\', \'action\': \'品牌型号\', \'userId\': \'140072\', \'menuId\': \'1005037427371347968\', \'startTime\': \'1567652816409\', \'endTime\': \'0\', \'url\': \'/ims/basis-brand-model/list\', \'requestHeaders\': \'140072-1005037427371347968-1567652816409\', \'requestBody\': \'\', \'responseHeaders\': \'\', \'responseData\': \'\', \'httpStatus\': \'\', \'webTraceId\': \'140072-1567652816409-1999-1005037427371347968\', \'resCode\': \'\', \'location\': \'/ims/basis-brand-model/list\', \'navigator\': \'5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36\'}, {\'xpath\': \'14007215676528176331770\', \'action\': \'查询(Q)\', \'userId\': \'140072\', \'menuId\': \'1005037427371347968\', \'startTime\': \'1567652817634\', \'endTime\': \'1567652817975\', \'url\': \'/router/rest?ims.basicBrand.search\', \'requestHeaders\': \'140072-1005037427371347968-1567652816409\', \'requestBody\': \'\', \'responseHeaders\': \'\', \'responseData\': \'\', \'httpStatus\': \'200\', \'webTraceId\': \'140072-1567652817634-9007-1005037427371347968\', \'resCode\': \'0\', \'location\': \'http://10.125.201.2/#/ims/basis-brand-model/list\', \'navigator\': \'5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36\'}, {\'xpath\': \'14007215676528213721326\', \'action\': \'成本分类\', \'userId\': \'140072\', \'menuId\': \'1066236178441768963\', \'startTime\': \'1567652821372\', \'endTime\': \'0\', \'url\': \'/ims/basis-cost-classification\', \'requestHeaders\': \'140072-1066236178441768963-1567652821372\', \'requestBody\': \'\', \'responseHeaders\': \'\', \'responseData\': \'\', \'httpStatus\': \'\', \'webTraceId\': \'140072-1567652821372-1326-1066236178441768963\', \'resCode\': \'\', \'location\': \'/ims/basis-cost-classification\', \'navigator\': \'5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36\'}]}, \'validate\': []}}', '31', '1', 'cts');
INSERT INTO `testcase_logic_info` VALUES ('328', '2019-09-05 11:07:42.185960', '2019-09-05 19:01:03.522637', '1', 'ims.basicCostCategory.search', '测试项目1', '[]', 'user', '\r\n{\'test\': {\'request\': {\'url\': \'http://10.125.201.2/router/rest\', \'method\': \'POST\', \'json\': {\'page\': \'$page\', \'pageSize\': \'$pageSize\', \'elasticsearchFlag\': \'N\', \'generic\': {\'vos\': []}, \'level\': \'1\', \'ERPSearchCacheFlag\': True, \'forceCache\': True}, \'headers\': {\'webTraceId\': \'140072-1567652821660-3435-1066236178441768963\', \'X-menu-id\': \'1066236178441768963\', \'sign\': \'8B5B85D8B25AEEBBC05279969C794678\', \'method\': \'ims.basicCostCategory.search\', \'User-Agent\': \'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36\', \'format\': \'JSON\', \'Content-Type\': \'application/json;charset=UTF-8\', \'timestamp\': \'1567652821660\', \'token\': \'6c17c266-81d3-4ab1-8334-7c0553fcfbf9\', \'appkey\': \'10164\'}}, \'name\': \'ims.basicCostCategory.search\', \'validate\': [{\'comparator\': \'equals\', \'check\': \'content.code\', \'expected\': \'123123\'}], \r\n\'parameters\': [{\'&assert&\': \'[22222222]\', \'page-test\': [[111],[222]]}, {\'&assert&\': \'[33333333333]\', \'page1\': [3, 4]}]}}', '31', '1', 'ims');
INSERT INTO `testcase_logic_info` VALUES ('329', '2019-09-06 14:52:43.013243', '2019-09-06 14:52:43.013243', '1', 'system.genericSearch.listByMenuId', '测试项目2', '[]', 'user', '{\'test\': {\'name\': \'system.genericSearch.listByMenuId\', \'request\': {\'url\': \'https://www.kye-erp.com/router/rest\', \'params\': {\'system.genericSearch.listByMenuId\': \'\'}, \'method\': \'POST\', \'headers\': {\'webtraceid\': \'140072-1567752689390-0820-1011546240312217600\', \'sec-fetch-mode\': \'cors\', \'x-menu-id\': \'1011546240312217600\', \'sign\': \'326C852FA0591E02E3A218020A1DC316\', \'method\': \'system.genericSearch.listByMenuId\', \'user-agent\': \'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36\', \'format\': \'JSON\', \'content-type\': \'application/json;charset=UTF-8\', \'timestamp\': \'1567752689390\', \'sec-fetch-site\': \'same-origin\', \'token\': \'c4662111-17d3-47fb-8b55-b7b72bee88ee\', \'appkey\': \'10124\'}, \'json\': {\'menuId\': \'1011546240312217600\', \'time\': \'1567752690328\'}}, \'validate\': []}}', '2', '1', 'system');
INSERT INTO `testcase_logic_info` VALUES ('330', '2019-09-06 14:52:43.126259', '2019-09-06 15:02:50.352536', '1', 'system.genericSearch.template.listByGenericId', '测试项目2', '[]', 'user', '{\'test\': {\'request\': {\'url\': \'https://www.kye-erp.com/router/rest\', \'method\': \'POST\', \'json\': {\'test\': \'${get_test(?3423)}\', \'genericId\': \'1012676329108213760\'}, \'headers\': {\'webtraceid\': \'140072-1567752689631-1144-1011546240312217600\', \'sec-fetch-mode\': \'cors\', \'x-menu-id\': \'1011546240312217600\', \'sign\': \'57939564BF7AEA2DEAA23CC8B4BABF6C\', \'method\': \'system.genericSearch.template.listByGenericId\', \'user-agent\': \'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36\', \'format\': \'JSON\', \'content-type\': \'application/json;charset=UTF-8\', \'timestamp\': \'1567752689631\', \'sec-fetch-site\': \'same-origin\', \'token\': \'c4662111-17d3-47fb-8b55-b7b72bee88ee\', \'appkey\': \'10124\'}}, \'name\': \'system.genericSearch.template.listByGenericId\'}}', '2', '1', 'system-genericSearch');
INSERT INTO `testcase_logic_info` VALUES ('331', '2019-09-06 14:52:43.278167', '2019-09-10 18:18:12.047437', '1', 'mcs.mcsMenu.search', '测试项目2', '[]', 'user', '{\'test\': {\'request\': {\'url\': \'https://www.kye-erp.com/router/rest\', \'method\': \'POST\', \'json\': {\'key1\': \'$key1\', \'key2\': \'$key2\'}, \'headers\': {\'webtraceid\': \'140072-1567752734574-5869-150038606985888135\', \'sec-fetch-mode\': \'cors\', \'x-menu-id\': \'150038606985888135\', \'sign\': \'803A0B78837F454F0F26C4A6D15F4617\', \'method\': \'mcs.mcsMenu.search\', \'user-agent\': \'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36\', \'format\': \'JSON\', \'content-type\': \'application/json;charset=UTF-8\', \'timestamp\': \'1567752734574\', \'sec-fetch-site\': \'same-origin\', \'token\': \'c4662111-17d3-47fb-8b55-b7b72bee88ee\', \'appkey\': \'50178\'}}, \'name\': \'mcs.mcsMenu.search\', \'validate\': [{\'comparator\': \'equals\', \'check\': \'content.code\', \'expected\': \'100201\'}], \'parameters\': [{\'&assert&\': \"[{\'check\': \'content.code\', \'comparator\': \'equals\', \'expected\': \'100201\'},{\'check\': \'content.msg\', \'comparator\': \'equals\', \'expected\': \'OK\'}]\", \'key1-key2\': [\'value1\', \'value1\']}, {\'&assert&\': \"[{\'check\': \'content.msg\', \'comparator\': \'equals\', \'expected\': \'不OK\'}]\", \'key1-key2\': [\'value2\', \'value2\']}]}}', '2', '1', 'mcs');
INSERT INTO `testcase_logic_info` VALUES ('332', '2019-09-11 11:16:50.908108', '2019-09-11 11:16:50.908108', '1', 'aaaaaaaaaaaaaaaaa', '自动干线', '[]', 'user', '{\'test\': {\'request\': {\'url\': \'111111111\', \'method\': \'POST\', \'json\': {\'key\': \'value\'}}, \'name\': \'aaaaaaaaaaaaaaaaa\', \'parameters\': [{\'&assert&\': \'1111111111\', \'asdf\': [11]}, {\'&assert&\': \'111111111111111\', \'1111111111111111\': [11]}]}}', '12', '1', '');
INSERT INTO `testcase_logic_info` VALUES ('335', '2019-09-11 16:55:48.936173', '2019-09-11 16:55:48.936673', '1', '获取下单编码11111', '自动干线', '[]', 'zouchun', '{\'test\': {\'request\': {\'url\': \'http://edge.uat.kye-erp.com/router/rest\', \'method\': \'POST\', \'json\': {\'key\': \'value\'}, \'headers\': {\'Content-Type\': \'application/json;charset=UTF-8\', \'User-Agent\': \'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36\', \'X-menu-id\': \'3799854782090627\', \'appkey\': \'10123\', \'format\': \'JSON\', \'method\': \'oms.order.add\', \'sign\': \'0F18B047A9C06DD20A3C4532A6F890A5\', \'timestamp\': \'1560850005177\', \'webTraceId\': \'109527-1560850005177-6900-3799854782090627\'}}, \'name\': \'获取下单编码11111\', \'validate\': [{\'comparator\': \'equals\', \'check\': \'status_code\', \'expected\': 200}, {\'comparator\': \'equals\', \'check\': \'content.msg\', \'expected\': \'OK\'}], \'extract\': [{\'orderNumber\': \'content.data\'}]}}', '12', '1', 'oms');
INSERT INTO `testcase_logic_info` VALUES ('336', '2019-09-11 17:01:31.055014', '2019-09-11 17:01:31.055514', '1', '获取下单编码44444444', '自动干线', '[]', 'zouchun', '{\'test\': {\'request\': {\'url\': \'http://edge.uat.kye-erp.com/router/rest\', \'method\': \'POST\', \'headers\': {\'Content-Type\': \'application/json;charset=UTF-8\', \'User-Agent\': \'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36\', \'X-menu-id\': \'3799854782090627\', \'appkey\': \'10123\', \'format\': \'JSON\', \'method\': \'oms.order.add\', \'sign\': \'0F18B047A9C06DD20A3C4532A6F890A5\', \'timestamp\': \'1560850005177\', \'webTraceId\': \'109527-1560850005177-6900-3799854782090627\'}}, \'name\': \'获取下单编码44444444\', \'validate\': [{\'comparator\': \'equals\', \'check\': \'status_code\', \'expected\': 200}, {\'comparator\': \'equals\', \'check\': \'content.msg\', \'expected\': \'OK\'}], \'extract\': [{\'orderNumber\': \'content.data\'}]}}', '12', '1', 'oms');
INSERT INTO `testcase_logic_info` VALUES ('337', '2019-09-11 17:04:58.075648', '2019-09-11 17:04:58.076161', '1', '获取下单编码6666666', '自动干线', '[]', 'user', '{\'test\': {\'request\': {\'url\': \'http://edge.uat.kye-erp.com/router/rest\', \'method\': \'POST\', \'headers\': {\'Content-Type\': \'application/json;charset=UTF-8\', \'User-Agent\': \'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36\', \'X-menu-id\': \'3799854782090627\', \'appkey\': \'10123\', \'format\': \'JSON\', \'method\': \'oms.order.add\', \'sign\': \'0F18B047A9C06DD20A3C4532A6F890A5\', \'timestamp\': \'1560850005177\', \'webTraceId\': \'109527-1560850005177-6900-3799854782090627\'}}, \'name\': \'获取下单编码6666666\', \'validate\': [{\'comparator\': \'equals\', \'check\': \'status_code\', \'expected\': 200}, {\'comparator\': \'equals\', \'check\': \'content.msg\', \'expected\': \'OK\'}], \'extract\': [{\'orderNumber\': \'content.data\'}]}}', '12', '1', 'oms');

-- ----------------------------
-- Table structure for testreports
-- ----------------------------
DROP TABLE IF EXISTS `testreports`;
CREATE TABLE `testreports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `report_name` varchar(100) NOT NULL,
  `start_at` varchar(40) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `testsRun` int(11) NOT NULL,
  `successes` int(11) NOT NULL,
  `reports` longtext NOT NULL,
  `type` varchar(40) NOT NULL COMMENT '报告类型(project-项目:module-模块:suite-套件,test-用例)',
  `executor` varchar(20) DEFAULT NULL COMMENT '执行人',
  `execute_service` varchar(50) DEFAULT NULL COMMENT '执行服务',
  `execute_source` varchar(10) DEFAULT NULL COMMENT '执行来源',
  `execute_id` varchar(32) DEFAULT NULL COMMENT '执行id',
  `path` varchar(100) DEFAULT NULL COMMENT '报表路径',
  PRIMARY KEY (`id`),
  KEY `execute_id_index` (`execute_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=508 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of testreports
-- ----------------------------

-- ----------------------------
-- Table structure for testsuite
-- ----------------------------
DROP TABLE IF EXISTS `testsuite`;
CREATE TABLE `testsuite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `suite_name` varchar(100) NOT NULL,
  `include` longtext NOT NULL,
  `belong_project_id` int(11) NOT NULL,
  `creator` varchar(20) NOT NULL COMMENT '创建人',
  `config_id` int(22) DEFAULT NULL COMMENT '关联配置id',
  `service_name` varchar(50) DEFAULT NULL COMMENT '所属服务名称',
  PRIMARY KEY (`id`),
  KEY `TestSuite_belong_project_id_76d73d7f_fk_ProjectInfo_id` (`belong_project_id`),
  CONSTRAINT `TestSuite_belong_project_id_76d73d7f_fk_ProjectInfo_id` FOREIGN KEY (`belong_project_id`) REFERENCES `projectinfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;


-- ----------------------------
-- Table structure for userinfo
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `username` varchar(20) NOT NULL,
  `name` varchar(20) DEFAULT NULL COMMENT '姓名',
  `password` varchar(20) NOT NULL,
  `email` varchar(254) NOT NULL,
  `status` int(11) NOT NULL,
  `user_type` int(2) NOT NULL DEFAULT '0' COMMENT '用户类型(0:用户,1:管理员)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of userinfo
-- ----------------------------
INSERT INTO `userinfo` VALUES ('1', '2019-06-25 18:05:46.560103', '2019-06-25 18:05:46.560103', 'admin', '管理员', 'admin', 'admin@163.com', '1', '1');

-- ----------------------------
-- Table structure for usertype
-- ----------------------------
DROP TABLE IF EXISTS `usertype`;
CREATE TABLE `usertype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `type_name` varchar(20) NOT NULL,
  `type_desc` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of usertype
-- ----------------------------
