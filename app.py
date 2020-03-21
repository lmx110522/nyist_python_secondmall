import math

from flask import Flask, render_template, session, redirect, url_for, request
from extend import db, qiniu_store
import json
from blueprint.user import user_dp
from blueprint.validate_code import validate_code
from mail import send_mail
import config
from datetime import datetime,timedelta
from pojo import *
from redis_cache import redis_cache
from blueprint.product import product_dp

app = Flask(__name__)
app.jinja_env.add_extension('jinja2.ext.loopcontrols')
app.register_blueprint(user_dp)
app.register_blueprint(validate_code)
app.register_blueprint(product_dp)

app.config.from_object(config)
db.init_app(app)
qiniu_store.init_app(app)
send_mail.init_app(app)

with app.app_context():
    db.create_all()


@app.route('/')
def index():
    productList = Product.query.filter(Product.is_sell == 1,Product.is_pass == 2).order_by(Product.click_count.desc()).slice(0, 10)
    productList1 = Product.query.filter(Product.is_sell == 1,Product.is_pass == 2).order_by(Product.pdate.desc()).slice(0, 10)
    productList2 = redis_cache.get('productList2')
    category = Category.query.all()
    # 推广产品
    if productList2 is None:
        products = Product.query.filter(Product.is_hot == 2, Product.is_sell == 1, Product.is_pass == 2).order_by(
            Product.pdate.desc()).slice(0, 3)
        productList2 = []
        for product in products:
            product = Product.product_json(product)
            productList2.append(product)
        json_dumps = json.dumps(productList2, ensure_ascii=False)
        print(json_dumps)
        # redis_cache.set("productList2", json_dumps)
    else:
        productList2 = productList2.decode('utf8')
        productList2 = json.loads(productList2)
        print(productList2)
    return render_template('user/index.html', hot_products=productList, new_products=productList1,
                           extend_products=productList2, categorys=category)


@app.route("/admin")
def adminProducts():
    products = Product.query.filter(Product.is_pass == 0).order_by(
        Product.pdate.desc())
    productList = []
    for product in products:
        product = Product.product_json2(product)
        productList.append(product)
    return render_template('admin/list.html', productList=productList )


@app.context_processor
def my_context_processor():
    category_all = Category.query.all()
    categoryList = redis_cache.get('categoryList')
    if categoryList is None:
        categorys = Category.query.all()
        categoryList = []
        for category in categorys:
            category = Category.category_json(category)
            categoryList.append(category)
        json_dumps = json.dumps(categoryList, ensure_ascii=False)
        print(json_dumps)
        redis_cache.set("categoryList", json_dumps)
    else:
        categoryList = categoryList.decode('utf8')
        categoryList = json.loads(categoryList)
        print(categoryList)
    uid = session.get("uid")
    last_time = ""
    if uid is not None:
        user = User.query.get(uid)
        if user.shop_time is not None:
            shop_time = user.shop_time
            offset = timedelta(minutes=20)
            result_time = (shop_time + offset)-datetime.now()
            if result_time.days < 0:
                for shopCart in user.shopcarts:
                    product = Product.query.get(shopCart.pid)
                    product.counts = product.counts + shopCart.count
                    db.session.delete(shopCart)
                    db.session.commit()
                user.shop_time is None
                db.session.commit()
                last_time = ""
            else:
                m, s = divmod(result_time.seconds, 60)
                last_time = "" + str(m) + ":" + str(s)
        length = 0
        for shopCart in user.shopcarts:
            length += shopCart.count

        return {"uid": uid, "username": user.username, 'user_img': user.img_url, "categorys": categoryList,
                "category_all": category_all, "last_time": last_time, "length": length}
    else:
        return {"categorys": categoryList, "category_all": category_all, "uid": "", "length": "0"}



# @app.errorhandler(404)
# def not_foundPage():
#     return redirect(url_for('index'))


if __name__ == '__main__':
    app.run()
