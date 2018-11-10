<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<HTML>
	<HEAD>
		<meta http-equiv="Content-Language" content="zh-cn">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<LINK href="${pageContext.request.contextPath}/css/Style1.css" type="text/css" rel="stylesheet">
				<script type="text/javascript">
		function check(){
			var pic = document.Form1.upload.value;
			var name = document.Form1.pname.value;
			var market_price = document.Form1.market_price.value;
			var shop_price = document.Form1.shop_price.value;
			var pdesc = document.Form1.pdesc.value;
			var extStart=pic.lastIndexOf('.');
			var ext=pic.substring(extStart,pic.length).toUpperCase();
			if(name.length == 0){
				alert("商品名不能为空！");
				return false;
			}
			if(market_price.length == 0){
				alert("市场价不能为空！");
				return false;
			}
			if(shop_price.length == 0){
				alert("商城价不能为空！");
				return false;
			}
			if(pdesc.length == 0){
				alert("商品描述不能为空！");
				return false;
			}
			if(ext!='.BMP'&&ext!='.PNG'&&ext!='.GIF'&&ext!='.JPG'&&ext!='.JPEG'){
			alert('图片限于png,gif,jpeg,jpg格式');
			return false;
			}
			return true;
}
		</script>
	</HEAD>
	
	<body>
		<form id="userAction_save_do" name="Form1" action="${pageContext.request.contextPath}/adminProduct_save.action" method="post" enctype="multipart/form-data" onsubmit="return check()">
			&nbsp;
			<table cellSpacing="1" cellPadding="5" width="100%" align="center" bgColor="#eeeeee" style="border: 1px solid #8ba7e3" border="0">
				<tr>
					<td class="ta_01" align="center" bgColor="#afd1f3" colSpan="4"
						height="26">
						<strong><STRONG>添加商品</STRONG>
						</strong>
					</td>
				</tr>

				<tr>
			
					<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
						商品名称：
					</td>
					<td class="ta_01" bgColor="#ffffff" colspan="3">
						<input type="text" name="pname" value="" id="userAction_save_do_logonName" class="bg"/>
					</td>
				</tr>
				<tr>
			
					<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
						商品市场价：
					</td>
					<td class="ta_01" bgColor="#ffffff" colspan="3">
						<input type="text" name="market_price" value="" id="userAction_save_do_logonName" class="bg"/>
					</td>
				</tr>
				<tr>
			
					<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
						商品商城价：
					</td>
					<td class="ta_01" bgColor="#ffffff" colspan="3">
						<input type="text" name="shop_price" value="" id="userAction_save_do_logonName" class="bg"/>
					</td>
				</tr>
				<tr>
			
					<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
						商品照片：
					</td>
					<td class="ta_01" bgColor="#ffffff" colspan="3">
						<input type="file" name = "upload">
					</td>
				</tr>
				<tr>
			
					<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
						商品描述：
					</td>
					<td class="ta_01" bgColor="#ffffff" colspan="3">
						<textarea rows="15em" cols="25em" name="pdesc"></textarea><br>
					</td>
				</tr>
				<tr>
			
					<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
						商品所属二级分类
					</td>
					<td class="ta_01" bgColor="#ffffff" colspan="3">
						<select name="categorySecond.csid">
							<c:forEach items="${categorySecond }" var="catese">
								<option value="${catese.csid }">${catese.csname}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
			
					<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
						商品是否是热卖品：
					</td>
					<td class="ta_01" bgColor="#ffffff" colspan="3">
						<select name="is_hot">
							<option value="1">热卖品</option>
							<option value="0">非热卖品</option>
						</select>
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