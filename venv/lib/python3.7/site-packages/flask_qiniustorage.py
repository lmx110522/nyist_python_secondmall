# -*- coding: utf-8 -*-

try:
    from urlparse import urljoin
except ImportError:
    from urllib.parse import urljoin
import qiniu as QiniuClass


class Qiniu(object):
    def __init__(self, app=None):
        self.app = app
        if app is not None:
            self.init_app(app)

    def init_app(self, app):
        self._access_key = app.config.get('QINIU_ACCESS_KEY', '')
        self._secret_key = app.config.get('QINIU_SECRET_KEY', '')
        self._bucket_name = app.config.get('QINIU_BUCKET_NAME', '')
        domain = app.config.get('QINIU_BUCKET_DOMAIN')
        if not domain:
            self._base_url = 'http://' + self._bucket_name + '.qiniudn.com'
        else:
            self._base_url = 'http://' + domain

    def save(self, data, filename=None):
        auth = QiniuClass.Auth(self._access_key, self._secret_key)
        token = auth.upload_token(self._bucket_name)
        return QiniuClass.put_data(token, filename, data)

    def delete(self, filename):
        auth = QiniuClass.Auth(self._access_key, self._secret_key)
        bucket = QiniuClass.BucketManager(auth)
        return bucket.delete(self._bucket_name, filename)

    def url(self, filename):
        return urljoin(self._base_url, filename)

    def private_url(self, filename):
        auth = QiniuClass.Auth(self._access_key, self._secret_key)
        return auth.private_download_url(urljoin(self._base_url, filename), expires=3600)
