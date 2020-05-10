import base64
import uuid

from flask import Blueprint, request, render_template, redirect, url_for, session, jsonify

from config import QINIU_URL
from extend import *
from pojo import *
from redis_cache import redis_cache

product_dp = Blueprint("product", __name__, url_prefix="/product", template_folder="../templates/product")


@product_dp.route("/detail")
def detail():
    is_love = 0
    pid = request.args.get("id")
    my_uid = session.get("uid")
    product = Product.query.get(pid)
    if product is None:
        return redirect(url_for('index'))
    product.click_count = int(product.click_count) + 1
    db.session.commit()
    users = []
    images = product.images.split('@')
    if product.love_user is not None:
        uids = product.love_user.split('_')
        for uid in uids:
            if uid != "":
                user = User.query.get(uid)
                if uid == my_uid:
                    is_love = 1
                users.append(user)
    categorys = Category.query.all()
    postUser = User.query.get(product.uid)
    comments = Comment.query.filter(Comment.pid == pid).order_by(Comment.cdate.desc()).all()
    return render_template("detail.html", product=product, categorys=categorys, users=users, is_love=is_love,
                           comments=comments, images=images, postUser=postUser)


@product_dp.route("/do_myLove")
def do_myLove():
    flag = request.args.get("flag")
    pid = request.args.get("pid")
    uid = session.get('uid')
    if uid is None:
        return redirect(url_for('index'))
    user = User.query.get(uid)
    product = Product.query.get(pid)
    if str(flag) == '0':
        if product.love_user is None:
            product.love_user = uid + "_"
        else:
            product.love_user = product.love_user + uid + "_"
        db.session.commit()
    else:
        users = []
        uids = product.love_user.split('_')
        for uid1 in uids:
            if uid == uid1:
                pos = product.love_user.index(str(uid))
                id_len = len(str(uid))
                product.love_user = product.love_user.replace(product.love_user[pos:(pos + 1 + id_len)], "")
                db.session.commit()
    return jsonify({"img_url": user.img_url, "uid": user.id})


# 添加对该商品的评价

@product_dp.route("/add_comment")
def add_comment():
    pid = request.args.get('pid')
    cid = request.args.get('cid')
    content = request.args.get("content")
    uid = session.get('uid')
    if uid is None:
        return redirect(url_for('index'))
    user = User.query.get(uid)
    id = str(uuid.uuid1()).replace('-', '')
    comment = Comment(id=id, pid=pid, content=content, uid=uid, comment_id=cid)
    db.session.add(comment)
    db.session.commit()
    comment = Comment.query.get(id)
    return jsonify({"img_url": user.img_url, "cdate": str(comment.cdate), "id": id, "username": user.username})


# 删除对此商品的评价
@product_dp.route("/delete_comment")
def delete_comment():
    uid = session.get('uid')
    if uid is None:
        return redirect(url_for('index'))
    comment_id = request.args.get("comment_id")
    if comment_id is not None:
        comment = Comment.query.get(comment_id)
        db.session.delete(comment)
        db.session.commit()
    return jsonify()


@product_dp.route("/add_product", methods=['POST'])
def add_product():
    uid = session.get("uid")
    if uid is None:
        return redirect(url_for('index'))
    user = User.query.get(uid)
    datas = request.form.get("datas")
    datas = str(datas).split('@')

    img_urls = ""
    i = 0
    for data in datas:
        if data != "":
            img_data = base64.b64decode(data)
            filename = str(uuid.uuid1()).replace("-", "") + ".jpg"
            qiniu_store.save(img_data, filename=filename)
            img_url = QINIU_URL + filename
            if i == 0:
                head_img = img_url
            i = i + 1
            img_urls += (img_url + "@")

    pname = request.form.get("pname")
    pDesc = request.form.get("pDesc")
    counts = request.form.get("counts")
    old_price = request.form.get("old_price")
    new_price = request.form.get("new_price")
    csid = request.form.get("csid")
    if csid is not None or csid != "":
        categorySecond = CategorySecond.query.get(csid)
        if categorySecond is None:
            return jsonify({'error': '1'})
        else:
            product = Product(id=str(uuid.uuid1()).replace("-", ""), pname=pname, pDesc=pDesc, counts=counts,
                              old_price=old_price, new_price=new_price, uid=uid, images=img_urls, head_img=head_img,
                              csid=str(csid))
            db.session.add(product)
            db.session.commit()
            return jsonify({'error': '0'})
    return jsonify({'error': '1'})


@product_dp.route("/addCart", methods=['post'])
def addCart():
    pid = request.form.get("pid")
    count = request.form.get("count")
    product = Product.query.get(pid)
    if product is None:
        return redirect(url_for('index'))
    if product.counts == 0:
        return jsonify({'status': "500", 'msg': "来晚一步，商品已经售完，加入购物车失败"})
    uid = session.get('uid')
    if uid is None:
        return redirect(url_for('user.login'))
    if product is not None:
        p_flag = 0
        user = User.query.get(uid)
        for shopCart in user.shopcarts:
            if shopCart.pid == pid:
                p_flag = p_flag + 1
                shopCart.count = (shopCart.count + int(count))
                shopCart.subTotal = float(shopCart.count) * product.new_price
                product.counts = product.counts - int(count)
                user.shop_time = datetime.now()
                db.session.commit()

        if len(user.shopcarts) == 0 or 0 == p_flag:
            id = str(uuid.uuid1()).replace('-', '')
            subTotal = product.new_price * float(count)
            shop_cart = ShopCart(id=id, count=count, uid=uid, pid=pid, subTotal=subTotal)
            db.session.add(shop_cart)
            product.counts = product.counts - int(count)
            user.shop_time = datetime.now()
            db.session.commit()
        return jsonify({'status': '200'})
    else:
        return jsonify({'status': '500', "msg": "出现错误"})


@product_dp.route("/clear_cart")
def clear_cart():
    uid = session.get('uid')
    user = User.query.get(uid)
    if uid is not None:
        flag = request.args.get('flag')
        if flag is not None:
            if flag == "1":
                clearCart(user)
            else:
                sp_id = request.args.get('sp_id')
                if sp_id is not None:
                    shopCart = ShopCart.query.get(sp_id)
                    if shopCart is not None:
                        if shopCart.pid is not None:
                            product = Product.query.get(shopCart.pid)
                            product.counts = product.counts + shopCart.count
                        db.session.delete(shopCart)
                        db.session.commit()
                        if len(user.shopcarts) == 0:
                            user.shop_time = None
                            db.session.commit()
        else:
            clearCart(user)
    return jsonify()


def clearCart(user):
    for shopCart in user.shopcarts:
        if shopCart.pid is not None:
            product = Product.query.get(shopCart.pid)
            product.counts = product.counts + shopCart.count
        db.session.delete(shopCart)
        db.session.commit()
    user.shop_time = None

    db.session.commit()


@product_dp.route("/find_one")
def find_one():
    id = request.args.get('id')
    products = Product.query.filter(Product.id == id).first()
    product = Product.product_json1(products)
    CS = CategorySecond.query.filter(CategorySecond.id == products.csid).first()
    C = Category.query.filter(Category.id == CS.cid).first()
    category = Category.category_json(C);
    categorySecond = CategorySecond.categorySecond_json(CS)
    return jsonify({"error": '0', "product": product, "category": category, "categorySecond": categorySecond})

    return jsonify({"error": "1"})


# 重新提交
@product_dp.route("/repeat_check")
def repeat_check():
    redis_cache.delete("productList")
    redis_cache.delete("productList1")
    redis_cache.delete("productList2")
    pid = request.args.get('pid')
    products = Product.query.filter(Product.id == pid).first()
    products.is_pass = 0
    db.session.commit()
    return jsonify({"error": '0'})


# 通过
@product_dp.route("/passItem")
def passItem():
    id = request.args.get('id')
    products = Product.query.filter(Product.id == id).first()
    products.is_pass = 2
    db.session.commit()
    redis_cache.delete("productList1")
    redis_cache.delete("productList3")
    return jsonify({"error": '0'})

    return jsonify({"error": "1"})


# 驳回
@product_dp.route("/no_pass")
def no_pass():
    id = request.args.get('id')
    products = Product.query.filter(Product.id == id).first()
    products.is_pass = 1
    db.session.commit()
    return jsonify({"error": '0'})
    return jsonify({"error": "1"})


@product_dp.route("/change_nums")
def change_nums():
    uid = session.get('uid')
    if uid is None:
        return redirect(url_for('user.login'))
    else:
        user = User.query.get(uid)
        nums = request.args.get('nums')

        sp_id = request.args.get('sp_id')
        shopCart = ShopCart.query.get(sp_id)
        if shopCart.pid is None:
            return jsonify({'error': "1"})
        all_count = shopCart.product.counts + shopCart.count
        if int(nums) > all_count:
            shopCart.count = all_count
            shopCart.subTotal = float(shopCart.count) * shopCart.product.new_price
            shopCart.product.counts = 0

            db.session.commit()
            length = 0
            for shopCart1 in user.shopcarts:
                length += shopCart1.count
            return jsonify({"error": "2", "maxlen": shopCart.count, "max_length": length})
        if shopCart is not None:
            if str.isdigit(nums):
                shopCart.count = int(nums)
                shopCart.subTotal = float(shopCart.count) * shopCart.product.new_price
                shopCart.product.counts = all_count - int(nums)

                db.session.commit()
                length = 0
                for shopCart1 in user.shopcarts:
                    length += shopCart1.count
                return jsonify({"error": '0', "max_length": length})

    return jsonify({"error": "1"})


@product_dp.route("/deleteOrderItem")
def deleteOrderItem():
    uid = session.get('uid')
    if uid is None:
        return redirect(url_for('index'))
    orderItem_id = request.args.get("id")
    flag = request.args.get("flag")
    orderItem = OrderItem.query.get(str(orderItem_id))
    if orderItem is not None:
        order = orderItem.order
        if orderItem.pid is not None:
            product = Product.query.get(orderItem.product.id)
            product.counts += orderItem.count
        db.session.delete(orderItem)
        db.session.commit()
        if len(order.orderItems) == 0:
            db.session.delete(order)
            db.session.commit()
            if flag is None:
                return redirect(url_for('index'))
            else:
                return redirect(url_for('user.userInfo', tab=3))
        db.session.commit()
        if flag is None:
            return redirect(url_for('user.showOrder', oid=order.id))
        else:
            return redirect(url_for('user.userInfo', tab=3))
    return redirect(url_for('index'))


@product_dp.route("/cancelOrder")
def cancelOrder():
    uid = session.get('uid')
    if uid is None:
        return jsonify({"error": "1"})
    user = User.query.get(uid)
    order_id = request.args.get("order_id")
    order = Order.query.get(str(order_id))
    if order is not None:
        if order.state != 2:
            for orderItem in order.orderItems:
                if orderItem.pid is not None:
                    product = Product.query.get(orderItem.product.id)
                    product.counts += orderItem.count
                db.session.delete(orderItem)
                db.session.commit()
        db.session.delete(order)
        db.session.commit()
        return jsonify({"error": "0"})
    return jsonify({"error": "1"})


@product_dp.route("/getClassify")
def getClassify():
    pageNum = request.args.get('pageNum')
    cid = request.args.get('cid')
    csid = request.args.get('csid')
    category = None
    categorySecond = None
    if csid is not None:
        categorySecond = CategorySecond.query.get(csid)
    if categorySecond is None or csid is None:
        categorySecond = CategorySecond()
    if cid is not None:
        category = Category.query.get(cid)
    if category is None or cid is None:
        category = Category()
    csids = []
    if pageNum is None or str.isdigit(pageNum) == False:
        pageNum = 1
    else:
        pageNum = int(pageNum) + 1
    if category is not None:
        for categorySecond_One in category.categoryseconds:
            csids.append(str(categorySecond_One.id))
        page_all = Product.query.filter(Product.csid.in_(csids), Product.is_pass == 2).order_by(
            Product.pdate.desc()).paginate(int(pageNum), 12, False)

    if csid is not None:
        page_all = Product.query.filter(Product.csid == str(csid), Product.is_pass == 2).order_by(
            Product.pdate.desc()).paginate(int(pageNum), 12, False)
    if categorySecond is None and category is None:
        page_all = Product.query.order_by(Product.pdate.desc(), Product.is_pass == 2).paginate(int(pageNum), 12, False)
    categorys = Category.query.all()
    return render_template('classify.html', categorys=categorys, products=page_all.items, currentPage=page_all.page,
                           pages=page_all.pages, categorySecond=categorySecond, category_my=category)


@product_dp.route("/getCategorySecond")
def getCategorySecond():
    cid = request.args.get("cid")
    cs_dicts = []
    categorySeconds = CategorySecond.query.filter(CategorySecond.cid == str(cid)).all()
    for categorySecond in categorySeconds:
        cs_dict = {"csid": categorySecond.id, "csname": categorySecond.csname}
        cs_dicts.append(cs_dict)
    return jsonify(cs_dicts)


@product_dp.route("/deleteProduct")
def deleteProduct():
    pid = request.args.get('pid')
    if pid == "" or pid is None:
        return jsonify({'error': '1'})
    product = Product.query.get(pid)
    if product is not None:
        pid = product.id
        shopCart = ShopCart.query.filter(ShopCart.pid == pid).first()
        if shopCart is not None:
            return jsonify({"error": "1", "msg": "已经被用户加入购物车，不能下架"})
        orderItem = OrderItem.query.filter(OrderItem.pid == pid).first()
        if orderItem is not None:
            return jsonify({"error": "1", "msg": "已经被用户加入订单列表，不能下架"})
        product.is_pass = 3
        db.session.commit()
        return jsonify({'error': "0"})
