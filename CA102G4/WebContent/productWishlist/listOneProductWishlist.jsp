<%@ page contentType="text/html; charset=Big5"%>
<%@ page import="com.productWishlist.model.*"%>
<%@ page import="sun.misc.BASE64Encoder"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- �����Ƚm�߱ĥ� Script ���g�k���� --%>

<%
	ProductWishlistVO  productWishlistVO = ( ProductWishlistVO) request.getAttribute("productWishlistVO"); //ProductWishlistServlet.java (Concroller), �s�Jreq��productWishlistVO����
%>

<html>
<head>
<title>���ðӫ~��� - listOneProductWishlist.jsp</title>

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
		 <h3>���ðӫ~��� - listOneProductWishlist.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>���ðӫ~�s��</th>
		<th>���÷|���s��</th>
		<th>���îɶ�</th>
	</tr>
	<tr>
		<td><%=productWishlistVO.getWishlist_product_id()%></td>
		<td><%=productWishlistVO.getWishlist_mem_id()%></td>
		<td><%=productWishlistVO.getProduct_wishlist_time()%></td>
	</tr>
</table>

</body>
</html>