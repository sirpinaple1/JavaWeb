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
    <script src="js/jquery-ui/jquery.ui.sortable.min.js" type="text/javascript"></script>
    <!-- END: load jquery -->
    <script src="/lyjdzxpwsys/js/jquery-2.0.3.min.js"></script>	
	<script src="/lyjdzxpwsys/layer/layer.js"></script>
  </head>
 
  <body>
<div class="container_12">
        <jsp:include page="/admin/top.jsp"></jsp:include>
        <jsp:include page="/admin/left.jsp"></jsp:include>
        
        <div class="grid_10">
            <div class="box round first fullpage">
                <h2>添加</h2>
                <div class="block ">
                    <form id="form" action="/lyjdzxpwsys/lyjdzxpwsys?ac=useradd" method="post">
                    <table class="form">
                        <tr>
                            <td class="col1">
                                <label>用户名</label>
                            </td>
                            <td class="col2">
                                <input type="text" id="username" name="username" class="input-xlarge span12" onblur="validatorloginName()" required>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1">
                                <label>密码</label>
                            </td>
                            <td class="col2">
                                <input type="password" id="userpwd" name="userpwd" class="input-xlarge span12" required>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1">
                                <label>姓名</label>
                            </td>
                            <td class="col2">
                                <input type="text" id="realname" name="realname" class="input-xlarge span12" required>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1">
                                <label>性别</label>
                            </td>
                            <td class="col2">
                                <select id="sex" name="sex" required>
						        	<option value="男">男</option>
						        	<option value="女">女</option>
						        </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1">
                                <label>身份证号</label>
                            </td>
                            <td class="col2">
                                <input type="text" id="idcard" name="idcard" class="input-xlarge span12" required>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1">
                                <label>电话</label>
                            </td>
                            <td class="col2">
                                <input type="number" id="tel" name="tel" class="input-xlarge span12" required>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1">
                                <label>email</label>
                            </td>
                            <td class="col2">
                                <input type="text" id="email" name="email" class="input-xlarge span12" required>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1" colspan="2">
                                <button class="btn btn-primary"><i class="icon-save"></i> Save</button>
                            </td>
                        </tr>
                        
                        
                    </table>
                    </form>
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
    	function validatorloginName(){     
          	 var username=document.getElementById("username").value;     
          	 $.ajax({  
          	        type: "POST",      
          	         url: "/lyjdzxpwsys/lyjdzxpwsys?ac=usernamecheck", //servlet的名字     
          	          data: "username="+username, 
          	         success: function(data){       
          	    if(data=="true"){     
          	    	
          	    }else{    
          	    	layer.msg('用户名已存在'); 
          	     	document.getElementById("username").value = "";
          	    }     
          	 }     
          	        });     
          	}     
    </script>
</html>
