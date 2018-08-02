<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="javax.servlet.http.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.fri.model.*" %>
<%@ page import="com.mem.model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.product.model.*"%>
<%@ page import="com.productWishlist.model.*"%>
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


	/***************取出登入者會員資訊******************/
	String memId = ((MemberVO)session.getAttribute("memberVO")).getMem_Id();
	
	//為了join(寫法有servlet3.0限制)
	MemberService memSvc = new MemberService();
	pageContext.setAttribute("memSvc",memSvc); 
	
	
	/***************取出登入會員銷售商品******************/
	ProductService productSvc = new ProductService();
    Set<ProductVO> list = productSvc.getSellerProducts(memId);
    pageContext.setAttribute("list",list);

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
    <link href="<%=request.getContextPath()%>/front_end/css/all/index_style_header_footer.css" rel="stylesheet" type="text/css" media="all" />
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
    <link href="<%=request.getContextPath()%>/front_end/css/personal/personal_area_fri.css" rel="stylesheet" type="text/css">
    <!-- //AD_Page相關CSS及JS -->
    
    <!-- 聊天相關CSS及JS -->
    <link href="<%=request.getContextPath()%>/front_end/css/chat/chat_style.css" rel="stylesheet" type="text/css">
    <script src="<%=request.getContextPath()%>/front_end/js/chat/chat.js"></script>
    <!-- //聊天相關CSS及JS -->
    
    <!-- 賣場相關CSS及JS -->
   	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/css/store/util.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/css/store/main.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/css/store/seller_prod_mgt.css">
   
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/css/store/store_tab.css">	   
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/css/store/store_order_mgt.css">	   
    <!-- //賣場相關CSS及JS -->
   
   <style>
	   a:hover, a:focus {
		    color: #aaa;
		    text-decoration: none;
		}
	  .wish-add-btn{
	  		color: #111;
	  }
	  
	  .mem_ind_name > p {
    	 line-height: 1.4285em;
    	 color: #333;
    	 font-family: 'Oswald','Noto Sans TC', sans-serif !important;
	  }
	  
	  .mem_ind_topbar {
		   height: 0;
		}
	.nav-tabs {
	    margin-bottom: 1em;
	}
   </style>
    <script>
    	$(document).ready(function(){
    		
        	/*若有錯誤訊息時，就會跳出視窗.......*/
      		$('#errorModal').modal();
    	});

    </script>
</head>

<body>
    <%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<div class="modal fade" id="errorModal">
		    <div class="modal-dialog modal-sm" role="dialog">
		      <div class="modal-content">
		        <div class="modal-header">
		          <i class="fas fa-exclamation-triangle"></i>
		          <span class="modal-title"><h4>請修正以下錯誤:</h4></span>
		        </div>
		        <div class="modal-body">
					<c:forEach var="message" items="${errorMsgs}">
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
        <!--會員個人頁面-首頁內容-->
        <div class="mem_ind_content">
          <!-- 頁籤項目 -->
          <ul class="nav nav-tabs" role="tablist">
            <li class="nav-item">
              <a href="<%=request.getContextPath()%>/front_end/personal_area/personal_area_home.jsp">
                  <i class="fas fa-home"></i>首頁
              </a>
            </li>
            <li class="nav-item">
              <a href="<%=request.getContextPath()%>/front_end/personal_area/personal_area_friend.html">
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
            
             <li class="nav-item active">
              <a href="<%=request.getContextPath()%>/front_end/personal_area/personal_area_sell.jsp">
                  <i class="money bill alternate icon"></i>銷售
              </a>
            </li>

             <li class="nav-item">
              <a href="<%=request.getContextPath()%>/front_end/personal_area/personal_area_buy.jsp">
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
          <!-- 頁籤項目-銷售管理內容 -->
          <div class="tab-content" style="float:left;width:75%">
            <!--首頁左半邊-銷售管理-->
            <div id="fri" class="container tab-pane active">
                <div class="u_title">
                    <strong>我的銷售</strong>
                </div>
                <br>
                <div id="sell_management">
                   <div style="width: 70%;float: left">
                       <ul class="nav nav-tabs" id="sell_tab">
                          <li class="active"><a data-toggle="tab" href="#store_mgt">賣場管理</a></li>
                          <li><a data-toggle="tab" href="#orderlist_sell">銷售清單</a></li>
                          <li><a data-toggle="tab" href="#rating_sell">銷售評價</a></li>
                        </ul>
                   </div>
                </div>
                
                <div class="tab-content">
                  <!--管理賣場-->
                  <div id="store_mgt" class="tab-pane fade in active"> 
                   <!--內容-->  
                    <div class="main" style="min-height: 1px;">
                    	<section class="bgwhite p-t-55 p-b-65">
							<div class="container">
								<div class="row">
							<div class="col-sm-6 col-md-8 col-lg-11 p-b-50">
								<div class="row">
									<div class="col-sm-10 col-md-10 col-lg-12">
										<%@ include file="page1.file" %>
										<div class="page-top flex-sb-m flex-w p-b-35 p-t-40" style="display: inline-block;">
											<span class="s-text8 p-t-5 p-b-5">
												第<%=whichPage%>/<%=pageNumber%>頁  共<%=rowNumber%>筆
											</span>
										</div>
										<div style="text-align: right;display: inline-block;float:right">
											<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front_end/store/store_add_product.jsp">
													<input type="hidden" name="mem_Id"  value="${memberVO.mem_Id}">
													<button type="submit" style="border: 0; background: transparent">
													    <img id="add-product" src="<%=request.getContextPath()%>/front_end/images/store/add_circle_grey_96x96.png" width="80" height="80" alt="submit" onmouseover="this.src='<%=request.getContextPath()%>/front_end/images/store/add_circle_black_96x96.png'" onmouseout="this.src='<%=request.getContextPath()%>/front_end/images/store/add_circle_grey_96x96.png'" />
													</button>
											</FORM>
										</div>
									</div>
								</div>
								<!-- Product -->
								<jsp:useBean id="productWishlistSvc" scope="page" class="com.productWishlist.model.ProductWishlistService" />
								<div class="row">
								<c:forEach var="productVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
										<div class="col-sm-12 col-md-6 col-lg-4 p-b-50">
											<!-- Block2 -->
											<div class="block2">
												<div class="block2-img wrap-pic-w of-hidden pos-relative" style="height:16rem;width: 18rem;">
													<img class="prod-img" src="data:image/jpeg;base64,${productVO.product_photo_1_base}" onerror="this.src='<%=request.getContextPath()%>/front_end/images/store/no-image-icon-15.png'"  alt="IMG-PRODUCT">
													<div class="block2-overlay trans-0-4" style="width: 18rem;">
														<div class="block2-btn-addcart w-size1 trans-0-4">
															<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front_end/store/product.do">
																 <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
															     <input type="hidden" name="product_id"  value="${productVO.product_id}">
															     <input type="hidden" name="action" value="getOne_For_Update">
																<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>"> <!--送出當前是第幾頁給Controller-->
																<button type="submit" class="edit-prod-btn flex-c-m size1 bg4 hov7 s-text1 trans-0-4" id="edit-${productVO.product_id}">
																	<i class="fas fa-pencil-alt p-r-5"></i>編輯商品
																</button>
															</FORM>			
															<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front_end/store/product.do" onsubmit="return confirm('確定要刪除商品: ${productVO.product_name} 嗎?');">
															     <button type="submit" class="delete-prod-btn flex-c-m size1 bg4 hov1 s-text1 trans-0-4 m-t-10" id="delete-${productVO.product_id}">
																	<i class="fas fa-trash-alt p-r-5"></i>刪除商品
																 </button>
																 <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
															     <input type="hidden" name="product_id" value="${productVO.product_id}">
															     <input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>"> 
															     <input type="hidden" name="action" value="delete">
														    </FORM>
														</div>
													</div>
												</div>
				
												<div class="block2-txt p-t-20">
													<a href="<%=request.getContextPath()%>/front_end/store/store_product.jsp?prod_id=${productVO.product_id}" class="block2-name dis-block s-text3 p-b-5 prod-title">
														${productVO.product_name}
													</a>
													<div class="p-t-10">
														<span class="wish-add m-text6 p-r-5 p-l-5" style="float: lefft;">
															<a href="#" class="wish-add-btn">
															<i class="far fa-heart" aria-hidden="true"></i>
															<i class="fas fa-heart dis-none" aria-hidden="true"></i></a>
														</span>
														<span class="wish-like-text m-text6 p-r-5" style="float: lefft;">
															${productWishlistSvc.getLikesByProductid(productVO.product_id).size()}
														</span>
														<span class="block2-price m-text6 p-r-5" style="float: right;">
															$ ${productVO.product_price}
														</span>
													</div>
												</div>
											</div>
										</div>
									</c:forEach>
								</div>
								<!-- //Product -->
								
								<div class="row">
									<div class="col-sm-12 col-md-6 col-lg-12 p-b-50">
										<nav aria-label="Page navigation">
											  <ul class="pagination" name="whichPage">
											  <%if (rowsPerPage<rowNumber) {%>
											      <%if(pageIndex>=rowsPerPage){%> 
											       <li><a href="<%=request.getRequestURI()%>?whichPage=<%=whichPage-1%>" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
											    <%}%>
											      <%}%> 
											  
											    
										  		  <%if (pageNumber>=1) {%>
											         <%for (int i=1; i<=pageNumber; i++){%>
													         <%if(pageIndex==(i*rowsPerPage-rowsPerPage)){%>
													          <li class="active"><a href="<%=request.getRequestURI()%>?whichPage=<%=i%>"><%=i%></a></li>
													         <%}else{%>
												            	<li><a href="<%=request.getRequestURI()%>?whichPage=<%=i%>"><%=i%></a></li>
												         	<%}%> 
											         	 <%}%> 
													  <%}%>
													  
												 <%if (rowsPerPage<rowNumber) {%>
													 
													    <%if(pageIndex<pageIndexArray[pageNumber-1]){%>
													        <li><a href="<%=request.getRequestURI()%>?whichPage=<%=whichPage+1%>" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
													    <%}%>
												  <%}%>  
											  </ul>
										</nav>
								</div>
							</div>
							</div>
						</div>
					 </div>
					</section>
                    </div>
                    <!--內容--> 
                  </div>
                  <!--//管理賣場-->
                  
                  <!--銷售清單列表-->
                  <div id="orderlist_sell" class="tab-pane fade">
                   <div class="container">
						<div class="row">	
							<div class="col-md-10 col-lg-10"  style="padding-top:20px;padding-bottom: 100px;">
								<div class="tabbable-panel">
									<div class="tabbable-line">
									<ul class="nav nav-tabs ">
											<li class="active">
												<a href="#tab_1" data-toggle="tab">
													待出貨 </a>
											</li>
											<li>
												<a href="#tab_2" data-toggle="tab">
													待收貨 </a>
											</li>
											<li>
												<a href="#tab_3" data-toggle="tab">
													完成 </a>
											</li>
											<li>
												<a href="#tab_4" data-toggle="tab">
													取消</a>
											</li>
										</ul>
										<div class="tab-content">
										<!-- 待出貨  tab1-->
											<div class="tab-pane active" id="tab_1">
												<div class="host">
													<a href="agnes" target="_blank" class="photo" style="background-image: url(https://img.triplisher.com/USERIMG/133.jpg)">
													</a>
													<span class="text" style="display:inline-block">	
														<a href="agnes" target="_blank" style="display:inline-block">Agnes Kang</a>	
													</span>
												</div>
												<div class="text order_id">訂單編號. 18052901002QRK5</div>
												<hr class="divider-w pt-20">
												<div class="order-content">
													<div class="order-content-product">
														<div class="order-content-img" style="display:inline-block">
															<div class="prod-img-wrap">
																<div class="prod-img-content" style="background-image: url(https://cfshopeetw-a.akamaihd.net/file/7b31e5058a1cfd5b611a4b9c623e2c07_tn)">
																</div>
															</div>
														</div>
														<div class="order-content-detail" style="display:inline-block">
															<div class="order-content-prod-name">【彤彤小舖】Bath &amp; Body Works 薰香蠟燭 三蕊燭芯 14.5oz BBW美國真品輸入</div>
															<div class="order-content-prod-qty">x 1</div>
														</div>
														<div class="order-content-prod-price" style="display:inline-block;float:right">
																<div class="order-content-prod-price-text" style="display:inline-block">
																	$559
																</div>
														</div>
													</div>
												</div>
												<hr class="divider-w pt-20">
												<div class="order-list-review" align="right">
													<div class="order-list-review-title" style="display:inline-block">訂單金額 (2 商品):</div>
													<div class="order-list-review-price" style="display:inline-block">$258</div>
												</div>
												<p class="form-submit"><button type="button" class="btn cancel-order" id="cancel-order" data-toggle="modal" data-target="#cancelOrderModal">取消訂單</button> <button type="button" class="btn ship-order" id="ship-order" data-toggle="modal" data-target="#shipOrderModal">確認出貨</button>
												
												</p>
											</div>
										<!-- 待出貨  tab1 END-->	
										
										<!-- 待收貨  tab2 -->	
											<div class="tab-pane" id="tab_2">
											<div class="host">
												<a href="agnes" target="_blank" class="photo" style="background-image: url(https://img.triplisher.com/USERIMG/133.jpg)">
												</a>
												<span class="text" style="display:inline-block">	
													<a href="agnes" target="_blank" style="display:inline-block">Agnes Kang</a>	
												</span>
											</div>
												<div class="text order_id">訂單編號. 18052901002QRK5</div>
												<hr class="divider-w pt-20">
												<div class="order-content">
													<div class="order-content-product">
														<div class="order-content-img" style="display:inline-block">
															<div class="prod-img-wrap">
																<div class="prod-img-content" style="background-image: url(https://cfshopeetw-a.akamaihd.net/file/7b31e5058a1cfd5b611a4b9c623e2c07_tn)">
																</div>
															</div>
														</div>
														<div class="order-content-detail" style="display:inline-block">
															<div class="order-content-prod-name">【彤彤小舖】Bath &amp; Body Works 薰香蠟燭 三蕊燭芯 14.5oz BBW美國真品輸入</div>
															<div class="order-content-prod-qty">x 1</div>
														</div>
														<div class="order-content-prod-price" style="display:inline-block;float:right">
															<div class="order-content-prod-price-text" style="display:inline-block">
																$559
															</div>
														</div>
													</div>
												</div>
												<hr class="divider-w pt-20">
												<div class="order-list-review" align="right">
													<div class="order-list-review-title" style="display:inline-block">訂單金額 (2 商品):</div>
													<div class="order-list-review-price" style="display:inline-block">$258</div>
												</div>
												<p class="form-submit">  <button type="button" class="btn confirm-delivery" id="confirm-delivery" data-toggle="modal" data-target="#confirmDeliveryModal">確認到貨</button>
												
												</p>
											</div>
										<!-- 待收貨  tab2 END-->	
										
										
										<!-- 已完成  tab3 -->	
											<div class="tab-pane" id="tab_3">
												<div class="host">
												<a href="agnes" target="_blank" class="photo" style="background-image: url(https://img.triplisher.com/USERIMG/133.jpg)">
												</a>
												<span class="text" style="display:inline-block">	
													<a href="agnes" target="_blank" style="display:inline-block">Agnes Kang</a>	
												</span>
											</div>
												<div class="text order_id">訂單編號. 18052901002QRK5</div>
												<hr class="divider-w pt-20">
												<div class="order-content">
													<div class="order-content-product">
														<div class="order-content-img" style="display:inline-block">
															<div class="prod-img-wrap">
																<div class="prod-img-content" style="background-image: url(https://cfshopeetw-a.akamaihd.net/file/7b31e5058a1cfd5b611a4b9c623e2c07_tn)">
																</div>
															</div>
														</div>
														<div class="order-content-detail" style="display:inline-block">
															<div class="order-content-prod-name">【彤彤小舖】Bath &amp; Body Works 薰香蠟燭 三蕊燭芯 14.5oz BBW美國真品輸入</div>
															<div class="order-content-prod-qty">x 1</div>
														</div>
														<div class="order-content-prod-price" style="display:inline-block;float:right">
															<div class="order-content-prod-price-text" style="display:inline-block">
																$559
															</div>
														</div>
													</div>
												</div>
												<hr class="divider-w pt-20">
												<div class="order-list-review" align="right">
													<div class="order-list-review-title" style="display:inline-block">訂單金額 (2 商品):</div>
													<div class="order-list-review-price" style="display:inline-block">$258</div>
												</div>
												<p class="form-submit">  <button type="button" class="btn rating-star" id="rating-star" data-toggle="modal" data-target="#ratingModal">評價</button>
												</p>
											</div>
										<!-- 已完成  tab3 END-->	
											
										<!-- 取消 tab4 -->		
											<div class="tab-pane" id="tab_4">
													<div class="host">
												<a href="agnes" target="_blank" class="photo" style="background-image: url(https://img.triplisher.com/USERIMG/133.jpg)">
												</a>
												<span class="text" style="display:inline-block">	
													<a href="agnes" target="_blank" style="display:inline-block">Agnes Kang</a>	
												</span>
											</div>
												<div class="text order_id">訂單編號. 18052901002QRK5</div>
												<hr class="divider-w pt-20">
												<div class="order-content">
													<div class="order-content-product">
														<div class="order-content-img" style="display:inline-block">
															<div class="prod-img-wrap">
																<div class="prod-img-content" style="background-image: url(https://cfshopeetw-a.akamaihd.net/file/7b31e5058a1cfd5b611a4b9c623e2c07_tn)">
																</div>
															</div>
														</div>
														<div class="order-content-detail" style="display:inline-block">
															<div class="order-content-prod-name">【彤彤小舖】Bath &amp; Body Works 薰香蠟燭 三蕊燭芯 14.5oz BBW美國真品輸入</div>
															<div class="order-content-prod-qty">x 1</div>
														</div>
														<div class="order-content-prod-price" style="display:inline-block;float:right">
															<div class="order-content-prod-price-text" style="display:inline-block">
																$559
															</div>
														</div>
													</div>
												</div>
												<hr class="divider-w pt-20">
												<div class="order-list-review" align="right">
													<div class="order-list-review-title" style="display:inline-block">訂單金額 (2 商品):</div>
													<div class="order-list-review-price" style="display:inline-block">$258</div>
												</div>
												<p class="form-submit">  <button type="button" class="btn cancel-details" id="cancel-details" data-toggle="modal" data-target="#cancelDetailsModal">查看詳情</button>
												</p>
											</div>
										<!-- 取消 tab4 END-->	
											
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
                  </div>
                  <!--//銷售清單列表-->
                  
                  <!--我的評價-->
                  <div id="rating_sell" class="tab-pane fade">
                  
                  </div>
                  <!--//我的評價-->
                </div>
            </div>
            <!--//首頁左半邊-銷售管理-->
          </div>
          <!--頁籤項目-銷售管理內容-->
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



<!--===============================================================================================-->

<!-- 已完成 評價 Modal -->
  <div class="modal fade" id="ratingModal" role="dialog">
    <div class="modal-dialog modal-lg">
    
      <!-- 已完成 評價  Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">評價此商品買家</h4>
        </div>
        <div class="modal-body">
          <div class="host">
			<a href="agnes" target="_blank" class="photo" style="background-image: url(https://img.triplisher.com/USERIMG/133.jpg)">
			</a>
			<span class="text">	
				<a href="agnes" target="_blank">Agnes Kang</a>	
			</span>
			</div>
			<hr class="divider-w pt-20" style="margin-top: 30px;">
			<ul class="list-inline" data-rating="0" title="Average Rating -0">
			<li title="1" id="6-1" data-index="1" data-business_id="6" data-rating="0" class="rating" style="cursor: pointer; color: rgb(255, 204, 0); font-size: 16px;">★</li>
			<li title="2" id="6-2" data-index="2" data-business_id="6" data-rating="0" class="rating" style="cursor: pointer; color: rgb(255, 204, 0); font-size: 16px;">★</li>
			<li title="3" id="6-3" data-index="3" data-business_id="6" data-rating="0" class="rating" style="cursor: pointer; color: rgb(255, 204, 0); font-size: 16px;">★</li>
			<li title="4" id="6-4" data-index="4" data-business_id="6" data-rating="0" class="rating" style="cursor: pointer; color: rgb(255, 204, 0); font-size: 16px;">★</li>
			<li title="5" id="6-5" data-index="5" data-business_id="6" data-rating="0" class="rating" style="cursor: pointer; color: rgb(204, 204, 204); font-size: 16px;">★</li>
			</ul>
			<div>跟我們分享你的經驗吧!</div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
          <button type="button" class="btn btn-info" data-dismiss="modal">完成</button>
        </div>
      </div>
   <!-- Modal 已完成 評價 content END-->    
    </div>
  </div>   
<!-- Modal 已完成 評價 END -->

<!-- 待收貨 確認到貨 Modal  -->
  <div class="modal fade" id="confirmDeliveryModal" role="dialog">
    <div class="modal-dialog modal-lg">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">確認到貨</h4>
        </div>
        <div class="modal-body">
          <div>確認商品到貨了嗎?</div>
          <div>尚未到貨請點選取消，確認到貨請點選完成!</div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
          <button type="button" class="btn btn-info" data-dismiss="modal">完成</button>
        </div>
      </div>
<!-- 待收貨 確認到貨 Modal CONTENT END -->      
    </div>
  </div>
<!-- 待收貨 確認到貨 Modal END -->  

<!--待出貨 取消訂單  Modal -->
  <div class="modal fade" id="cancelOrderModal" role="dialog">
    <div class="modal-dialog modal-lg">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">取消原因</h4>
        </div>
        <div class="modal-body">
        	<div>請選擇取消原因</div>
         <select class="selectpicker">
		  <option>買家要求取消</option>
		  <option>缺貨</option>
		  <option>收件地址不在運送範圍內</option>
		  <option>其他(例如 不想賣了)</option>
		 </select>

        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">離開</button>
          <button type="button" class="btn btn-info" data-dismiss="modal">取消訂單</button>
        </div>
      </div>
<!--待出貨 取消訂單  Modal CONTENT END -->       
    </div>
  </div>
<!--待出貨 取消訂單  Modal END -->   

<!--取消 取消詳情 Modal -->
  <div class="modal fade" id="cancelDetailsModal" role="dialog">
    <div class="modal-dialog modal-lg">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">取消訂單詳情</h4>
        </div>
        <div class="modal-body">
          <div>取消人<span>&nbsp;&nbsp;&nbsp;買家</span></div>
          <div>取消時間 <span>&nbsp;&nbsp;&nbsp;2018-07-02</span></div>
          <div>取消原因 <span>&nbsp;&nbsp;&nbsp;其他(例如 不想買了)</span></div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">離開</button>
        </div>
      </div>
 <!--取消 取消詳情 Modal CONTENT END-->    
    </div>
  </div>
 <!--取消 取消詳情 Modal END-->   

<!-- 待出貨 確認商品出貨 Modal -->
  <div class="modal fade" id="shipOrderModal" role="dialog">
    <div class="modal-dialog modal-lg">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">確認商品出貨</h4>
        </div>
        <div class="modal-body">
          <div>寄件編號<span>&nbsp;&nbsp;&nbsp;<input type="text" name="shipping-id" id="shipping-id" style="width: 300px;"></span></div>
         
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">離開</button>
           <button type="button" class="btn btn-info" data-dismiss="modal">完成</button>
        </div>
      </div>
<!-- 待出貨 確認商品出貨 Modal CONTENT END-->      
    </div>
  </div>
<!-- 待出貨 確認商品出貨 Modal END--> 

      
<!--===============================================================================================-->
<!-- 收藏商品 JS-->
<script>
	  	$('.wish-add-btn').on('click', function(e) {
		  e.preventDefault();
		//$('.wish-add a').toggleClass('added');
		 if($(this).hasClass('added')){
			 $(this).removeClass('added');
		 }else{
			 $(this).addClass('added');
		 }

		});

</script>
<!-- 收藏商品 JS END -->


<!-- 評價商品 JS -->
<script>
 			$(document).on('mouseenter', '.rating', function() {
				var index = $(this).data("index");
				var business_id = $(this).data('business_id');
				remove_background(business_id);
				for (var count = 1; count <= index; count++) {
					$('#' + business_id + '-' + count).css('color', '#ffcc00');
				}

			});

			function remove_background(business_id) {
				for (var count = 1; count <= 5; count++) {
					$('#' + business_id + '-' + count).css('color', '#ccc');
				}
			}

			$(document).on('mouseleave', '.rating', function() {
				var index = $(this).data("index");
				var business_id = $(this).data('business_id');
				var rating = $(this).data("rating");
				remove_background(business_id);
				//alert(rating);
				for (var count = 1; count <= rating; count++) {
					$('#' + business_id + '-' + count).css('color', '#ffcc00');
				}
			});
			
			$(document).on('click', '.rating', function() {
				var index = $(this).data("index");
				var business_id = $(this).data('business_id');
				for (var count = 1; count <= index; count++) {
					$('#' + business_id + '-' + count).css('color', '#ffcc00');
				}

			});

 </script> 
<!-- 評價商品 JS END-->



</body>

</html>
