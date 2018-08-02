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
	    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/css/store/store_cart.css" media="all" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/css/store/store_header.css" media="all" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/css/store/store_footer.css" media="all" />

		 <!-- //store 自定義的css -->

	
	    <!-- store 自定義的js -->
 	    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

 	    <!-- //store 自定義的js -->
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
			<section class="overlay bg-title-page p-t-40 p-b-50 flex-col-c-m" style="background-image: url('<%=request.getContextPath()%>/front_end/images/store/header.jpg');opacity: 0.8;filter: grayscale(40%);">
				<h2 class="l-text2 t-center">
					購物車
				</h2>
			</section>
			<div class="container">
			    <div class="row p-t-100 p-b-50">
			        <div class="col-sm-12 col-md-10 col-md-offset-1">
			        	<div>
				            <table class="table table-hover">
				                <thead>
				                    <tr>
				                        <th class="col-sm-1 col-md-1"> </th>
				                        <th class="col-sm-6 col-md-4">商品</th>
				                        <th class="col-sm-1 col-md-1">數量</th>
				                        <th class="col-sm-1 col-md-1 text-center">單價</th>
				                        <th class="col-sm-1 col-md-1 text-center">總計</th>
				                        <th class="col-sm-1 col-md-1 text-center"> </th>
				                    </tr>
				                </thead>
				            </table>
			            </div>
			            <div class="p-b-50">
				            <div class="cart-store-header">
				            	<i class="fas fa-store-alt p-l-20"></i><a href="#" class="s-text3 p-l-10">李柴柴</a>
				            </div>
			            
			             <table class="table table-hover p-t-100">
			                <tbody>
			                    <tr>
			                    	<td class="col-sm-1 col-md-1">
				                 	  <input type="checkbox" class="form-check-input">
			                        </td>
			                        <td class="col-sm-6 col-md-4">
			                        <div class="media">
			                            <div class="pull-left m-b-10 m-t-10" href="#"> <img class="media-object" src="<%=request.getContextPath()%>/front_end/images/all/g6.jpg" style="width: 72px; height: 72px;"> </div>
			                            <div class="media-body">
			                                <h4 class="media-heading p-l-20 p-t-40 s-text3"><a href="#" class="s-text3">Product name</a></h4>
			                            </div>
			                        </div>
			                        </td>
			                        <td class="col-sm-1 col-md-1" style="text-align: center">
			                        <input type="number" class="form-control" value="3">
			                        </td>
			                        <td class="col-sm-1 col-md-1 text-center">$150</td>
			                        <td class="col-sm-1 col-md-1 text-center">$450</td>
			                        <td class="col-sm-1 col-md-1">
				                        <button type="button" class="btn remove-btn">
				                            <i class="fas fa-trash-alt"></i>
				                        </button>
			                        </td>
			                    </tr>
			                        <tr>
			                    	<td class="col-sm-1 col-md-1">
	 									<input type="checkbox" class="form-check-input">
			                        </td>
			                        <td class="col-sm-6 col-md-4">
			                        <div class="media">
			                            <div class="pull-left m-b-10 m-t-10" href="#"> <img class="media-object" src="images/g6.jpg" style="width: 72px; height: 72px;"> </div>
			                            <div class="media-body">
			                                <h4 class="media-heading p-l-20 p-t-40 s-text3"><a href="#" class="s-text3">Product name</a></h4>
			                            </div>
			                        </div>
			                        </td>
			                        <td class="col-sm-1 col-md-1" style="text-align: center">
			                        <input type="number" class="form-control" value="3">
			                        </td>
			                        <td class="col-sm-1 col-md-1 text-center">$150</td>
			                        <td class="col-sm-1 col-md-1 text-center">$450</td>
			                        <td class="col-sm-1 col-md-1">
				                        <button type="button" class="btn remove-btn">
				                            <i class="fas fa-trash-alt"></i>
				                        </button>
			                        </td>
			                    </tr>
			                </tbody>
			            </table>
			            </div>
			             <div class="p-b-50">
				            <div class="cart-store-header">
				            	<i class="fas fa-store-alt p-l-20"></i><a href="#" class="s-text3 p-l-10">李柴柴</a>
				            </div>
			            
			             <table class="table table-hover p-t-100">
			                <tbody>
			                    <tr>
			                    	<td class="col-sm-1 col-md-1">
				                 	  <input type="checkbox" class="form-check-input">
			                        </td>
			                        <td class="col-sm-6 col-md-4">
			                        <div class="media">
			                            <div class="pull-left m-b-10 m-t-10" href="#"> <img class="media-object" src="images/g6.jpg" style="width: 72px; height: 72px;"> </div>
			                            <div class="media-body">
			                                <h4 class="media-heading p-l-20 p-t-40 s-text3"><a href="#" class="s-text3">Product name</a></h4>
			                            </div>
			                        </div>
			                        </td>
			                        <td class="col-sm-1 col-md-1" style="text-align: center">
			                        <input type="number" class="form-control" value="3">
			                        </td>
			                        <td class="col-sm-1 col-md-1 text-center">$150</td>
			                        <td class="col-sm-1 col-md-1 text-center">$450</td>
			                        <td class="col-sm-1 col-md-1">
				                        <button type="button" class="btn remove-btn">
				                            <i class="fas fa-trash-alt"></i>
				                        </button>
			                        </td>
			                    </tr>
			                        <tr>
			                    	<td class="col-sm-1 col-md-1">
	 									<input type="checkbox" class="form-check-input">
			                        </td>
			                        <td class="col-sm-6 col-md-4">
			                        <div class="media">
			                            <div class="pull-left m-b-10 m-t-10" href="#"> <img class="media-object" src="images/g6.jpg" style="width: 72px; height: 72px;"> </div>
			                            <div class="media-body">
			                                <h4 class="media-heading p-l-20 p-t-40 s-text3"><a href="#" class="s-text3">Product name</a></h4>
			                            </div>
			                        </div>
			                        </td>
			                        <td class="col-sm-1 col-md-1" style="text-align: center">
			                        <input type="number" class="form-control" value="3">
			                        </td>
			                        <td class="col-sm-1 col-md-1 text-center">$150</td>
			                        <td class="col-sm-1 col-md-1 text-center">$450</td>
			                        <td class="col-sm-1 col-md-1">
				                        <button type="button" class="btn remove-btn">
				                            <i class="fas fa-trash-alt"></i>
				                        </button>
			                        </td>
			                    </tr>
			                </tbody>
			            </table>
			            </div>
			            <form method="post" action="#">
			            	<div>
				            	<div class="p-b-50">
				            		<div class="cart-total" style="float: right;display: block;">
				            			購買總金額 (4 個商品):<span>$409</span>
				            		</div>
				            	</div>
					            <div class="box-footer d-flex justify-content-between align-items-center" style="display:block">
					            	<div class="left-col"><a href="shop-category.html" class="btn btn-secondary mt-0">
					            		<i class="fa fa-chevron-left"></i> 繼續購買</a>
					            	</div>
					            	<div class="right-col">
				                      <button class="btn btn-secondary"><i class="fas fa-sync-alt"></i> 刷新購物車</button>
				                      <button type="submit" class="btn btn-template-outlined">去買單 <i class="fa fa-chevron-right"></i></button>
				                    </div>
					            </div>
				            </div>
			            </form>
			        </div>
			    </div>
			</div>
		</div>
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

<script src="https://static.codepen.io/assets/common/stopExecutionOnTimeout-41c52890748cd7143004e05d3c5f786c66b19939c4500ce446314d1748483e13.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
	<script>
	$(document).ready(function () {
	$('.add-to-cart').on('click', function () {
        var cart = $('.shopping-cart');
        var imgtodrag = $(this).parent().parent().parent().find("img").eq(0);
        if (imgtodrag) {
            var imgclone = imgtodrag.clone()
                .offset({
                top: imgtodrag.offset().top,
                left: imgtodrag.offset().left
            })
                .css({
                'opacity': '0.5',
                    'position': 'absolute',
                    'height': '150px',
                    'width': '150px',
                    'z-index': '100'
            })
                .appendTo($('body'))
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
</script>	
</body>
</html>