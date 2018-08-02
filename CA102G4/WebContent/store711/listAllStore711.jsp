<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.store711.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	Store711Service store711Svc = new Store711Service();
    List<Store711VO> list = store711Svc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有711資料 - listAllStore711.jsp</title>

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
		 <h3>所有711資料 - listAllStore711.jsp</h3>
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
		<th>711店號</th>
		<th>711行政區編號</th>
		<th>711店名</th>
		<th>711地址</th>
		<th>711城市名稱</th>
		<th>711行政區名稱</th>
	
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="store711VO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${store711VO.store_711_id}</td>
			<td>${store711VO.store_711_dist_id}</td>
			<td>${store711VO.store_711_name}</td>
			<td>${store711VO.store_711_addr}</td>
			<td>${store711VO.store_711_city_name}</td>
			<td>${store711VO.store_711_dist_name}</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>