<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="dao.CommDAO"%>
<%@page import="util.PageManager"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<!--[if IE 7 ]><html class="ie ie7 lte9 lte8 lte7" lang="en-US"><![endif]-->
<!--[if IE 8]><html class="ie ie8 lte9 lte8" lang="en-US">	<![endif]-->
<!--[if IE 9]><html class="ie ie9 lte9" lang="en-US"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--><html class="noIE" lang="en-US"><!--<![endif]-->
<%CommDAO dao = new CommDAO();  
HashMap sitemap = dao.select("select * from siteinfo where id=1").get(0);%>
<head>
	<meta charset="UTF-8" />
	<title>智慧景区票务系统</title>
	<meta name="description" content=""/>
	<meta name="keywords" content=""/>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	
	<!-- Favorite Icons -->
	<link rel="icon" href="img/favicon/favicon.html" type="image/x-icon" />
	<link rel="apple-touch-icon-precomposed" sizes="144x144" href="img/favicon/apple-touch-icon-144x144-precomposed.html">
	<link rel="apple-touch-icon-precomposed" sizes="72x72" href="img/favicon/apple-touch-icon-72x72-precomposed.html">
	<link rel="apple-touch-icon-precomposed" href="img/favicon/apple-touch-icon-precomposed.html">
	<!-- // Favorite Icons 
	
	<link href='http://fonts.useso.com/css?family=Open+Sans:300,400,600,700' rel='stylesheet' type='text/css'>
	-->
	<!-- GENERAL CSS FILES -->
	<link rel="stylesheet" href="css/minified.css">
	<!-- // GENERAL CSS FILES -->
	
	<!--[if IE 8]>
		<script src="js/respond.min.js"></script>
		<script src="js/selectivizr-min.js"></script>
	<![endif]-->
	<!--
	<script src="js/jquery.min.js"></script>
	-->
	<script>window.jQuery || document.write('<script src="js/jquery.min.js"><\/script>');</script>
	<script src="js/modernizr.min.js"></script>	
	<!-- PARTICULAR PAGES CSS FILES -->
	<link rel="stylesheet" href="css/jquery.nouislider.css">
	<link rel="stylesheet" href="css/isotope.css">
	<link rel="stylesheet" href="css/innerpage.css">
	<!-- // PARTICULAR PAGES CSS FILES -->
	<link rel="stylesheet" href="css/responsive.css">
	<script src="js/jquery-2.0.3.min.js"></script>	
	<script src="layer/layer.js"></script>
</head>
  <%
  HashMap member = (HashMap)session.getAttribute("member");
  String ddid = request.getParameter("ddid");%>
<body class="products-view">
			
	<!-- PAGE WRAPPER -->
<div id="page-wrapper">

	<jsp:include page="top.jsp"></jsp:include>
	
		<!-- BREADCRUMB -->
		<div class="breadcrumb-container"  style="height:50px">
			<div class="container">
				<div class="relative">
					<ul class="bc push-up unstyled clearfix">
						<li><a href="index.jsp">Home</a></li>
						<li class="active">收银台</li>
					</ul>
				</div>
			</div>
		</div>
		<!-- // BREADCRUMB -->
		
		
		<!-- SITE MAIN CONTENT -->
		<main id="main-content" role="main">
		
			<div class="container">
				<div class="row">
					
					<div class="m-t-b clearfix">
						
						<jsp:include page="left.jsp"></jsp:include>
						
						<section class="col-xs-12 col-sm-8 col-md-9">
						<%String info = (String)request.getAttribute("info");
						if(info!=null){%>
						    <div class="alert alert-info">
						        <button type="button" class="close" data-dismiss="alert">×</button>
						        	<%=info %>
					    	</div>
						<%}%>
							<div class="panel-group checkout" id="checkout-collapse"   style="margin-top:  0px">
								
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a data-toggle="collapse" data-parent="#checkout-collapse" href="#checkout-collapse1">
												收银台
											</a>
										</h4>
									</div>
									<div id="checkout-collapse1" class="panel-collapse collapse in">
										<div class="panel-body">
											<div class="row">
												<div class="space40 visible-xs"></div>
												<div class="col-xs-12 col-sm-6" style="width: 100%">
													<ul class="nav nav-tabs">
														<li class="active"><a href="#tab-1" data-toggle="tab">支付宝付款</a></li>
														<li><a href="#tab-2" data-toggle="tab">网银付款</a></li>
													</ul>
													<div class="tab-content">
														<div class="tab-pane fade in active" id="tab-1">
																<form class="form-horizontal" name="form1" id="ff1" method="post" action="/lyjdzxpwsys/lyjdzxpwsys?ac=pay&ddid=<%=ddid %>">
																	<fieldset>
																		<div class="inner">
																			<div class="form-login">
																				<div class="form-group stylish-input">
																					<label for="inputEmail" class="col-xs-12 col-sm-3 control-label required">支付宝帐户</label>
																					<div class="col-lg-7">
																						<input type="text" class="form-control" id="uname" name="uname" required>
																					</div>
																				</div>
																				<div class="form-group stylish-input">
																					<label for="inputPassword" class="col-xs-12 col-sm-3 control-label required">密码</label>
																					<div class="col-lg-7">
																						<input type="password" class="form-control" id="upass" name="upass" required>
																					</div>
																				</div>
																			</div>
																			<button class="btn btn-primary btn-round padder">确认支付</button>
																		</div>
																	</fieldset>
																</form>
														</div>
														<div class="tab-pane fade" id="tab-2">
															<form class="form-horizontal" name="form2" id="ff2" method="post" action="/lyjdzxpwsys/lyjdzxpwsys?ac=pay&ddid=<%=ddid %>">
																	<fieldset>
																		<div class="inner">
																			<div class="form-login">
																				<div class="form-group stylish-input">
																					<label for="inputEmail" class="col-xs-12 col-sm-3 control-label required">银行卡号</label>
																					<div class="col-lg-7">
																						<input type="text" class="form-control" id="uname" name="uname" required>
																					</div>
																				</div>
																				<div class="form-group stylish-input">
																					<label for="inputPassword" class="col-xs-12 col-sm-3 control-label required">密码</label>
																					<div class="col-lg-7">
																						<input type="password" class="form-control" id="upass" name="upass" required>
																					</div>
																				</div>
																			</div>
																			<button class="btn btn-primary btn-round padder">确认支付</button>
																		</div>
																	</fieldset>
																</form>
														</div>
														
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								
								
								
							</div>
						</section>
						
					</div>
				
				</div>
			</div>
		
		</main>
		<!-- // SITE MAIN CONTENT -->
		
		
	<!-- SITE FOOTER -->
	<jsp:include page="foot.jsp"></jsp:include>
	<!-- // SITE FOOTER -->
		
</div>
<!-- // PAGE WRAPPER -->

<!-- Essential Javascripts -->
<script src="js/minified.js"></script>
<!-- // Essential Javascripts -->

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','../../../www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-27646173-3', 'themina.net');
  ga('send', 'pageview');

</script>
	<!-- Particular Page Javascripts -->
	<script src="js/jquery.nouislider.js"></script>
	<script src="js/jquery.isotope.min.js"></script>
	<script src="js/products.js"></script>
	<!-- // Particular Page Javascripts -->


</body>
</html>
