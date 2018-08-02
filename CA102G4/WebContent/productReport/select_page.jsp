<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>CA102G4 ProductReport: Home</title>

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
   <tr><td><h3>CA102G4 ProductReport: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for CA102G4 ProductReport: Home</p>

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
  <li><a href='listAllProductReport.jsp'>List</a> all Products.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="productReport.do" >
        <b>��J�ӫ~�s�� (�p1001):</b>
        <input type="text" name="prod_report_product_id">
         <b>��J���|�|���s�� (�pM000001):</b>
        <input type="text" name="prod_report_mem_id">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="�e�X">
    </FORM>
  </li>

  <jsp:useBean id="productReportSvc" scope="page" class="com.productReport.model.ProductReportService" />
   
  <li>
     <FORM METHOD="post" ACTION="productReport.do" >
       <b>��ܰӫ~�s��:</b>
       <select size="1" name="prod_report_product_id">
         <c:forEach var="productReportVO" items="${productReportSvc.all}" > 
          <option value="${productReportVO.prod_report_product_id}">${productReportVO.prod_report_product_id}
         </c:forEach>   
       </select>
       <b>������|�|���s��:</b>
       <select size="1" name="prod_report_mem_id">
         <c:forEach var="productReportVO" items="${productReportSvc.all}" > 
          <option value="${productReportVO.prod_report_mem_id}">${productReportVO.prod_report_mem_id}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="�e�X">
    </FORM>
  </li>
</ul>


<h3>���|�ӫ~�޲z</h3>

<ul>
  <li><a href='addProductReport.jsp'>Add</a> a new ProductReport.</li>
</ul>

</body>
</html>