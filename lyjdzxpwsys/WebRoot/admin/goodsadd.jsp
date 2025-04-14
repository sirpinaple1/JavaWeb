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
   <%CommDAO dao = new CommDAO();  %>
  <body>
<div class="container_12">
        <jsp:include page="/admin/top.jsp"></jsp:include>
        <jsp:include page="/admin/left.jsp"></jsp:include>
        
        <div class="grid_10">
            <div class="box round first fullpage">
                <h2>添加</h2>
                <div class="block ">
                    <form id="form" action="/lyjdzxpwsys/lyjdzxpwsys?ac=goodsadd" method="post" enctype="multipart/form-data">
                    <table class="form">
                        <tr>
                            <td class="col1">
                                <label>景点名称</label>
                            </td>
                            <td class="col2">
                                <input type="text" id="goodname" name="goodname" class="input-xlarge span5" required>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1">
                                <label>景点分类</label>
                            </td>
                            <td class="col2">
                                <select id="fid" name="fid" onChange="Change_Select()" class="input-xlarge" required>
									<option value="">请选择大类</option>
						    		<%ArrayList<HashMap> fprotypelist = (ArrayList<HashMap>)dao.select("select * from protype where delstatus='0' and fatherid='0' "); 
						    		for(HashMap fprotype:fprotypelist){%>
						    		<option value="<%=fprotype.get("id") %>"><%=fprotype.get("typename") %></option>
						    		<%} %>
								</select>
								<select id="sid" name="sid" required>
								    <option value="">请选择小类</option>
								</select>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1">
                                <label>类型</label>
                            </td>
                            <td class="col2">
                                <select id="goodpp" name="goodpp" class="input-xlarge" required>
										<option value="">请选择</option>
									    <%ArrayList<HashMap> pplist = (ArrayList<HashMap>)dao.select("select * from ppinfo where delstatus='0' "); 
									    for(HashMap ppmap:pplist){%>
									    <option value="<%=ppmap.get("id") %>"><%=ppmap.get("ppname") %></option>
									    <%} %>
								</select>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1">
                                <label>景点门票价格</label>
                            </td>
                            <td class="col2">
                                <input type="number" step="0.1" id="price" name="price" class="input-xlarge" required>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1">
                                <label>图片</label>
                            </td>
                            <td class="col2">
                                <input type="file" id="filename" name="filename" class="input-xlarge" required>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1">
                                <label>简要描述</label>
                            </td>
                            <td class="col2">
                                <input type="text" size="100" id="remark" name="remark" class="input-xlarge" required>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1">
                                <label>详情</label>
                            </td>
                            <td class="col2">
                                <textarea id="editor_id" id="note" name="note" style="width:1000px;height:400px;" ></textarea>
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


    	var req;
	    function Change_Select(){//当第一个下拉框的选项发生改变时调用该函数
	      var fprotype = document.getElementById('fid').value;
	      var url = "/lyjdzxpwsys/lyjdzxpwsys?ac=searchsontype&fprotype="+ escape(fprotype);
	      if(window.XMLHttpRequest){
	        req = new XMLHttpRequest();
	      }else if(window.ActiveXObject){
	        req = new ActiveXObject("Microsoft.XMLHTTP");
	      }  
	      if(req){
	     
	        req.open("GET",url,true);
	         //指定回调函数为callback
	        req.onreadystatechange = callback;
	        req.send(null);
	      }
	    }
	    //回调函数
	    function callback(){
	    
	      if(req.readyState ==4){
	        if(req.status ==200){
	        //var msg = req.responseText;
			//		alert(msg);
	        
	          parseMessage();//解析XML文档
	        }else{
	          alert("不能得到描述信息:" + req.statusText);
	        }
	      }
	    }
	    //解析返回xml的方法
	    function parseMessage(){
	      var xmlDoc = req.responseXML.documentElement;//获得返回的XML文档
	      var xSel = xmlDoc.getElementsByTagName('select');
	      //获得XML文档中的所有<select>标记
	      var select_root = document.getElementById('sid');
	      //获得网页中的第二个下拉框
	      select_root.options.length=0;
	      //每次获得新的数据的时候先把每二个下拉框架的长度清0
	     
	      for(var i=0;i<xSel.length;i++){
	        var xValue = xSel[i].childNodes[0].firstChild.nodeValue;
	        //获得每个<select>标记中的第一个标记的值,也就是<value>标记的值
	        var xText = xSel[i].childNodes[1].firstChild.nodeValue;
	        //获得每个<select>标记中的第二个标记的值,也就是<text>标记的值
	       
	        var option = new Option(xText, xValue);
	        //根据每组value和text标记的值创建一个option对象
	       
	        try{
	          select_root.add(option);//将option对象添加到第二个下拉框中
	        }catch(e){
	        }
	      }
	    }  
    </script>
</html>
