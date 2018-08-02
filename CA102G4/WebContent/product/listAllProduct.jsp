<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.product.model.*"%>
<%@ page import="sun.misc.BASE64Encoder"%>

<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	BASE64Encoder base64Encoder = new BASE64Encoder();
    ProductService productSvc = new ProductService();
    List<ProductVO> list = productSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有商品資料 - listAllProduct.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>所有商品資料 - listAllProduct.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
		<th>商品編號</th>
		<th>商品類別編號</th>
		<th>商品賣家編號</th>
		<th>商品名稱</th>
		<th>商品價格</th>
		<th>商品描述</th>
		<th>商品庫存</th>
		<th>商品狀態</th>
		<th>商品上架時間</th>
		<th>商品照片1</th>
		<th>商品照片2</th>
		<th>商品照片3</th>
		<th>商品照片4</th>
		<th>商品照片5</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="productVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">

		<tr>
		<td>${productVO.product_id}</td>
		<td>${productVO.product_category_id}</td>
		<td>${productVO.product_mem_id}</td>
		<td>${productVO.product_name}</td>
		<td>${productVO.product_price}</td>
		<td>${productVO.product_descr}</td>
		<td>${productVO.product_stock}</td>
		<td>${productVO.product_status}</td>
		<td>${productVO.product_date}</td>
		<c:set var="imgData1" scope="page" value="${productVO.product_photo_1_base}"/>
		<c:set var="imgData2" scope="page" value="${productVO.product_photo_2_base}"/>
		<c:set var="imgData3" scope="page" value="${productVO.product_photo_3_base}"/>
		<c:set var="imgData4" scope="page" value="${productVO.product_photo_4_base}"/>
		<c:set var="imgData5" scope="page" value="${productVO.product_photo_5_base}"/>
		
		<td><c:if test="${not empty imgData1}"><img src="data:image/jpeg;base64,${imgData1}" height="60" width="75" class="img-thumbnail"/></c:if><c:if test="${empty imgData1}"><img id="preview-product_photo_1" src="images/no-image-icon-15.png" height="60" width="75" class="img-thumbnail"/></c:if></td>
	
		<td><c:if test="${not empty imgData2}"><img src="data:image/jpeg;base64,${imgData2}" height="60" width="75" class="img-thumbnail"/></c:if><c:if test="${empty imgData2}"><img id="preview-product_photo_2" src="images/no-image-icon-15.png" height="60" width="75" class="img-thumbnail"/></c:if></td>
		
		<td><c:if test="${not empty imgData3}"><img src="data:image/jpeg;base64,${imgData3}" height="60" width="75" class="img-thumbnail"/></c:if><c:if test="${empty imgData3}"><img id="preview-product_photo_3" src="images/no-image-icon-15.png" height="60" width="75" class="img-thumbnail"/></c:if></td>		
		<td><c:if test="${not empty imgData4}"><img src="data:image/jpeg;base64,${imgData4}" height="60" width="75" class="img-thumbnail"/></c:if><c:if test="${empty imgData4}"><img id="preview-product_photo_4" src="images/no-image-icon-15.png" height="60" width="75" class="img-thumbnail"/></c:if></td>	
		<td><c:if test="${not empty imgData5}"><img src="data:image/jpeg;base64,${imgData5}" height="60" width="75" class="img-thumbnail"/></c:if><c:if test="${empty imgData5}"><img id="preview-product_photo_5" src="images/no-image-icon-15.png" height="60" width="75" class="img-thumbnail"/></c:if></td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front_end/store/product.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="product_id"  value="${productVO.product_id}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front_end/store/product.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="product_id"  value="${productVO.product_id}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>