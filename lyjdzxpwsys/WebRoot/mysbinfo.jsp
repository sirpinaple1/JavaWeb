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
  HashMap member = (HashMap)session.getAttribute("member");%>
<body class="products-view">
<jsp:include page="checksession.jsp"></jsp:include>
	<!-- PAGE WRAPPER -->
<div id="page-wrapper">

	<jsp:include page="top.jsp"></jsp:include>
	
		<!-- BREADCRUMB -->
		<div class="breadcrumb-container"  style="height:50px">
			<div class="container">
				<div class="relative">
					<ul class="bc push-up unstyled clearfix">
						<li><a href="index.jsp">Home</a></li>
						<li class="active">手办投递</li>
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
							<div class="container">
								
								<table class="tbl-cart">
									<thead>
										<tr>
											<th>标题</th>
											<th>投递日期</th>
											<th>审核状态</th>
											<th class="hidden-xs" style="width: 20%;"></th>
										</tr>
									</thead>
									<tbody>
									<%
									String sql = "select * from sbinfo where memberid='"+member.get("id")+"' order by id desc";
									String url ="mysbinfo.jsp?1=1";
											String did = request.getParameter("did");
											if(did!=null){
								           		dao.commOper("delete from sbinfo where id="+did);
											}
								            PageManager pageManager = PageManager.getPage(url,10, request);
										    pageManager.doList(sql);
										    PageManager bean= (PageManager)request.getAttribute("page");
										    ArrayList<HashMap> infoslist=(ArrayList)bean.getCollection();
										    for(HashMap infosmap :infoslist)
										    {
									%>
										<tr>
											<td align="center"><a href="sbinfodetail.jsp?id=<%=infosmap.get("id") %>"><%=infosmap.get("title") %></a></td>
											<td><%=infosmap.get("savetime") %></td>
											<td align="left"><%=infosmap.get("shstatus") %></td>
											<td class="hidden-xs">
											<button type="button" class="close" aria-hidden="true" onclick="removeaddr(<%=infosmap.get("id") %>)">×</button>
											</td>
										</tr>
										<%} %>
										<tr><td colspan="2"><h5><small>${page.info }</small></h5></td>
										<td colspan="2"><button type="button" class="btn btn-primary" onclick="toaddradd()">我要投递</button></td>
										</tr>
									</tbody>
								</table>
								
								
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
 	function toaddradd(){
		location.href="sbinfoadd.jsp";
 	}
 	function removeaddr(id){
 		 $.ajax({  
 			type: "POST",      
 			url: "/lyjdzxpwsys/lyjdzxpwsys?ac=sbinfodel", //servlet的名字     
 		 	data: "id="+id, 
 		 	success: function(data){
  		 	if(data=="true"){
  		 		layer.msg('删除成功');   
  	  		 	}       
 	   		}
 		 });
 	}

 </script>

</body>
</html>
