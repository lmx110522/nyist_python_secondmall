import base64
import random
import uuid

from flask import Blueprint, views, render_template, request, jsonify, redirect, url_for, session
from flask_mail import Message
from werkzeug.security import generate_password_hash, check_password_hash

from app import qiniu_store
from config import QINIU_URL
from mail import send_mail
from pojo import *
from redis_cache import redis_cache

user_dp = Blueprint("user", __name__, url_prefix='/user', template_folder="../templates/user")


class loginUrl(views.MethodView):

    def get(self):
        return render_template('loginUI.html')

    def post(self):
        is_mt = request.form.get("is_mt")
        code = request.form.get("code")
        image = session.get("image")
        if str(code).lower() == str(image).lower():
            email = request.form.get("email")
            password = request.form.get("password")
            user = User.query.filter(User.email == email, User.is_ok == 1).first()

            if user is not None:
                if check_password_hash(user.password, password):
                    session["uid"] = user.id
                    if str(is_mt) == '0':
                        return jsonify({"status": "200"})
                    return redirect(url_for('index'))
            if str(is_mt) == '0':
                return jsonify({"status": "500", "msg": "用户名或密码不正确", "error_pos": "#email_msg"})
            return render_template("loginUI.html", email_msg='用户名或密码不正确')

        else:
            if str(is_mt) == '0':
                return jsonify({"status": "500", "msg": "验证码错误", "error_pos": "#code_msg"})
            return render_template("loginUI.html", code_msg='验证码错误')


user_dp.add_url_rule('/login', endpoint='login', view_func=loginUrl.as_view('login'))


class registerUrl(views.MethodView):

    def get(self):
        return render_template('registerUI.html')

    def post(self):
        code = request.form.get("code")
        random_sample_old = redis_cache.get('random_sample').decode()
        if random_sample_old.lower() == code.lower():
            username = request.form.get("username")
            password = request.form.get("password")
            email = request.form.get("email")
            name = request.form.get("name")
            phone = request.form.get("phone")
            addr = request.form.get("addr")
            id = str(uuid.uuid1()).replace('-', '')
            user = User(id=id, username=username, password=generate_password_hash(password), email=email, name=name,
                        phone=phone, addr=addr)
            db.session.add(user)
            db.session.commit()
            return redirect(url_for('user.login'))
        else:
            return render_template("registerUI.html", msg='动态码不正确')


user_dp.add_url_rule('/register', endpoint='register', view_func=registerUrl.as_view('register'))


@user_dp.route("/logout")
def logout():
    uid = session.get('uid')
    if uid is None:
        return redirect(url_for('index'))
    session.pop('uid')
    return redirect(url_for('index'))


@user_dp.route("/sendMail")
def sendMail():
    email = request.args.get("email")
    isEmail = User.query.filter(User.email == email, User.is_ok == 1).first()

    if not isEmail:
        random_sample = random.sample('1234567890abcdefghijklmnopqrstuvwxyz', 4)
        random_sample = ''.join(random_sample)
        redis_cache.set("random_sample", str(random_sample))
        msg = Message(subject="南阳理工学院二手交易平台动态码", recipients=[email])
        msg.html = "<b><img src='http://qiniuyun.donghao.club/nyist.png' " \
                   "style='width:260px'></b><br><b>南阳理工学院二手交易平台注册动态码:" \
                   "<font color='red'>" + random_sample + "</font><b>"
        send_mail.send(msg)
        return jsonify({"msg": "", 'status': "200"})
    else:
        return jsonify({"msg": "检测到该邮箱已经被注册，一个邮箱只有一个南工二手交易平台账号", 'status': "500"})


@user_dp.route("/userInfo")
def userInfo():
    uid = session.get('uid')
    if uid is None:
        return redirect(url_for('user.login'))
    tab = request.args.get('tab')
    user = User.query.get(uid)
    for shopCart in user.shopcarts:
        if shopCart.pid is None:
            db.session.delete(shopCart)
            db.session.commit()
    for order in user.orders:
        for orderItem in order.orderItems:
            if orderItem.pid is None:
                db.session.delete(orderItem)
                db.session.commit()
        if len(order.orderItems) == 0:
            db.session.delete(order)
            db.session.commit()
    for order in user.orders:
        result_time = datetime.now() - order.ordertime
        resultTime = str(result_time).split(':')
        if int(resultTime[0]) > 0 or int(resultTime[1]) >= 30:
            for orderItem in order.orderItems:
                orderItem.product.counts = orderItem.count
                db.session.delete(orderItem)
                db.session.commit()
            db.session.delete(order)
            db.session.commit()
        else:
            second = resultTime[2]
            index = str(second).find('.')
            if index != -1:
                second = second[0:index]
            last_time = "" + str(29 - int(resultTime[1])) + ":" + str(60 - int(second))
            order.order_last_time = last_time
            db.session.commit()
    return render_template("userInfo.html", tab=tab, user=user)


@user_dp.route("/changeHeadImage", methods=['POST'])
def changeHeadImage():
    datas = request.form.get("datas")
    filename = str(uuid.uuid1()).replace("-", "") + ".jpg"
    try:
        img_data = base64.b64decode(datas)
        qiniu_store.save(img_data, filename=filename)
        img_url = QINIU_URL + filename
        uid = session.get('uid')
        user = User.query.get(uid)
        user.img_url = img_url
        db.session.commit()
        return jsonify({"error": '0'})
    except:
        return jsonify({"error": '1'})


@user_dp.route("/checkPassword", methods=['POST'])
def checkPassword():
    password = request.form.get('password')
    uid = session.get('uid')
    user = User.query.get(uid)
    flag = check_password_hash(user.password, password)

    return jsonify({'flag': flag})


@user_dp.route("/editUserInfo", methods=['POST'])
def editUserInfo():
    id = request.form.get("id")
    username = request.form.get("username")
    password = request.form.get("password")
    name = request.form.get("username")
    phone = request.form.get("phone")
    addr = request.form.get("addr")
    user = User.query.get(id)
    if password is not None and password != "":
        user.password = generate_password_hash(password)
    user.name = name
    user.phone = phone
    user.addr = addr
    db.session.commit()
    return jsonify()


@user_dp.route("/resetPassword")
def resetPassword():
    email = request.args.get('email')
    name = request.args.get('name')
    user = User.query.filter(User.email == email).first()
    if user is None:
        return jsonify({'status': 500, 'msg': '此邮箱无注册记录'})
    else:
        if user.username != name:
            return jsonify({"msg": "主人姓名不对呦~~~", 'status': "500"})
        else:
            random_sample = random.sample('1234567890abcdefghijklmnopqrstuvwxyz', 6)
            random_sample = ''.join(random_sample)
            user.password = generate_password_hash(random_sample)
            db.session.commit()
            msg = Message(subject="南阳理工学院二手交易平台找回密码", recipients=[email])
            msg.html = "<b><img src='http://127.0.0.1:5000/static/images/nyist.png" \
                       "style='width:260px'></b><br><b>南阳理工学院二手平台重置你的密码为:" \
                       "<font color='red'>" + random_sample + "</font>,建议登录之后修改密码，谢谢你的使用！<b>"
            send_mail.send(msg)
            return jsonify({"msg": "", 'status': "200"})


@user_dp.route("/provideOrders", methods=['POST'])
def provideOrders():
    uid = session.get('uid')
    if uid is None:
        return redirect(url_for('user.login'))
    user = User.query.get(uid)
    sp_ids = request.form.get("sp_ids")
    if sp_ids is not None:
        oid = str(uuid.uuid1()).replace('-', '')
        order = Order(id=oid, user=user, name="", phone="", addr="")
        db.session.commit()
        sp_ids = str(sp_ids).split('_')

        all_money = float(0)
        for sp_id in sp_ids:
            if sp_id is not None and len(sp_id) != 0:
                sp_id = str(sp_id)
                shopCart = ShopCart.query.get(sp_id)
                if shopCart is None:
                    continue
                if shopCart.pid is None:
                    return redirect(url_for('user.userInfo', tab=2))
                if shopCart is not None:
                    all_money += shopCart.subTotal
                    orderItem = OrderItem(id=shopCart.id, count=shopCart.count, sub_total=shopCart.subTotal,
                                          product=shopCart.product)
                    orderItem.order = order
                    db.session.delete(shopCart)
                    db.session.commit()
        user.shop_time = None
        order.total_money = all_money
        db.session.commit()
        return jsonify({"error": "0", "oid": order.id})
    return jsonify({"error": "1"})


@user_dp.route("/showOrder")
def showOrder():
    oid = request.args.get("oid")
    if oid is not None:
        order = Order.query.get(str(oid))
        if order is None:
            return redirect(url_for('index'))
        return render_template('order.html', order=order)
