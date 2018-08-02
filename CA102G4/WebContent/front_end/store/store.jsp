<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.product.model.*"%>
<%@ page import="com.productWishlist.model.*"%>
<%@ page import="com.mem.model.*" %>
<%
    ProductService productSvc = new ProductService();
    List<ProductVO> list = productSvc.getAll();
    pageContext.setAttribute("list",list);
    
    boolean login_state = false ;
	Object login_state_temp = session.getAttribute("login_state");
	
	//確認登錄狀態
	if(login_state_temp != null ){
		login_state= (boolean) login_state_temp ;
	}
	
	//若登入狀態為是true
	/***************取出登入者會員資訊******************/
	if( login_state == true){
		String memId = ((MemberVO)session.getAttribute("memberVO")).getMem_Id();
		pageContext.setAttribute("memId",memId);
	}

	//為了join(寫法有servlet3.0限制)
	MemberService memSvc = new MemberService();
	pageContext.setAttribute("memSvc",memSvc); 
 
%>
<jsp:useBean id="productWishlistSvc" scope="page" class="com.productWishlist.model.ProductWishlistService" />
<jsp:useBean id="productCategorySvc" scope="page" class="com.productCategory.model.ProductCategoryService" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
	    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/css/store/nouislider.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/css/store/seller_prod_mgt.css">
		 <!-- //store 自定義的css -->

	
	    <!-- store 自定義的js -->
 	    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

 	    <!-- //store 自定義的js -->
		<style>
			#myHeader{
				position: fixed;
			}
			.banner {
		   		left: 0%;
		   		right:0%; 
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
								<a class="top_banner" href="store_shoppingcart.html"><i class="fa fa-shopping-cart shopping-cart" aria-hidden="true"></i></a>
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
		
		<!-- store banner-->
			<div class="parallax" style="background-image: url('<%=request.getContextPath()%>/front_end/images/store/header.jpg');">
				<div class="page-header-module module">
					<div class="container">
						<div class="row">
							<div class="col-sm-6 col-sm-offset-3">
								<h1 class="module-title font-alt">Shop</h1>
								<div class="module-subtitle font-serif mb-0">Shop all products</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		<!-- //store banner -->
			<section class="module-small module-small-shop">
				<div class="container">
					<nav class="prod-breadcrumb mt-0">
							<a href="<%=request.getContextPath()%>/front_end/index.jsp">首頁</a>&nbsp;/&nbsp;交易平台
					</nav>
					<!-- 排序方式 -->
					<form class="prod-ordering" method="get">
						<select name="orderby" class="orderby">
							<option value="menu_order" selected="selected">預設排序</option>
							<option value="popularity">依熱門度排序</option>
							<option value="rating">依賣家評價排序</option>
							<option value="date">依上架時間排序</option>
							<option value="price">依最低價排序</option>
							<option value="price-desc">依最高價排序</option>
						</select>
						<input type="hidden" name="paged" value="1">
					</form>
					<!-- //排序方式 -->
				<!-- 內容 -->
			
			<section class="bgwhite p-t-55 p-b-65">
				<div class="container">
					<div class="row">
						<div class="col-sm-6 col-md-4 col-lg-3 p-b-50">
							<div class="leftbar p-r-20 p-r-0-sm">
								<!--  -->
								<h4 class="m-text14 p-b-7">
									分類
								</h4>
		
								<ul class="p-b-54">
									<li class="p-t-4">
										<a href="#" class="s-text13 active1">
											全部
										</a>
									</li>
								<c:forEach var="productCategoryVO" items="${productCategorySvc.all}">
									<li class="p-t-4">
										<a href="#" class="s-text13" id="${productCategoryVO.product_category_id}">
											${productCategoryVO.product_category_name}
										</a>
									</li>
								</c:forEach>
									
								</ul>

						<!-- 篩選 -->
						<h4 class="m-text14 p-b-32">
							篩選
						</h4>

						<div class="filter-price p-t-22 p-b-50 bo3">
							<div class="m-text15 p-b-17">
								價格
							</div>

							<div class="wra-filter-bar">
								<div id="filter-bar"></div>
							</div>

							<div class="flex-sb-m flex-w p-t-16">
								<div class="w-size11">
									<!-- Button -->
									<button class="flex-c-m size4 bg4 hov1 s-text14 trans-0-4">
										篩選
									</button>
								</div>

								<div class="s-text3 p-t-10 p-b-10">
									範圍: $<span id="value-lower">610</span> - $<span id="value-upper">980</span>
								</div>
							</div>
						</div>

						<div class="search-product pos-relative bo4 of-hidden">
							<input class="s-text7 size6 p-l-23 p-r-50" type="text" name="search-product" placeholder="搜尋商品...">

							<button class="flex-c-m size5 ab-r-m color2 color0-hov trans-0-4">
								<i class="fs-12 fa fa-search" aria-hidden="true"></i>
							</button>
						
						</div>	
						<div class="flex-sb-m flex-w p-t-16">
						<div class="w-size11">
							<!-- Button -->
							<button class="flex-c-m size4 bg4 hov1 s-text14 trans-0-4">
								搜尋
							</button>
						</div>
						</div>
					</div>
				</div>

				<div class="col-sm-6 col-md-8 col-lg-9 p-b-50">
				<%@ include file="page1.file"%>
				<div class="page-top flex-sb-m flex-w p-b-35">
						<span class="s-text8 p-t-5 p-b-5">
							第<%=whichPage%>/<%=pageNumber%>頁  共<%=rowNumber%>筆
						</span>
				</div>
				
					<!-- Product -->
					<div class="row">
					
					<c:forEach var="productVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
						<div class="col-sm-12 col-md-6 col-lg-4 p-b-50">
							<!-- Block2 -->
							<div class="block2">
								<div class="block2-img wrap-pic-w of-hidden pos-relative block2-labelnew" style="height:16rem">
									<img class="prod-img" src="data:image/jpeg;base64,${productVO.product_photo_1_base}" onerror="this.src='<%=request.getContextPath()%>/front_end/images/store/no-image-icon-15.png'"  alt="IMG-PRODUCT">
									<div class="block2-overlay trans-0-4">
										<div class="block2-btn-addcart w-size1 trans-0-4">
											<!-- Shopping Cart Button -->
											<c:if test="${productVO.product_mem_id != memId}">
												<button id="${productVO.product_id}" class="add-to-cart flex-c-m size1 bg4 hov1 s-text1 trans-0-4">
													加入購物車
												</button>
											</c:if>
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
	<script type="text/javascript" src="<%=request.getContextPath()%>/front_end/js/store/nouislider.js"></script>
	<script type="text/javascript">
		/*[ No ui ]
	    ===========================================================*/
	    var filterBar = document.getElementById('filter-bar');

	    noUiSlider.create(filterBar, {
	        start: [ 50, 200 ],
	        connect: true,
	        range: {
	            'min': 50,
	            'max': 200
	        }
	    });

	    var skipValues = [
	    document.getElementById('value-lower'),
	    document.getElementById('value-upper')
	    ];

	    filterBar.noUiSlider.on('update', function( values, handle ) {
	        skipValues[handle].innerHTML = Math.round(values[handle]) ;
	    });
	</script>
<!--========================收藏商品=======================================================================-->

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
<!--========================購物車動畫=======================================================================-->
<script src="https://static.codepen.io/assets/common/stopExecutionOnTimeout-41c52890748cd7143004e05d3c5f786c66b19939c4500ce446314d1748483e13.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
	<script>
	$(document).ready(function () {
	$('.add-to-cart').on('click', function () {
        var cart = $('.shopping-cart');
        console.log(cart.offset())
        var imgtodrag = $(this).parent().parent().parent().find("img").eq(0);
        if (imgtodrag) {
            var imgclone = imgtodrag.clone()
                .offset({
                top: imgtodrag.offset().top,
                left: imgtodrag.offset().left
            }).css({
					'opacity': '0.5',
                    'position': 'absolute',
                    'height': '150px',
                    'width': '150px',
                    'z-index': '100'
            }).appendTo($('body'))
            .animate({
               		'top': cart.offset().top + 10,
                    'left': cart.offset().left + 10,
                    'width': 75,
                    'height': 75
            }, 1000, 'easeInOutExpo');
            
            

            imgclone.animate({
                'width': 0,
                    'height': 0
            }, function () {
                $(this).detach()
            });
        }
    });
	
	});
<!--===============================================================================================-->
</script>	
</body>
</html>