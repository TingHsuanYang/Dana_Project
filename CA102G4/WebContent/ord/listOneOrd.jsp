<%@ page contentType="text/html; charset=Big5"%>
<%@ page import="com.ord.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- �����Ƚm�߱ĥ� Script ���g�k���� --%>

<%
	OrdVO  ordVO = (OrdVO) request.getAttribute("ordVO"); //OrdServlet.java (Concroller), �s�Jreq��ordVO����
%>

<html>
<head>
<title>�q���� - listOneOrd.jsp</title>

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

<h4>�����Ƚm�߱ĥ� Script ���g�k����:</h4>
<table id="table-1">
	<tr><td>
		 <h3>�q���� - listOneOrd.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>�q��s��</th>
		<th>�R�a�|���s��</th>
		<th>��a�|���s��</th>
		<th>�q��a�}</th>
		<th>�I�ڪ��A</th>
		<th>�I�ڤ覡</th>
		<th>�q�檫�y���A</th>
		<th>�q����</th>
		<th>�q�檬�A</th>
		<th>�q����B</th>
		<th>�q�涵��</th>
		<th>�����q���]</th>
		<th>��a���R�a�����P��</th>
		<th>��a���R�a�������e</th>
		<th>�R�a����a�����P��</th>
		<th>�R�a����a�������e</th>
		<th>�H��s��</th>
		<th>���f�覡</th>
		<th>711���W</th>
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