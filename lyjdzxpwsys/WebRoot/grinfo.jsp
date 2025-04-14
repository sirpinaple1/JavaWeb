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
  HashMap membersession = (HashMap)session.getAttribute("member");
  HashMap member = dao.select("select * from member where id="+membersession.get("id")).get(0);%>
<body class="products-view">
			
	<!-- PAGE WRAPPER -->
<div id="page-wrapper">
<jsp:include page="checksession.jsp"></jsp:include>
	<jsp:include page="top.jsp"></jsp:include>
	
		<!-- BREADCRUMB -->
		<div class="breadcrumb-container"  style="height:50px">
			<div class="container">
				<div class="relative">
					<ul class="bc push-up unstyled clearfix">
						<li><a href="index.jsp">Home</a></li>
						<li class="active">个人信息</li>
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

							<div class="panel-group checkout" id="checkout-collapse"   style="margin-top:  0px">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a data-toggle="collapse" data-parent="#checkout-collapse" href="#checkout-collapse1">
												个人信息
											</a>
										</h4>
									</div>
									<div id="checkout-collapse1" class="panel-collapse collapse in">
										<div class="panel-body">
											<form class="form-horizontal" role="form" name="form2" id="ff2" method="post" action="/lyjdzxpwsys/lyjdzxpwsys?ac=memberinfo&id=<%=member.get("id") %>">
												<div class="row">
													<div class="col-xs-12 col-sm-12 col-md-6">
														<div class="form-group stylish-input">
															<label for="inputFirstname" class="col-sm-4 col-lg-4 control-label required">用户名</label>
															<div class="col-sm-8 col-lg-8">
																<input type="text" value="<%=member.get("uname") %>" class="form-control" id="username" name="username" readonly="readonly" required/>
															</div>
														</div>
														<div class="form-group stylish-input">
															<label for="inputLastname" class="col-sm-4 col-lg-4 control-label required">密码</label>
															<div class="col-sm-8 col-lg-8">
																<input type="password" class="form-control" id="upass" name="upass" required/>
															</div>
														</div>
														<div class="form-group stylish-input">
															<label for="inputEmail2" class="col-sm-4 col-lg-4 control-label required">再次输入密码</label>
															<div class="col-sm-8 col-lg-8">
																<input type="password" class="form-control" id="upass1" name="upass1" onblur="validatorpwd()" required/>
															</div>
														</div>
														<div class="form-group stylish-input">
															<label for="inputPhone" class="col-sm-4 col-lg-4 control-label required">姓名</label>
															<div class="col-sm-8 col-lg-8">
																<input type="text" value="<%=member.get("tname") %>" class="form-control" id="tname" name="tname" required/>
															</div>
														</div>
														<div class="form-group stylish-input">
															<label for="inputFax" class="col-sm-4 col-lg-4 control-label">性别</label>
															<div class="col-sm-8 col-lg-8">
																<select class="form-control" id="sex" name="sex">	
																	<option value="男" <%if(member.get("sex").equals("男")){out.print("selected==selected");} %>>男</option>
																	<option value="女" <%if(member.get("sex").equals("男")){out.print("selected==selected");} %>>女</option>
																</select>
															</div>
														</div>
														<div class="form-group stylish-input">
															<label for="inputCompany" class="col-sm-4 col-lg-4 control-label required">电子邮箱</label>
															<div class="col-sm-8 col-lg-8">
																<input type="email" value="<%=member.get("email") %>" class="form-control" id="email" name="email" required/>
															</div>
														</div>
													</div>
													<div class="col-xs-12 col-sm-12 col-md-6">
														<div class="form-group stylish-input">
															<label for="inputAddress1" class="col-sm-4 col-lg-4 control-label required">qq</label>
															<div class="col-sm-8 col-lg-8">
																<input type="text" value="<%=member.get("qq") %>" class="form-control" id="qq" name="qq" required/>
															</div>
														</div>
														<div class="form-group stylish-input">
															<label for="inputAddress2" class="col-sm-4 col-lg-4 control-label required">电话</label>
															<div class="col-sm-8 col-lg-8">
																<input type="text" value="<%=member.get("tel") %>" class="form-control" id="tel" name="tel" required/>
															</div>
														</div>
														<div class="form-group stylish-input">
															<label for="inputAddress2" class="col-sm-4 col-lg-4 control-label required">生日</label>
															<div class="col-sm-8 col-lg-8">
																<input type="date" value="<%=member.get("birthday") %>" class="form-control" id="birthday" name="birthday" required/>
															</div>
														</div>
													</div>
												</div>
												<div class="space20 clearfix"></div>
												<button class="btn btn-primary">提交</button>
											</form>
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
<script type="text/javascript">
function validatorpwd(){
	if(document.getElementById("upass").value!=document.getElementById("upass1").value){
		layer.msg('两次密码不一致');
		document.getElementById("upass1").value = "";
		return false;
	}else{
		$("#pwderroinfo").hide(); 
	}   
}
<%String info = (String)request.getAttribute("info");
if(info!=null){%>
	layer.msg('<%=info %>');   
<%}%>
  
</script>
</body>
</html>
