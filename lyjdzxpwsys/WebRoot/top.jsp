<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="dao.CommDAO"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <base href="<%=basePath%>">
    <meta name="description" content="Admin panel developed with the Bootstrap from Twitter.">
    <meta name="author" content="travis">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <%CommDAO dao = new CommDAO();  
  HashMap aboutmap = dao.select("select * from about where id=1").get(0);
  HashMap membersession = (HashMap)session.getAttribute("member");
  HashMap member = null;
  if(membersession!=null){
  	member = dao.select("select * from member where id="+membersession.get("id")).get(0);
  }%>
  <body>
    	<!-- SITE HEADER -->
	<header id="site-header" role="banner">
		<!-- HEADER TOP -->
		<div class="header-top">
			<div class="container">
				<div class="row">
					<div class="col-xs-12 col-sm-6 col-md-7">
						<!-- CONTACT INFO -->
						<div class="contact-info" style="    display: flex;
    align-items: center;
    height: 45px;
    font-size: 20px;
    font-weight: bold;">
							智慧景区票务系统
							</div>
						<!-- // CONTACT INFO -->
					</div>
					<div class="col-xs-12 col-sm-6 col-md-5">
						<ul class="actions unstyled clearfix">
							<li>
								<!-- SEARCH BOX -->
								<div class="search-box">
									<form action="goods.jsp" method="post">
										<div class="input-iconed prepend">
											<button class="input-icon"><i class="iconfont-search"></i></button>
											<label for="input-search" class="placeholder">Search here…</label>
											<input type="text" name="key1" id="key1" class="round-input full-width" required />
										</div>
									</form>
								</div>
								<!-- // SEARCH BOX -->
							</li>
							<%if(member!=null){%> 
							<li data-toggle="sub-header" data-target="#sub-cart">
								<!-- SHOPPING CART -->
								<a href="javascript:void(0);" id="total-cart">
									<i class="iconfont-shopping-cart round-icon"></i>
								</a>
								
								<div id="sub-cart" class="sub-header">
									<!--  <div class="cart-header">
										<span>Your cart is currently empty.</span>
										<small><a href="cart.html">(See All)</a></small>
									</div>
									<!-- <ul class="cart-items product-medialist unstyled clearfix"></ul>-->
									<div class="cart-footer">
										<!--  <div class="cart-total clearfix">
											<span class="pull-left uppercase">Total</span>
											<span class="pull-right total">￥ 0</span>
										</div>-->
										<div class="text-right">
											<a href="cart.jsp" class="btn btn-default btn-round view-cart">View Cart</a>
										</div>
									</div>
								</div>
								<!-- // SHOPPING CART -->
							</li>
							<%} %>
						</ul>
					</div>
				</div>
			</div>
			
			<!-- ADD TO CART MESSAGE -->
			<div class="cart-notification">
				<ul class="unstyled"></ul>
			</div>
			<!-- // ADD TO CART MESSAGE -->
		</div>
		<!-- // HEADER TOP -->
		<!-- MAIN HEADER -->
		<div class="main-header-wrapper">
			<div class="container">
				<div class="main-header">
					<!-- CURRENCY / LANGUAGE / USER MENU -->
					<div class="actions">
						<div class="center-xs">
							
							
						</div>
						<div class="clearfix"></div>
						<!-- USER RELATED MENU -->
						<nav id="tiny-menu" class="clearfix">
							<ul class="user-menu">
								
								<%if(member==null){%>
								<li><a href="login.jsp">亲，请登录</a></li>
								<li><a href="reg.jsp">免费注册</a></li>
								<%}else{ %>
								<li><a><%=member.get("tname") %>,你好</a></li>
								<li><a href="mydd.jsp">会员中心</a></li>
								<li><a href="/lyjdzxpwsys/lyjdzxpwsys?ac=frontexit">退出</a></li>
								<%} %>
							</ul>
						</nav>
						<!-- // USER RELATED MENU -->
					</div>
					<!-- // CURRENCY / LANGUAGE / USER MENU -->
					<!-- SITE LOGO -->
					<div class="logo-wrapper">
						<a href="index.jsp" class="logo" title="GFashion - Responsive e-commerce HTML Template">
						</a>
					</div>
					<!-- // SITE LOGO -->
					<!-- SITE NAVIGATION MENU -->
					<nav id="site-menu" role="navigation">
						<ul class="main-menu hidden-sm hidden-xs">
							<li class="active">
								<a href="index.jsp">主页</a>
							</li>
							<%ArrayList<HashMap> ftypelist = (ArrayList<HashMap>)dao.select("select * from protype where fatherid='0' and delstatus='0' order by id desc"); 
							for(HashMap ftypemap:ftypelist){%>
							
							<li>
								<a href="#"><%=ftypemap.get("typename") %></a>
								
								<!-- MEGA MENU -->
								<div class="mega-menu" data-col-lg="9" data-col-md="12">
									<div class="row">
									
										<div class="col-md-3">
											<ul class="mega-sub">
												<%ArrayList<HashMap> stypelist = (ArrayList<HashMap>)dao.select("select * from protype where fatherid='"+ftypemap.get("id")+"' and delstatus='0'"); 
												for(HashMap stypemap:stypelist){%>
												<li><a href="goods.jsp?key2=<%=stypemap.get("id") %>"><%=stypemap.get("typename") %></a></li>
												<%} %>
											</ul>
										</div>
										
									</div>
								</div>
								<!-- // MEGA MENU -->
								
							</li>
							<%} %>
							<li>
								<a href="news.jsp">站内资讯</a>
							</li>
							<li>
								<a href="msg.jsp">在线留言</a>
							</li>
							<li>
								<a href="about.jsp">关于我们</a>
							</li>
						</ul>
						
						<!-- MOBILE MENU -->
						<div id="mobile-menu" class="dl-menuwrapper visible-xs visible-sm">
							<button class="dl-trigger"><i class="iconfont-reorder round-icon"></i></button>
							<ul class="dl-menu">
								<li class="active">
									<a href="javsacript:void(0);">Home</a>
								</li>
								<%ArrayList<HashMap> ftypelistmobile = (ArrayList<HashMap>)dao.select("select * from protype where fatherid='0' and delstatus='0' order by id desc"); 
								for(HashMap ftypemap:ftypelistmobile){%>
								<li>
									<a href="javsacript:void(0);"><%=ftypemap.get("typename") %></a>
									
									<ul class="dl-submenu">
										<li>
											<a href="products.html">进入分类</a>
											<ul class="dl-submenu">
												<%ArrayList<HashMap> stypelistmobile = (ArrayList<HashMap>)dao.select("select * from protype where fatherid='"+ftypemap.get("id")+"' and delstatus='0'"); 
												for(HashMap stypemap:stypelistmobile){%>
												<li><a href="goods.jsp?key2=<%=stypemap.get("id") %>"><%=stypemap.get("typename") %></a></li>
												<%} %>
											</ul>
										</li>
										
									</ul>
								</li>
								<%} %>
							</ul>
						</div>
						<!-- // MOBILE MENU -->

					</nav>
					<!-- // SITE NAVIGATION MENU -->
				</div>
			</div>
		</div>
		<!-- // MAIN HEADER -->
	</header>
  </body>
</html>
