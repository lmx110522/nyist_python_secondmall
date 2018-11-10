<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<HTML>
	<HEAD>
		<meta http-equiv="Content-Language" content="zh-cn">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link href="${pageContext.request.contextPath}/css/Style1.css" rel="stylesheet" type="text/css" />
		
		<script language="javascript" src="${pageContext.request.contextPath}/js/public.js"></script>
		<script type="text/javascript">
			function addUser(){
				window.location.href = "${pageContext.request.contextPath}/adminProduct_add";
			}
		</script>
	</HEAD>
	<body>
		<br>
		<form id="Form1" name="Form1" action="${pageContext.request.contextPath}/user/list.jsp" method="post">
			<table cellSpacing="1" cellPadding="0" width="100%" align="center" bgColor="#f5fafe" border="0">
				<TBODY>
					<tr>
						<td class="ta_01" align="center" bgColor="#afd1f3">
							<strong>订单 列 表</strong>
						</TD>
					</tr>
					<tr>
						<td class="ta_01" align="center" bgColor="#f5fafe">
							<table cellspacing="0" cellpadding="1" rules="all"
								bordercolor="gray" border="1" id="DataGrid1"
								style="BORDER-RIGHT: gray 1px solid; BORDER-TOP: gray 1px solid; BORDER-LEFT: gray 1px solid; WIDTH: 100%; WORD-BREAK: break-all; BORDER-BOTTOM: gray 1px solid; BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: #f5fafe; WORD-WRAP: break-word">
								<c:forEach items="${order }" var="order">
								<tr
									style="FONT-WEIGHT: bold; FONT-SIZE: 12pt; HEIGHT: 25px; BACKGROUND-COLOR: #afd1f3">

									<td align="center" width="19%">
										订单编号:${order.oid }<br> 订单所属用户:${order.name }<br>下单时间:${order.ordertime }<br>
										订单状态：<c:choose>
											<c:when test="${order.state == 1}">
												未付款
											</c:when>
											<c:when test="${order.state == 2}">
												已付款
											</c:when>
											<c:when test="${order.state == 3}">
												已发货
											</c:when>
											<c:when test="${order.state == 43}">
												交易完成
											</c:when>
										</c:choose>
									</td>
									
								</tr>
								<c:forEach items="${order.setOrderItem }" var="orderItem">
								<c:choose>
								<c:when test="${empty orderItem.product.pname }">
									<tr><td align="center" style="HEIGHT: 22px">
										商品已下架
								</td>
								<td align="center" style="HEIGHT: 22px">
										<a href="${pageContext.request.contextPath}/adminOrder_delete.action?oid=${order.oid }"/>
										<img src="${pageContext.request.contextPath}/images/i_del.gif" width="16" height="16" border="0" style="CURSOR: hand">
									</a>
								</td>
								</tr>
								</c:when>
								<c:otherwise>
								<tr>
									<td align="center" style="HEIGHT: 22px">
										商品编号
								</td>
								
									<td align="center" style="HEIGHT: 22px">
										商品照片
								</td>
								<td align="center" style="HEIGHT: 22px">
										商品名字
								</td>
								<td align="center" style="HEIGHT: 22px">
										商品价格
								</td>
								<td align="center" style="HEIGHT: 22px">
										此商品小计
								</td>
								<td align="center" style="HEIGHT: 22px">
										商品数量
								</td>
								<td align="center" style="HEIGHT: 22px">
										修改
								</td>
								<td align="center" style="HEIGHT: 22px">
										移除
								</td>
								</tr>
								<tr>
								<td align="center" style="HEIGHT: 22px">
										${orderItem.product.pid }
								</td>
								<td style="CURSOR: hand; HEIGHT: 22px"  align="center"
												>
												<img src = "${pageContext.request.contextPath}/${orderItem.product.image }" width="145" height ="140" alt="照片丢失">
											</td>
								<td align="center" style="HEIGHT: 22px">
										${orderItem.product.pname }
								</td>
								<td align="center" style="HEIGHT: 22px">
										${orderItem.product.shop_price }元
								</td>
								<td align="center" style="HEIGHT: 22px">
										${orderItem.subtotal }元
								</td>
								<td align="center" style="HEIGHT: 22px">
										${orderItem.count }
								</td>
								
								<td align="center" style="HEIGHT: 22px">
									<a href="${pageContext.request.contextPath}/adminOrder_edit.action?oid=${order.oid }"/>
										<img src="${pageContext.request.contextPath}/images/i_edit.gif" border="0" style="CURSOR: hand">
									</a>
								</td>
						
								<td align="center" style="HEIGHT: 22px">
									<a href="${pageContext.request.contextPath}/adminOrder_delete.action?oid=${order.oid }"/>
										<img src="${pageContext.request.contextPath}/images/i_del.gif" width="16" height="16" border="0" style="CURSOR: hand">
									</a>
								</td>
								</tr>
								</c:otherwise>
								</c:choose>
								</c:forEach>
								</c:forEach>
									<tr>
									<div class="pagination">
									订单页码：<select name="currentPage" onchange="document.location.href = '${pageContext.request.contextPath}/adminOrder_findAllByPage?currentPage='+this.value">
										<c:forEach var="i" begin="1" end="${pageBean.totalPage }">
											<option value='${i}' <c:if test="${pageBean.currentPage == i}">selected</c:if>>第${i}页</option>
										</c:forEach>
									</select>
									</div>
									<tr>	
							</table>
						</td>
					</tr>
				</TBODY>
			</table>
		</form>
	</body>
</HTML>

