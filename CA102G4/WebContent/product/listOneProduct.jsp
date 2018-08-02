<%@ page contentType="text/html; charset=Big5"%>
<%@ page import="com.product.model.*"%>
<%@ page import="sun.misc.BASE64Encoder"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- �����Ƚm�߱ĥ� Script ���g�k���� --%>

<%
	ProductVO  productVO = ( ProductVO) request.getAttribute("productVO"); //ProductServlet.java (Concroller), �s�Jreq��productVO����
%>

<html>
<head>
<title>�ӫ~��� - listOneProduct.jsp</title>

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
		 <h3>�ӫ~��� - listOneProduct.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>�ӫ~�s��</th>
		<th>�ӫ~���O�s��</th>
		<th>�ӫ~��a�s��</th>
		<th>�ӫ~�W��</th>
		<th>�ӫ~����</th>
		<th>�ӫ~�y�z</th>
		<th>�ӫ~�w�s</th>
		<th>�ӫ~���A</th>
		<th>�ӫ~�W�[�ɶ�</th>
		<th>�ӫ~�Ӥ�1</th>
		<th>�ӫ~�Ӥ�2</th>
		<th>�ӫ~�Ӥ�3</th>
		<th>�ӫ~�Ӥ�4</th>
		<th>�ӫ~�Ӥ�5</th>
		
	</tr>
	<tr>
		<td><%=productVO.getProduct_id()%></td>
		<td><%=productVO.getProduct_category_id()%></td>
		<td><%=productVO.getProduct_mem_id()%></td>
		<td><%=productVO.getProduct_name()%></td>
		<td><%=productVO.getProduct_price()%></td>
		<td><%=productVO.getProduct_descr()%></td>
		<td><%=productVO.getProduct_stock()%></td>
		<td><%=productVO.getProduct_status()%></td>
		<td><%=productVO.getProduct_date()%></td>
		<%  byte[] imgData1 = productVO.getProduct_photo_1();
			byte[] imgData2 = productVO.getProduct_photo_2();
			byte[] imgData3 = productVO.getProduct_photo_3();
			byte[] imgData4 = productVO.getProduct_photo_4();
			byte[] imgData5 = productVO.getProduct_photo_5();
			request.setAttribute("imgData1",imgData1);
			request.setAttribute("imgData2",imgData2);
			request.setAttribute("imgData3",imgData3);
			request.setAttribute("imgData4",imgData4);
			request.setAttribute("imgData5",imgData5);
		   BASE64Encoder base64Encoder = new BASE64Encoder(); %>
		
		<td><c:if test="${not empty imgData1}"><img src="data:image/jpeg;base64,<%=base64Encoder.encode(imgData1)%>" height="60" width="75" class="img-thumbnail"/></c:if><c:if test="${empty imgData1}"><img id="preview-product_photo_1" src="images/no-image-icon-15.png" height="60" width="75" class="img-thumbnail"/></c:if></td>
	
		<td><c:if test="${not empty imgData2}"><img src="data:image/jpeg;base64,<%=base64Encoder.encode(imgData2)%>" height="60" width="75" class="img-thumbnail"/></c:if><c:if test="${empty imgData2}"><img id="preview-product_photo_2" src="images/no-image-icon-15.png" height="60" width="75" class="img-thumbnail"/></c:if></td>
		
		<td><c:if test="${not empty imgData3}"><img src="data:image/jpeg;base64,<%=base64Encoder.encode(imgData3)%>" height="60" width="75" class="img-thumbnail"/></c:if><c:if test="${empty imgData3}"><img id="preview-product_photo_3" src="images/no-image-icon-15.png" height="60" width="75" class="img-thumbnail"/></c:if></td>		
		<td><c:if test="${not empty imgData4}"><img src="data:image/jpeg;base64,<%=base64Encoder.encode(imgData4)%>" height="60" width="75" class="img-thumbnail"/></c:if><c:if test="${empty imgData4}"><img id="preview-product_photo_4" src="images/no-image-icon-15.png" height="60" width="75" class="img-thumbnail"/></c:if></td>	
		<td><c:if test="${not empty imgData5}"><img src="data:image/jpeg;base64,<%=base64Encoder.encode(imgData5)%>" height="60" width="75" class="img-thumbnail"/></c:if><c:if test="${empty imgData5}"><img id="preview-product_photo_5" src="images/no-image-icon-15.png" height="60" width="75" class="img-thumbnail"/></c:if></td>
	
	</tr>
</table>

</body>
</html>