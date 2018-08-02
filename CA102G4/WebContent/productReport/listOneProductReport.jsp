<%@ page contentType="text/html; charset=Big5"%>
<%@ page import="com.productReport.model.*"%>
<%@ page import="sun.misc.BASE64Encoder"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	ProductReportVO  productReportVO = ( ProductReportVO) request.getAttribute("productReportVO"); //ProductReportServlet.java (Concroller), 存入req的productReportVO物件
%>

<html>
<head>
<title>檢舉商品資料 - listOneProductReport.jsp</title>

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
		 <h3>檢舉商品資料 - listOneProductReport.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>檢舉商品編號</th>
		<th>檢舉會員編號</th>
		<th>檢舉原因</th>
		<th>檢舉時間</th>
		<th>檢舉狀態</th>
	
		
	</tr>
	<tr>
		<td><%=productReportVO.getProd_report_product_id()%></td>
		<td><%=productReportVO.getProd_report_mem_id()%></td>
		<td><%=productReportVO.getProd_report_reason()%></td>
		<td><%=productReportVO.getProd_report_time()%></td>
		<td><%=productReportVO.getProd_report_status()%></td>

	</tr>
</table>

</body>
</html>