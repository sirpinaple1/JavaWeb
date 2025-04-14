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
    
    
  </head>
  <%HashMap admin = (HashMap)session.getAttribute("admin"); %>
  <body>
<div class="container_12">
        <div class="grid_12 header-repeat">
            <div id="branding">
                <div class="floatleft">
                    	<h3 style="color: white;">智慧景区票务系统</h3></div>
                <div class="floatright">
                    <div class="floatleft">
                        <img src="img/img-profile.jpg" alt="Profile Pic" /></div>
                    <div class="floatleft marginleft10">
                        <ul class="inline-ul floatleft">
                            <li>您好：<%=admin.get("realname") %></li>
                            <li><a href="myaccount.jsp">密码修改</a></li>
                            <li><a href="/lyjdzxpwsys/lyjdzxpwsys?ac=backexit">安全退出</a></li>
                        </ul>
                        
                    </div>
                </div>
                <div class="clear">
                </div>
            </div>
        </div>
        <div class="clear">
        </div>
        
	</body>
</html>
