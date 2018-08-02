<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ord.model.*"%>


<%
	OrdVO  ordVO = (OrdVO) request.getAttribute("ordVO"); // OrdServlet.java (Concroller) 存入req的ordVO物件 (包括幫忙取出的ordVO, 也包括輸入資料錯誤時的ordVO物件)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>訂單修改 - update_ord_input.jsp</title>

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
		 <h3>訂單修改 - update_ord_input.jsp</h3>
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

<FORM METHOD="post" ACTION="ord.do" name="form1">
<table>
	<tr>
		<td>訂單編號:<font color=red><b>*</b></font></td>
		<td><%=ordVO.getOrder_id()%></td>
	</tr>
	
	<tr>
		<td>買家會員編號:<font color=red><b>*</b></font></td>
		<td><%=ordVO.getBuyer_mem_id()%></td>
		
	</tr>
	
	<tr>
		<td>賣家會員編號:<font color=red><b>*</b></font></td>
		<td><%=ordVO.getSeller_mem_id()%></td>
		
	</tr>
	<tr>
		<td>訂單地址:<font color=red><b>*</b></font></td>
		<td><%=ordVO.getOrder_address()%></td>
		
	</tr>
	
	<tr>
		<td>付款狀態:</td>
		<td>
			<select size="1" name="payment_status">
	          		<option value="1" ${(ordVO.payment_status==1)?'selected':''}>待付款
	       			<option value="2" ${(ordVO.payment_status==2)?'selected':''}>已付款(TM)
	       			<option value="3" ${(ordVO.payment_status==3)?'selected':''}>已付款(Seller)
	       			<option value="4" ${(ordVO.payment_status==4)?'selected':''}>退款
	        </select>
	    </td>
	</tr>
	<tr>   
	    <td>付款方式:<font color=red><b>*</b></font></td>
		<td><%=ordVO.getPayment_method()%></td>	
	</tr>
		
	<tr>
		<td>訂單物流狀態:</td>
		<td>
			<select size="1" name="shipment_status">
	          		<option value="1" ${(ordVO.shipment_status==1)?'selected':''}>待出貨
	       			<option value="2" ${(ordVO.shipment_status==2)?'selected':''}>已出貨
	       			<option value="3" ${(ordVO.shipment_status==3)?'selected':''}>已到貨
	       </select>
	     </td>
	</tr>
		
	<tr>
		<td>訂單日期:<font color=red><b>*</b></font></td>
		<td><%=ordVO.getOrder_date()%></td>
	</tr>
	
	<tr>
		<td>訂單狀態:</td>
		<td>
			<select size="1" name="order_status">
	          		<option value="1" ${(ordVO.order_status==1)?'selected':''}>待出貨
	       			<option value="2" ${(ordVO.order_status==2)?'selected':''}>待收貨
	       			<option value="3" ${(ordVO.order_status==3)?'selected':''}>已取貨
	       			<option value="4" ${(ordVO.order_status==4)?'selected':''}>已完成
	       			<option value="5" ${(ordVO.order_status==5)?'selected':''}>取消
	        </select>
	     </td>
	</tr>
	<tr>
		<td>訂單金額:<font color=red><b>*</b></font></td>
		<td><%=ordVO.getOrder_total()%></td>
	</tr>
	
	<tr>
		<td>訂單項目:<font color=red><b>*</b></font></td>
		<td><%=ordVO.getOrder_item()%></td>
	</tr>
	
	<tr>
		<td>取消訂單原因:</td>
		<td>
			<select size="1" name="cancel_reason">
					<option value="null" ${(ordVO.cancel_reason==null)?'selected':''}>N.A
	          		<option value="11" ${(ordVO.cancel_reason==11)?'selected':''}>賣家不回應
	       			<option value="12" ${(ordVO.cancel_reason==12)?'selected':''}>賣家要求取消訂單
	       			<option value="13" ${(ordVO.cancel_reason==13)?'selected':''}>修改訂單內容(地址，姓名，電話等等)
	       			<option value="14" ${(ordVO.cancel_reason==14)?'selected':''}>賣家出貨速度太慢
	       			<option value="15" ${(ordVO.cancel_reason==15)?'selected':''}>對賣家行為有疑慮(例如要求私下交易)
	       			<option value="16" ${(ordVO.cancel_reason==16)?'selected':''}>其他(例如 不想買了)
	       			<option value="21" ${(ordVO.cancel_reason==21)?'selected':''}>買家要求取消
	       			<option value="22" ${(ordVO.cancel_reason==22)?'selected':''}>缺貨
	       			<option value="23" ${(ordVO.cancel_reason==23)?'selected':''}>收件地址不在運送範圍內
	       			<option value="24" ${(ordVO.cancel_reason==24)?'selected':''}>其他(例如 不想賣了)
	        </select>
	     </td>
	</tr>
	
	<tr>
	<td>賣家給買家評價星等:</td>
		<td>
		<select size="1" name="stob_rating">
					<option value="null" ${(ordVO.stob_rating==1)?'selected':''}>N.A
	          		<option value="1" ${(ordVO.stob_rating==1)?'selected':''}>1
	       			<option value="2" ${(ordVO.stob_rating==2)?'selected':''}>2
	       			<option value="3" ${(ordVO.stob_rating==3)?'selected':''}>3
	       			<option value="4" ${(ordVO.stob_rating==4)?'selected':''}>4
	       			<option value="5" ${(ordVO.stob_rating==5)?'selected':''}>5
	     </select>
	     </td>
	</tr>
	
	<tr>
		<td>賣家給買家評價內容:</td>
		<td><input type="TEXT" name="stob_rating_descr" size="30" value="<%=ordVO.getStob_rating_descr()%>" /></td>
	</tr>
	
	<tr>
		<td>買家給賣家評價星等:</td>
		<td>
			<select size="1" name="btos_rating">
	          		<option value="1" ${(ordVO.btos_rating==1)?'selected':''}>1
	       			<option value="2" ${(ordVO.btos_rating==2)?'selected':''}>2
	       			<option value="3" ${(ordVO.btos_rating==3)?'selected':''}>3
	       			<option value="4" ${(ordVO.btos_rating==4)?'selected':''}>4
	       			<option value="5" ${(ordVO.btos_rating==5)?'selected':''}>5
	    	</select>
		</td>
	</tr>
	
	<tr>
		<td>買家給賣家評價內容:</td>
		<td><input type="TEXT" name="btos_rating_descr" size="30" value="<%=ordVO.getBtos_rating_descr()%>" /></td>
	</tr>
	
	<tr>
		<td>寄件編號:</td>
		<td><input type="TEXT" name="shipment_id" size="30" value="<%=ordVO.getShipment_id()%>" /></td>
	</tr>
	
	<tr>
		<td>收貨方式:<font color=red><b>*</b></font></td>
		<td><%=ordVO.getShipment_method()%></td>
	</tr>
	
	<tr>
		<td>711店名:<font color=red><b>*</b></font></td>
		<td><%=ordVO.getOrd_store_711_name()%></td>
	</tr>
	

</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="order_id" value="<%=ordVO.getOrder_id()%>">
<input type="hidden" name="buyer_mem_id" value="<%=ordVO.getBuyer_mem_id()%>">
<input type="hidden" name="seller_mem_id" value="<%=ordVO.getSeller_mem_id()%>">
<input type="hidden" name="order_address" value="<%=ordVO.getOrder_address()%>">
<input type="hidden" name="payment_method" value="<%=ordVO.getPayment_method()%>">
<input type="hidden" name="order_date" value="<%=ordVO.getOrder_date()%>">
<input type="hidden" name="order_total" value="<%=ordVO.getOrder_total()%>">
<input type="hidden" name="order_item" value="<%=ordVO.getOrder_item()%>">
<input type="hidden" name="shipment_method" value="<%=ordVO.getShipment_method()%>">
<input type="hidden" name="ord_store_711_name" value="<%=ordVO.getOrd_store_711_name()%>">
<input type="submit" value="送出修改"></FORM>

</body>
</html>