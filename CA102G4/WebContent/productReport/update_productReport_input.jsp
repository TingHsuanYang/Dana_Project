<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.productReport.model.*"%>

<%
	ProductReportVO  productReportVO = (ProductReportVO) request.getAttribute("productReportVO"); // ProductReportServlet.java (Concroller) 存入req的productReportVO物件 (包括幫忙取出的productReportVO, 也包括輸入資料錯誤時的productReportVO物件)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>檢舉商品修改 - update_productReport_input.jsp</title>

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
	<tr><td>
		 <h3>檢舉商品修改 - update_productReport_input.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="productReport.do" name="form1">
<table>
	<tr>
		<td>檢舉商品編號:<font color=red><b>*</b></font></td>
		<td><%=productReportVO.getProd_report_product_id()%></td>
	</tr>
	<tr>
		<td>檢舉會員編號:<font color=red><b>*</b></font></td>
		<td><%=productReportVO.getProd_report_mem_id()%></td>
	</tr>
	
	<tr>
		<td>檢舉原因:<font color=red><b>*</b></font></td>
		<td><%=productReportVO.getProd_report_reason()%></td>
	</tr>
	
	<tr>
		<td>檢舉時間:<font color=red><b>*</b></font></td>
		<td><%=productReportVO.getProd_report_time()%></td>
	</tr>
	
	<tr>
		<td>檢舉狀態:</td>
		<td>
			<select size="1" name="prod_report_status">
	          		<option value="1" ${(productReportVO.prod_report_status==1)?'selected':''}>未處理
	       			<option value="2" ${(productReportVO.prod_report_status==2)?'selected':''}>已處理
	        </select>
	     </td>
	</tr>
</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="prod_report_product_id" value="<%=productReportVO.getProd_report_product_id()%>">
<input type="hidden" name="prod_report_mem_id" value="<%=productReportVO.getProd_report_mem_id()%>">
<input type="hidden" name="prod_report_reason" value="<%=productReportVO.getProd_report_reason()%>">
<input type="hidden" name="prod_report_time" value="<%=productReportVO.getProd_report_time()%>">
<input type="submit" value="送出修改"></FORM>
</body>
</html>