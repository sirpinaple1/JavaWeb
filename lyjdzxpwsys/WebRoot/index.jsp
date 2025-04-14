<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="dao.CommDAO"%>
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
HashMap sitemap = dao.select("select * from siteinfo where id=1").get(0);
HashMap member = (HashMap)session.getAttribute("member");%>
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
	<link rel="stylesheet" href="css/owl.carousel.css">
	<link rel="stylesheet" href="css/owl.theme.css">
	<link href="css/flexslider.css" rel="stylesheet" />
	<!-- // PARTICULAR PAGES CSS FILES -->
	<link rel="stylesheet" href="css/responsive.css">
	<script src="js/jquery-2.0.3.min.js"></script>	
	<script src="layer/layer.js"></script>
</head>

<body class="home">
			
	<!-- PAGE WRAPPER -->
<div id="page-wrapper">

	<jsp:include page="top.jsp"></jsp:include>
	<!-- // SITE HEADER -->
    
		
		<!-- HOMEPAGE SLIDER -->
		<div id="home-slider">
			<div class="flexslider">
	<ul class="slides">
		<!-- THE FIRST SLIDE -->
		<%ArrayList<HashMap> imglist = (ArrayList<HashMap>)dao.select("select * from imgadv order by id");
		for(HashMap imgmap:imglist){
		%>
		<li>
			<!-- THE MAIN IMAGE IN THE SLIDE -->
			<img src="upfile/<%=imgmap.get("filename") %>" alt="" />
			
			<!-- THE CAPTIONS OF THE FIRST SLIDE -->
			<div class="flex-caption h6 text-bold gfc uppercase animated"
			data-animation="fadeInLeftBig"
			data-x="800"
			data-y="110"
			data-speed="600"
			data-start="1200"></div>
			
			<div class="flex-caption herotext text-bold gfc animated"
			data-animation="fadeInRightBig"
			data-x="580"
			data-y="140"
			data-speed="900"
			data-start="2000"></div>
			
			<div class="flex-caption h6 text-bold gfc text-center animated"
			data-animation="fadeInDown"
			data-x="639"
			data-y="260"
			data-speed="1600"
			data-start="2900">
				<!--  Comfy knits and warm jackets for cooler Autumn days<br/>
				<a href="products.html" class="btn btn-primary uppercase">Shop Now</a>-->
			</div>
		</li>
		<%} %>
		
		
	</ul>
</div>

<script>
	jQuery(function($) {
		var $slider = $('#home-slider > .flexslider');
		$slider.find('.flex-caption').each(function() {
			var $this = $(this);
			var configs = {
				left: $this.data('x'),
				top: $this.data('y'),
				speed: $this.data('speed') + 'ms',
				delay: $this.data('start') + 'ms'
			};
			if ( configs.left == 'center' && $this.width() !== 0 ) 
			{
				configs.left = ( $slider.width() - $this.width() ) / 2;
			}
			if ( configs.top == 'center' && $this.height() !== 0 ) 
			{
				configs.top = ( $slider.height() - $this.height() ) / 2;
			}
			
			$this.data('positions', configs);
			
			$this.css({
				'left': configs.left + 'px',
				'top': configs.top + 'px',
				'animation-duration': configs.speed,
				'animation-delay': configs.delay
			});
		});
		
		$(window).on('resize', function() {
			var wW = $(window).width(),
				zoom = ( wW >= 1170 ) ? 1 : wW / 1349;
			$('.flex-caption.gfc').css('zoom', zoom);
		});
		$(window).trigger('resize');
		
		
		
		$slider.imagesLoaded(function() {
			$slider.flexslider({
				animation: 'slide',
				easing: 'easeInQuad',
				slideshow: false,
				nextText: '<i class="iconfont-angle-right"></i>',
				prevText: '<i class="iconfont-angle-left"></i>',
				start: function() {
					flex_fix_pos(1);
				},
				before: function(slider) {
					// initial caption animation for next show
					$slider.find('.slides li .animation-done').each(function() {
						$(this).removeClass('animation-done');
						var animation = $(this).attr('data-animation');
						$(this).removeClass(animation);
					});
					
					flex_fix_pos(slider.animatingTo + 1);
				},
				after: function() {
					// run caption animation
					$slider.find('.flex-active-slide .animated').each(function() {
						var animation = $(this).attr('data-animation');
						$(this).addClass('animation-done').addClass(animation);
					});
				}
			});
		});
		
		
		function flex_fix_pos(i) {
			$slider.find('.slides > li:eq(' + i + ') .gfc').each(function() {
				var $this = $(this),
					pos = $(this).data('positions');
					
				if ( pos.left == 'center' )
				{
					pos.left = ( $slider.width() - $this.width() ) / 2;
					$this.css('left', pos.left + 'px');
					$this.data('positions', pos);
				}
				if ( pos.top == 'center' )
				{
					pos.top = ( $slider.height() - $this.height() ) / 2;
					$this.css('left', pos.top + 'px');
					$this.data('positions', pos);
				}
			});
		}
	});
</script>		</div>
		<!-- // HOMEPAGE SLIDER -->
		
		<!-- SITE MAIN CONTENT -->
		<main id="main-content" role="main">

			
			<!-- FEATURED PRODUCTS -->
			<section class="section featured visible-items-4">
				<div class="container">
					<div class="row">
						<header class="section-header clearfix col-sm-offset-3 col-sm-6">
							<h3 class="section-title">feature products</h3>
							<p class="section-teaser">查看更多景点，<a href="goods.jsp">请点击</a></p>
						</header>
						
						<div class="clearfix"></div>
						
						<!-- BEGIN CAROUSEL -->
						<div id="featured-products" class="add-cart" data-product=".product" data-thumbnail=".entry-media .thumb" data-title=".entry-title > a" data-url=".entry-title > a" data-price=".entry-price > .price">
						
							<div class="owl-controls clickable top">
								<div class="owl-buttons">
									<div class="owl-prev"><i class="iconfont-angle-left"></i></div>
									<div class="owl-next"><i class="iconfont-angle-right"></i></div>
								</div>
							</div>
							
							<div class="owl-carousel owl-theme" data-visible-items="4" data-navigation="true" data-lazyload="true">
							
							<%ArrayList<HashMap> goodslist = (ArrayList<HashMap>)dao.select("select * from goods where delstatus='0' and istj='yes' order by id desc limit 8"); 
							int a=0;
							for(HashMap goodsmap:goodslist){
								a++;
							%>
							
								<div class="product" data-product-id="<%=a %>">
									<div class="entry-media">
										<!--  <img data-src="images/women/basic/848051-0014_1_t.jpg" alt="" class="lazyOwl thumb" />-->
										<img data-src="upfile/<%=goodsmap.get("filename") %>" alt="" class="lazyOwl thumb" style="height:250px"/>
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
										<div class="entry-price">
										<%if(goodsmap.get("tprice")!=null&&!goodsmap.get("tprice").equals("")){ %>
											<s class="entry-discount">¥ <%=goodsmap.get("price") %></s>
											<strong class="accent-color price">¥<%=goodsmap.get("tprice") %></strong>
										<%}else{ %>
											<strong class="accent-color price">¥<%=goodsmap.get("price") %></strong>
										<%} %>
										<a onclick="tofav(<%=goodsmap.get("id") %>)" class="pull-right">+ 收藏</a>
										</div>
										
									</div>
								</div>
								<%} %>
								
								
							
							</div>
								
						</div>
						<!-- // END CAROUSEL -->
						
					</div>
				</div>
			</section>
			<!-- // FEATURED PRODUCTS -->
			
			
			
		</main>
		<!-- // SITE MAIN CONTENT -->
				
		<jsp:include page="foot.jsp"></jsp:include>
		
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
		     	$("#tsinfo").html("加入购物车失败");
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
	<script src="js/owl.carousel.js"></script>
	<script src="js/jquery.flexslider-min.js"></script>
	<!-- // Particular Page Javascripts -->
</body>
</html>
