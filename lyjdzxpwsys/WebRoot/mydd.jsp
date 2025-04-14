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
						<li class="active">订单中心</li>
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
								
								<table class="tbl-cart" style="width: 80%">
									<thead>
										<tr>
											<th>订单号</th>  
											<th>订单景点</th>  
											<th>订单金额</th>
											<th>付款状态</th>
											<th>发货状态</th>  
											<th>收货状态</th> 
											<th>订单日期</th> 
											<th class="hidden-xs" style="width: 10%;"></th>
										</tr>
									</thead>
									<tbody>
											<%
											String sql = "select * from ddinfo where  memberid='"+member.get("id")+"' order by id desc";
											String url ="mydd.jsp?1=1";
											String did = request.getParameter("did");
											if(did!=null){
												HashMap mm = dao.select("select * from ddinfo where id="+did).get(0);
								           		dao.commOper("delete from ddinfo where id="+did);
								           		dao.commOper("delete from dddetail where ddno="+mm.get("ddno"));
											}
											String shid = request.getParameter("shid");
								            if(shid!=null)
								            {
								         		dao.commOper("update ddinfo set shstatus='已收货' where id="+shid);
								            }
								            PageManager pageManager = PageManager.getPage(url,10, request);
										    pageManager.doList(sql);
										    PageManager bean= (PageManager)request.getAttribute("page");
										    ArrayList<HashMap> infoslist=(ArrayList)bean.getCollection();
										    for(HashMap infosmap :infoslist)
										    {
											%>
										<tr style="height: 100%">
											<td align="center"><h5><small><%=infosmap.get("ddno") %></small></h5></td>  
											<td style="text-align: left;height: 100%;"><h5><small>
											<%ArrayList<HashMap> dddetaillist = (ArrayList<HashMap>)dao.select("select * from dddetail where ddno="+infosmap.get("ddno")); 
							                String str = "";
							                for(HashMap dddetail:dddetaillist){
							                	HashMap gmap = dao.select("select * from goods where id="+dddetail.get("goodid")).get(0);
							                %>
							                <a href="good.jsp?id=<%=gmap.get("id") %>"><%=gmap.get("goodname") %></a>&nbsp;&nbsp;&nbsp;数量：<%=dddetail.get("sl") %>
							                <%
							                if(dddetail.get("ticketno")!=null && !dddetail.get("ticketno").equals("")){ 
							                	str = "票号:"+dddetail.get("ticketno")+"[有效期:"+dddetail.get("yxq")+"]";
							                } 
							                %>
							                <%=str %>
							                <% ArrayList<HashMap> pjlist = (ArrayList<HashMap>)dao.select("select * from pj where goodid='"+gmap.get("id")+"' and ddid='"+infosmap.get("id")+"' and memberid='"+member.get("id")+"'");
							                if(pjlist.size()==0&&infosmap.get("shstatus").equals("已收货")){ %>
							                	<a href="pj.jsp?id=<%=gmap.get("id") %>&ddid=<%=infosmap.get("id") %>">[评价]</a>
							                <%} %>
							                <br/>
							                <%} %></a></small></h5>
											</td>  
											<td><h5><small>¥<%=infosmap.get("ddprice") %></small></h5></td>  
											<td><h5><small><%=infosmap.get("fkstatus") %></small></h5></td>  
											<td><h5><small><%=infosmap.get("fhstatus") %></small></h5></td>
											<td><h5><small><%=infosmap.get("shstatus") %></small></h5></td>
											<td><h5><small><%=infosmap.get("savetime").toString().substring(0,10) %></small></h5></td>
											<td class="hidden-xs">
											
											
											<%if(infosmap.get("fkstatus").equals("待付款")){ %>
							                <button type="button" class="close" aria-hidden="true" onclick="tocheckout(<%=infosmap.get("id") %>,<%=infosmap.get("ddprice") %>)" title="订单付款">¥</button>
							                <%} %>
							                <%if(infosmap.get("fhstatus").equals("待发货")){ %>
							                <button type="button" class="close" aria-hidden="true" onclick="removedd(<%=infosmap.get("id") %>)" title="撤销订单">×</button>
							                <%} %>
							                <%if(infosmap.get("shstatus").equals("待收货")&&infosmap.get("fhstatus").equals("已发货")){ %>
							                <button type="button" class="close" aria-hidden="true" onclick="confirmorder(<%=infosmap.get("id") %>)" title="确认收货">√</button>
							                <%}%>
											
											</td>
										</tr>
										<%} %>
										<tr>
											<td colspan="9"><h5><small>${page.info }</small></h5></td>
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


function removedd(id){
	 $.ajax({  
		type: "POST",      
		url: "/lyjdzxpwsys/lyjdzxpwsys?ac=removedd", //servlet的名字     
	 	data: "id="+id, 
	 	success: function(data){       
   		}
	 });  
}
function tocheckout(id,fee){
	location.href="checkout.jsp?ddid="+id+"&fee="+fee;
}
function confirmorder(id){
	$.ajax({  
		type: "POST",      
		url: "/lyjdzxpwsys/lyjdzxpwsys?ac=confirmorder", //servlet的名字     
	 	data: "id="+id, 
	 	success: function(data){  
	 		if(data=="true"){
		 		location.href="mydd.jsp";
		 		}     
   		}
	 });  
}
</script>
</body>
</html>
