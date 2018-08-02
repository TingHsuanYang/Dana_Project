<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.product.model.*"%>
<%@ page import="java.sql.Date"%>
<%
    ProductVO  productVO = ( ProductVO) request.getAttribute("productVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>商品新增 - addProduct.jsp</title>

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
		 <h3>商品新增 - addProduct.jsp</h3></td><td>
		 <h4><a href="select_page.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料新增:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front_end/store/product.do" name="form1" enctype="multipart/form-data">
<table>
	<jsp:useBean id="productCategorySvc" scope="page" class="com.productCategory.model.ProductCategoryService" />
	<tr>
		<td>商品類別編號:<font color=red><b>*</b></font></td>
		<td>
			<select size="1" name="product_category_id">
	         	<c:forEach var="productCategoryVO" items="${productCategorySvc.all}" > 
	          		<option value="${productCategoryVO.product_category_id}" ${(productVO.product_category_id==productCategoryVO.product_category_id)?'selected':''}>${productCategoryVO.product_category_name}
	         	</c:forEach>   
	        </select>
       </td>
	</tr>
	
	<tr>
		<td>商品賣家編號:</td>
		<td><input type="TEXT" name="product_mem_id" size="30" value="<%=(productVO==null)? "M000003" :productVO.getProduct_mem_id()%>" /></td>
		
	</tr>
	
	<tr>
		<td>商品名稱:</td>
		<td><input type="TEXT" name="product_name" size="30" value="<%=(productVO==null)? "環球一日券" :productVO.getProduct_name()%>" /></td>
	</tr>
	
	<tr>
		<td>商品價格:</td>
		<td><input type="TEXT" name="product_price" size="30" value="<%=(productVO==null)? 600 :productVO.getProduct_price()%>" /></td>
	</tr>
	
	<tr>
		<td>商品描述:</td>
		<td><input type="TEXT" name="product_descr" size="30" value="<%=(productVO==null)? "請填寫商品描述" :productVO.getProduct_descr()%>" /></td>
	</tr>
	
	<tr>
		<td>商品庫存:</td>
		<td><input type="TEXT" name="product_stock" size="10" value="<%=(productVO==null)? 1:productVO.getProduct_stock()%>" /></td>
	</tr>

	<tr>
		<td>商品狀態:</td>
		<td>
			<select size="1" name="product_status">
	          		<option value="1" ${(productVO.product_status==1)?'selected':''}>上架
	        </select>
	     </td>
	</tr>

	<tr>
		<td>商品上架時間:</td>
		<td><input type="TEXT" id="f_date1" name="product_date"/></td>
	</tr>

	<tr>
		<td>商品照片1:</td>
		<td><input type="FILE" id="product_photo_1" name="product_photo_1" value="<%=(productVO==null)? null:productVO.getProduct_photo_1_base()%>" /></td>
		<c:set var="imgData1" scope="page" value="${productVO.product_photo_1_base}"/>
		<td><c:if test="${not empty imgData1}"> <img id="preview-product_photo_1" src="data:image/jpeg;base64,${imgData1}" height="60" width="75" class="img-thumbnail"/></c:if><c:if test="${empty imgData1}"><img id="preview-product_photo_1" src="images/no-image-icon-15.png" height="60" width="75" class="img-thumbnail"/></c:if></td>
	</tr>
	
	<tr>
		<td>商品照片2:</td>
		<td><input type="FILE" id="product_photo_2" name="product_photo_2" value="<%=(productVO==null)? null:productVO.getProduct_photo_2_base()%>" /></td>
		<c:set var="imgData2" scope="page" value="${productVO.product_photo_2_base}"/>
		<td><c:if test="${not empty imgData2}"> <img id="preview-product_photo_2" src="data:image/jpeg;base64,${imgData2}" height="60" width="75" class="img-thumbnail"/></c:if><c:if test="${empty imgData2}"><img id="preview-product_photo_2" src="images/no-image-icon-15.png" height="60" width="75" class="img-thumbnail"/></c:if></td>
	</tr>
	
		<tr>
		<td>商品照片3:</td>
		<td><input type="FILE" id="product_photo_3" name="product_photo_3" value="<%=(productVO==null)? null:productVO.getProduct_photo_3_base()%>" /></td>
		<c:set var="imgData3" scope="page" value="${productVO.product_photo_3_base}"/>
		<td><c:if test="${not empty imgData3}"> <img id="preview-product_photo_3" src="data:image/jpeg;base64,${imgData3}" height="60" width="75" class="img-thumbnail"/></c:if><c:if test="${empty imgData3}"><img id="preview-product_photo_3" src="images/no-image-icon-15.png" height="60" width="75" class="img-thumbnail"/></c:if></td>
	</tr>
	
		<tr>
		<td>商品照片4:</td>
		<td><input type="FILE" id="product_photo_4" name="product_photo_4"  /></td>
		
		<c:set var="imgData4" scope="page" value="${productVO.product_photo_4_base}"/>
		<td><c:if test="${not empty imgData4}"> <img id="preview-product_photo_4" src="data:image/jpeg;base64,${imgData4}" height="60" width="75" class="img-thumbnail"/></c:if><c:if test="${empty imgData4}"><img id="preview-product_photo_4" src="images/no-image-icon-15.png" height="60" width="75" class="img-thumbnail"/></c:if></td>
	</tr>
	
	<tr>
		<td>商品照片5:</td>
		<td><input type="FILE" id="product_photo_5" name="product_photo_5" value="<%=(productVO==null)? null:productVO.getProduct_photo_5_base()%>" /></td>
		<c:set var="imgData5" scope="page" value="${productVO.product_photo_5_base}"/>
		<td><c:if test="${not empty imgData5}"> <img id="preview-product_photo_5" src="data:image/jpeg;base64,${imgData5}" height="60" width="75" class="img-thumbnail"/></c:if><c:if test="${empty imgData5}"><img id="preview-product_photo_5" src="images/no-image-icon-15.png" height="60" width="75" class="img-thumbnail"/></c:if></td>
	</tr>
</table>
<br>
<input type="hidden" name="product_photo_1_base" value="<%=(productVO==null)? null:productVO.getProduct_photo_1_base()%>" />
<input type="hidden" name="product_photo_2_base" value="<%=(productVO==null)? null:productVO.getProduct_photo_2_base()%>" />
<input type="hidden" name="product_photo_3_base" value="<%=(productVO==null)? null:productVO.getProduct_photo_3_base()%>" />
<input type="hidden" name="product_photo_4_base" value="<%=(productVO==null)? null:productVO.getProduct_photo_4_base()%>" />
<input type="hidden" name="product_photo_5_base" value="<%=(productVO==null)? null:productVO.getProduct_photo_5_base()%>" />
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script>
function readURL(input) {

	  if (input.files && input.files[0]) {
		    var reader = new FileReader();
		
		    reader.onload = function(e) {
		    	 imgId = '#preview-'+$(input).attr('id');
	             $(imgId).attr('src', e.target.result);
		    }
		
		    reader.readAsDataURL(input.files[0]);
	  }
}

$("input[type='file']").change(function() {
  readURL(this);
});

</script>

</body>

<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->


<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=(productVO==null)?new java.sql.Date(System.currentTimeMillis()):productVO.getProduct_date()%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        
        
   
        // ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

        //      1.以下為某一天之前的日期無法選擇
        //      var somedate1 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});

        
        //      2.以下為某一天之後的日期無法選擇
        //      var somedate2 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});


        //      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
        //      var somedate1 = new Date('2017-06-15');
        //      var somedate2 = new Date('2017-06-25');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //		             ||
        //		            date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});
        
</script>
</html>