from flask_sqlalchemy import SQLAlchemy
from flask_qiniustorage import Qiniu

db = SQLAlchemy()
qiniu_store = Qiniu()
