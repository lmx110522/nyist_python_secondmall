# coding = utf-8
import os

DEBUG = True

SECRET_KEY = os.urandom(24)
MAX_CONTENT_LENGTH = 16 * 1024 * 1024

# mysql配置
DIALECT = "mysql"
DRIVER = "pymysql"
USERNAME = "****"
PASSWORD = "****"
HOST = "120.79.179.175"
PORT = "3306"
DATABASE = "new_shop"

SQLALCHEMY_DATABASE_URI = "{}+{}://{}:{}@{}:{}/{}?charset=utf8".format(DIALECT, DRIVER, USERNAME, PASSWORD, HOST, PORT,
                                                                       DATABASE)
SQLALCHEMY_TRACK_MODIFICATIONS = False

# qq邮箱配置

MAIL_SERVER = 'smtp.qq.com'
MAIL_PROT = 25
MAIL_USE_TLS = True
MAIL_USE_SSL = False
MAIL_USERNAME = "1247721306@qq.com"
MAIL_DEFAULT_SENDER = "1247721306@qq.com"
MAIL_PASSWORD = "*****************"
MAIL_DEBUG = True

# redis配置
REDIS_HOST = "120.79.179.175"
REDIS_PORT = 6379

# 七牛云配置
ALLOWED_EXT=set(['png', 'jpg','jpeg','bmp','gif'])
QINIU_ACCESS_KEY = 你的七牛云QINIU_ACCESS_KEY
QINIU_SECRET_KEY = 你的七牛云QINIU_ACCESS_KEY
QINIU_BUCKET_NAME = 'lmx110522'
QINIU_ACCESS_KEY = 你的QINIU_ACCESS_KEY
