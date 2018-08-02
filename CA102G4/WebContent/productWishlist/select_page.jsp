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

<h3>資料查詢:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
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
        <b>輸入商品編號 (如1001):</b>
        <input type="text" name="wishlist_product_id">
         <b>輸入會員編號 (如M000001):</b>
        <input type="text" name="wishlist_mem_id">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="productWishlistSvc" scope="page" class="com.productWishlist.model.ProductWishlistService" />
   
  <li>
     <FORM METHOD="post" ACTION="productWishlist.do" >
       <b>選擇商品編號:</b>
       <select size="1" name="wishlist_product_id">
         <c:forEach var="productWishlistVO" items="${productWishlistSvc.all}" > 
          <option value="${productWishlistVO.wishlist_product_id}">${productWishlistVO.wishlist_product_id}
         </c:forEach>   
       </select>
       <b>選擇檢舉會員編號:</b>
       <select size="1" name="wishlist_mem_id">
         <c:forEach var="productWishlistVO" items="${productWishlistSvc.all}" > 
          <option value="${productWishlistVO.wishlist_mem_id}">${productWishlistVO.wishlist_mem_id}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
</ul>


<h3>檢舉商品管理</h3>

<ul>
  <li><a href='addProductWishlist.jsp'>Add</a> a new ProductWishlist.</li>
</ul>

</body>
</html>