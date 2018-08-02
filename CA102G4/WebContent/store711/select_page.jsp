<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>CA102G4 Store711: Home</title>
<script type="text/javascript" src="js/jquery-1.12.4.min.js"></script>

<script type="text/javascript">
function city_change()
{
    var city = $(".city").val();
 
    $.ajax({
        type: "POST",
        url: "dist.jsp",
        data: "store_711_city_id="+city,
        cache: false,
        success: function(response)
        {
            $(".dist").html(response);
        }
    });
}
function dist_change()
{
    var dist = $(".dist").val();
 
    $.ajax({
        type: "POST",
        url: "store.jsp",
        data: "store_711_dist_id="+dist,
        cache: false,
        success: function(response)
        {
            $(".store").html(response);
        }
    });
}
</script>
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
  
  label
	{
	font-weight:bold;
	padding:10px;
	}
	div
	{
	 margin-top:100px;
	}
	.city ,.dist{
	  width:100px;
	  height:35px;
	}
	.store{
	  width:300px;
	  height:35px;
	}
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>CA102G4 Store711: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for CA102G4 Store711: Home</p>

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
  <li><a href='listAllStore711.jsp'>List</a> all Store711.  <br><br></li>

  <jsp:useBean id="store711CitySvc" scope="page" class="com.store711City.model.Store711CityService" />

  <li>
      <div>
		 <label>市區 :</label>
		 <select size="1" name="store_711_city_id" class="city" onchange="city_change()">
		 	<option selected="selected">--選擇市區--</option>
	         <c:forEach var="store711CityVO" items="${store711CitySvc.all}" > 
	          	<option value="${store711CityVO.store_711_city_id}">${store711CityVO.store_711_city_name}
	         </c:forEach>   
      	 </select>
		 
		
		 <label>行政區 :</label> 
		  <select size="1" name="store_711_dist_id" class="dist" onchange="dist_change()">
		 	<option selected="selected">--選擇行政區--</option>
      	 </select>
		
		 <label>711地址 :</label> 
		 <select class="store" name="store_711_id">
		 <option selected="selected">--選擇711地址--</option>
		 </select>
		
		 </div>
  </li>
</ul>


</body>
</html>