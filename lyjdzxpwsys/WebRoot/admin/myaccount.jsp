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
  </head>
    <%CommDAO dao = new CommDAO(); 
    
    HashMap admin = (HashMap)session.getAttribute("admin");
  	HashMap map = dao.select("select * from sysuser where id="+admin.get("id")).get(0);
  %>
  <body>
<div class="container_12">
        <jsp:include page="/admin/top.jsp"></jsp:include>
        <jsp:include page="/admin/left.jsp"></jsp:include>
        
        <div class="grid_10">
            <div class="box round first fullpage">
                <h2>添加</h2>
                <div class="block ">
                    <input type="hidden" id="id" name="id" value="<%=admin.get("id") %>">
                    <table class="form">
                        <tr>
                            <td class="col1">
                                <label>旧密码</label>
                            </td>
                            <td class="col2">
                                <input type="password"  id="oldpwd" name="oldpwd" class="input-xlarge span12" required>

                            </td>
                        </tr>
                        <tr>
                            <td class="col1">
                                <label>新密码</label>
                            </td>
                            <td class="col2">
                                <input type="password"  id="newpwd" name="newpwd" class="input-xlarge span12" required>
                            	<div class="alert alert-info" id="pwderroinfo1" style="display: none">
									<button type="button" class="close" data-dismiss="alert">×</button>
							    </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1">
                                <label>确认新密码</label>
                            </td>
                            <td class="col2">
                                <input type="password"  id="newpwd1" name="newpwd1" class="input-xlarge span12" required>
                            	<div class="alert alert-info" id="erroinfo" style="display: none">
						        	<button type="button" class="close" data-dismiss="alert">×</button>
					    		</div>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1" colspan="2">
                                <button class="btn btn-primary" onclick="sub()"><i class="icon-save"></i> Save</button>
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
    function validatorpwd(){
    	
    }
    	function sub(){     
    		if(document.getElementById("newpwd").value!=document.getElementById("newpwd1").value){
        		$("#pwderroinfo1").show(); 
        		$("#pwderroinfo1").html("两次密码不一致");
        		return false;
        	}else{
        		$("#pwderroinfo1").hide(); 
        	}
          	 var id=document.getElementById("id").value;  
          	 var oldpwd=document.getElementById("oldpwd").value;   
          	 var newpwd=document.getElementById("newpwd").value;   
          	 $.ajax({  
          	        type: "POST",      
          	         url: "/lyjdzxpwsys/lyjdzxpwsys?ac=pwdedit", //servlet的名字     
          	          data: "id="+id+"&oldpwd="+oldpwd+"&newpwd="+newpwd, 
          	         success: function(data){       
          	    if(data=="true"){     
          	    	$("#erroinfo").show();
          	     	$("#erroinfo").html("密码修改成功");
          	    }else{    
          	    	$("#erroinfo").show(); 
          	     	$("#erroinfo").html("旧密码不正确");
          	    }     
          	 }     
          	        });     
          	}     
    </script>
</html>
