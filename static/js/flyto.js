/*!
 * jQuery lightweight Fly to
 * Author: @ElmahdiMahmoud
 * Licensed under the MIT license
 */

// self-invoking
;(function ($, window, document, undefined) {
    $.fn.flyto = function (options) {
        // Establish default settings

        var settings = $.extend({
            item: '.flyto-item',
            target: '.flyto-target',
            button: '.flyto-btn',
            shake: true
        }, options);


        return this.each(function () {
            var
                $this = $(this),
                flybtn = $this.find(settings.button),
                target = $(settings.target),
                itemList = $this.find(settings.item);
            console.log(itemList[0])

            flybtn.on('click', function () {
                username = $(".user_msg").text()
                if (username == "") {
                    $(".open_loginUI").click()
                } else {
                    count = $("#count").val()
                    if (count == '' || count == 0 || count == undefined || isNaN(count)) {
                        $("#count").val('')
                        $("#count").focus()
                    } else {
                        var _this = $(this),
                            eltoDrag = $(".medium");

                        if (eltoDrag) {

                            var pid = $(".no_use_pid").text()
                            $.post("/product/addCart", {"pid": pid, "count": count}, function (result) {
                                if (result.status != 200) {
                                    zlalert.alertErrorToast(result.msg)
                                    sleep(function () {
                                    window.location.reload()
                                    },1500)
                                    function sleep(success, num) {
                                        setTimeout(function () {
                                            success();//执行的函数，通过参数传递过来
                                        }, num);//num 暂停时间 毫秒
                                    }

                                } else {
                                    var imgclone = eltoDrag.clone()
                                        .offset({
                                            top: eltoDrag.offset().top,
                                            left: eltoDrag.offset().left
                                        })
                                        .css({
                                            'opacity': '0.8',
                                            'position': 'absolute',
                                            'height': eltoDrag.height() / 2,
                                            'width': eltoDrag.width() / 2,
                                            'z-index': '100',
                                            'border-radius': "10px"
                                        })
                                        .appendTo($('body'))
                                        .animate({
                                            'top': target.offset().top + 10,
                                            'left': target.offset().left + 15,
                                            'height': eltoDrag.height() / 2,
                                            'width': eltoDrag.width() / 2
                                        }, 1000, 'easeInOutExpo');

                                    if (settings.shake) {
                                        setTimeout(function () {
                                            target.effect("shake", {
                                                times: 2
                                            }, 200);
                                        }, 1500);
                                    }
                                    imgclone.animate({
                                        'width': 0,
                                        'height': 0
                                    }, function () {
                                        $(this).detach()
                                    });
                                    if ($(".cart:has(.last_time)").length == 0) {
                                        $(".cart").append('<div class="last_time">20:00</div>')
                                    }
                                    cart_nums = $(".cart_nums").text()
                                    $(".cart_nums").text(parseInt(cart_nums) + parseInt(count))
                                    $('.last_time').html("20:00")
                                    lastTime()
                                }
                            })
                        }
                    }
                }
            });
        });
    }
})(jQuery, window, document);

function lastTime() {
    clearInterval(window.last_Interval)
    var m = 19;
    var s = 59;
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