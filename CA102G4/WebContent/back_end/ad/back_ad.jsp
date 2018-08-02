<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ad.model.*" %>

<%
	AdService adSvc = new AdService();
	List<AdVO> list = adSvc.getAllAD();
	pageContext.setAttribute("list", list);
%>

<!DOCTYPE HTML>
<html>
    <head>
        <title>Travel Maker 後台   - 專欄廣告管理</title>
        <meta charset="UTF-8">
        <!-- Bootstrap CSS v3.3.4 -->
        <link rel="stylesheet" href="<%=request.getContextPath()%>/back_end/css/all/bootstrap.css">

        <!-- 自定義的CSS -->
        <link rel="stylesheet" href="<%=request.getContextPath()%>/back_end/css/all/back_all.css">

        <!-- Font Awesome JS -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">


        <!-- jQuery CDN - Slim version (=without AJAX) -->
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>

        <!-- Bootstrap JS v3.3.4-->
        <script src="<%=request.getContextPath()%>/back_end/js/all/bootstrap.js"></script>
        
        <!-- 自己定義的JS檔案-->
        <script src="<%=request.getContextPath()%>/back_end/js/all/back_all.js"></script>
        
        
        <!-- font字體 -->
        <link href='https://fonts.googleapis.com/css?family=Oswald:400,700,300' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Pacifico' rel='stylesheet' type='text/css'>
        <!-- //font字體 -->
		
		<!-- AD頁面自己定義的CSS-->
        <link rel="stylesheet" href="<%=request.getContextPath()%>/back_end/css/ad/back_ad.css">
        
 
    </head>
    <body>
        <div class="wrapper">
                <!-- Sidebar  -->
            <nav id="sidebar" class="navbar-fixed-left">
                <div class="sidebar-header">
                    <h3>Travel Maker</h3>
                    <strong>TM</strong>
                </div>

                <ul class="list-unstyled components">
                    <li class="active">
                        <a href="<%=request.getContextPath()%>/back_end/back_index.jsp">
                            <i class="fas fa-home"></i>
                            回首頁
                        </a>
                    </li>
                    
                    <li>
                        <li class="dropdown">
                            <a href="#auth_Submenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">
                                <i class="fas fa-users"></i>
                                權限管理
                            </a>

                            <ul class="dropdown-menu" id="auth_Submenu">
                                <li>
                                    <a href="#">管理員</a>
                                </li>
                                <li>
                                    <a href="#">會員</a>
                                </li>
                            </ul>

                        </li>
                        
                        <li>
                            <a href="#">
                                <i class="fas fa-newspaper"></i>
                                最新消息管理
                            </a>
                        </li>
                        
                        <li>
                            <a href="#">
                                <i class="fas fa-image"></i>
                                景點管理
                            </a>
                        </li>
                       
                        <li class="dropdown">
                            <a href="#category_Submenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">
                                <i class="fas fa-tag"></i>
                                標籤管理
                            </a>
                            <ul class="dropdown-menu" id="category_Submenu">
                                <li>
                                    <a href="Back_TagBlog.html">旅遊記</a>
                                </li>
                                <li>
                                    <a href="#">問答區</a>
                                </li>
                            </ul>
                        </li>
                        
                        <li class="dropdown">
                            <a href="#report_Submenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle" aria-haspopup="true" >
                                <i class="fas fa-comment-dots"></i>
                                檢舉管理
                            </a>
                            <ul class="dropdown-menu" id="report_Submenu">
                                <li>
                                    <a href="#">會員檢舉</a>
                                </li>
                                <li>
                                    <a href="Back_ReportBlog.html">旅遊記檢舉</a>
                                </li>
                                <li>
                                    <a href="#">問答區檢舉</a>
                                </li>
                                <li>
                                    <a href="#">照片牆檢舉</a>
                                </li>
                                <li>
                                    <a href="#">揪團檢舉</a>
                                </li>
                                <li>
                                    <a href="#">商品檢舉</a>
                                </li>
                            </ul>
                        </li>
                        
                        <li>
                            <a href="#">
                                <i class="fas fa-shopping-cart"></i>
                                交易款項管理
                            </a>
                        </li>
                        
                        <li>
                            <a href="<%=request.getContextPath()%>/back_end/ad/back_ad.jsp">
                                <i class="fas fa-audio-description"></i>
                                專欄廣告管理
                            </a>
                        </li>
                        
                        <li class="dropdown">
                            <a href="#aboutUS_Submenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">
                                <i class="fas fa-briefcase"></i>
                                關於我們管理
                                </a>
                            <ul class="dropdown-menu" id="aboutUS_Submenu">
                                <li>
                                    <a href="#">關於我們</a>
                                </li>
                                <li>
                                    <a href="#">FAQ</a>
                                </li>
                            </ul>
                        </li>

                    </li>
                </ul>

            </nav>

            <!-- Page Content  -->
            <div id="content">

                <nav class="navbar"> <!--navbar-expand-lg navbar-light bg-light-->
                    <div class="container-fluid">
                        <!--側邊欄按鈕-->
                        <button type="button" id="sidebarCollapse" class="btn btn-info">
                            <i class="fas fa-align-left"></i>
                        </button>
                        <span style="float: right">
                        <button type="button" class="btn btn-info" onclick="location.href='<%=request.getContextPath()%>/back_end/back_login.jsp'">
                            登出
                            <i class="fas fa-sign-out-alt"></i>
                        </button>
                        </span>
                    </div>
                </nav>
                
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                        	專欄廣告管理
                        	<button class="btn btn-primary" onclick="location.href='<%=request.getContextPath()%>/back_end/ad/back_addad.jsp'">
                        		<i class="fas fa-plus"></i> 新增廣告
                        	</button>
                        </h1>
                        
                    </div>
                </div>
                
                <div class="row">
                	<div class="col-lg-12" style="text-align:left">
                    	
                	</div>
                </div>
                
                
                <div class="row">
                    <div class="col-lg-12">
                        <!-- 這邊要放所有廣告 -->
                        <table class="table">
                        	<thead>
                        		<th>編號</th>
                        		<th>標題</th>
                        		<th>簡介</th>
                        		<th>連結</th>
                        		<th>圖片</th>
                        		<th>狀態</th>
                        		<th>修改</th>
                        		<th>刪除</th>
                        	</thead>
                        	<tbody>
								<c:forEach var="advo" items="${list}">
									<tr>
										<td>${advo.ad_ID}</td>
										<td>${advo.ad_Title}</td>
										<td>${advo.ad_Text}</td>
										<td>${advo.ad_Link}</td>
										<td><img src="<%=request.getContextPath()%>/ADPicReader?AD_ID=${advo.ad_ID}"></td>
										<td>
											<form action="<%=request.getContextPath()%>/ad.do" method="post">
											<input type="hidden" name="adId" value="${advo.ad_ID}">
											<input type="hidden" name="action" value="UpdateStat">
											<c:choose>
									            <c:when test="${advo.ad_Stat == 0}">
													<input type="hidden" name="stat" value="1">
													<button type="submit" class="btn btn-warning"><i class="fas fa-bell"></i>上架廣告</button>
									            </c:when>
									            <c:otherwise>
													<input type="hidden" name="stat" value="0">
													<button type="submit" class="btn btn-success"><i class="fas fa-arrow-down"></i>下架廣告</button>	
									            </c:otherwise>
									        </c:choose>
									        </form>
										</td>
										<td>
											<form action="<%=request.getContextPath()%>/ad.do" method="post">
												<input type="hidden" name="adId" value="${advo.ad_ID}">
												<input type="hidden" name="action" value="getOne_For_Update">
												
												<c:choose>
										            <c:when test="${advo.ad_Stat == 0}">
														<input type="submit" class="btn btn-primary" value="修改">
										            </c:when>
										            <c:otherwise>
														<input type="submit" class="btn btn-primary" value="無法修改" disabled="disabled">	
										            </c:otherwise>
										        </c:choose>
												
											</form>
										</td>
										<td>
											<form action="<%=request.getContextPath()%>/ad.do" method="post" onSubmit="return confirm('確認要刪除嗎?');">
												<input type="hidden" name="adId" value="${advo.ad_ID}">
												<input type="hidden" name="action" value="delete">
												
												<c:choose>
										            <c:when test="${advo.ad_Stat == 0}">
														<input type="submit" class="btn btn-danger" value="刪除">
										            </c:when>
										            <c:otherwise>
														<input type="submit" class="btn btn-danger" value="無法刪除" disabled="disabled">	
										            </c:otherwise>
										        </c:choose>
												
											</form>
										</td>
									</tr>								
								</c:forEach>
                        	</tbody>

                        </table>                
                    </div>
                </div>

                
            </div>
        </div>
        
    </body>
</html>