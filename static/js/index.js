$(function () {
    $("#myModal_ads").modal({backdrop: "static", keyboard: false, show: false});
    $(".bs-example-modal-sm").modal({backdrop: "static", keyboard: false, show: false});

    var now_time = new Date();
    now_minutes = now_time.getMinutes();
    if (now_minutes == 22 || now_minutes == 53) {
        $("#myModal_ads").modal('show')
        var time = 5
        interval = setInterval(function () {
            if (time == 0) {
                clearInterval(interval)
                $("#myModal_ads").modal('hide')
            } else {
                $(".djs_time").text(time)
                time--
            }
        }, 1000)
        $(".closeMt").click(function () {
            clearInterval(interval)
            $("#myModal_ads").modal('hide')
        })
    }


    $(".must_input_product").change(function () {
        $(this).css({
            "color": '#E14961',
            'font-size': '16px'
        })
    })
    $(".index_close").click(function () {
        $("#Section1").addClass('active in')
        $("#Section2").removeClass('active in')
        $(".my_nav_tab li:eq(0)").addClass('active')
        $(".my_nav_tab li:eq(1)").removeClass('active')
    })
    $(".my_nav_tab li:last").click(function () {
        username = $(".user_msg").text()
        if (username == "") {

            $(".open_loginUI").click()
        }

    })
    $(".one_li").click(function (e) {
        e.preventDefault()
        $(".one_cate").text($(this).children('a').text())
        $(".one_cate").attr('cid', $(this).attr('id'))
        $(this).addClass('disabled').siblings('li').removeClass('disabled')
        cid = $(this).attr('id')
        $.getJSON('/product/getCategorySecond', 'cid=' + cid, function (result) {
            $(".cate_two").empty()
            append_html = ""
            for (var i = 0; i < result.length; i++) {

                append_html += "<li id='" + result[i]["csid"] + "'><a href='#'>" + result[i]["csname"] + "</a></li>"

            }

            console.log(append_html)
            $(".cate_two").append(append_html)
        })
    })
    $(".cate_two").delegate('li', 'click', function (e) {
        e.preventDefault()
        $(".two-cate").text($(this).children('a').text())
        $(".two-cate").attr('csid', $(this).attr('id'))
    })
    $(".mt_img").click(function () {
        window.open("/product/detail?id=f08252166c4411ea9a1cacde48001122")
    })
})

function checkAll() {
    i = 0
    $(".must_input_product").each(function () {
        if ($(this).val().trim().length == 0) {
            $(this).focus()
            i++
            return false;
        }
    })
    length2 = $("#ssi-previewBox .ssi-pending").length;
    if (length2 == 0) {
        i++
        zlalert.alertInfo("必须上传至少一张商品照片")
        return false
    }
    var csid = $(".two-cate").attr('csid')
    if (csid == undefined || csid == "") {
        i++
        zlalert.alertInfo('请先选择类别再发布！')
    }
    $(".load-bg").show()
    $('body').addClass('pon');


    if (i == 0) {
        var pname = $("#pname").val()
        var pDesc = $("#pDesc").val()
        var counts = $("#counts").val()
        var old_price = $("#old_price").val()
        var new_price = $("#new_price").val()

        var imgs = ""
        $(".ssi-imgToUploadTable tbody tr").each(function () {
            upload_img = $(this).find('.ssi-imgToUpload').attr('src')
            if (upload_img != undefined) {
                no_use = upload_img.split(",")[0]
                upload_img = upload_img.replace(no_use, '')
                imgs += upload_img + "@"
            }

        })
        $.post("/product/add_product", {
            "datas": imgs,
            "pname": pname,
            "pDesc": pDesc,
            "counts": counts,
            "old_price": old_price,
            "new_price": new_price,
            "csid": csid
        }, function (result) {
            $('body').removeClass('pon');
            $(".load-bg").hide()
            if (result.error == 0) {
                zlalert.alertSuccess("商品发布成功，我们会尽快审核，敬请等待！", function () {
                    // window.location.href="/user/userInfo?tab=2"
                    window.location.reload()
                })
            } else {
                zlalert.alertError('出现错误！')
            }
        })
    }
}

