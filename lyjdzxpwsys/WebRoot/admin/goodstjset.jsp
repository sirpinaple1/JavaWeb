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
  String id = request.getParameter("id");
  HashMap map = dao.select("select * from goods where id="+id).get(0);
  %>
    
  <body>
<div class="container_12">
        <jsp:include page="/admin/top.jsp"></jsp:include>
        <jsp:include page="/admin/left.jsp"></jsp:include>
        
        <div class="grid_10">
            <div class="box round first fullpage">
                <h2>特价设置</h2>
                <div class="block ">
                    <form id="form" action="/lyjdzxpwsys/lyjdzxpwsys?ac=goodstjset&id=<%=id %>"" method="post">
                    <input type="hidden" id="gid" name="gid" value="<%=id %>">
                    <table class="form">
                       
                        <tr>
                            <td class="col1">
                                <label>特价</label>
                            </td>
                            <td class="col2">
                            	 <input type="number" onblur="validator()" value="<%=map.get("tprice")==null?"":map.get("tprice") %>" step="0.1" id="tprice" name="tprice" class="input-xlarge">
                            	<div class="alert alert-info" id="erroinfo" style="display: none">
						        	<button type="button" class="close" data-dismiss="alert">×</button>
					    		</div>
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
	function validator(){     
     	 var tprice=document.getElementById("tprice").value;     
     	 var gid=document.getElementById("gid").value;   
     	 $.ajax({  
     	        type: "POST",      
     	         url: "/lyjdzxpwsys/lyjdzxpwsys?ac=validatortprice", //servlet的名字     
     	          data: "tprice="+tprice+"&gid="+gid, 
     	         success: function(data){   
     	    if(data=="true"){     
     	    	$("#erroinfo").show();
     	     	$("#erroinfo").html("");
     	    }else{    
     	    	$("#erroinfo").show(); 
     	     	$("#erroinfo").html("特价必须低于原价");
     	     	document.getElementById("tprice").value = "";
     	    }     
     	 }     
     	        });     
     	}  
    </script>
</html>
