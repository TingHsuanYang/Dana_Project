<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.productReport.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    ProductReportService productReportSvc = new ProductReportService();
    List<ProductReportVO> list = productReportSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有商品檢舉資料 - listAllProductReport.jsp</title>

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
		 <h3>所有商品檢舉資料 - listAllProductReport.jsp</h3>
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
		<th>檢舉商品編號</th>
		<th>檢舉會員編號</th>
		<th>檢舉原因</th>
		<th>檢舉時間</th>
		<th>檢舉狀態</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="productReportVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${productReportVO.prod_report_product_id}</td>
			<td>${productReportVO.prod_report_mem_id}</td>
			<td>${productReportVO.prod_report_reason}</td>
			<td>${productReportVO.prod_report_time}</td>
			<td>${productReportVO.prod_report_status}</td>

			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/productReport/productReport.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="prod_report_product_id"  value="${productReportVO.prod_report_product_id}">
			     <input type="hidden" name="prod_report_mem_id"  value="${productReportVO.prod_report_mem_id}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/productReport/productReport.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="prod_report_product_id"  value="${productReportVO.prod_report_product_id}">
			     <input type="hidden" name="prod_report_mem_id"  value="${productReportVO.prod_report_mem_id}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>