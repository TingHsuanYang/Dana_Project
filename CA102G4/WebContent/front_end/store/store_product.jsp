<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.product.model.*"%>
<%@ page import="com.productWishlist.model.*"%>
<%@ page import="com.productCategory.model.*"%>
<%@ page import="com.mem.model.*" %>

<%
    ProductService productSvc = new ProductService();
    Integer prod_id = new Integer(request.getParameter("prod_id"));
    ProductVO productVO =  productSvc.getOneProduct(prod_id);
    pageContext.setAttribute("productVO",productVO);
    //查看照片欄位的照片，有就加到list
    List<String> list = new ArrayList<String>();
    if(productVO.getProduct_photo_1() != null && productVO.getProduct_photo_1().length>0){
    	list.add(productVO.getProduct_photo_1_base());
    }
    if(productVO.getProduct_photo_2() != null && productVO.getProduct_photo_2().length>0){
    	list.add(productVO.getProduct_photo_2_base());
    }
    if(productVO.getProduct_photo_3()!= null && productVO.getProduct_photo_3().length>0){
    	list.add(productVO.getProduct_photo_3_base());
    }
    if(productVO.getProduct_photo_4()!= null && productVO.getProduct_photo_4().length>0){
    	list.add(productVO.getProduct_photo_4_base());
    }
    if(productVO.getProduct_photo_5() != null && productVO.getProduct_photo_5().length>0){
    	list.add(productVO.getProduct_photo_5_base());
    }
    pageContext.setAttribute("list",list);
    
    //取出會員名稱
    MemberService memSvc = new MemberService();
    MemberVO memberVO = memSvc.getOneMember(productVO.getProduct_mem_id());
	pageContext.setAttribute("memName",memberVO.getMem_Name()); 

%>

<jsp:useBean id="productWishlistSvc" scope="page" class="com.productWishlist.model.ProductWishlistService" />
<jsp:useBean id="productCategorySvc" scope="page" class="com.productCategory.model.ProductCategoryService" />

<!DOCTYPE html>
<html>
	<head>
		<!-- 網頁title -->
		<title>Travle Maker</title>
		<!-- //網頁title -->
		<!-- 指定螢幕寬度為裝置寬度，畫面載入初始縮放比例 100% -->
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- //指定螢幕寬度為裝置寬度，畫面載入初始縮放比例 100% -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<!-- 設定網頁keywords -->
		<meta name="keywords" content="TravleMaker,travlemaker,自助旅行" />
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
	    <link href="<%=request.getContextPath()%>/front_end/css/all/index_bootstrap.css" rel="stylesheet" type="text/css" media="all" />
	    <script src="<%=request.getContextPath()%>/front_end/js/all/index_bootstrap.js"></script>
	    <!-- //bootstrap-css -->
	    
	    <!-- 套首頁herder和footer css -->
	    <link href="<%=request.getContextPath()%>/front_end/css/all/index_style_header_footer.css" rel="stylesheet" type="text/css" media="all" />
	    <!-- //套首頁herder和footer css -->
	    
	    <!-- font-awesome icons -->
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" 
		integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
		<!-- //font-awesome icons -->
		
		<!-- font字體 -->
		<link href='https://fonts.googleapis.com/css?family=Oswald:400,700,300' rel='stylesheet' type='text/css'>
		<link href='https://fonts.googleapis.com/css?family=Pacifico' rel='stylesheet' type='text/css'>
		<!-- //font字體 -->
	
		<!--store 自定義的css -->
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/css/store/util.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/css/store/main.css">
	    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/css/store/store_banner.css" media="all" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/css/store/store_header.css" media="all" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/css/store/store_footer.css" media="all" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/css/store/store_product.css" media="all" />

		 <!-- //store 自定義的css -->

	
	    <!-- store 自定義的js -->
 	    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
		
 	    <!-- //store 自定義的js -->
	
	<style>
		p{
			color:#555;
		}
		
		.carousel-inner > .item > img,
		.carousel-inner > .item > a > img {
		  height: 370px;   
		  margin: auto;
		}	
	</style>
	
	</head>

	<body>
		<!-- banner -->
		<div class="banner about-bg" id="myHeader">
			<div class="top-banner about-top-banner">
				<div class="container">
					<div class="top-banner-left">
						<ul>
							<li><i class="fa fa-phone" aria-hidden="true"></i>
								<a href="tel:034257387"> 03-4257387</a>
							</li>
							<li>
								<a href="mailto:TravleMaker@gmail.com"><i class="fa fa-envelope" aria-hidden="true"></i> TravleMaker@gmail.com</a>
							</li>
						</ul>
					</div>
					<div class="top-banner-right">
						<ul>
							<li>
								<a class="top_banner" href="#"><i class="fa fa-user" aria-hidden="true"></i></a>
							</li>
							<li>
								<a class="top_banner" href="store_shoppingcart.html"><i class="fa fa-shopping-cart" aria-hidden="true"></i></a>
							</li>
							<li>
								<a class="top_banner" href="#"><i class="fa fa-envelope" aria-hidden="true"></i></a>
							</li>
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
									<li>
										<a href="news.html">最新消息</a>
									</li>
									<li>
										<a href="tour.html">景點介紹</a>
									</li>
									<li>
										<a href="plan.html">行程規劃</a>
									</li>
									<li>
										<a href="blog.html">旅遊記</a>
									</li>
									<li>
										<a href="ask.html">問答區</a>
									</li>
									<li>
										<a href="galley.html">照片牆</a>
									</li>
									<li>
										<a href="chat.html">聊天室</a>
									</li>
									<li>
										<a href="together.html">揪團</a>
									</li>
									<li>
										<a href="<%=request.getContextPath()%>/front_end/store/store.jsp">交易平台</a>
									</li>
									<li>
										<a href="advertisement.html">專欄</a>
									</li>

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
		<!-- store -->
		<div class="main" style="min-height: 1px;">
			<section class="module-small module-small-shop">
				<div class="container">
					<nav class="prod-breadcrumb mt-0">
							<a href="<%=request.getContextPath()%>/front_end/index.jsp">首頁</a>&nbsp;/&nbsp;<a href="<%=request.getContextPath()%>/front_end/store/store.jsp">交易平台</a>&nbsp;/&nbsp;${productCategorySvc.getOneProductCategory(productVO.product_category_id).product_category_name}&nbsp;/&nbsp;${productVO.product_name}
					</nav>
				</div>
			</section>
			
			<section class="bgwhite p-t-55 p-b-65">
				<div class="container">
					<div class="row">
						<div class="col-sm-6 col-md-6 col-lg-6 p-b-50">
							<div id="myCarousel" class="carousel slide" data-ride="carousel">
								  <!-- Indicators -->
								  <ol class="carousel-indicators">
								    	<c:forEach var="pic_base_str" items="${list}" varStatus="status">
					   			    	 
								    		<c:if test="${status.index == 0}"> 
												<li data-target="#myCarousel" data-slide-to="${status.index}" class="active"></li>
											</c:if>
											<c:if test="${status.index != 0}"> 
												<li data-target="#myCarousel" data-slide-to="${status.index}"></li>
											</c:if>
										</c:forEach>
								  </ol>
								
								  <!-- Wrapper for slides -->
								  <div class="carousel-inner">
									  <c:forEach var="pic_base_str" items="${list}" varStatus="status">
								    		
											<c:if test="${status.index== 0}">  
												<div class="item active">
								     			 	<img src="data:image/jpeg;base64,${pic_base_str}" onerror="this.src='<%=request.getContextPath()%>/front_end/images/store/no-image-icon-15.png'">
												 </div>
										    </c:if>
											<c:if test="${status.index!= 0}"> 
												<div class="item">
								     			 	<img src="data:image/jpeg;base64,${pic_base_str}" onerror="this.src='<%=request.getContextPath()%>/front_end/images/store/no-image-icon-15.png'">
												 </div>
											 </c:if>
											
										</c:forEach>
								  </div>
								
								  <!-- Left and right controls -->
								  <a class="left carousel-control" href="#myCarousel"  role="button" data-slide="prev">
								    <span class="glyphicon glyphicon-chevron-left"></span>
								    <span class="sr-only">Previous</span>
								  </a>
								  <a class="right carousel-control" href="#myCarousel"  role="button" data-slide="next">
								    <span class="glyphicon glyphicon-chevron-right"></span>
								    <span class="sr-only">Next</span>
								  </a>
								</div>
						</div>
						
						<div class="col-sm-6 col-md-6 col-lg-6 w-size14 respon5 p-l-50">
							<h4 class="product-detail-name m-text16 p-b-20" style="min-height: 130px;">
								${productVO.product_name}
							</h4>
						
							<span class="m-text17">
								$ ${productVO.product_price}
							</span>
							<div style="display:inline-block;float: right;">
								<span class="wish-add m-text6 p-r-5 p-l-5" style="font-size: 22px;">
											<a href="#" class="wish-add-btn"> 
											<i class="far fa-heart" aria-hidden="true"></i>
											<i class="fas fa-heart dis-none" aria-hidden="true"></i></a>
								</span>
								<span class="wish-like-text m-text6 p-r-5" style="font-size: 22px;">
									${productWishlistSvc.getLikesByProductid(productVO.product_id).size()}
								</span>
							</div>
							<div class="host p-t-30">
									<a href="agnes" target="_blank" class="photo" style="background-image: url(https://img.triplisher.com/USERIMG/133.jpg)">
									</a>
									<span class="text" style="display:inline-block;height: 10px;position: absolute;bottom: 160px;right: 310px;letter-spacing: 2px;">	
										<a href="agnes" target="_blank" style="display:inline-block">${memName}</a>	
									</span>
									<span class="star" style="display:inline-block ;position: absolute;height: 10px;bottom: 135px;right: 265px;">	
										<ul class="list-inline" data-rating="0" title="Average Rating -0">
											<li title="1" id="6-1" data-index="1" data-business_id="6" data-rating="0" class="rating" style="cursor: pointer; color: rgb(255, 204, 0); font-size: 16px;">★</li>
											<li title="2" id="6-2" data-index="2" data-business_id="6" data-rating="0" class="rating" style="cursor: pointer; color: rgb(204, 204, 204); font-size: 16px;">★</li>
											<li title="3" id="6-3" data-index="3" data-business_id="6" data-rating="0" class="rating" style="cursor: pointer; color: rgb(204, 204, 204); font-size: 16px;">★</li>
											<li title="4" id="6-4" data-index="4" data-business_id="6" data-rating="0" class="rating" style="cursor: pointer; color: rgb(204, 204, 204); font-size: 16px;">★</li>
											<li title="5" id="6-5" data-index="5" data-business_id="6" data-rating="0" class="rating" style="cursor: pointer; color: rgb(204, 204, 204); font-size: 16px;">★</li>
										</ul>
									</span>
							</div>
							<form class="cart p-t-30" action="" method="post" enctype="multipart/form-data">
								<div class="quantity"><input type="number" id="qty_${productVO.product_id}" class="input-text qty" step="1" min="1" max="${productVO.product_stock}" name="quantity" value="1" title="Qty" size="4"></div>
								<button type="submit" name="add-to-cart" class="flex-c-m size1 bg4 hov4 s-text1 trans-0-4 add-to-cart-btn">加入購物車</button>
							</form>
							
							<form class="chat p-t-50" action="" method="post" enctype="multipart/form-data">
								<button type="submit" name="chat-to-seller" class="flex-c-m size1 bg4 hov4 s-text1 trans-0-4 chat-to-seller-btn"><i class="fa fa-comments" aria-hidden="true"></i>聊聊</button>
							</form>
							<form class="report p-t-50" action="" method="post" enctype="multipart/form-data" style='display:inline;'> 
								<button type="submit" name="report-prod" class="flex-c-m size1 bg4 hov4 s-text1 trans-0-4 report-prod-btn"><i class="fa fa-flag" aria-hidden="true"></i>檢舉</button>
							</form>
							
						</div>
						
					</div>	
					
					
					<div class="row">
						<div class="col-sm-12 col-md-12 col-lg-12 p-b-50">
							<ul class="nav nav-tabs">
							  <li class="active"><a data-toggle="tab" href="#home">商品詳情</a></li> 
							</ul>
							
							<div class="tab-content">
							  <div id="home" class="tab-pane fade in active p-l-50 p-t-50">
							    <p class="fs-20">${productVO.product_descr}</p>
							  </div>
							</div>
						</div>
					</div>
				</div>
			</section>
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
								<li>
									<a href="about.html">關於Travle Maker</a>
								</li>
								<li>
									<a href="about.html">聯絡我們</a>
								</li>
								<li>
									<a href="about.html">常見問題</a>
								</li>
							</ul>
						</div>
					</div>
					<div class="col-md-3 footer-grid">
						<div class="footer-grid-heading">
							<h4>網站條款</h4>
						</div>
						<div class="footer-grid-info">
							<ul>
								<li>
									<a href="about.html">服務條款</a>
								</li>
								<li>
									<a href="services.html">隱私權條款</a>
								</li>
							</ul>
						</div>
					</div>
					<div class="col-md-3 footer-grid">
						<div class="footer-grid-heading">
							<h4>社群</h4>
						</div>
						<div class="social">
							<ul>
								<li>
									<a href="https://www.facebook.com/InstaBuy.tw/"><i class="fab fa-facebook"></i></a>
								</li>
								<li>
									<a href="https://www.instagram.com/"><i class="fab fa-instagram"></i></a>
								</li>
								<li>
									<a href="#"><i class="fab fa-line"></i></a>
								</li>
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
						<a href="index.html" target="_blank" title="TravleMaker">TravleMaker</a>
					</p>
				</div>
			</div>
		</div>
		<!-- //footer -->

<!--===============================================================================================-->
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
	
</body>
</html>