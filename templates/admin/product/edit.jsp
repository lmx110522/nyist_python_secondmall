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
			var pic = document.Form1.upload.value;
			var extStart=pic.lastIndexOf('.');
			var ext=pic.substring(extStart,pic.length).toUpperCase();
			if(ext!='.BMP'&&ext!='.PNG'&&ext!='.GIF'&&ext!='.JPG'&&ext!='.JPEG'){
			alert('图片限于png,gif,jpeg,jpg格式');
			return false;
			}
			return true;
}
		</script>
	</HEAD>
	
	<body>
		<form id="userAction_save_do" name="Form1" action="${pageContext.request.contextPath}/adminProduct_update.action" method="post" enctype="multipart/form-data" onsubmit="return check()">
			<input type="hidden" name="pid" value="${product.pid }">
			&nbsp;
			<table cellSpacing="1" cellPadding="5" width="100%" align="center" bgColor="#eeeeee" style="border: 1px solid #8ba7e3" border="0">
				<tr>
					<td class="ta_01" align="center" bgColor="#afd1f3" colSpan="4"
						height="26">
						<strong><STRONG>编辑商品信息</STRONG>
						</strong>
					</td>
				</tr>

				<tr>
					<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
					</td>
					<td class="ta_01" bgColor="#ffffff" colspan="3">
						商品名：<input type="text" name="pname" value="${product.pname}" style="width: 230px" id="userAction_save_do_logonName" class="bg"/><br>
						商品市场价：<input type="text" name="market_price" value="${product.market_price}" id="userAction_save_do_logonName" class="bg"/>元<br>
						商品商城价：<input type="text" name="shop_price" value="${product.shop_price}" id="userAction_save_do_logonName" class="bg"/>元<br>
						<p id = "cc">商品照片：</p><img alt="商品照片" src="${pageContext.request.contextPath}/${product.image}"><br>
						修改照片：<input type="file" name = "upload">
						<p id = "cc">商品描述：</p>
								<textarea rows="15em" cols="25em" name="pdesc">${product.pdesc}</textarea><br>
						商品所属热度：<select name = "is_hot">
							<option value="1">热卖商品</option>
							<option value="0">非热卖商品</option>
						</select>
						<br>所属二级分类：
						<select name="categorySecond.csid">
						<c:forEach items="${categorySecond }" var="catese">
								<option value="${catese.csid }" <c:if test="${catese.csid == product.categorySecond.csid}">selected</c:if>>${catese.csname }</option>
						</c:forEach>
						<br>
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