<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>CA102G4 ProductWishlist: Home</title>

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
   <tr><td><h3>CA102G4 ProductWishlist: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for CA102G4 ProductWishlist: Home</p>

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
  <li><a href='listAllProductWishlist.jsp'>List</a> all ProductWishlist.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="productWishlist.do" >
        <b>��J�ӫ~�s�� (�p1001):</b>
        <input type="text" name="wishlist_product_id">
         <b>��J�|���s�� (�pM000001):</b>
        <input type="text" name="wishlist_mem_id">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="�e�X">
    </FORM>
  </li>

  <jsp:useBean id="productWishlistSvc" scope="page" class="com.productWishlist.model.ProductWishlistService" />
   
  <li>
     <FORM METHOD="post" ACTION="productWishlist.do" >
       <b>��ܰӫ~�s��:</b>
       <select size="1" name="wishlist_product_id">
         <c:forEach var="productWishlistVO" items="${productWishlistSvc.all}" > 
          <option value="${productWishlistVO.wishlist_product_id}">${productWishlistVO.wishlist_product_id}
         </c:forEach>   
       </select>
       <b>������|�|���s��:</b>
       <select size="1" name="wishlist_mem_id">
         <c:forEach var="productWishlistVO" items="${productWishlistSvc.all}" > 
          <option value="${productWishlistVO.wishlist_mem_id}">${productWishlistVO.wishlist_mem_id}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="�e�X">
    </FORM>
  </li>
</ul>


<h3>���|�ӫ~�޲z</h3>

<ul>
  <li><a href='addProductWishlist.jsp'>Add</a> a new ProductWishlist.</li>
</ul>

</body>
</html>