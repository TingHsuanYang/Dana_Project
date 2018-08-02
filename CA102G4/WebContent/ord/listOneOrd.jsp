<%@ page contentType="text/html; charset=Big5"%>
<%@ page import="com.ord.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	OrdVO  ordVO = (OrdVO) request.getAttribute("ordVO"); //OrdServlet.java (Concroller), 存入req的ordVO物件
%>

<html>
<head>
<title>訂單資料 - listOneOrd.jsp</title>

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
	width: 600px;
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

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>訂單資料 - listOneOrd.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

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
	</tr>
	<tr>
		<td><%=ordVO.getOrder_id()%></td>
		<td><%=ordVO.getBuyer_mem_id()%></td>
		<td><%=ordVO.getSeller_mem_id()%></td>
		<td><%=ordVO.getOrder_address()%></td>
		<td><%=ordVO.getPayment_status()%></td>
		<td><%=ordVO.getPayment_method()%></td>
		<td><%=ordVO.getShipment_status()%></td>
		<td><%=ordVO.getOrder_date()%></td>
		<td><%=ordVO.getOrder_status()%></td>
		<td><%=ordVO.getOrder_total()%></td>
		<td><%=ordVO.getOrder_item()%></td>
		<td><%=ordVO.getCancel_reason()%></td>
		<td><%=ordVO.getStob_rating()%></td>
		<td><%=ordVO.getStob_rating_descr()%></td>
		<td><%=ordVO.getBtos_rating()%></td>
		<td><%=ordVO.getBtos_rating_descr()%></td>
		<td><%=ordVO.getShipment_id()%></td>
		<td><%=ordVO.getShipment_method()%></td>
		<td><%=ordVO.getOrd_store_711_name()%></td>
	</tr>
</table>

</body>
</html>