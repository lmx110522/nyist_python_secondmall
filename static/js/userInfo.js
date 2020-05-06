$(function () {
    if ($(".tr_head").parents('.xs_table').find('tr').length <= 1) {
        $('.xs_table').empty()
        $(".xs_table").addClass('null_page')
    }
    orderLastTime()
    self_tab = $(".self_tab").text()
    if (self_tab != null || self_tab != undefined) {
        $(".nav-tabs li:eq(" + self_tab + ")").addClass('active').siblings().removeClass('active')
        $(".tab-content div.tab-pane:eq(" + self_tab + ")").addClass('active in').siblings().removeClass('active in')
    }
    if ($(".order_one").length == 0) {
        $(".order_page").addClass('null_page')
    }
    if ($(".order_lists").length <= 1) {
        $(".cartMain").empty()
        $(".cartMain").css("background", "").addClass('null_page')

    }
    // 裁剪后更新头像
    $(".use_img").click(function () {
        img_len = $(".cropped img").length;
        if (img_len > 0) {
            $src = $(".cropped img:eq(1)").attr("src");
            no_use = $src.split(",")[0]
            $src1 = $src.replace(no_use, '')
            $.post("/user/changeHeadImage", {"datas": $src1}, function (result) {
                if (result.error == 1) {
                    zlalert.alertError("设置头像出错！")
                } else {
                    window.location.reload()
                }

            })
        }
    })

    $(".edit_userInfo").click(function () {

        // 这个时候应该关闭修改信息按钮
        if ($(this).hasClass('edit_msg')) {
            var i = 0
            $('.can_change').each(function () {
                if ($(this).val().trim().length == 0) {
                    i++;
                    $(this).focus()
                    return false
                }
            })

            if ($(".new_password").length != 0) {
                var password = $(".new_password1").val()
                var repassword = $(".repassword").val()

                if (password != repassword) {
                    i++
                    $(".repassword").val('')
                    $("#new_password1").val('')
                    $(".new_password1").focus()
                    $(".password_error1").text("密码前后不一致")
                }
            }
            if (i == 0) {
                var password_old = $(".old_password").val()
                if (password_old == "" || password_old == undefined) {
                    var datas = $("#userInfo_form").serialize()
                    var new_password = $(".new_password1 ").val()

                    datas = $.param({'password': $(".new_password1 ").val()}) + '&' + datas
                    $.post("/user/editUserInfo", datas, function () {
                        zlalert.alertSuccess("个人信息修改完成", function () {
                        })

                    })
                    $(".add_password").parents('tr').remove()
                    $(this).removeClass('btn-info')
                    $(this).addClass('btn-danger')
                    $(this).removeClass('edit_msg')
                    $(this).text("修改信息")
                    $(".can_change").attr('disabled', "disabled")
                    $(".reset_msg").css('display', 'none')
                }

            } else {
                $(".old_password").focus()
            }
        } else {
            $(this).removeClass('btn-danger')
            $(this).addClass('btn-info')
            $(this).addClass('edit_msg')
            $(this).text("确认修改")
            $(".password").after('<tr><td><span class="msg_left">旧密码</span></td><td><input type="text" placeholder="请先输入旧密码，正确才可以修改密码，不修改可以不填" class="form-control add_password old_password"><p class="password_error" style="margin-top:10px;\n' +
                '    color:#E14961;"></p></td></tr>')
            $(".can_change").removeAttr('disabled')
            $(".reset_msg").css('display', 'inline-block')
        }
    })

    $(".my_table").delegate('.old_password', 'blur', function () {
        var password = $(this).val()
        if (password.trim().length != 0) {
            $.post("/user/checkPassword", {'password': password}, function (result) {
                if (result.flag == true) {
                    $(".old_password").parents('tr').remove()
                    $(".password").after('<tr class="new_password"><td><span class="msg_left">新密码</span></td><td><input type="password" placeholder="输入新密码" name="password" id="passoword" class="form-control add_password new_password1 can_change"><p  class="password_error1" style="margin-top:10px;\n' +
                        '    color:#E14961;"></p></td></tr>' +
                        '<tr><td><span class="msg_left">确认密码</span></td><td><input type="password" placeholder="确认密码"  class="form-control can_change repassword add_password"></td>')
                    $("#passoword").focus()
                } else {
                    $(".password_error").text("旧密码不正确")
                    $(".old_password").focus()
                }
            })
        }

    })
    $(".my_table").delegate('.old_password', 'input', function () {
        $(".password_error").text("")
    })
    $(".my_table").delegate('.new_password1 ', 'input', function () {
        $(".password_error1").text("")
    })
    $(".delBtn").click(function () {
        var $that = $(this)
        if ($(".order_lists").length > 1) {
            zlalert.alertConfirm({
                "title": "删除商品",
                "confirmText": "删除",
                'msg': "确认删除商品吗？",
                "confirmCallback": function () {
                    var flag = 0
                    var sp_id = ""
                    if ($that.parent('.delete_all').length != 0) {
                        flag = 1
                    } else {
                        sp_id = $that.attr('sp_id')
                    }

                    $.getJSON("/product/clear_cart", "flag=" + flag + "&sp_id=" + sp_id, function (result) {
                        window.location.href = "/user/userInfo?tab=1"
                    })
                }
            })
        }
    })
    $(".calBtn").click(function () {
        if ($(this).children('a').hasClass('btn_sty') && $(".son_check + label.mark").length > 0) {
            var sp_ids = ""
            $(".son_check + label.mark").each(function () {
                sp_ids += ($(this).attr("for") + "_")
            })
            $.post('/user/provideOrders', {"sp_ids": sp_ids}, function (result) {
                if (result.error == 0) {
                    zlalert.alertSuccess("生成订单成功，接下来为你跳转到订单页面", function () {
                        window.location.href = "/user/showOrder?oid=" + result.oid
                    })
                }
            })
        }
    })
    $(".order_cancel").click(function () {
        $that = $(this)
        zlalert.alertConfirm({
            "title": "删除订单",
            "confirmText": "删除",
            "msg": "确定要删除这项订单吗？",
            "confirmCallback": function () {
                order_id = $that.attr("order_id")
                if (order_id.trim().length != "") {
                    $.getJSON("/product/cancelOrder", "order_id=" + order_id, function (result) {
                        if (result.error != "1") {
                            $that.parents('.order_one').remove()
                            if ($(".order_one").length == 0) {
                                $(".order_page").addClass('null_page')
                            }
                        }
                    })
                }
            }
        })

    })

    $(".xj_product").click(function (e) {
        e.preventDefault()
        var $that = $(this)
        pid = $(this).attr('id')
        zlalert.alertConfirm({
            "title": "下架商品",
            "confirmText": "下架",
            'msg': "确认下架商品吗？",
            "confirmCallback": function () {
                $.getJSON('/product/deleteProduct', 'pid=' + pid, function (result) {
                    if (result.error == 0) {
                        $that.parents('tr').remove()
                        if ($(".tr_head").parents('.xs_table').find('tr').length <= 1) {
                            $('.xs_table').empty()
                            $(".xs_table").addClass('null_page')
                        }
                    } else {
                        zlalert.alertError(result.msg);
                    }
                })
            }
        })

    })

    $(".repeat-check").click(function (e) {
        e.preventDefault()
        var $that = $(this)
        pid = $(this).attr('id')
        zlalert.alertConfirm({
            "title": "确认重新申请上架商品",
            "confirmText": "上架",
            'msg': "确认重新申请上架商品吗？",
            "confirmCallback": function () {
                $.getJSON('/product/repeat_check', 'pid=' + pid, function (result) {
                    if (result.error == 0) {
                        $that.parents('tr').find(".no_pass").text("审核中...")
                    } else {
                        zlalert.alertError("重新申请失败")
                    }
                })
            }
        })

    })
})

function orderLastTime() {
    $('.order_last_time').each(function () {
        var $that = $(this)
        var order_id = $(this).parents('th').find('.order_num').text()
        order_id = order_id
        var m = parseInt($that.text().split(':')[0])
        var s = parseInt($that.text().split(':')[1])
        window.order_id = setInterval(function () {
            if (s < 10) {
                //如果秒数少于10在前面加上0
                $that.html(m + ':0' + s);
            } else {
                $that.html(m + ':' + s);
            }
            s--;
            if (s < 0) {
                //如果秒数少于0就变成59秒
                s = 59;
                m--;
            }
            if (s == 0 && m == 0) {
                clearInterval(window.order_id)
                $.getJSON("/product/cancelOrder", "order_id=" + order_id, function (result) {
                    if (result.error != "1") {
                        window.location.href = "/user/userInfo?tab=3";
                    }
                })
            }

        }, 1000)
    })

}
