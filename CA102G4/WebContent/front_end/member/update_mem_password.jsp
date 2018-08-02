<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.mem.model.*"%>

<%

//MemberServlet.java (Concroller) 存入req的memberVO物件 
//(包括幫忙取出的memberVO, 也包括輸入資料錯誤時的memberVO物件)	

 	boolean login_state = false;
 	Object login_state_temp = session.getAttribute("login_state");
 	if(login_state_temp!=null){
 		login_state=(boolean)login_state_temp;
 	}
 	
 	if(login_state!=true){
 		response.sendRedirect("/CA102G4/front_end/member/mem_login.jsp");
 		return;
 	}
 	
	MemberVO memberVO = (MemberVO) request.getAttribute("memberVO"); 


// String arti_no = request.getParameter("arti_no");
// ArticleDAO dao = new ArticleDAO();
// ArticleVO articleVO = dao.findByPrimaryKey(arti_no);
// pageContext.setAttribute("articleVO", articleVO);

%>
<!DOCTYPE html>
<html>

<head>

<title>Travle Maker</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="TravleMaker,travlemaker,自助旅行,登入畫面" />
<!-- jQuery&ajax -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- Bootstrap -->
<link href="<%=request.getContextPath()%>/front_end/css/all/index_bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<script src="<%=request.getContextPath()%>/front_end/js/all/index_bootstrap.js"></script>
<!-- modernizr -->
<script src="<%=request.getContextPath()%>/front_end/js/member/modernizr-2.6.2.min.js"></script>
<!--自定義的dropdown.js-->
<script src="<%=request.getContextPath()%>/front_end/js/member/dropdown.js"></script>
<!--  生日js  -->
<script src="<%=request.getContextPath()%>/front_end/js/member/birthday.js"></script>

<!-- font字體 -->
<link href='https://fonts.googleapis.com/css?family=Oswald:400,700,300'
	rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Pacifico'
	rel='stylesheet' type='text/css'>
<!-- font字體 -->
<!--  css  -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/front_end/css/member/blog_semantic.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/front_end/css/member/google_icon.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/front_end/css/member/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/front_end/css/member/animate.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/front_end/css/member/login_style.css" type="text/css" media="all" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/front_end/css/member/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/front_end/css/member/login.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/front_end/css/member/modal.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/front_end/css/member/mem_page_v1.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
<!-- <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> -->
<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->

<!--  css  -->
<style>

#update_password_btn{

margin-top: 50px;
    float: left;

}
    
</style>

</head>

<body>

	<!-- banner -->
	<div class="banner about-bg">
		<div class="top-banner about-top-banner">
			<div class="container">
				<div class="top-banner-left">
					<ul>
						<li><i class="fa fa-phone" aria-hidden="true"></i> <a
							href="tel:034257387"> 03-4257387</a></li>
						<li><a href="mailto:TravleMaker@gmail.com"><i
								class="fa fa-envelope" aria-hidden="true"></i>
								TravleMaker@gmail.com</a></li>
					</ul>
				</div>
				<div class="top-banner-right">
					<ul>
						<li><a class="top_banner" href="#"><i class="fa fa-user"
								aria-hidden="true"></i></a></li>
						<li><a class="top_banner" href="#"><i
								class="fa fa-shopping-cart" aria-hidden="true"></i></a></li>
						<li><a class="top_banner" href="#"><i
								class="fa fa-envelope" aria-hidden="true"></i></a></li>
					</ul>
				</div>
				<div class="clearfix"></div>
			</div>
		</div>
		<div class="header">
			<div class="container">
				<div class="logo">
					<h1>
						<a href="index.html">Travle Maker</a>
					</h1>
				</div>
				<div class="top-nav">
					<!-- 當網頁寬度太小時，導覽列會縮成一個按鈕 -->
					<nav class="navbar navbar-default">
						<button type="button" class="navbar-toggle collapsed"
							data-toggle="collapse"
							data-target="#bs-example-navbar-collapse-1">Menu</button>
						<!-- //當網頁寬度太小時，導覽列會縮成一個按鈕 -->
						<!-- Collect the nav links, forms, and other content for toggling -->
						<div class="collapse navbar-collapse"
							id="bs-example-navbar-collapse-1">
							<ul class="nav navbar-nav">
								<li><a href="news.html">最新消息</a></li>
								<li><a href="tour.html">景點介紹</a></li>
								<li><a href="plan.html">行程規劃</a></li>
								<li><a href="blog.html">旅遊記</a></li>
								<li><a href="ask.html">問答區</a></li>
								<li><a href="galley.html">照片牆</a></li>
								<li><a href="chat.html">聊天室</a></li>
								<li><a href="together.html">揪團</a></li>
								<li><a href="buy.html">交易平台</a></li>
								<li><a href="advertisement.html">專欄</a></li>
								<div class="clearfix"></div>
							</ul>
						</div>
					</nav>
				</div>
				<div class="clearfix"></div>
			</div>
		</div>


		<!-- //banner -->


		<!-- Sidebar  -->

		<div class="sidebar_menu">
			<div class="has_children">
				<li class="fas fa-user">&nbsp;我的帳戶</li> <a id="dropdown_item"
					href="#">個人檔案</a> 
					
					<a id="dropdown_item" href="/CA102G4/front_end/member/update_mem_password.jsp">更改密碼</a>
					
					<a id="dropdown_item" href="#">地址</a>

			</div>
			<div class="has_children">
				<li class="fas fa-coins">&nbsp;我的購買</li> <a id="dropdown_item"
					href="#">管理購買清單</a> <a id="dropdown_item" href="#">管理我的銷售</a>

			</div>

			<div class="has_children">
				<li class="fas fa-exclamation-circle">&nbsp;我的通知</li> <a
					id="dropdown_item" href="#">test</a>
			</div>

			<!--
            <div class="has_children">
                <li class="far fa-calendar-alt">&nbsp;我的行程</li>

                <a id="dropdown_item" href="#">瀏覽我的自助行程</a>
                <a id="dropdown_item" href="#">瀏覽我收藏的行程</a>

            </div>
-->

			<!--
            <div class="has_children">
                <li class="fas fa-users">&nbsp;我的揪團</li>

                <a id="dropdown_item" href="#">管理我發起的揪團</a>
                <a id="dropdown_item" href="#">管理我參加的揪團</a>

            </div>
-->

			<!--
            <div class="has_children">
                <li class="fas fa-user-friends">&nbsp;我的好友</li>

                <a id="dropdown_item" href="#">新增好友</a>
                <a id="dropdown_item" href="#">瀏覽好友清單</a>
                <a id="dropdown_item" href="#">瀏覽黑名單</a>

            </div>
-->

			<!--
            <div class="has_children">
                <li class="fas fa-question-circle">&nbsp;我的問答</li>

                <a id="dropdown_item" href="#">我發表的討論</a>
                <a id="dropdown_item" href="#">我參與的討論</a>
                <a id="dropdown_item" href="#">我收藏的討論</a>

            </div>
-->

			<!--
            <div class="has_children">
                <li class="fas fa-book-open">&nbsp;我的旅遊記</li>

                <a id="dropdown_item" href="#">發表旅遊記</a>
                <a id="dropdown_item" href="#">刪除旅遊記</a>
                <a id="dropdown_item" href="#">收藏旅遊網誌</a>
                <a id="dropdown_item" href="#">影片牆</a>
            </div>
-->

			<!--
            <div class="has_children">
                <li class="fas fa-comments">&nbsp;我的聊天室</li>

                <a id="dropdown_item" href="#">test</a>

            </div>
-->

</div>

<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
<form method="POST" action="/CA102G4/front_end/member/member.do" enctype="multipart/form-data">
		<div class="item_context">
			<div class="my_account_selet_header">
				<div class="my_account_selet_header_title">我的檔案</div>
				<div class="my_account_selet_header_title_subtitle">管理你的檔案以保護你的帳戶</div>
				<hr class="hr_setting_left">
				<div class="my_account_profile">
				
					<div class="my_account_profile_left">
						<table border="0">
						<tr>
							<td>會　員　帳　號&nbsp;&nbsp;：</td>
							<td>${memberVO.mem_Account}</td>
						</tr>	
						<tr>
							<td>會員密碼(確認用)：</td>
							<td>${memberVO.mem_Password}</td>
						</tr>
						
						</table>
						<br>
						<br>
						<label style="color:#272727;">請輸入 欲修改新密碼：</label>
							
							<input class="stardust-input_element_my-account_full-input" style="font-color:black ;background-color:white;"
								type="password" name="mem_Password" VALUE="">
						<br>
						<br>
						<label style="color:#272727;">請再輸入一次 新密碼：</label>
							
							<input class="stardust-input_element_my-account_full-input" style="font-color:black ;background-color:white;"
								type="password" name="mem_Password" VALUE="" >
							
							<input type="hidden" name="mem_Account" value="${memberVO.mem_Account}">
							<input type="hidden" name="action" value="UPDATE_PASSWORD">
							<br>
							<input type="submit" value="更新密碼" class="btn btn-primary" id="update_password_btn">
						
						</div>
							
					</div>
				</div>
			</div>
				
</form>					
					
			</div>


	<div class="footer">
		<div class="container">
			<div class="footer-grids">
				<div class="col-md-3 footer-grid">
					<div class="footer-grid-heading">
						<h4>關於我們</h4>
					</div>
					<div class="footer-grid-info">
						<ul>
							<li><a href="about.html">關於Travle Maker</a></li>
							<li><a href="about.html">聯絡我們</a></li>
							<li><a href="about.html">常見問題</a></li>
						</ul>
					</div>
				</div>
				<div class="col-md-3 footer-grid">
					<div class="footer-grid-heading">
						<h4>網站條款</h4>
					</div>
					<div class="footer-grid-info">
						<ul>
							<li><a href="about.html">服務條款</a></li>
							<li><a href="services.html">隱私權條款</a></li>
						</ul>
					</div>
				</div>
				<div class="col-md-3 footer-grid">
					<div class="footer-grid-heading">
						<h4>社群</h4>
					</div>
					<div class="social">
						<ul>
							<li><a href="https://www.facebook.com/InstaBuy.tw/"><i
									class="fab fa-facebook"></i></a></li>
							<li><a href="https://www.instagram.com/"><i
									class="fab fa-instagram"></i></a></li>
							<li><a href="#"><i class="fab fa-line"></i></a></li>
						</ul>
					</div>
				</div>
				<div class="col-md-3 footer-grid">
					<div class="footer-grid-heading">
						<h4>訂閱電子報</h4>
					</div>
					<div class="footer-grid-info">
						<form action="#" method="post">
							<input type="email" id="mc4wp_email" name="EMAIL"
								placeholder="請輸入您的Email" required=""> <input
								type="submit" value="訂閱">
						</form>
					</div>
				</div>
				<div class="clearfix"></div>
			</div>
			<div class="copyright">
				<p>
					Copyright &copy; 2018 All rights reserved <a href="index.html"
						target="_blank" title="TravleMaker">TravleMaker</a>
				</p>
			</div>
		</div>
	</div>
	

</body>

</html>
