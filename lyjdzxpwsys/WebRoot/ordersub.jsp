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
HashMap member = (HashMap)session.getAttribute("member");
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
						<li class="active">订单确认</li>
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
						<form name="form2" id="form2" method="post" action="/lyjdzxpwsys/lyjdzxpwsys?ac=submitorder" >
							<div class="container">
								
								<table class="tbl-cart">
									<thead>
										<tr>
											<th>景点名称</th>
											<th style="width: 15%;">单价</th>
											<th style="width: 15%;">数量</th>
											<th class="hidden-xs" style="width: 15%;">总价</th>
										</tr>
									</thead>
									<tbody>
									<%
									ArrayList<HashMap> goodlist = (ArrayList<HashMap>)dao.select("select *,a.id as aid,b.id as bid from car a,goods b where a.gid=b.id and a.mid='"+member.get("id")+"' and b.delstatus='0' order by a.id desc");
									if(goodlist.size()==0){
									%>
										<tr class="hide empty-cart">
											<td colspan="5">
												It seems your shopping cart is empty, try looking our <a href="products.html">products</a>.
											</td>
										</tr>
										<%}else{ 
										double totalprice = 0.0;
										for(int i=0;i<goodlist.size();i++){ 
										double oneprice = 0.0;
										double onetotalprice = 0.0;
										HashMap carmap = goodlist.get(i);
										HashMap ppmap = dao.select("select * from ppinfo where id="+carmap.get("goodpp")).get(0); 
										HashMap fmap = dao.select("select * from protype where id="+carmap.get("fid")).get(0);
								   		HashMap smap = dao.select("select * from protype where id="+carmap.get("sid")).get(0);
								   		
								   		if(carmap.get("tprice")!=null&&!carmap.get("tprice").equals("")){ 
								   			oneprice = Double.valueOf(carmap.get("tprice").toString());
								   			totalprice += Double.valueOf(carmap.get("tprice").toString())*Integer.valueOf(carmap.get("sl").toString());
								   			onetotalprice+= Double.valueOf(carmap.get("tprice").toString())*Integer.valueOf(carmap.get("sl").toString());
								   		}else{
								   			oneprice = Double.valueOf(carmap.get("price").toString());
								   			totalprice += Double.valueOf(carmap.get("price").toString())*Integer.valueOf(carmap.get("sl").toString());
								   			onetotalprice += Double.valueOf(carmap.get("price").toString())*Integer.valueOf(carmap.get("sl").toString());
								   		}
								   		%>
										<tr>
											<td>
												<a class="entry-thumbnail" href="upfile/<%=carmap.get("filename") %>" data-toggle="lightbox">
													<img src="upfile/<%=carmap.get("filename") %>" alt="" />
												</a>
												<a class="entry-title" href="good.jsp?id=<%=carmap.get("id") %>"><%=carmap.get("goodname") %></a>
											</td>
											<td><span class="unit-price">¥<%=oneprice %></span></td>
											<td>
												<%=carmap.get("sl") %>
											</td>
											<td class="hidden-xs"><strong class="text-bold row-total">¥<%=onetotalprice %></strong></td>
										</tr>
										<%}} %>
									</tbody>
								</table>
								
								
								
								<div class="shopcart-total pull-right clearfix">
									
									<div class="cart-total text-bold m-b-lg clearfix">
										<span class="pull-left">实付款:</span>
										<span class="pull-right">¥1050.00</span>
									</div>
									
									
									
									<div class="text-center">
										<a class="btn btn-round btn-primary uppercase" onclick="suborder()">提交订单</a>
									</div>
									
								</div>
								
							</div>
							</form>
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


function removecart(cartid){
	 $.ajax({  
		type: "POST",      
		url: "/lyjdzxpwsys/lyjdzxpwsys?ac=removecart", //servlet的名字     
	 	data: "cartid="+cartid, 
	 	success: function(data){       
   		}
	 });  
}

function updatecartnum(i,carid,type){
	var sl=document.getElementById("sl"+i).value;
	//加载层
	var index = layer.load(0, {shade: false}); //0代表加载的风格，支持0-2
	if(type=='+'){
		sl = parseInt(sl)+1;
	}else{
		sl = parseInt(sl)-1;
		if(parseInt(sl)==0){
			sl = 1;
		}
	}
	

	 $.ajax({  
	        type: "POST",      
	         url: "/lyjdzxpwsys/lyjdzxpwsys?ac=updatecart", //servlet的名字     
	          data: "carid="+carid+"&sl="+sl, 
	         success: function(data){       
	    if(data=="true"){     
	    }  
	    layer.closeAll();  
	 }     
	});
	
}


function suborder(){
	
		form2.submit();
}
	function toaddradd(){
		location.href="addradd.jsp";
 	}
</script>
</body>
</html>
