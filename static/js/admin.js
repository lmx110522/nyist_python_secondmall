$(function () {
    $(".open_detail").click(function () {
        let id = $(this).attr("id");
        // $(".open_detail_model").click()
        $.get("/product/find_one", {"id": id}, function (result) {
            if (result.error == 0) {
                let product = result.product;
                let category = result.category;
                let categorySecond = result.categorySecond;
                $("#one").text(category.cname)
                $("#two").text(categorySecond.csname)
                $("#pname").val(product.pname)
                $("#pDesc").val(product.pDesc)
                $("#counts").val(product.counts)
                $("#old_price").val(product.old_price)
                $("#new_price").val(product.new_price)
                $("#do_area .pass").attr("pid", product.id);
                $("#do_area .nopass").attr("pid", product.id);
                var arr = product.images.split("@")
                var html = ""
                $("#product_img").empty()
                $.each(arr, function (index, obj) {
                    html += "<img src=" + obj + ">"
                    console.log(obj)
                })
                console.log(html)
                $("#product_img").append(html);
            } else {
                zlalert.alertError('出现错误！')
            }
        })
        $(".open_detail_model").click()
    })

    $("#do_area .pass").click(function () {
        var id = $("#do_area .pass").attr("pid");
        console.log(id)
        $(this).css({'background-color': 'gray'});
        $(this).attr("disabled", true);
        $.get("/product/passItem", {"id": id}, function (result) {
            if (result.error == 0) {
                zlalert.alertSuccess("商品上线成功", function () {
                    window.location.reload();
                })
            } else {
                zlalert.alertError('出现错误！', function () {
                    window.location.reload();

                })
            }
        })
    })

    $("#do_area .nopass").click(function () {
        var id = $("#do_area .nopass").attr("pid");
        console.log(id)
        $(this).css({'background-color': 'gray'});
        $(this).attr("disabled", true);
        $.get("/product/no_pass", {"id": id}, function (result) {
            if (result.error == 0) {
                zlalert.alertSuccess("商品驳回成功", function () {
                    window.location.reload();
                })

            } else {
                zlalert.alertError('出现错误！', function () {
                    window.location.reload();
                })
            }
        })
    })
})