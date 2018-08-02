<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ord.model.*"%>


<%-- 此頁練習採用 EL 的寫法取值 --%>

<%

    OrdService ordSvc = new OrdService();
    List<OrdVO> list = ordSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有訂單資料 - listAllOrd.jsp</title>

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
		 <h3>所有訂單資料 - listAllOrd.jsp</h3>
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
		<th>訂單編號</th>
		<th>買家會員編號</th>
		<th>賣家會員編號</th>
		<th>訂單地址</th>
		<th>付款狀態</th>
		<th>付款方式</th>
		<th>訂單物流狀態</th>
		<th>訂單日期</th>
		<th>訂單狀態</th>
		<th>訂單金額</th>
		<th>訂單項目</th>
		<th>取消訂單原因</th>
		<th>賣家給買家評價星等</th>
		<th>賣家給買家評價內容</th>
		<th>買家給賣家評價星等</th>
		<th>買家給賣家評價內容</th>
		<th>寄件編號</th>
		<th>收貨方式</th>
		<th>711店名</th>
		<th>修改</th>
	
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="ordVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">

		<tr>
		<td>${ordVO.order_id}</td>
		<td>${ordVO.buyer_mem_id}</td>
		<td>${ordVO.seller_mem_id}</td>
		<td>${ordVO.order_address}</td>
		<td>${ordVO.payment_status}</td>
		<td>${ordVO.payment_method}</td>
		<td>${ordVO.shipment_status}</td>
		<td>${ordVO.order_date}</td>
		<td>${ordVO.order_status}</td>
		<td>${ordVO.order_total}</td>
		<td>${ordVO.order_item}</td>
		<td>${ordVO.cancel_reason}</td>
		<td>${ordVO.stob_rating}</td>
		<td>${ordVO.stob_rating_descr}</td>
		<td>${ordVO.btos_rating}</td>
		<td>${ordVO.btos_rating_descr}</td>
		<td>${ordVO.shipment_id}</td>
		<td>${ordVO.shipment_method}</td>
		<td>${ordVO.ord_store_711_name}</td>
		
		<td>
		  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ord/ord.do" style="margin-bottom: 0px;">
		     <input type="submit" value="修改">
		     <input type="hidden" name="order_id"  value="${ordVO.order_id}">
		     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
		</td>
	
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>