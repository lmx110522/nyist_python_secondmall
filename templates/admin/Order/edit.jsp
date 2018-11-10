<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<HTML>
	<HEAD>
		<meta http-equiv="Content-Language" content="zh-cn">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<LINK href="${pageContext.request.contextPath}/css/Style1.css" type="text/css" rel="stylesheet">
		<style type="text/css">
			#cc{
				font-weight: bolder;
				color: red;
			}
		</style>
		<script type="text/javascript">
		function check(){
			var name = document.Form1.name.value;
			var phone = document.Form1.phone.value; 
			var addr = document.Form1.addr.value;
			if(name.length == 0){
				alert("不能将收件人名字置空");
				return false;
			}
			if(phone.length == 0){
				alert("不能将收件人电话置空");
				return false;
			}
			if(addr.length == 0){
				alert("不能将收件人地址置空");
				return false;
			}
			return true;
		}			
		</script>
	</HEAD>
	
	<body>
		<form id="userAction_save_do" name="Form1" action="${pageContext.request.contextPath}/adminOrder_update.action" method="post" enctype="multipart/form-data" onsubmit="return check()">
			<input type="hidden" name="oid" value="${order.oid }">
			<input type="hidden" name="ordertime" value="${order.ordertime }">
			&nbsp;
			<table cellSpacing="1" cellPadding="5" width="100%" align="center" bgColor="#eeeeee" style="border: 1px solid #8ba7e3" border="0">
				<tr>
					<td class="ta_01" align="center" bgColor="#afd1f3" colSpan="4"
						height="26">
						<strong><STRONG>编辑订单信息</STRONG>
						</strong>
					</td>
				</tr>

				<tr>
					<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
					订单号：
					</td>
					<td class="ta_01" bgColor="#ffffff" colspan="3">
						${order.oid}
					</td>
					
					<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
					修改订单状态：
					</td>
					<td class="ta_01" bgColor="#ffffff" colspan="3">
						<select name="state">
								<option value="1"<c:if test="${order.state == 1}">selected</c:if>>未付款</option>
								<option value="2"<c:if test="${order.state == 2}">selected</c:if>>已付款</option>
								<option value="3"<c:if test="${order.state == 3}">selected</c:if>>已发货</option>
								<option value="4"<c:if test="${order.state == 4}">selected</c:if>>交易完成</option>
						</select>
					</td>
					<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
					<br>修改收件人姓名：
					</td>
					<td class="ta_01" bgColor="#ffffff" colspan="3">
						<input type="text" name="name" value="${order.name}">
					</td>
					<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
					修改收件人手机号：
					</td>
					<td class="ta_01" bgColor="#ffffff" colspan="3">
						<input type="text" name="phone" value="${order.phone}">
					</td>
					<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
					修改收件人收件地址：
					</td>
					<td class="ta_01" bgColor="#ffffff" colspan="3">
						<input type="text" name="addr" value="${order.addr}">
					</td>
				</tr>	
				<tr>
					<td class="ta_01" style="WIDTH: 100%" align="center"
						bgColor="#f5fafe" colSpan="4">
						<button type="submit" id="userAction_save_do_submit" value="确定" class="button_ok">
							&#30830;&#23450;
						</button>

						<FONT face="宋体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT>
						<button type="reset" value="重置" class="button_cancel">&#37325;&#32622;</button>

						<FONT face="宋体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT>
						<INPUT class="button_ok" type="button" onclick="history.go(-1)" value="返回"/>
						<span id="Label1"></span>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>