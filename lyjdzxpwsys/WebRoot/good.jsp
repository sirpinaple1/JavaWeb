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
  String id = request.getParameter("id");
  HashMap map = dao.select("select * from goods where id="+id).get(0);
  HashMap ppmap = dao.select("select * from ppinfo where id="+map.get("goodpp")).get(0); 
	HashMap fmap = dao.select("select * from protype where id="+map.get("fid")).get(0);
	HashMap smap = dao.select("select * from protype where id="+map.get("sid")).get(0); %>
<body class="products-view">
			
	<!-- PAGE WRAPPER -->
<div id="page-wrapper">

	<jsp:include page="top.jsp"></jsp:include>
	
		<!-- BREADCRUMB -->
		<div class="breadcrumb-container" style="height:50px">
			<div class="container">
				<div class="relative">
					<ul class="bc unstyled clearfix">
						<li><a href="index.jsp">Home</a></li>
						<li class="active"><a href="goods.jsp">景点列表</a></li>
						<li class="active">景点详情</li>
					</ul>
				</div>
			</div>
		</div>
		<!-- // BREADCRUMB -->
		
		
		
		<!-- SITE MAIN CONTENT -->
		<main id="main-content" role="main">
			<section class="section">
				<div class="container">
					<div class="row">
						<!-- PRODUCT PREVIEW -->
						<div class="col-xs-12 col-sm-4">
							
							<div class="product-preview">
								<div class="big-image">
									<a href="upfile/<%=map.get("filename") %>" data-toggle="lightbox">
										<img src="upfile/<%=map.get("filename") %>" alt="" />
									</a>
								</div>
								<ul class="thumbs unstyled clearfix">
									<li><a href="upfile/<%=map.get("filename") %>"><img src="upfile/<%=map.get("filename") %>" alt="" /></a></li>
								</ul>
							</div>
							
						</div>
						<!-- // PRODUCT PREVIEW -->
						<div class="space40 visible-xs"></div>
						<!-- PRODUCT DETAILS -->
						<div class="col-xs-12 col-sm-8">
							<section class="product-details add-cart">
								<header class="entry-header">
									<h2 class="entry-title uppercase"><%=map.get("goodname") %></h2>
								</header>
								<article class="entry-content">
									<figure>
										
										<%if(map.get("tprice")!=null&&!map.get("tprice").equals("")){ %>
										<span class="entry-price inline-middle">¥<%=map.get("tprice") %></span>
										<%}else{ %>
										<span class="entry-price inline-middle">¥<%=map.get("price") %></span>
										<%} %>
										
										<ul class="entry-meta unstyled">
											<li>
												<span class="key">类型:</span>
												<span class="value"><%=ppmap.get("ppname")%></span>
											</li>
											<li>
												<span class="key">景点分类:</span>
												<span class="value"><%=fmap.get("typename") %> / <%=smap.get("typename") %></span>
											</li>
											<li>
												<span class="key">景点编号:</span>
												<span class="value"><%=map.get("goodno")%></span>
											</li>
										</ul>
										
										<div class="clearfix"></div>
										
										<figcaption class="m-b-sm">
											<h5 class="subheader uppercase">景点描述:</h5>
											<p><%=map.get("remark") %>.</p>
										</figcaption>
										
										
										<div>
										<label for="input2">购买数量:</label>
											<div class="qty-btn-group" style="width: 13%;">
													<button type="button" class="down" ><i class="iconfont-caret-down inline-middle"></i></button>
													<input type="text" id="sl" name="sl" value="1" />
													<button type="button" class="up" ><i class="iconfont-caret-up inline-middle"></i></button>
											</div>
										</div>
										<ul class="inline-li li-m-r-l m-t-lg">
											<li>
												<a href="#" onclick="tocart(<%=map.get("id") %>)" class="btn btn-default btn-lg btn-round add-to-cart">放入购物车</a>
											</li>
											<li>
												<a onclick="tobuy(<%=map.get("id") %>)" class="btn btn-default btn-lg btn-round add-to-cart">直接购买</a>
											</li>
											<li>
												<a onclick="tofav(<%=map.get("id") %>)" class="btn btn-default btn-lg btn-round add-to-cart">加入收藏</a>
											</li>
										</ul>
										
									</figure>
								</article>
							</section>
						</div>
						<!-- // PRODUCT DETAILS -->
					</div>
					<div class="m-t-lg">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#product-description" data-toggle="tab">景点详情</a></li>
							<li><a href="#product-reviews" data-toggle="tab">景点评价</a></li>
							<li><a href="#product-shipping" data-toggle="tab">购买记录</a></li>
						</ul>
						<div class="tab-content">
							<div class="tab-pane fade in active" id="product-description">
								<p><%=map.get("note") %></p>
							</div>
							<div class="tab-pane fade in" id="product-reviews">
								<div class="comments-list">
									<div id="disqus_thread"></div>
									<table>
										<thead>
											<tr>
												<th>评价内容</th>
												<th style="width: 15%;">评分</th>
												<th>回复内容</th>
												<th class="hidden-xs" style="width: 15%;">会员</th>
												<th class="hidden-xs" style="width: 10%;">评价时间</th>
											</tr>
										</thead>
										<tbody>
											<%String pjsql = "select  * from pj where goodid='"+id+"' order by savetime desc "; 
										    ArrayList<HashMap> pjlist=(ArrayList<HashMap>)dao.select(pjsql);
										    for(HashMap pjmap :pjlist)
										    {
										    HashMap mmm = dao.select("select * from member where id="+pjmap.get("memberid")).get(0);
										    %>
											<tr>
												<td><%=pjmap.get("msg") %></td>
												<td><%=pjmap.get("jb") %>分</td>
												<td><%=pjmap.get("hf") %></td>
												<td class="hidden-xs"><strong class="text-bold row-total"><%=mmm.get("tname") %></strong></td>
												<td class="hidden-xs"><%=pjmap.get("savetime") %></td>
											</tr>
											<%} %>
										</tbody>
									</table>
								</div>
							</div>
							<div class="tab-pane fade in" id="product-shipping">
								
								<div class="comments-list">
									<div id="disqus_thread"></div>
									<table style="width: 100%">
										<thead>
											<tr>
												<th>会员</th>
												<th>购买日期</th>
											</tr>
										</thead>
										<tbody>
											<%String buysql = "SELECT b.savetime, (select uname from member where id=b.memberid)  as uname FROM dddetail a,ddinfo b where a.ddno=b.ddno and a.goodid='"+id+"' order by b.savetime desc "; 
										    ArrayList<HashMap> buylist=(ArrayList<HashMap>)dao.select(buysql);
										    for(HashMap buymap :buylist)
										    {
										    %>
											<tr>
												<td><%=buymap.get("uname") %></td>
												<td><%=buymap.get("savetime") %></td>
											</tr>
											<%} %>
										</tbody>
									</table>
								</div>
								
							</div>
						</div>
					</div>
				</div>
			</section>
			
			
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

  function tocart(gid){
	  var sl=document.getElementById("sl").value;
		 $.ajax({  
		        type: "POST",      
		         url: "/lyjdzxpwsys/lyjdzxpwsys?ac=tocar", //servlet的名字     
		          data: "gid="+gid+"&sl="+sl, 
		         success: function(data){       
		    if(data=="true"){     
		    	layer.msg('添加购物车成功');
		    }else{    
		    	$("#tsinfo").show(); 
		    	layer.msg('请先登录');
		     	location.href="login.jsp";
		    }     
		 }     
		});   
	}
	function tofav(gid){
		 $.ajax({  
		        type: "POST",      
		         url: "/lyjdzxpwsys/lyjdzxpwsys?ac=addfav", //servlet的名字     
		          data: "goodid="+gid, 
		         success: function(data){       
		    if(data=="true"){     
		    	layer.msg('收藏成功');
		    }else if(data=="unlogin"){    
		    	layer.msg('请先登录');
		    	location.href="login.jsp";
		    }else{
		    	layer.msg('此景点已在收藏夹中');
			}     
		 }     
		});   
	}

	function tobuy(gid){     
		 var sl=document.getElementById("sl").value;    
		 if(sl==""||sl<=0){
		    layer.msg('请填写正确的数量');
		    return;
		 }  
		 $.ajax({  
		        type: "POST",      
		         url: "/lyjdzxpwsys/lyjdzxpwsys?ac=tobuy", //servlet的名字     
		          data: "gid="+gid+"&sl="+sl, 
		         success: function(data){       
		    if(data=="true"){     
		    	layer.msg('订单已创建');
		    	location.href="mydd.jsp";
		    }else{    
		    	layer.msg('购买失败,未登录或未维护收货地址(且需设置默认收货地址)');
		    }     
		 }     
		});     
	}   
</script>
	<!-- Particular Page Javascripts -->
	<script src="js/jquery.nouislider.js"></script>
	<script src="js/jquery.isotope.min.js"></script>
	<script src="js/products.js"></script>
	<!-- // Particular Page Javascripts -->
</body>
</html>
