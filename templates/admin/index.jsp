<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>网上商城管理中心</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="${pageContext.request.contextPath }/css/general.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/css/main.css" rel="stylesheet" type="text/css" />

<style type="text/css">
body {
  color: white;
}
h1{
	text-align: center;
	color:orange;
}
#for{
	text-align: center;
	margin-top: 45px;
}
</style>
<script type="text/javascript">
	function validate(){
		var name = document.theForm.admin_name.value;
		var password = document.theForm.admin_password.value;
		var message = document.getElementById("span2").innerHTML;
		if(name.length == 0){
			document.getElementById("span1").innerHTML = "用户名不能为空";
			return false;
		}
		if(password.length == 0){
			document.getElementById("span2").innerHTML = "密码不能为空	";
			return false;
		}
		if(message.indexOf("用户名或密码不正确") != -1){
			alert("请输入正确的用户和密码登录！");
			return false;
		}
	}
	function ajaxFunction(){
		var name = document.theForm.admin_name.value;
		var password = document.theForm.admin_password.value;
		var xhr = new XMLHttpRequest();
		xhr.open("GET", "${pageContext.request.contextPath}/userAdmin_login.action?time="+new Date().getTime()+"&admin_name="+name+"&admin_password="+password, true);
		xhr.send(null);
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4){
				if(xhr.status == 200){
					document.getElementById("span2").innerHTML = xhr.response;
				}
			}
		}
	}
</script>
</head>
<body style="background: #278296">
	<h1>管理员登录页面</h1>
<div id ="for">
<form method="post" action="${pageContext.request.contextPath }/userAdmin_success.action" target="_parent" name='theForm' onsubmit="return validate()">
<pre> 管理员：<input type = "text" name = "admin_name"/></pre><span id="span1"></span><br/>
 <pre> 密   码：<input type = "password" name = "admin_password" onblur="ajaxFunction()"/></pre><span id="span2"></span><br/>
 <input type = "submit" value="管理员登录"/>
</form>
</div>
</body>