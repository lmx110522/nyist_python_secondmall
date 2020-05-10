$(function () {
    $("#wrapper .close_btn").click(function () {
        $("#wrapper").hide(500)
    })

    $("#wrapper").mouseenter(function () {
        $('body').addClass('pon');
    })

    $("#wrapper").mouseleave(function () {
        $('body').removeClass('pon');
        $("#wrapper").hide(500)
    })


    $(".user_img_btn").click(function () {
        $(".product_list").empty()
        id = $(this).attr("id")
        var append_html = ""
        $.getJSON("/user/post_product", "uid=" + id, function (result) {
            $(".post_num").text(result.length)
            for (var i = 0; i < result.length; i++) {
                let product = result[i]
                append_html = append_html + "<div class=\"product_item flex_col\">\n" +
                    "                <img src=\"" + product["head_img"] + "\">\n" +
                    "                <span class=\"name\"><a href='/product/detail?id=" + product["id"] + "'>" + product["pname"] + "</a></span>\n" +
                    "                <span class=\"price\"><strong>￥" + product["new_price"] + "元</strong></span>\n" +
                    "            </div>"
            }
            $(".product_list").append(append_html)
        })
        $("#wrapper").show()
    })

    $('.span18 ').flyto({
        item: '.medium',
        target: '.cart',
        button: '#addCart'
    });
    jQuery(document).ready(function ($) {
        if ($(".all_comment_in_out li").length > 0) {
            $('.all_comment_in_out').paginathing({
                perPage: 3,
                containerClass: 'panel',
                firstText: '首页',
                lastText: '尾页',
            })
        }

    });


    huojian()
    $(".myLove").click(function () {
        $that = $(this)
        username = $(".user_msg").text()
        if (username == "") {
            $(".open_loginUI").click()
        } else {
            var pid = $(".no_use_pid").text()
            if ($(this).hasClass('do_myLove')) {
                $.getJSON("/product/do_myLove", "flag=" + 1 + "&pid=" + pid, function (result) {
                    $(".show_love_user div").each(function () {
                        if ($(this).hasClass(result.uid)) {
                            $(this).remove()
                        }
                    })
                    $(".love_nums").text(parseInt($(".love_nums").text()) - 1)
                    $that.removeClass('do_myLove')
                    $that.attr('title', '喜欢')
                })
            } else {
                $.getJSON("/product/do_myLove", "flag=" + 0 + "&pid=" + pid, function (result) {
                    $(".no_like").remove()
                    $(".show_love_user").append('<div class="' + result.uid + '"><img src="' + result.img_url + '"></div>')
                    $(".love_nums").text(parseInt($(".love_nums").text()) + 1)
                    $that.addClass('do_myLove')
                    $that.attr('title', '不喜欢')
                })
            }
        }

    })
    $(".comment_send").click(function () {
        username = $(".user_msg").text()
        if (username == "") {
            $(".open_loginUI").click()
            return;
        }
        var content = $(".real_comment").val()
        if (content.trim().length > 5) {
            username = $(".user_msg").text()
            if (username == "") {
                $(".open_loginUI").click()
            } else {
                var pid = $(".no_use_pid").text()
                $.getJSON("/product/add_comment", "pid=" + pid + "&content=" + content, function (result) {
                    $(".all_comment_in_out").prepend("<li class=\"list-group-item out_item\">\n" +
                        "                             <div class=\"show_comment_content show_outer\">\n" +
                        "                                <img src=\"" + result.img_url + "\">\n" +
                        "                                <p>" + content + "</p>\n" +
                        "                                <strong>\n" +
                        "                                    <span>" + result.cdate + " " + result.username + "</span>\n" +
                        "                                    <span class=\"reply to_del\" ><a href=\"#\" my_id='" + result.id + "'>删除</a></span>\n" +
                        "                                    <span><a href=\"#\" class=\"reply to_relply\" my_id='" + result.id + "'>回复TA</a></span>\n" +
                        "                                    <span><a href=\"#\" class=\"reply watch_all_reply\"  my_id='" + result.id + "'>查看全部回复(<b>0</b>)</a></span>\n" +
                        "                                </strong><div class=\"show_all_reply\">\n" +
                        "\n" +
                        "                                     <ul class=\" all_comment_in small_comment\"></ul>\n" +
                        "\n" +
                        "                                     <textarea class=\"form-control real_comment1\" rows=\"3\" placeholder=\"回复的语言有不合法或者不符合南工二手交易平台规定，会被删除并且你的账号可能会被查封~\"></textarea>\n" +
                        "                                     <button type=\"button\" cid = \"" + result.id + "\" class=\"btn btn-default comment_send_small\" data-toggle=\"button\" aria-pressed=\"false\" autocomplete=\"off\">回复</button>\n" +
                        "\n" +
                        "                                 </div>\n" +
                        "                            </div>\n" +
                        "                        </li>")
                    $(".real_comment").val("")
                    $(".panel").remove()
                    jQuery(document).ready(function ($) {
                        $('.all_comment_in_out').paginathing({
                            perPage: 3,
                            containerClass: 'panel',
                            firstText: '首页',
                            lastText: '尾页',
                        })
                        var currentpage = $('.all_comment ul li.page')
                        currentpage.click()
                    });

                })


            }
        } else {
            zlalert.alertInfo("内容不能为空且大于5个字")
        }

    })
    $(".all_comment_in_out").delegate(".to_del a", "click", function (e) {
        e.preventDefault()
        var $that = $(this)
        var index_active = $(".panel li.active").index()
        zlalert.alertConfirm({
            "msg": "你确定要删除这条提问吗?",
            "confirmText": "删除",
            "confirmCallback": function () {
                comment_id = $that.attr("my_id")
                $.getJSON("/product/delete_comment", "comment_id=" + comment_id, function () {
                    $that.parents('.list-group-item').remove()
                    $(".panel").remove()
                    if ($(".all_comment_in_out li").length > 0) {
                        $('.all_comment_in_out').paginathing({
                            perPage: 3,
                            containerClass: 'panel',
                            firstText: '首页',
                            lastText: '尾页',
                        })
                        console.log(index_active)
                        length1 = $('.all_comment ul.pagination li').length;
                        if (length1 - 2 <= index_active) {
                            $('.all_comment ul.pagination li >a:last').click()
                        } else {
                            $('.all_comment ul.pagination li >a:eq(' + index_active + ')').click()
                        }
                    }
                })

            }
        })

    })
    $(".all_comment_in_out").delegate(".to_del1 a", "click", function (e) {
        e.preventDefault()
        var $that = $(this)

        zlalert.alertConfirm({
            "msg": "你确定要删除这回复吗?",
            "confirmText": "删除",
            "confirmCallback": function () {
                nums1 = $that.parents('.show_outer').find('b').text()
                $that.parents('.show_outer').find('b').text(parseInt(nums1) - 1)
                comment_id = $that.attr("my_id")
                $.getJSON("/product/delete_comment", "comment_id=" + comment_id, function () {
                    $that.parents('.list-group-inner').remove()
                    console.log($that.parents('.show_all_reply')[0])

                })
            }
        })

    })
    $(".all_comment_in_out").delegate(".watch_all_reply", "click", function (e) {
        e.preventDefault()
        if ($(this).hasClass('isClose')) {
            $(this).parents('.list-group-item').find(".show_all_reply").css("display", "none")
            $(this).removeClass("isClose")
            var nums = $(this).text().match(/\d+/)
            $(this).html("查看全部回复(<b>" + nums + "</b>)")
            $(this).css("color", "black")

        } else {
            $(this).parents('.list-group-item').find(".show_all_reply").css("display", "block")
            $(this).addClass("isClose")
            var nums = $(this).text().match(/\d+/)
            $(this).html("关闭全部回复(<b>" + nums + "</b>)")
            $(this).css("color", "#E14961")
        }
    })
    $(".all_comment_in_out").delegate(".to_relply", "click", function (e) {
        e.preventDefault()
        if ($(this).parents('.list-group-item').find(".show_all_reply").css("display") == "none") {
            $(this).parent("span").next("span").find("a").click()
        }
        $(this).parents('.list-group-item').find(".real_comment1").focus()
    })
    $(".all_comment_in_out").delegate(".comment_send_small", "click", function () {
        username = $(".user_msg").text()
        if (username == "") {
            $(".open_loginUI").click()
            return;
        }
        var $that = $(this)
        var content = $that.prev(".real_comment1").val()
        var cid = $(this).attr("cid")
        if (content.trim().length > 0) {
            $.getJSON("/product/add_comment", "&content=" + content + "&cid=" + cid, function (result) {
                $that.prev().prev().prepend("<li class=\"list-group-item  list-group-inner\">\n" +
                    "                             <div class=\"show_comment_content\">\n" +
                    "                                <img src=\"" + result.img_url + "\">\n" +
                    "                                <p>" + content + "</p>\n" +
                    "                                <strong>\n" +
                    "                                    <span>" + result.cdate + " " + result.username + "</span>\n" +
                    "                                    <span class=\"reply to_del1\" ><a href=\"#\" my_id='" + result.id + "'>删除</a></span>\n" +
                    "                                    <span class=\"reply to_relply\"><a href=\"#\" my_id='" + result.id + "'>回复TA</a></span>\n" +
                    "                                    \n" +
                    "                                </strong>\n" +
                    "                            </div>\n" +
                    "                        </li>")
                $that.prev(".real_comment1").val("")
            })
            nums1 = $that.parents('.show_outer').find('b').text()
            $that.parents('.show_outer').find('b').text(parseInt(nums1) + 1)
        } else {
            $that.prev().focus()
        }
    })

})

function checkCount() {
    count = $("#count").val()
    if (isNaN(count)) {
        $("#count").val('')
    }
    allCounts = $(".no_use_count").text()
    if (parseInt(count) > parseInt(allCounts)) {
        $("#count").val(allCounts)
    }

}

function huojian() {

    var e = $("#rocket-to-top"),
        t = $(document).scrollTop(),
        n,
        r,
        i = !0;
    $(window).scroll(function () {
        var t = $(document).scrollTop();
        t == 0 ? e.css("background-position") == "0px 0px" ? e.fadeOut("slow") : i && (i = !1, $(".level-2").css("opacity", 1), e.delay(100).animate({
                marginTop: "-1000px"
            },
            "normal",
            function () {
                e.css({
                    "margin-top": "-125px",
                    display: "none"
                }),
                    i = !0
            })) : e.fadeIn("slow")
    }),
        e.hover(function () {
                $(".level-2").stop(!0).animate({
                    opacity: 1
                })
            },
            function () {
                $(".level-2").stop(!0).animate({
                    opacity: 0
                })
            }),
        $(".level-3").click(function () {
            function t() {
                var t = e.css("background-position");
                if (e.css("display") == "none" || i == 0) {
                    clearInterval(n),
                        e.css("background-position", "0px 0px");
                    return
                }
                switch (t) {
                    case "0px 0px":
                        e.css("background-position", "-298px 0px");
                        break;
                    case "-298px 0px":
                        e.css("background-position", "-447px 0px");
                        break;
                    case "-447px 0px":
                        e.css("background-position", "-596px 0px");
                        break;
                    case "-596px 0px":
                        e.css("background-position", "-745px 0px");
                        break;
                    case "-745px 0px":
                        e.css("background-position", "-298px 0px");
                }
            }

            if (!i) return;
            n = setInterval(t, 50),
                $("html,body").animate({scrollTop: 0}, "slow");
        });
}