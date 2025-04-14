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
	<!-- // Favorite Icons -->
	
	
	
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
			
	<!-- PAGE WRAPPER -->
<div id="page-wrapper">

	<jsp:include page="top.jsp"></jsp:include>
	
		<!-- BREADCRUMB -->
		<div class="breadcrumb-container">
			<div class="container">
				<div class="relative">
					<ul class="bc push-up unstyled clearfix">
						<li><a href="index.jsp">Home</a></li>
						<li class="active"><a href="goods.jsp">景点列表</a></li>
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
						<!-- SIDEBAR -->
						<aside class="col-xs-12 col-sm-4 col-md-3">
							<section class="sidebar push-up">
							
								<!-- CATEGORIES -->
								<section class="side-section bg-white">
									<header class="side-section-header">
										<h3 class="side-section-title">景点分类</h3>
									</header>
									<div class="side-section-content">
										<ul id="category-list" class="vmenu unstyled">
										<%ArrayList<HashMap> ftypelist = (ArrayList<HashMap>)dao.select("select * from protype where fatherid='0' and delstatus='0' order by id desc"); 
										int a = 0;
										for(HashMap ftypemap:ftypelist){
											a++;%>
											<li>
												<input type="checkbox" id="checkftype<%=ftypemap.get("id") %>" class="prettyCheckable" data-label="<%=ftypemap.get("typename") %>" data-labelPosition="right" value="<%=ftypemap.get("id") %>" />
												<ul>
												<%ArrayList<HashMap> stypelist = (ArrayList<HashMap>)dao.select("select * from protype where fatherid='"+ftypemap.get("id")+"' and delstatus='0'"); 
												for(HashMap stypemap:stypelist){%>
													<li><input type="checkbox" id="checkftype<%=ftypemap.get("id") %>-checkstype<%=stypemap.get("id") %>" class="prettyCheckable" data-label="<%=stypemap.get("typename") %>" data-labelPosition="right" value="<%=stypemap.get("id") %>" /></li>
												<%} %>
												</ul>
											</li>
										<%} %>
										</ul>
									</div>
									<footer class="side-section-footer text-center hide">
										<button type="button" id="btn-filter-cat" class="btn btn-primary btn-round uppercase">Clear Filters</button>
									</footer>
								</section>
								<!-- // CATEGORIES -->
								
								<!-- BRANDS -->
								<section class="side-section bg-white">
									<header class="side-section-header">
										<h3 class="side-section-title">类型</h3>
									</header>
									<div class="side-section-content">
										<ul id="brands-list" class="vmenu unstyled">
										<%String sql = "select * from ppinfo where 1=1 and delstatus='0' ";
										ArrayList<HashMap> pplist  = (ArrayList<HashMap>)dao.select("select * from ppinfo where delstatus='0'");
										for(HashMap ppmap:pplist){%>
											<li>
												<input type="checkbox" id="check-brand<%=ppmap.get("id") %>" class="prettyCheckable" data-label="<%=ppmap.get("ppname") %>" data-labelPosition="right" value="<%=ppmap.get("id") %>" />
											</li>
										<%} %>
										</ul>
									</div>
									<footer class="side-section-footer text-center hide">
										<button type="button" id="btn-filter-brand" class="btn btn-primary btn-round uppercase">Clear Filters</button>
									</footer>
								</section>
								<!-- // BRANDS -->
								
								<!-- PRODUCT FILTER -->
								<section class="side-section bg-white">
									<header class="side-section-header">
										<h3 class="side-section-title">Filter</h3>
									</header>
									
									<!-- PRICE RANGE SLIDER -->
									<div id="filter-by-price" class="side-section-content">
										<h4 class="side-section-subheader">Filter By Price</h4>
										<div class="range-slider-container">
											<div class="range-slider" data-min="0" data-max="2000" data-step="10" data-currency="￥"></div>
											<div class="range-slider-value clearfix">
												<span>Price: &ensp;</span>
												<span class="min"></span>
												<span class="max"></span>
											</div>
										</div>
									</div>
									<!-- // PRICE RANGE SLIDER -->
									
									<!-- FILTER BY SIZE -->
									<!-- <div id="filter-by-size" class="side-section-content">
										<h4 class="side-section-subheader">Filter By Size</h4>
										<ul class="inline-li li-m-lg text-center unstyled">
											<li>
												<a href="#" class="round-icon" data-toggle="tooltip" data-title="X-Small / UK 8"><small>XS</small></a>
												<input type="checkbox" class="filter-checkbox filter-size" value="XS" />
											</li>
											<li>
												<a href="#" class="round-icon" data-toggle="tooltip" data-title="Small / UK 10"><small>S</small></a>
												<input type="checkbox" class="filter-checkbox filter-size" value="S" />
											</li>
											<li>
												<a href="#" class="round-icon" data-toggle="tooltip" data-title="Medium / UK 12"><small>M</small></a>
												<input type="checkbox" class="filter-checkbox filter-size" value="M" />
											</li>
											<li>
												<a href="#" class="round-icon" data-toggle="tooltip" data-title="Large / UK 14"><small>L</small></a>
												<input type="checkbox" class="filter-checkbox filter-size" value="L" />
											</li>
											<li>
												<a href="#" class="round-icon" data-toggle="tooltip" data-title="X-Large / UK 16"><small>XL</small></a>
												<input type="checkbox" class="filter-checkbox filter-size" value="XL" />
											</li>
											<li>
												<a href="#" class="round-icon" data-toggle="tooltip" data-title="XX-Large"><small>XXL</small></a>
												<input type="checkbox" class="filter-checkbox filter-size" value="XXL" />
											</li>
										</ul>
									</div> -->
									<!-- // FILTER BY SIZE -->
									
									<!-- FILTER BY COLOR -->
									<!--  <div id="filter-by-color" class="side-section-content">
										<h4 class="side-section-subheader">Filter By Colour</h4>
										<ul class="inline-li li-m-sm text-center unstyled">
											<li>
												<a href="#" class="round-icon color-box" data-toggle="tooltip" data-title="Black" style="background: #000;"></a>
												<input type="checkbox" class="filter-checkbox filter-color" value="black" />
											</li>
											<li>
												<a href="#" class="round-icon color-box" data-toggle="tooltip" data-title="White" style="background: #fff; border-color: #acacac;"></a>
												<input type="checkbox" class="filter-checkbox filter-color" value="white" />
											</li>
											<li>
												<a href="#" class="round-icon color-box" data-toggle="tooltip" data-title="Green" style="background: #60bd0d;"></a>
												<input type="checkbox" class="filter-checkbox filter-color" value="green" />
											</li>
											<li>
												<a href="#" class="round-icon color-box" data-toggle="tooltip" data-title="Red" style="background: #ff5757;"></a>
												<input type="checkbox" class="filter-checkbox filter-color" value="red" />
											</li>
											<li>
												<a href="#" class="round-icon color-box" data-toggle="tooltip" data-title="Blue" style="background: #0d9abd;"></a>
												<input type="checkbox" class="filter-checkbox filter-color" value="blue" />
											</li>
											<li>
												<a href="#" class="round-icon color-box" data-toggle="tooltip" data-title="Brown" style="background: #c57313;"></a>
												<input type="checkbox" class="filter-checkbox filter-color" value="brown" />
											</li>
											<li>
												<a href="#" class="round-icon color-box" data-toggle="tooltip" data-title="Purple" style="background: #a613c5;"></a>
												<input type="checkbox" class="filter-checkbox filter-color" value="purple" />
											</li>
											<li>
												<a href="#" class="round-icon color-box" data-toggle="tooltip" data-title="Silver" style="background: #e5e5e8;"></a>
												<input type="checkbox" class="filter-checkbox filter-color" value="silver" />
											</li>
											<li>
												<a href="#" class="round-icon color-box" data-toggle="tooltip" data-title="Patternie" style="background: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAQAAAAECAYAAACp8Z5+AAAAHklEQVQIW2NkYGD4D8QgwAgjMASgCiAqwcqgACwAAIrDBAOqGrGNAAAAAElFTkSuQmCC');"></a>
												<input type="checkbox" class="filter-checkbox filter-color" value="patternie" />
											</li>
										</ul>
									</div>-->
									<!-- // FILTER BY COLOR -->
								</section>
								<!-- // PRODUCT FILTER -->
								
								<!-- BEST SELLERS -->
								<section class="side-section bg-white">
									<header class="side-section-header">
										<h3 class="side-section-title">热销景点</h3>
									</header>
									<div class="side-section-content">
										<ul class="product-medialist li-m-t unstyled clearfix">
										<%String sql2 = "SELECT distinct goodid,sum(sl) as xl  FROM dddetail a, ddinfo b where a.ddno=b.ddno and b.fkstatus='已付款' group by goodid order by xl desc ";
								        ArrayList<HashMap> list5 = (ArrayList<HashMap>)dao.select(sql2);
								        String gname = "";
								        for(HashMap map3:list5){
						            		HashMap gmap = dao.select("select * from goods where id="+map3.get("goodid")+"").get(0);
						            		gname = gmap.get("goodname").toString();
						            	  %>
											<li>
												<div class="item clearfix">
													<a href="upfile/<%=gmap.get("filename") %>" data-toggle="lightbox" class="entry-thumbnail">
														<img src="upfile/<%=gmap.get("filename") %>" alt="Inceptos orci hac libero" />
													</a>
													<h5 class="entry-title"><a href="good.jsp?id=<%=gmap.get("id") %>"><%=gname %></a></h5>
													
													
													
													<%if(gmap.get("tprice")!=null&&!gmap.get("tprice").equals("")){ %>
													<s class="entry-discount m-r-sm"><span class="text-sm">￥ <%=gmap.get("price") %></span></s>
													<span class="entry-price accent-color">￥<%=gmap.get("tprice") %></span>
													<%}else{ %>
														<span class="entry-price accent-color">￥<%=gmap.get("price") %></span>
													<%} %>
												</div>
											</li>
										<%} %>	
										</ul>
									</div>
								</section>
								<!-- // BEST SELLERS -->
								
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
								
							</section>
						</aside>
						
						
						
						<!-- // SIDEBAR -->
						<section class="col-xs-12 col-sm-8 col-md-9">
							
							<section class="products-wrapper">
								<!-- DISPLAY MODE - NUMBER OF ITEMS TO BE DISPLAY - PAGINATION -->
								<header class="products-header">
									<div class="row">
										<div class="col-xs-12 col-sm-12 col-md-6 center-xs">
											<!-- DISPLAY MODE -->
											<ul class="unstyled inline-li li-m-r-l-sm pull-left">
												<li><a class="round-icon active" href="#" data-toggle="tooltip" data-layout="grid" data-title="Switch to List Grid Mode"><i class="iconfont-th"></i></a></li>
												<li><a class="round-icon" href="#" data-toggle="tooltip" data-layout="list" data-title="Switch to List View Mode"><i class="iconfont-list"></i></a></li>
											</ul>
											<!-- // DISPLAY MODE -->
											
											<!-- NUMBER OF ITEMS TO BE DISPLAY 
											<div class="pull-right m-l-lg">
												<span class="inline-middle m-r-sm text-xs">Show</span>
												<div class="inline-middle styled-dd">
													<select>
														<option value="9">9</option>
														<option value="12" selected>12</option>
														<option value="24">24</option>
														<option value="36">36</option>
													</select>
												</div>
											</div>-->
											<!-- // NUMBER OF ITEMS TO BE DISPLAY -->
										</div>
										<div class="space30 visible-xs"></div>
										<!-- PAGINATION 
										<div class="col-xs-12 col-sm-12 col-md-6 center-xs">
											<ul class="paginator li-m-r-l pull-right">
												<li></li>
											</ul>
										</div>
										// PAGINATION -->
									</div>
								</header>
								<!-- // DISPLAY MODE - NUMBER OF ITEMS TO BE DISPLAY - PAGINATION -->
								
								<!-- PRODUCT LAYOUT -->
								<div class="products-layout grid m-t-b add-cart" data-product=".product" data-thumbnail=".entry-media .thumb" data-title=".entry-title > a" data-url=".entry-title > a" data-price=".entry-price > .price">
									
									<!-- 景点列表开始 -->
									<%String key1 = request.getParameter("key1")==null?"":request.getParameter("key1");
							         	 String key2 = request.getParameter("key2")==null?"":request.getParameter("key2");
							         	 String key3 = request.getParameter("key3")==null?"":request.getParameter("key3");
							         	 String url ="goods.jsp?1=1";
							             sql = "select  * from goods where delstatus='0'  "; 
							             String f = request.getParameter("f");
							         	 if(f!=null)
							         	 {
							         	 //key1 = Info.getUTFStr(key1);
							         	 }
							              if(!key1.equals(""))
							         	 {
							         	 sql+=" and (goodname like'%"+key1+"%' or goodpp like'%"+key1+"%')";
							         	 url+="&key1="+key1;
							         	 } 
							         	 if(!key2.equals(""))
							          	 {
							          	 sql+=" and (sid ='"+key2+"')";
							          	 url+="&key2="+key2;
							          	 }
							         	 if(!key3.equals(""))
							          	 {
							          	 sql+=" and (goodpp ='"+key3+"')";
							          	 url+="&key3="+key3;
							          	 }
							              sql+=" order by savetime desc";  
										PageManager pageManager = PageManager.getPage(url,30, request);
									    pageManager.doList(sql);
									    PageManager bean= (PageManager)request.getAttribute("page");
									    ArrayList<HashMap> goodslist=(ArrayList)bean.getCollection();
									    for(HashMap goodsmap :goodslist)
									    {
									    	String zsjg = "";
									    	if(goodsmap.get("tprice")!=null&&!goodsmap.get("tprice").equals("")){
									    		zsjg = goodsmap.get("tprice").toString();
									    	}else{
									    		zsjg = goodsmap.get("price").toString();
									    	}
									    %>
									<div class="product" data-product-id="<%=goodsmap.get("id") %>" data-category="<%=goodsmap.get("sid") %>|" data-brand="<%=goodsmap.get("goodpp") %>|" data-price="<%=zsjg %>">
										<div class="entry-media">
											<img data-src="upfile/<%=goodsmap.get("filename") %>" alt="" class="lazyLoad thumb" style="height:250px;width:100%"/>
											<div class="hover">
												<a href="good.jsp?id=<%=goodsmap.get("id") %>" class="entry-url"></a>
												<ul class="icons unstyled">
													<li>
														<%if(goodsmap.get("istj").equals("yes")){ %>
														<div class="circle ribbon ribbon-sale">推荐</div>
														<%} %>
													</li>
													<li>
														<a href="upfile/<%=goodsmap.get("filename") %>" class="circle" data-toggle="lightbox"><i class="iconfont-search"></i></a>
													</li>
													<li>
														<a href="#" onclick="tocart(<%=goodsmap.get("id") %>)" class="circle add-to-cart"><i class="iconfont-shopping-cart"></i></a>
													</li>
												</ul>
											</div>
										</div>
										<div class="entry-main">
											<h5 class="entry-title">
												<a href="good.jsp?id=<%=goodsmap.get("id") %>"><%=goodsmap.get("goodname") %></a>
											</h5>
											<div class="entry-description visible-list">
												<p>
												<%HashMap fmap = dao.select("select * from protype where id="+goodsmap.get("fid")).get(0);
										   		HashMap smap = dao.select("select * from protype where id="+goodsmap.get("sid")).get(0);
										   		HashMap ppmap = dao.select("select * from ppinfo where id="+goodsmap.get("goodpp")).get(0); %>
												景点分类：<%=fmap.get("typename") %>/<%=smap.get("typename") %><br/>
												类型：<%=ppmap.get("ppname") %><br/>
												<%=goodsmap.get("remark") %>
												</p>
											</div>
											<div class="entry-price">
												<%if(goodsmap.get("tprice")!=null&&!goodsmap.get("tprice").equals("")){ %>
													<s class="entry-discount">¥ <%=goodsmap.get("price") %></s>
													<strong class="accent-color price">¥<%=goodsmap.get("tprice") %></strong>
												<%}else{ %>
													<strong class="accent-color price">¥<%=goodsmap.get("price") %></strong>
												<%} %>
												<a href="#" onclick="tocart(<%=goodsmap.get("id") %>)" class="btn btn-round btn-default add-to-cart visible-list">Add to Cart</a>
											</div>
											<div class="entry-links clearfix">
												<a onclick="tocart(<%=goodsmap.get("id") %>)" class=" pull-leftcircle add-to-cart">+ 加入购物车</a>
												<a onclick="tofav(<%=goodsmap.get("id") %>)" class="pull-right">+ 收藏</a>
											</div>
										</div>
									</div>
									<%} %>
									<!-- 景点列表结束 -->
									
									
								</div>
								<div><h5><small>${page.info }</small></h5></div>
								<!-- // PRODUCT LAYOUT -->
							</section>
							
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

  function tocart(gid){
		 $.ajax({  
		        type: "POST",      
		         url: "/lyjdzxpwsys/lyjdzxpwsys?ac=tocar", //servlet的名字     
		          data: "gid="+gid+"&sl=1", 
		         success: function(data){       
		    if(data=="true"){     
		    	$("#tsinfo").show();
		     	//$("#tsinfo").html("该图书已加入到购物车");
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
</script>
	<!-- Particular Page Javascripts -->
	<script src="js/jquery.nouislider.js"></script>
	<script src="js/jquery.isotope.min.js"></script>
	<script src="js/products.js"></script>
	<!-- // Particular Page Javascripts -->
</body>
</html>
