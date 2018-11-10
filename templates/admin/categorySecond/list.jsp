<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<HTML>
	<HEAD>
		<meta http-equiv="Content-Language" content="zh-cn">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link href="${pageContext.request.contextPath}/css/Style1.css" rel="stylesheet" type="text/css" />
		<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css"/>
		<link href="${pageContext.request.contextPath}/css/product.css" rel="stylesheet" type="text/css"/>
		<script language="javascript" src="${pageContext.request.contextPath}/js/public.js"></script>
		<script type="text/javascript">
			function addUser(){
				window.location.href = "${pageContext.request.contextPath}/adminCategorySecond_addCate.action";
			}
		</script>
		<style type="text/css">
		
		</style>
	</HEAD>
	<body>
		<br>
		<form id="Form1" name="Form1" action="${pageContext.request.contextPath}/adminCategorySecond_findByCate.action" method="post">
			<table cellSpacing="1" cellPadding="0" width="100%" align="center" bgColor="#f5fafe" border="0">
				<TBODY>
					<tr>
						<td class="ta_01" align="center" bgColor="#afd1f3">
							<strong>二级分类 列 表</strong>
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
								
								<tr >
									选择一级分类进行二级分类查找：
									
									<select name="category.cid">
										<c:forEach items="${cclist}" var="cclist">
										<option value="${cclist.cid}">${cclist.cname}</option>
										</c:forEach>
									</select>
									<input type="submit" value = "查询" >
									
								</tr>
								<tr
									style="FONT-WEIGHT: bold; FONT-SIZE: 12pt; HEIGHT: 25px; BACKGROUND-COLOR: #afd1f3">

									<td align="center" width="18%">
										序号
									</td>
									<td align="center" width="17%">
										二级分类名称
									</td>
									<td align="center" width="17%">
										所属一级分类
									</td>
									<td width="7%" align="center">
										编辑
									</td>
									<td width="7%" align="center">
										删除
									</td>
								</tr>
								<c:forEach items="${second_list }" var="second">
										<tr onmouseover="this.style.backgroundColor = 'white'"
											onmouseout="this.style.backgroundColor = '#F5FAFE';">
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="18%">
												${second.csid }
											</td>
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="17%">
												${second.csname }
											</td>
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="17%">
												${second.category.cname }
											</td>
											<td align="center" style="HEIGHT: 22px">
												<a href="${pageContext.request.contextPath}/adminCategorySecond_edit.action?csid=${second.csid }"/>
													<img src="${pageContext.request.contextPath}/images/i_edit.gif" border="0" style="CURSOR: hand">
												</a>
											</td>
									
											<td align="center" style="HEIGHT: 22px">
												<a href="${pageContext.request.contextPath}/adminCategorySecond_delete.action?csid=${second.csid }"/>
													<img src="${pageContext.request.contextPath}/images/i_del.gif" width="16" height="16" border="0" style="CURSOR: hand">
												</a>
											</td>
										</tr>
									</c:forEach>
									<tr>
									<div class="pagination">
									
									<span>第${tpageBean.currentPage}/${tpageBean.totalPage}页   </span>
									<c:if test="${tpageBean.currentPage != 1}">
										<a href ="${pageContext.request.contextPath}/adminCategorySecond_findAllByPage.action?currentPage=${tpageBean.currentPage-1} ">上一页</a>
									</c:if>
										<c:forEach var="i" begin="1" end="${tpageBean.totalPage }">
											<a href =" ${pageContext.request.contextPath}/adminCategorySecond_findAllByPage.action?currentPage=${i}">${i}   </a>
										</c:forEach>
										<c:if test="${tpageBean.currentPage != tpageBean.totalPage}">
										<a href ="${pageContext.request.contextPath}/adminCategorySecond_findAllByPage.action?currentPage=${tpageBean.currentPage+1} ">下一页</a>
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

