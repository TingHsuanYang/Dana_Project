<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>CA102G4 OrderDetails: Home</title>

<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
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

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>CA102G4 OrderDetails: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for CA102G4 OrderDetails: Home</p>

<h3>��Ƭd��:</h3>
	
<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='listAllOrderDetails.jsp'>List</a> all OrderDetails.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="orderDetails.do" >
        <b>��J�q��s�� (�p20180724-000002):</b>
        <input type="text" name="details_order_id">
        <b>��J�ӫ~�s�� (�p1001):</b>
        <input type="text" name="details_product_id">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="�e�X">
    </FORM>
  </li>

  <jsp:useBean id="ordSvc" scope="page" class="com.ord.model.OrdService" />
  <jsp:useBean id="productSvc" scope="page" class="com.product.model.ProductService" />
  <li>
     <FORM METHOD="post" ACTION="ord.do" >
       <b>��ܭq��s��:</b>
       <select size="1" name="details_order_id">
         <c:forEach var="ordVO" items="${ordSvc.all}" > 
          <option value="${ordVO.order_id}">${ordVO.order_id}
         </c:forEach>   
       </select>
       <b>��ܰӫ~�s��:</b>
		<select size="1" name="details_product_id">
         	<c:forEach var="productVO" items="${productSvc.all}" > 
          		<option value="${productVO.product_id}">${productVO.product_id}
         	</c:forEach>   
        </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="�e�X">
    </FORM>
  </li>
</ul>


<h3>�q��޲z</h3>

<ul>
  <li><a href='addOrderDetails.jsp'>Add</a> a new OrderDetails.</li>
</ul>

</body>
</html>