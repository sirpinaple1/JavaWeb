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
  HashMap member = (HashMap)session.getAttribute("member");
  %>
  <body>
<!-- SIDEBAR -->
						<aside class="col-xs-12 col-sm-4 col-md-3">
							<section class="side-section">
							
								<ul class="nav nav-tabs nav-stacked">
									<li><a href="index.jsp">Home</a></li>															
									<%if(member==null){%>
									<li><a href="login.jsp">会员登录</a></li>	
									<li><a href="reg.jsp">帐户注册</a></li>	
									<%}else{ %>
									<li><a href="cart.jsp">购物车</a></li>
									<li><a href="mydd.jsp">订单中心</a></li>
									<li><a href="addr.jsp">地址管理</a></li>
									<li><a href="fav.jsp">收藏夹</a></li>	
									<li><a href="grinfo.jsp">个人信息</a></li>	
									<%} %>												
									<li><a href="about.jsp">关于我们</a></li>											
								</ul>
							</section>
								
							<!-- PROMO -->
							<div class="promo inverse-background" style="background: url('images/demo/Barn-Dress-Girl_t.jpg') no-repeat; background-size: auto 100%;">
								<div class="inner text-center np">
									<div class="ribbon">
										<h6 class="nmb">New Arrivals</h6>
										<h5 class="text-semibold uppercase nmb">Leather Fashion</h5>
										<div class="space10"></div>
										<a href="goods.jsp" class="with-icon prepend-icon"><i class="iconfont-caret-right"></i><span> Shop Now</span></a>
									</div>
								</div>
							</div>
							<!-- // PROMO -->
						</aside>
						<!-- // SIDEBAR -->

  </body>
</html>
