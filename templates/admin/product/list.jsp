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
							<strong>商品 列 表</strong>
						</TD>
					</tr>
					<tr>
						<td class="ta_01" align="right">
							<button type="button" id="add" name="add" value="添加" class="button_add" onclick="addUser()">
&#28155;&#21152;
</button>

						</td>
					</tr>
					<tr>
						<td class="ta_01" align="center" bgColor="#f5fafe">
							<table cellspacing="0" cellpadding="1" rules="all"
								bordercolor="gray" border="1" id="DataGrid1"
								style="BORDER-RIGHT: gray 1px solid; BORDER-TOP: gray 1px solid; BORDER-LEFT: gray 1px solid; WIDTH: 100%; WORD-BREAK: break-all; BORDER-BOTTOM: gray 1px solid; BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: #f5fafe; WORD-WRAP: break-word">
								<tr
									style="FONT-WEIGHT: bold; FONT-SIZE: 12pt; HEIGHT: 25px; BACKGROUND-COLOR: #afd1f3">

									<td align="center" width="18%">
										商品序号
									</td>
									<td align="center" width="17%">
										商品名称
									</td>
									<td align="center" width="17%">
										商品价格 
									</td>
									<td align="center" width="17%">
										市场价格
									</td>
									<td align="center" width="2%" height = "2%">
										商品照片
									</td>
									<td align="center" width="17%">
										商品描述
									</td>
									<td align="center" width="17%">
										商品是否是热品
									</td>
									<td align="center" width="17%">
										所属二级分类
									</td>
									<td width="7%" align="center">
										编辑
									</td>
									<td width="7%" align="center">
										删除
									</td>
								</tr>
								<c:forEach items="${pplist }" var="pplist">
										<tr onmouseover="this.style.backgroundColor = 'white'"
											onmouseout="this.style.backgroundColor = '#F5FAFE';">
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="18%">
												${pplist.pid }
											</td>
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="18%">
												${pplist.pname }
											</td>
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="18%">
												${pplist.shop_price }元
											</td>
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="18%" >
												${pplist.market_price }元
											</td>
											<td style="CURSOR: hand; HEIGHT: 22px"  align="center"
												>
												<img src = "${pageContext.request.contextPath}/${pplist.image }" width="145" height ="140">
											</td>
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="18%">
												${pplist.pdesc }
											</td>
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="18%">
												<c:choose>
													<c:when test="${pplist.is_hot == 0 }">
														非热卖品
													</c:when>
													<c:otherwise>
														热卖品
													</c:otherwise>
												</c:choose>
											</td>
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="17%">
												${pplist.categorySecond.csname }
											</td>
											<td align="center" style="HEIGHT: 22px">
												<a href="${pageContext.request.contextPath}/adminProduct_edit.action?pid=${pplist.pid }"/>
													<img src="${pageContext.request.contextPath}/images/i_edit.gif" border="0" style="CURSOR: hand">
												</a>
											</td>
									
											<td align="center" style="HEIGHT: 22px">
												<a href="${pageContext.request.contextPath}/adminProduct_delete.action?pid=${pplist.pid }"/>
													<img src="${pageContext.request.contextPath}/images/i_del.gif" width="16" height="16" border="0" style="CURSOR: hand">
												</a>
											</td>
										</tr>
									</c:forEach>
									<tr>
									<div class="pagination">
										<c:if test="${pageBean.currentPage == 0}">
											${pageBean.currentPage = 1}
										</c:if>
									<span>第${pageBean.currentPage}/${pageBean.totalPage}页   </span>
									<c:if test="${pageBean.currentPage != 1}">
										<a href ="${pageContext.request.contextPath}/adminProduct_findAllByPage.action?currentPage=${pageBean.currentPage-1} ">上一页</a>
									</c:if>
										<c:forEach var="i" begin="1" end="${pageBean.totalPage }">
											<a href =" ${pageContext.request.contextPath}/adminProduct_findAllByPage.action?currentPage=${i}">${i}   </a>
										</c:forEach>
										<c:if test="${pageBean.currentPage != pageBean.totalPage}">
										<a href ="${pageContext.request.contextPath}/adminProduct_findAllByPage.action?currentPage=${pageBean.currentPage+1} ">下一页</a>
										</c:if>
										
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

