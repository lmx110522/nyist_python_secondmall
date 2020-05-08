$(function () {
    $(document).scroll(function () {
        var scroH = $(document).scrollTop();  //滚动高度

        if (scroH > 100) {  //距离顶部大于100px时
            $(".header").addClass("my_hr")
            $(".header").addClass("fix")
            $(".main_show").addClass("top_pad")
        } else {
            $(".header").removeClass("my_hr")
            $(".header").removeClass("fix")
            $(".main_show").removeClass("top_pad")
        }
    })
    total = document.documentElement.clientHeight;
    document.getElementById("main_show_id").style.minHeight = total + "px";
    window.last_Interval
    if ($(".cart:has(.last_time)").length != 0) {
        var last_time = $(".cart .last_time").html()
        clearInterval(window.last_Interval)
        var m = last_time.split(':')[0];
        var s = last_time.split(':')[1];
        window.last_Interval = setInterval(function () {
            if (s < 10) {
                //如果秒数少于10在前面加上0
                $('.last_time').html(m + ':0' + s);
            } else {
                $('.last_time').html(m + ':' + s);
            }
            s--;
            if (s < 0) {
                //如果秒数少于0就变成59秒
                s = 59;
                m--;
            }
            if (s == 0 && m == 0) {
                clearInterval(window.last_Interval)
                $.getJSON("/product/clear_cart", function () {
                    window.location.reload()
                })
            }

        }, 1000)

    }
    huojian()
    $('.user_msg, .user_info_detail').mouseover(function () {
        var all_pos = $(".user_msg").get(0).getBoundingClientRect()
        $('.user_msg').children('span').removeClass('glyphicon-chevron-down')
        $('.user_msg').children('span').addClass('glyphicon-chevron-up')
        $('.user_info_detail').css({
                'display': 'block',
                'left': all_pos.left
            }
        )
    })
    $('.user_msg,.user_info_detail ').mouseout(function () {
        $('.user_msg').children('span').addClass('glyphicon-chevron-down')
        $('.user_msg').children('span').removeClass('glyphicon-chevron-up')
        $('.user_info_detail').css('display', 'none')
    })
    $(".sp_li,.all_list_detail").mouseover(function () {
        var all_pos = $(".sp_li").get(0).getBoundingClientRect()
        var top = all_pos.height + all_pos.top
        var left = all_pos.left
        $(".all_list_detail").css(
            {
                'display': 'block',
                'top': top,
                'left': left
            }
        )
    })
    $(".sp_li,.all_list_detail").mouseout(function () {
        $(".all_list_detail").css('display', 'none')
    })
    $(".ssi-button").click(function (e) {
        e.preventDefault()
    })
    // 找回密码
    $(".reset_password").click(function () {
        var email = $(".find_password").val();
        if (email.trim().length == 0) {
            zlalert.alertInfo("请先输入邮箱")
        } else {
            zlalert.alertOneInput({
                "title": "安全询问",
                "text": "这个邮箱的主人姓名叫什么？",
                "placeholder": "邮箱主人姓名",
                "confirmCallback": function (inputValue) {
                    $.getJSON("/user/resetPassword", "email=" + email + "&name=" + inputValue, function (result) {
                        if (result.status != 200) {
                            zlalert.alertError(result.msg)
                        } else {
                            zlalert.alertSuccess("信息已经发送到你的邮箱，请注意查收！")
                        }
                    })
                }
            })
        }
    })
})

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
