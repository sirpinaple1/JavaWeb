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
    <script charset="utf-8" src="/lyjdzxpwsys/kindeditor/kindeditor.js"></script>
	<script charset="utf-8" src="/lyjdzxpwsys/kindeditor/lang/zh-CN.js"></script>
	<script>
	        KindEditor.ready(function(K) {
	                window.editor = K.create('#editor_id');
	        });
	</script>
	<script>

KindEditor.ready(function(K) {

K.create('textarea[name="note"]', {

uploadJson : '/lyjdzxpwsys/kindeditor/jsp/upload_json.jsp',

                fileManagerJson : '/lyjdzxpwsys/kindeditor/jsp/file_manager_json.jsp',

                allowFileManager : true,

                allowImageUpload : true, 

autoHeightMode : true,

afterCreate : function() {this.loadPlugin('autoheight');},

afterBlur : function(){ this.sync(); }  //Kindeditor下获取文本框信息

});

});

</script>
  </head>
     
    <%	 CommDAO dao = new CommDAO(); 
	 String id = request.getParameter("id");
	 HashMap map = dao.select("select * from about where id=1").get(0);
%>
  <body>
<div class="container_12">
        <jsp:include page="/admin/top.jsp"></jsp:include>
        <jsp:include page="/admin/left.jsp"></jsp:include>
        
        <div class="grid_10">
            <div class="box round first fullpage">
                <h2>关于我们</h2>
                <div class="block ">
                    <form id="form" action="/lyjdzxpwsys/lyjdzxpwsys?ac=aboutedit" method="post">
                    <table class="form">
                       
                        <tr>
                            <td class="col1">
                                <label>联系人</label>
                            </td>
                            <td class="col2">
                            	<input type="text" id="lxr" name="lxr" class="input-xlarge span12"  value="<%=map.get("lxr") %>" required>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1">
                                <label>电话</label>
                            </td>
                            <td class="col2">
                            	<input type="text" id="tel" name=tel class="input-xlarge span12"  value="<%=map.get("tel") %>" required>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1">
                                <label>地址</label>
                            </td>
                            <td class="col2">
                            	<input type="text" id="addr" name="addr" class="input-xlarge span12"  value="<%=map.get("addr") %>" required>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1">
                                <label>内容</label>
                            </td>
                            <td class="col2">
                            	<textarea id="editor_id" id="note" name="note" style="width:1000px;height:400px;" ><%=map.get("note") %></textarea>
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
    	  
    </script>
</html>
