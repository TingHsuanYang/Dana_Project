<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.product.model.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.shopping.model.*"%>

<%
		//確認登錄狀態
		MemberVO memberVO = (MemberVO) request.getAttribute("memberVO"); 
		if(memberVO == null){
			memberVO = (MemberVO)session.getAttribute("memberVO");
		}
		
		boolean login_state = false;   
			Object login_state_temp = session.getAttribute("login_state");
			if(login_state_temp!=null){
			login_state=(boolean)login_state_temp;
			} 
		
			if(login_state!=true){
			session.setAttribute("location", request.getRequestURI());
		 	response.sendRedirect("/CA102G4/front_end/member/mem_login.jsp");
		 	return;
		 }

	//若登入狀態為是true
	/***************取出登入者會員資訊******************/
	if (login_state == true) {
		String memId = ((MemberVO) session.getAttribute("memberVO")).getMem_Id();
		pageContext.setAttribute("memId", memId);
		pageContext.setAttribute("memberVO", memberVO);
		
	}
	//若登入狀態為不是true，紀錄當前頁面並重導到登入畫面。
		if( login_state != true){
			session.setAttribute("location", request.getRequestURI());
			response.sendRedirect(request.getContextPath()+"/front_end/member/mem_login.jsp");
			return;
		}
	//為了join(寫法有servlet3.0限制)
	MemberService memSvc = new MemberService();
	pageContext.setAttribute("memSvc", memSvc);

	ProductService productSvc = new ProductService();
	pageContext.setAttribute("productSvc", productSvc);
	
	//取得購物車商品數量
	Object total_items_temp = session.getAttribute("total_items");
	int total_items = 0;
	if(total_items_temp != null ){
		total_items= (Integer) total_items_temp;
	}
	pageContext.setAttribute("total_items",total_items);
	
%>
<%@ page import="com.fri.model.*" %>
<%@ page import="com.chat.model.*" %>
<jsp:useBean id="chatRoomSvc" scope="page" class="com.chat.model.ChatRoomService"></jsp:useBean>
<jsp:useBean id="chatRoomJoinSvc" scope="page" class="com.chat.model.ChatRoom_JoinService"></jsp:useBean>
<jsp:useBean id="memberSvc" scope="page" class="com.mem.model.MemberService"></jsp:useBean>
<%

	//*****************聊天用：取得登錄者所參與的群組聊天*************/
	List<ChatRoom_JoinVO> myCRList =chatRoomJoinSvc.getMyChatRoom(memberVO.getMem_Id());
	Set<ChatRoom_JoinVO> myCRGroup = new HashSet<>(); //裝著我參與的聊天對話為群組聊天時
	
	for(ChatRoom_JoinVO myRoom : myCRList){
		//查詢我參與的那間聊天對話，初始人數是否大於2?? 因為這樣一定就是群組聊天
		int initJoinCount = chatRoomSvc.getOne_ByChatRoomID(myRoom.getChatRoom_ID()).getChatRoom_InitCNT();
		if(initJoinCount > 2){
			myCRGroup.add(myRoom);
		}
	}
	pageContext.setAttribute("myCRList", myCRGroup);
	
	/***************聊天用：取出會員的好友******************/
	FriendService friSvc = new FriendService();
	List<Friend> myFri = friSvc.findMyFri(memberVO.getMem_Id(),2); //互相為好友的狀態
	pageContext.setAttribute("myFri",myFri);
	
	/**************避免聊天-新增群組重新整理後重複提交********/
	session.setAttribute("addCR_token",new Date().getTime());


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- 網頁title -->
<title>Travel Maker</title>
<!-- //網頁title -->
<!-- 指定螢幕寬度為裝置寬度，畫面載入初始縮放比例 100% -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- //指定螢幕寬度為裝置寬度，畫面載入初始縮放比例 100% -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- 設定網頁keywords -->
<meta name="keywords" content="TravelMaker,Travelmaker,自助旅行" />
<!-- //設定網頁keywords -->
<!-- 隱藏iPhone Safari位址列的網頁 -->
<script type="application/x-javascript">
	
			addEventListener("load", function() {
				setTimeout(hideURLbar, 0);
			}, false);

			function hideURLbar() {
				window.scrollTo(0, 1);
			}
		
</script>
<!-- //隱藏iPhone Safari位址列的網頁 -->
<!-- JQUERY -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<!-- //JQUERY -->

<!-- bootstrap css、JS檔案 -->
<link
	href="<%=request.getContextPath()%>/front_end/css/all/index_bootstrap.css"
	rel="stylesheet" type="text/css" media="all" />
<!-- //bootstrap JS檔案 往後放 -->
<!-- //bootstrap-css -->

<!-- 套首頁herder和footer css -->
<link
	href="<%=request.getContextPath()%>/front_end/css/all/index_style_header_footer.css"
	rel="stylesheet" type="text/css" media="all" />
<!-- //套首頁herder和footer css -->

<!-- font-awesome icons -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.0.13/css/all.css"
	integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp"
	crossorigin="anonymous">
<!-- //font-awesome icons -->

<!-- font字體 -->
<link href='https://fonts.googleapis.com/css?family=Oswald:400,700,300'
	rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Pacifico'
	rel='stylesheet' type='text/css'>
<!-- //font字體 -->

<!--store 自定義的css -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/css/store/store_step.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/css/store/util.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/css/store/main.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/css/store/store_checkout.css">	
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/css/store/store_header.css"
	media="all" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/css/store/store_footer.css"
	media="all" />
<link rel="stylesheet" type="text/css"
href="<%=request.getContextPath()%>/front_end/css/store/store_cart.css"
media="all" />

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/css/store/store_checkout2.css">	

<!-- //store 自定義的css -->


<!-- store 自定義的js -->

<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<!-- //store 自定義的js -->

	<!-- 聊天相關CSS及JS -->
    <link href="<%=request.getContextPath()%>/front_end/css/chat/chat_style.css" rel="stylesheet" type="text/css">
    <script src="<%=request.getContextPath()%>/front_end/js/chat/vjUI_fileUpload.js"></script>
    <script src="<%=request.getContextPath()%>/front_end/js/chat/chat.js"></script>
    <%@ include file="/front_end/personal_area/chatModal_JS.file" %>
    <!-- //聊天相關CSS及JS -->

</head>


<body>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs_Ailee}">
		<div class="modal fade" id="errorModal_Ailee">
		    <div class="modal-dialog modal-sm" role="dialog">
		      <div class="modal-content">
		        <div class="modal-header">
		          <i class="fas fa-exclamation-triangle"></i>
		          <span class="modal-title"><h4>請修正以下錯誤:</h4></span>
		        </div>
		        <div class="modal-body">
					<c:forEach var="message" items="${errorMsgs_Ailee}">
						<li style="color:red" type="square">${message}</li>
					</c:forEach>
		        </div>
		        <div class="modal-footer">
		          <button type="button" class="btn btn-default" data-dismiss="modal">關閉</button>
		        </div>
		      </div>
		    </div>
		 </div>
	</c:if>
	<%-- 錯誤表列 --%>


	<!-- banner -->
	<div class="banner about-bg" id="myHeader">
		<div class="top-banner about-top-banner">
			<div class="container">
				<div class="top-banner-left">
					<ul>
						<li><i class="fa fa-phone" aria-hidden="true"></i> <a
							href="tel:034257387"> 03-4257387</a></li>
						<li><a href="mailto:TravelMaker@gmail.com"><i
								class="fa fa-envelope" aria-hidden="true"></i>
								TravelMaker@gmail.com</a></li>
					</ul>
				</div>
				<div class="top-banner-right">
					<ul>				
						<li><a href="<%= request.getContextPath()%>/front_end/member/member.do?action=logout"><span class=" top_banner"><i class=" fas fa-sign-out-alt" aria-hidden="true"></i></span></a></li>
						<li><a class="top_banner" href="<%=request.getContextPath()%>/front_end/personal_area_home.html"><i class="fa fa-user" aria-hidden="true"></i></a></li>
						<li><a class="top_banner" href="<%=request.getContextPath()%>/front_end/store/store_cart.jsp"><i class="fa fa-shopping-cart shopping-cart" aria-hidden="true"></i><span class="badge">${total_items}</span></a></li>
                        <li><a class="top_banner" href="#"><i class="fa fa-envelope" aria-hidden="true"></i></a></li>
					</ul>
				</div>
				<div class="clearfix"></div>
			</div>
		</div>
		<div class="header">
			<div class="container">
				<div class="logo">
					<h1>
						<a href="<%=request.getContextPath()%>/front_end/index.jsp">Travel
							Maker</a>
					</h1>
				</div>
				<div class="top-nav">
					<!-- 當網頁寬度太小時，導覽列會縮成一個按鈕 -->
					<nav class="navbar navbar-default">
					<button type="button" class="navbar-toggle collapsed"
						data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">Menu
					</button>
					<!-- //當網頁寬度太小時，導覽列會縮成一個按鈕 --> <!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse"
						id="bs-example-navbar-collapse-1">
						<ul class="nav navbar-nav">
							<li>
								<a href="<%=request.getContextPath()%>/front_end/news/news.jsp">最新消息</a>
							</li>
							<li>
								<a href="<%=request.getContextPath()%>/front_end/attractions/att.jsp">景點介紹</a>
							</li>
							<li>
								<a href="<%=request.getContextPath()%>/front_end/trip/trip.jsp">行程規劃</a>
							</li>
							<li>
								<a href="<%=request.getContextPath()%>/blog.index">旅遊記</a>
							</li>
							<li>
								<a href="<%=request.getContextPath()%>/front_end/question/question.jsp">問答區</a>
							</li>
							<li>
								<a href="<%=request.getContextPath()%>/front_end/photowall/photo_wall.jsp">照片牆</a>
							</li>
							<li>
								<a href="<%=request.getContextPath()%>/front_end/grp/grpIndex.jsp">揪團</a>
							</li>
							<li>
								<a href="<%=request.getContextPath()%>/front_end/store/store.jsp">交易平台</a>
							</li>
							<li>
								<a href="<%=request.getContextPath()%>/front_end/ad/ad.jsp">專欄</a>
							</li>

							<div class="clearfix"></div>
						</ul>
					</div>
					</nav>
				</div>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
	<!-- //banner -->
<!-- store -->
	<div class="main" style="min-height: 1px;">
		<div class="container">
			<div class="row p-b-70">
				<section>
					<div class="wizard">
						<!-- 上方 Tab-->
						<div class="wizard-inner">
							<div class="connecting-line"></div>
							<ul class="nav nav-tabs" role="tablist">
								<!-- Step 1 tab-->
								<li role="presentation" class="disabled">
									<a href="#step1" data-toggle="tab" aria-controls="step1" role="tab" title="Step 1">
										<span class="round-tab">
			                                <i class="fa fa-truck" style="line-height:70px"></i>
			                            </span>
									</a>
								</li>
								<!-- Step 2 tab-->
								<li role="presentation" class="disabled">
									<a href="#step2" data-toggle="tab" aria-controls="step2" role="tab" title="Step 2">
										<span class="round-tab">
			                                <i class="fa fa-credit-card" style="line-height:70px"></i>
			                            </span>
									</a>
								</li>
								<!-- Step 3 tab-->
								<li role="presentation" class="active">
									<a href="#complete" data-toggle="tab" aria-controls="complete" role="tab" title="Complete">
										<span class="round-tab">
			                                <i class="glyphicon glyphicon-ok" style="line-height:70px"></i>
			                            </span>
									</a>
								</li>
							</ul>
						</div>
						<!-- //上方 Tab END-->
						
						<form role="form" action="shopping.do" method="post">
							<div class="tab-content">
								<!-- Step 3 tab 內容-->
								<div class="tab-pane active" role="tabpanel" id="complete">
									<div class="p-t-50">
										<h3>感謝您的訂購</h3>
										<p>您已經完成下單流程，點擊按鈕可跳轉至購買清單管理頁面</p>
									</div>
									<ul class="list-inline pull-right p-t-80">
										
										<li><a href="<%=request.getContextPath()%>/front_end/personal_area/personal_area_buy.jsp"><button id="order-list" type="button" class="btn order-list-mgt">購買清單管理</button></a></li>
									</ul>
								</div>
								<!-- //Step 3 tab 內容-->
							</div>
						</form>
					</div>
				</section>
			</div>
		</div>
	</div>
		<!-- store -->
	
	<!-- footer -->
	<div class="footer">
		<div class="container">
			<div class="footer-grids">
				<div class="col-md-3 footer-grid">
					<div class="footer-grid-heading">
						<h4>關於我們</h4>
					</div>
					<div class="footer-grid-info">
						<ul>
                            <li><a href="<%=request.getContextPath()%>/front_end/about_us/about_us.jsp">關於Travel Maker</a></li>
                            <li><a href="<%=request.getContextPath()%>/front_end/content/content.jsp">聯絡我們</a></li>
                            <li><a href="<%=request.getContextPath()%>/front_end/faq/faq.jsp">常見問題</a></li>
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
					<p>Copyright &copy; 2018 All rights reserved
						<a href="<%=request.getContextPath()%>/front_end/index.jsp" target="_blank" title="TravelMaker">TravelMaker</a>
					</p>
			</div>
		</div>
	</div>
	<!-- //footer -->

<!--===============================================================================================-->
<script type="text/javascript">
	        //tab js
			$(document).ready(function() {
				//Initialize tooltips
				$('.nav-tabs > li a[title]').tooltip();

				//Wizard
				$('a[data-toggle="tab"]').on('show.bs.tab', function(e) {

					var $target = $(e.target);

					if($target.parent().hasClass('disabled')) {
						return false;
					}
				});

				$(".next-step").click(function(e) {

					var $active = $('.wizard .nav-tabs li.active');
					$active.next().removeClass('disabled');
					nextTab($active);

				});
				$(".prev-step").click(function(e) {

					var $active = $('.wizard .nav-tabs li.active');
					prevTab($active);

				});
				
				$("#order-checkout").click(function(e) {

					var $active = $('.wizard .nav-tabs li.active');
					$active.prev().addClass('disabled');
					$active.prev().prev().addClass('disabled');
					nextTab($active);
				});
				
				$("#place-order").click(function(e) {

					var $active = $('.wizard .nav-tabs li.active');
					$active.prev().addClass('disabled');
					nextTab($active);
				});
			});

			function nextTab(elem) {
				$(elem).next().find('a[data-toggle="tab"]').click();
			}

			function prevTab(elem) {
				$(elem).prev().find('a[data-toggle="tab"]').click();
			}
	
</script>	
</body>
</html>