<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" import="javax.servlet.http.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.mem.model.*" %>
<%@ page import="com.photo.model.*" %>
<%@ page import="com.blog.model.*" %>
<%@ page import="java.util.*" %>
<%

	
	boolean login_state = false ;
	Object login_state_temp = session.getAttribute("login_state");
	
	//確認登錄狀態
	if(login_state_temp != null ){
		login_state= (boolean) login_state_temp ;
	}
	
	//若登入狀態為不是true，紀錄當前頁面並重導到登入畫面。
	if( login_state != true){
		session.setAttribute("location", request.getRequestURI());
		response.sendRedirect(request.getContextPath()+"/front_end/member/mem_login.jsp");
		return;
	}
		
	//取得登錄者的照片牆
	Photo_wallJDBCDAO photoSvc = new Photo_wallJDBCDAO(); 
	List<Photo_wallVO> photoList=photoSvc.getAll_ByMemID(((MemberVO)session.getAttribute("memberVO")).getMem_Id());
	pageContext.setAttribute("photoList", photoList);
	
	//取得登錄者的部落格
	blogService blogSvc = new blogService();
	List<blogVO> blogList=blogSvc.findByMemId(((MemberVO)session.getAttribute("memberVO")).getMem_Id());
	pageContext.setAttribute("blogList", blogList);
%>

<!DOCTYPE html>
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
    <meta name="keywords" content="TravelMaker,travelmaker,自助旅行,部落格,旅遊記" />
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
    
    <!-- bootstrap css及JS檔案 -->
    <link href="<%=request.getContextPath()%>/front_end/css/all/index_bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    <script src="<%=request.getContextPath()%>/front_end/js/all/index_bootstrap.js"></script>
    <!-- //bootstrap-css -->
    
    <!-- semantic css -->
    <link href="<%=request.getContextPath()%>/front_end/css/ad/ad_semantic.min.css" rel="stylesheet" type="text/css">
    <!-- //semantic css -->
    
    <!-- 套首頁herder和footer css -->
    <link href="<%=request.getContextPath()%>/front_end/css/all/index_style.css" rel="stylesheet" type="text/css" media="all" />
    <!-- //套首頁herder和footer css -->
     
    <!-- font-awesome icons -->
    <link href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" rel="stylesheet" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
    <!-- //font-awesome icons -->
    
    <!-- font字體 -->
    <link href='https://fonts.googleapis.com/css?family=Oswald:400,700,300' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Pacifico' rel='stylesheet' type='text/css'>
    <!-- //font字體 -->
    
    <!-- AD_Page相關CSS及JS -->
    <link href="<%=request.getContextPath()%>/front_end/css/ad/ad_page.css" rel="stylesheet" type="text/css">
    <link href="<%=request.getContextPath()%>/front_end/css/personal/personal_area_home.css" rel="stylesheet" type="text/css">
    <!-- //AD_Page相關CSS及JS -->
    
    <!-- 聊天相關CSS及JS -->
    <link href="<%=request.getContextPath()%>/front_end/css/chat/chat_style.css" rel="stylesheet" type="text/css">
    <script src="<%=request.getContextPath()%>/front_end/js/chat/chat.js"></script>
    <!-- //聊天相關CSS及JS -->
    <style>
    
    /*若搜尋不到文章或圖片時，將會顯示 驚嘆號圖片nothing.png*/
    .nothing{
    	width:50px;
    	heigh:50px;
    }
    
    </style>
    

</head>

<body onload="connect();">
    <!-- banner -->
    <div class="banner about-bg">
        <div class="top-banner about-top-banner">
            <div class="container">
                <div class="top-banner-left">
                    <ul>
                        <li><i class="fa fa-phone" aria-hidden="true"></i>
                            <a href="tel:034257387"> 03-4257387</a></li>
                        <li><a href="mailto:TravelMaker@gmail.com"><i class="fa fa-envelope" aria-hidden="true"></i> TravelMaker@gmail.com</a></li>
                    </ul>
                </div>
                <div class="top-banner-right">
                    <ul>
                        <li><a class="top_banner" href="<%=request.getContextPath()%>/front_end/personal_area/personal_area_home.jsp"><i class="fa fa-user" aria-hidden="true"></i></a></li>
                        <li><a class="top_banner" href="#"><i class="fa fa-shopping-cart" aria-hidden="true"></i></a></li>
                        <li><a class="top_banner" href="#"><i class="fa fa-envelope" aria-hidden="true"></i></a></li>
                    </ul>
                </div>
                <div class="clearfix"> </div>
            </div>
        </div>
        <div class="header">
            <div class="container">
                <div class="logo">
                    <h1>
                        <a href="<%=request.getContextPath()%>/front_end/index.jsp">Travel Maker</a>
                    </h1>
                </div>
                <div class="top-nav">
                    <!-- 當網頁寬度太小時，導覽列會縮成一個按鈕 -->
                    <nav class="navbar navbar-default">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">Menu						
							</button>
                        <!-- //當網頁寬度太小時，導覽列會縮成一個按鈕 -->
                        <!-- Collect the nav links, forms, and other content for toggling -->
                        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
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
                                <li><a href="<%=request.getContextPath()%>/front_end/ad/ad.jsp">專欄</a></li>

                                <div class="clearfix"> </div>
                            </ul>
                        </div>
                    </nav>
                </div>
                <div class="clearfix"> </div>
            </div>
        </div>
    </div>
    <!-- //banner -->
    
    <!--container-->
    <div class="ui container">
        <!--會員個人頁面標頭-->
        <div class="mem_ind_topbar">
            <!--會員封面-->
            <div class="mem_ind_banner">
                <img src="<%=request.getContextPath()%>/front_end/images/all/person_bar.jpg">
            </div>
            <!--會員訊息--> 
            <div class="mem_ind_info"> 
                <div class="mem_ind_img">
                    <img src="<%=request.getContextPath()%>/front_end/readPic?action=member&id=${memberVO.mem_Id}">
                </div>
                <div class="mem_ind_name">
                    <p>${memberVO.mem_Name}</p>
                    <p class="text-truncate" style="font-size:0.9em;padding-top:10px;max-height:110px">
					   ${memberVO.mem_Profile}
                    </p>
                </div>
            </div> 
        </div>
        <!--//會員個人頁面標頭-->
        <!--會員個人頁面-首頁內容-->
        <div class="mem_ind_content">
          <!-- 頁籤項目 -->
          <ul class="nav nav-tabs" role="tablist">
            <li class="nav-item active">
              <a href="<%=request.getContextPath()%>/front_end/personal_area/personal_area_home.jsp">
                  <i class="fas fa-home"></i>首頁
              </a>
            </li>
            <li class="nav-item">
              <a href="<%=request.getContextPath()%>/front_end/personal_area/personal_area_friend.jsp">
                  <i class="fas fa-user-friends"></i>好友
              </a>
            </li>
            <li class="nav-item">
              <a href="personal_area_blog.html">
                  <i class="fab fa-blogger"></i>旅遊記
              </a>
            </li>
            <li class="nav-item">
              <a href="#trip">
                  <i class="fas fa-map"></i>行程
              </a>
            </li>
            <li class="nav-item">
              <a href="#together">
                  <i class="fas fa-bullhorn"></i>揪團
              </a>
            </li>
            <li class="nav-item">
              <a href="#question">
                  <i class="question circle icon"></i>問答
              </a>
            </li>
            <li class="nav-item">
              <a href="#gallery">
                  <i class="image icon"></i>相片
              </a>
            </li>
            
             <li class="nav-item">
              <a href="#gallery">
                  <i class="money bill alternate icon"></i>銷售
              </a>
            </li>

             <li class="nav-item">
              <a href="#gallery">
                  <i class="shopping cart icon"></i>購買
              </a>
            </li>
            <li class="nav-item" style="float: right">
              <a href="<%=request.getContextPath()%>/front_end/member/member.do?action=getOne_For_Display&mem_Id=${memberVO.mem_Id}">
                  <i class="cog icon"></i>設置
              </a>
            </li>
          </ul>
          <!-- //頁籤項目 -->
          <!-- 頁籤項目-首頁內容 -->
          <div class="tab-content" style="float:left;width:75%">
            <!--首頁左半邊-個人首頁-->
            <div id="home" class="container tab-pane active">
               <!--首頁我的照片列表-->
               <div class="u_ind_item">
                  <div class="u_title">
                      <strong>我的照片</strong>
                      <a href="#"><i class="angle double right icon"></i>更多</a>
                      <div>
                          <span>${photoList.size()}</span>
                          <span>張照片</span>
                      </div>
                  </div>
                  <div class="mem_ind_item_photo">
                  <c:choose>
                  	<c:when test="${not empty photoList}">
                      <div class="flex">
						<c:forEach var="photovo" items="${photoList}" begin="0" end="4">
							<div class="item">
						    	<a href="">
						        	<img src="<%=request.getContextPath()%>/front_end/readPic?action=photowall&id=${photovo.photo_No}">
						    	</a>
							</div>
						</c:forEach>
                      </div>
                     </c:when>
                     <c:otherwise>
                     	<img src="<%=request.getContextPath()%>/front_end/images/all/nothing.png" class="nothing">尚未發表
                     </c:otherwise>
                  </c:choose>
                  </div>
               </div>
               <!--首頁我的照片列表-->
               <hr>
               <!--首頁我的旅遊記列表-->
               <div class="u_ind_item">
                  <div class="u_title">
                      <strong>我的旅遊記</strong>
                      <a href="#"><i class="angle double right icon"></i>更多</a>
                      <div>
                          <span>${blogList.size()}</span>
                          <span>篇遊記</span>
                      </div>
                  </div>
                  <div class="mem_ind_item_blog">
                  	<!--我的旅遊記列表 start  -->
                     <div class="ui items">
                        <c:choose>
                     	  <c:when test="${not empty blogList}">
                     		<c:forEach var="blogvo" items="${blogList}" begin="0" end="2">
	                      	  <!-- 部落格區塊 -->
		                      <div class="item col-12">
		                        <div class="ui small image ">
		                          <a href="<%=request.getContextPath()%>/blog.do?action=article&blogID=${blogvo.blog_id}">
		                              <img src="<%=request.getContextPath()%>/blogPicReader?blog_id=${blogvo.blog_id}"/>
		                          </a>
		                        </div>
		                        <div class="content ">
		                          <div class="text-truncate header">${blogvo.blog_title}</div>
		                          <div class="meta">
		                            <span class="stay">
		                            	<i class="fas fa-calendar-alt"></i>
		                            	${blogvo.travel_date}
		                            </span>
		                          </div>
		                          <div class="description text-truncate">
		                            <span>
		                                <i class="fas fa-map-marker-alt"></i>
		                                <c:set var="blog_content" value="${blogvo.blog_content}"/>
										<%= ((String)pageContext.getAttribute("blog_content")).replaceAll("<[^>]*>","").trim()%>
		                            </span>
		                          </div>
		                        </div>
		                      </div>
		                    </c:forEach>
	                      	  <!-- 部落格區塊 -->
	                       </c:when>
	                       <c:otherwise>
	                       		<img src="<%=request.getContextPath()%>/front_end/images/all/nothing.png" class="nothing">尚未發表
	                       </c:otherwise>
	                     </c:choose>
                     </div>  
                     <!--我的旅遊記列表 end  -->
                  </div>
               </div>
               <hr>
               <!--首頁我的行程列表-->
               <div class="u_ind_item">
                  <div class="u_title">
                      <strong>我的行程</strong>
                      <a href="#"><i class="angle double right icon"></i>更多</a>
                      <div>
                          <span>11</span>
                          <span>篇行程</span>
                      </div>
                  </div>
                  <div class="mem_ind_item_plan">
                     <div class="ui items">
                      <div class="item">
                        <div class="ui small image">
                         <a href="">
                          <img src="<%=request.getContextPath()%>/front_end/images/all/2.jpg">
                         </a>
                        </div>
                        <div class="content">
                          <div class="header">水宝小慢的澳大利亚行程</div>
                          <div class="meta">
                            <span class="stay"><i class="fas fa-calendar-alt"></i> 13天</span>
                          </div>
                          <div class="description">
                            <p>
                                <i class="fas fa-map-marker-alt"></i> 
                                北京>悉尼>澳大利亚蓝山>霍巴特>阿德莱德>悉尼>北京京>悉尼>澳大利亚蓝山>霍巴特>阿德莱德>悉尼>北
                            </p>
                          </div>
                        </div>
                      </div>
                      <div class="item">
                        <div class="ui small image">
                         <a href="">
                          <img src="<%=request.getContextPath()%>/front_end/images/all/2.jpg">
                         </a>
                        </div>
                        <div class="content">
                          <div class="header">水宝小慢的澳大利亚行程</div>
                          <div class="meta">
                            <span class="stay"><i class="fas fa-calendar-alt"></i> 13天</span>
                          </div>
                          <div class="description">
                            <p>
                                <i class="fas fa-map-marker-alt"></i> 
                                北京>悉尼>澳大利亚蓝山>霍巴特>阿德莱德>悉尼>北京京>悉尼>澳大利亚蓝山>霍巴特>阿德莱德>悉尼>北
                            </p>
                          </div>
                        </div>
                      </div>
                      <div class="item">
                        <div class="ui small image">
                         <a href="">
                          <img src="<%=request.getContextPath()%>/front_end/images/all/2.jpg">
                         </a>
                        </div>
                        <div class="content">
                          <div class="header">水宝小慢的澳大利亚行程</div>
                          <div class="meta">
                            <span class="stay"><i class="fas fa-calendar-alt"></i> 13天</span>
                          </div>
                          <div class="description">
                            <p>
                                <i class="fas fa-map-marker-alt"></i> 
                                北京>悉尼>澳大利亚蓝山>霍巴特>阿德莱德>悉尼>北京京>悉尼>澳大利亚蓝山>霍巴特>阿德莱德>悉尼>北
                            </p>
                          </div>
                        </div>
                      </div>
                     </div>  
                  </div>
               </div>
               <br>
            </div>
            <!--//首頁左半邊-個人首頁-->
          </div>
          <!--頁籤項目-首頁內容-->
          <!--首頁右半邊-->                
          <div style="width:25%;float:left">
                <div class="add_Div">
                    <a href="blog_add.jsp" class="adddiv_a">
                        <div style="color:rgb(93,187,133)">
                            <i class="fas fa-edit"></i><br>
                            寫旅遊記
                        </div>        
                    </a>
                    <a href="" class="adddiv_a">
                        <div style="color:rgb(245,177,0)">
                            <i class="far fa-calendar-check"></i><br>
                            規劃行程
                        </div>  
                    </a>
                    <a href="" class="adddiv_a">
                        <div style="color:rgb(242,102,34)">
                        <i class="fas fa-bullhorn"></i><br>
                        揪旅伴去
                        </div>  
                    </a>
                    <a href="" class="adddiv_a">
                        <div style="color:rgb(81,167,219)">
                            <i class="fas fa-comment-dots"></i><br>
                            提問題去
                        </div> 
                    </a>

                </div>
            </div>
          <!--//首頁右半邊--> 
        </div>
        <!-- //會員個人頁面內容 -->
    </div>
    <!--//container-->
        
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
                            <li><a href="about.html">關於Travel Maker</a></li>
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
                            <li><a href="https://www.facebook.com/InstaBuy.tw/" target="_blank"><i class="fab fa-facebook"></i></a></li>
                            <li><a href="https://www.instagram.com/" target="_blank"><i class="fab fa-instagram"></i></a></li>
                            <li><a href="#" target="_blank"><i class="fab fa-line"></i></a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-3 footer-grid">
                    <div class="footer-grid-heading">
                        <h4>訂閱電子報</h4>
                    </div>
                    <div class="footer-grid-info">
                        <form action="#" method="post">
                            <input type="email" id="mc4wp_email" name="EMAIL" placeholder="請輸入您的Email" required="">
                            <input type="submit" value="訂閱">
                        </form>
                    </div>
                </div>
                <div class="clearfix"> </div>
            </div>
            <div class="copyright">
                <p>Copyright &copy; 2018 All rights reserved
                    <a href="index.html" target="_blank" title="TravelMaker">TravelMaker</a>
                </p>
            </div>
        </div>
    </div>
    <!-- //footer -->
    
    <!-- 小的聊天列表 start-->
    <div class="chatContainer">
        <div class="chatHeader">
            
                &nbsp;<i class="fas fa-comment"></i>&nbsp;聊天室
                <span style="float: right;padding-right: 10px" id="chat_addFri_span">
                    <span data-toggle="tooltip" title="建立新對話" data-placement="top" >
                        <i class="fas fa-user-plus"></i>
                    </span>
                </span> 

        </div>
        <div class="chatContext">
            <ul class="list-group">
                <li class="list-group-item"><img class="avatar" src="<%=request.getContextPath()%>/front_end/images/all/p1.jpg">凱文</li>
                <li class="list-group-item"><img class="avatar" src="<%=request.getContextPath()%>/front_end/images/all/p2.jpg">大眼怪</li>
                <li class="list-group-item"><img class="avatar" src="<%=request.getContextPath()%>/front_end/images/all/p3.png">卡納赫拉</li>
                <li class="list-group-item"><img class="avatar" src="<%=request.getContextPath()%>/front_end/images/all/p4.png">臭跩貓</li>
                <li class="list-group-item"><img class="avatar" src="<%=request.getContextPath()%>/front_end/images/all/p5.jpg">好想兔</li>
                <li class="list-group-item"><img class="avatar" src="<%=request.getContextPath()%>/front_end/images/all/p6.png">茶包</li>
            </ul>
        </div>
        <div class="chatFooter">
            <div class="input-group">
              <span class="input-group-addon" id="basic-addon1"><i class="fas fa-search"></i></span>
              <input type="text" class="form-control" placeholder="搜尋" aria-describedby="basic-addon1" id="search_Fri">
            </div>
        </div>
    </div>
    <!-- 小的聊天列表 END -->
    
    <!-- 聊天對話視窗start -->
    <div class="input_chatContainer">
        <div class="input_chatHeader">
                &nbsp;黃世銘 <!-- 互為好友才能聊天 -->
                <span style="float: right;padding-right: 10px">
                	<span data-toggle="tooltip" title="關閉" data-placement="top" >
                		<i class="fas fa-times"></i>
                	</span> 
                </span>
                <span style="float: right;padding-right: 10px" id="chat_addFri_span">
                    <span data-toggle="tooltip" title="建立新對話" data-placement="top" >
                        <i class="fas fa-user-plus"></i>
                    </span>
                </span>
        </div>
        <div class="input_chatContext" id="messageArea">
			<!--聊天內容 -->
        </div>
        <div class="input_chatFooter">
            <div class="input-group">
              <input type="text" id="message" name="message" class="form-control" placeholder="輸入訊息....." 
              	aria-describedby="basic-addon1" onkeydown="if (event.keyCode == 13) sendMessage();">
              <span class="input-group-addon btn" onclick="sendMessage();">送出</span>
            </div>
        </div>
    </div>
    <!-- 聊天對話視窗End -->
    
    <!-- Modal 建立聊天視窗 start-->
    <div class="modal fade" id="chat_AddFri_Modal" role="dialog">
        <div class="modal-dialog">

          <!-- Modal 建立聊天視窗content start-->
          <div class="modal-content" >
            
            <div class="modal-header">
              <h4 class="modal-title">建立聊天</h4>
            </div>
            
            <div class="modal-body"> 
                <!--輸入盒聊天對話-->
                <div class="ui left icon input fluid">
                  <input type="text" placeholder="為聊天命名" id="chatName" required>
                  <i class="users icon"></i>
                </div>
                <!--分隔線-->
                <hr>
                <!--搜尋要加入聊天對話的好友-->
                <div style="height:400px;margin-top:10px">
                      <div style="float:left;width:60%;height:inherit">
                          <div class="ui icon input fluid">
                              <input type="text" placeholder="搜尋要加入的用戶" id="search_Fri_modal">
                              <i class="search icon"></i>
                          </div>
                          <div class="ui middle aligned selection list" style="height:89%;overflow:auto">
                              
                           <div class="item">
                               <input type="checkbox" class="ui checkbox" id="fri01">
                               <label for="fri01" style="width:80%">
                                  <img class="ui avatar image" src="<%=request.getContextPath()%>/front_end/images/all/p1.jpg">
                                  <span class="content">小小兵small</span>  
                               </label>
                           </div>
                           <div class="item">
                               <input type="checkbox" class="ui checkbox" id="fri02">
                               <label for="fri02" style="width:80%">
                                  <img class="ui avatar image" src="<%=request.getContextPath()%>/front_end/images/all/p2.jpg">
                                  <span class="content">大眼怪eye</span>  
                               </label>
                           </div>
                           <div class="item">
                               <input type="checkbox" class="ui checkbox" id="fri03">
                               <label for="fri03" style="width:80%">
                                  <img class="ui avatar image" src="<%=request.getContextPath()%>/front_end/images/all/p3.png">
                                  <span class="content">卡納赫拉kanihei</span>  
                               </label>
                           </div>
                           <div class="item">
                               <input type="checkbox" class="ui checkbox" id="fri04">
                               <label for="fri04" style="width:80%">
                                  <img class="ui avatar image" src="<%=request.getContextPath()%>/front_end/images/all/p4.png">
                                  <span class="content">北爛貓cat</span>  
                               </label>
                           </div>
                           <div class="item">
                               <input type="checkbox" class="ui checkbox" id="fri05">
                               <label for="fri05" style="width:80%">
                                  <img class="ui avatar image" src="<%=request.getContextPath()%>/front_end/images/all/p5.jpg">
                                  <span class="content">好想兔rabbit</span>  
                               </label>
                           </div>
                           <div class="item">
                               <input type="checkbox" class="ui checkbox" id="fri06">
                               <label for="fri06" style="width:80%">
                                  <img class="ui avatar image" src="<%=request.getContextPath()%>/front_end/images/all/p6.png">
                                  <span class="content">豆卡頻道dog</span>  
                               </label>
                           </div>
                           <div class="item">
                               <input type="checkbox" class="ui checkbox" id="fri07">
                               <label for="fri07" style="width:80%">
                                  <img class="ui avatar image" src="<%=request.getContextPath()%>/front_end/images/all/author1.jpg">
                                  <span class="content">美女women</span>  
                               </label>
                           </div>
                           <div class="item">
                               <input type="checkbox" class="ui checkbox" id="fri08">
                               <label for="fri08" style="width:80%">
                                  <img class="ui avatar image" src="<%=request.getContextPath()%>/front_end/images/all/t4.jpg">
                                  <span class="content">帥哥man</span>  
                               </label>
                           </div>
                              
                          </div>
                      </div>
                      <!--已選擇加入聊天對話列表-->
                      <div style="float:left;width:40%;height:inherit;border-left: 1px" id="select_Fri">
                          <div style="padding-left: 20px;height: 10%">
                          已選擇<i class="check circle icon"></i>
                          </div>
                          <div class="ui middle aligned selection list" style="height:89%;overflow:auto" id="select_FriList">
                                <!--這裡我要塞被選到的好友；動態顯示--> 
                          </div>
                      </div>         
                </div>    
            </div>
            
            <div class="modal-footer"> 
              <button type="button" class="btn btn-danger" data-dismiss="modal">取消</button>
              <button type="button" class="btn btn-success">確認</button>
            </div>
                      
          </div>
          <!-- Modal 建立聊天視窗content END-->
        </div>
      </div>
    <!-- Modal 建立聊天視窗 END -->
    
    
    <script>
    
		
    	var MyPoint = "/chat/${memberVO.mem_Id}";
    	var host = window.location.host;
    	var endPointURL = "ws://localhost:8081<%=request.getContextPath()%>"+MyPoint;
    	var webSocket;
    	
		function connect(){
			//建立一個websocket
			webSocket = new WebSocket(endPointURL);

			webSocket.onopen = function(event){
				alert("WebSocket Connected");
			};
			
			//收到訊息的時候
			webSocket.onmessage = function(event){
				var messageArea = $("#messageArea");
				var jsonObj = JSON.parse(event.data);
				
				//若找不到
				if($("#" + jsonObj.MEM_ID + "").length === 0){
					alert("找步道該元素");
				}

				var massage = jsonObj.MEM_ID+":"+jsonObj.MSG+"("+jsonObj.TIME+")\r\n<br>";
				messageArea.append(massage);	
				messageArea.scrollTop = messageArea.scrollHeight;
			};
			
			webSocket.onclose = function(event){
				alert("WebSocket 關閉囉!");
			};
			
		}
		
		//當按下聊天送出按鈕後會呼叫的
		function sendMessage() {
			var userName = "${memberVO.mem_Id}";
			if(userName === ""){
				alert("錯誤：發出訊息，未取到會員ID");
				return;
			}
			
			var inputMessage = $("#message");
			var message = inputMessage.val().trim();
			alert("準備送出的訊息為:"+message);
			
			if(message === ""){
				alert("未輸入訊息不能送出喔");
				inputMessage.focus();
			}else{
				var date = new Date();
				var date_str = date.toJSON().substr(0,10);
				var time_str = date.toTimeString().substr(0,8);
				var jsonObj ={
					"MEM_ID":userName,
					"MSG":message,
					"TIME":date_str+" "+time_str
				};
				webSocket.send(JSON.stringify(jsonObj));
				inputMessage.val("");
				inputMessage.focus();
			}
			
		}

    </script>
</body>

</html>
