$(function () {
    $("#username").focus()
})
function checkAll() {
    var i = 0;
    $(".must_input").each(function () {
        if($(this).val().trim() == ""){
            $(this).focus()
            i++;
            return false
        }
    })
     if(i != 0){
        return false;
    }
}
function clear_code_msg() {
    $('#code_msg').text('')
}
function clear_email_msg() {
    $("#email_msg").text('')
}