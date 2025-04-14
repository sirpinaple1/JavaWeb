<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="dao.CommDAO"%>
<%@page import="util.PageManager"%>
<%@page import="util.Info"%>
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
    <script src="jquery-ui/jquery.ui.sortable.min.js" type="text/javascript"></script>
    <!-- END: load jquery -->
    <script src="/lyjdzxpwsys/js/jquery-2.0.3.min.js"></script>	
	<script src="/lyjdzxpwsys/layer/layer.js"></script>
  </head>
     
  <%CommDAO dao = new CommDAO(); 
  String ddid = request.getParameter("ddid");
  %>
  <body>
<div class="container_12">
        <jsp:include page="/admin/top.jsp"></jsp:include>
        <jsp:include page="/admin/left.jsp"></jsp:include>
        
        <div class="grid_10">
            <div class="box round first fullpage">
                <h2>订单发货</h2>
                <div class="block ">
                    
                    <input type="hidden" id="ddid" name="ddid" value="<%=ddid %>">
                    <table class="form">
                       
                        
                        <tr>
                            <td class="col1">
                                <label>门票有效期至</label>
                            </td>
                            <td class="col2">
                            	<input type="date" id="yxq" name="yxq" class="input-xlarge span12" required>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1" colspan="2">
                                <button class="btn btn-primary" onclick="fh()"><i class="icon-save"></i> 确认发货</button>
                            </td>
                        </tr>
                    </table>
                    
                </div>
            </div>
        </div>
        <div class="clear">
        </div>
        </div>
        <div class="clear">
        </div>
    </div>
    <div class="clear">
    </div>
    <jsp:include page="/admin/foot.jsp"></jsp:include>
	</body>
	<script type="text/javascript">
	function fh(){     
    	 var ddid=document.getElementById("ddid").value;     
    	 var yxq=document.getElementById("yxq").value;   
    	 $.ajax({  
    	        type: "POST",      
    	         url: "/lyjdzxpwsys/lyjdzxpwsys?ac=ddfh", //servlet的名字     
    	          data: "ddid="+ddid+"&yxq="+yxq, 
    	         success: function(data){   
    	    if(data=="true"){     
    	    	layer.msg('发货成功!'); 
    	     	location.href="ddgl.jsp";
    	    }else{    
    	    	layer.msg('订单中景点票务库存不足，发货失败'); 
    	    }     
    	 }     
    	        });     
    	}  
    </script>
</html>
