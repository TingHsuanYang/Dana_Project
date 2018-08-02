<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.orderDetails.model.*"%>
<%@ page import="com.product.model.*"%>

<%
	OrderDetailsVO  orderDetailsVO = (OrderDetailsVO) request.getAttribute("orderDetailsVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>購買清單新增 - addOrderDetailst.jsp</title>

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
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr>
	<td>
		 <h3>購買清單新增 - addOrderDetails.jsp</h3>
	</td>
	<td>
		 <h4><a href="select_page.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">回首頁</a></h4>
	</td>
	</tr>
</table>

<h3>資料新增:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="orderDetails.do" name="form1">
<table>
 
  <jsp:useBean id="productSvc" scope="page" class="com.product.model.ProductService" />
	
	<tr>
		<td>商品編號:<font color=red><b>*</b></font></td>
		<td>
			<select size="1" name="details_product_id">
	         	<c:forEach var="productVO" items="${productSvc.all}" > 
	          		<option value="${productVO.product_id}" ${(productVO.product_id==orderDetailsVO.details_product_id)?'selected':''}>${productVO.product_id}
	         	</c:forEach>   
	        </select>
	     </td>
	</tr>
	<tr>
		<td>清單商品數量:</td>
		<td><input type="TEXT" name="details_order_qty" size="30" 
			 value="<%= (orderDetailsVO==null)? 3 : orderDetailsVO.getDetails_order_qty()%>" /></td>
	</tr>
	<tr>
		<td>清單金額:</td>
		<td><input type="TEXT" name="details_order_total" size="30" 
			 value="<%= (orderDetailsVO==null)? 1500 : orderDetailsVO.getDetails_order_total()%>" /></td>
	</tr>

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>
</body>
</html>