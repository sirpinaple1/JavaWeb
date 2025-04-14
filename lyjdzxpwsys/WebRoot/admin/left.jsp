<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>智慧景区票务系统</title>
    <link rel="stylesheet" type="text/css" href="css/reset.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/text.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/grid.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/layout.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/nav.css" media="screen" />
    <!--[if IE 6]><link rel="stylesheet" type="text/css" href="css/ie6.css" media="screen" /><![endif]-->
    <!--[if IE 7]><link rel="stylesheet" type="text/css" href="css/ie.css" media="screen" /><![endif]-->
    <link href="css/table/demo_page.css" rel="stylesheet" type="text/css" />
    <!-- BEGIN: load jquery -->
    <script src="js/jquery-1.6.4.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/jquery-ui/jquery.ui.core.min.js"></script>
    <script src="js/jquery-ui/jquery.ui.widget.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.accordion.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.core.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.slide.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.mouse.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.sortable.min.js" type="text/javascript"></script>
    <script src="js/table/jquery.dataTables.min.js" type="text/javascript"></script>
    <!-- END: load jquery -->
    <script type="text/javascript" src="js/table/table.js"></script>
    <script src="js/setup.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            setupLeftMenu();

            $('.datatable').dataTable();
			setSidebarHeight();


        });
    </script>
  </head>
  
  <body>
<div class="container_12">
        
        <div class="grid_2">
            <div class="box sidemenu">
                <div class="block" id="section-menu">
                    <ul class="section menu">
                        <li><a class="menuitem">基础信息</a>
                            <ul class="submenu">
                                <li><a href="newslist.jsp">资讯管理</a> </li>
                                <li><a href="memberlist.jsp">会员管理</a> </li>
                                <li><a href="userlist.jsp">用户管理</a> </li>
                                <li><a href="yqlink.jsp">友情链接</a> </li>
                                <li><a href="imgadv.jsp">滚动图片</a> </li>
                                <li><a href="aboutedit.jsp"> 关于我们</a> </li>
                            </ul>
                        </li>
                        <li><a class="menuitem">业务功能</a>
                            <ul class="submenu">
                                <li><a href="protype.jsp">景点分类</a></li>
					            <li><a href="ppinfo.jsp">景点类型管理</a></li>
					            <li><a href="goodsgl.jsp">景点管理</a></li>
					            <li><a href="goodskc.jsp">票务管理</a></li>
					            <li><a href="ddgl.jsp">订单管理</a></li>
					            <li><a href="msglist.jsp">留言管理</a></li>
                            </ul>
                        </li>
                        <li><a class="menuitem">统计分析</a>
                            <ul class="submenu">
                                <li><a href="tj1.jsp">景点销量排行</a> </li>
                                <li><a href="tj2.jsp">景点收藏排行</a> </li>
                                <li><a href="tj3.jsp">销售额走势图</a> </li>
                                <li><a href="tj4.jsp">订单量走势图</a> </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        
	</body>
</html>
