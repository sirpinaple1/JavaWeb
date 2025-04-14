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
    <script src="js/pretty-photo/jquery.prettyPhoto.js" type="text/javascript"></script>
    <script src="js/setup.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            setupPrettyPhoto();
            setupLeftMenu();
			setSidebarHeight();


        });
    </script>
  </head>
<%	 CommDAO dao = new CommDAO(); 
     String sql = "select * from goods where 1=1 and delstatus='0' ";
	 String url = "/lyjdzxpwsys/admin/goodsgl.jsp?1=1";
	 String key = request.getParameter("key")==null?"":request.getParameter("key");
	 String key1 = request.getParameter("key1")==null?"":request.getParameter("key1");
	 String key2 = request.getParameter("key2")==null?"":request.getParameter("key2");
	 String f = request.getParameter("f");
	 
	 if(!key.equals(""))
	 {
		 sql+=" and (goodname like'%"+key+"%' or goodno like'%"+key+"%')";
	 url+="&key="+key;
	 }
	 if(!key1.equals(""))
	 {
	 sql+=" and (fid ='"+key1+"')";
	 url+="&key1="+key1;
	 }
	 if(!key2.equals(""))
	 {
	 sql+=" and (sid ='"+key2+"')";
	 url+="&key2="+key2;
	 }
	 sql+=" order by id desc";
%>
  <body>
<div class="container_12">
        <jsp:include page="/admin/top.jsp"></jsp:include>
        <jsp:include page="/admin/left.jsp"></jsp:include>
        
        <div class="grid_10">
            <div class="box round first grid">
                <h2>景点管理</h2>
                <div class="block">
                    
                    
                    
                    <table class="data display" id="example">
                    <thead>
						<tr>
							<th colspan="3" align="left">
								<form action="goodsgl.jsp?f=f" method="post" class="form-inline">
									<input class="input-xlarge" placeholder="景点编号或名称..." id="key" name="key" type="text" value="<%=key %>">
									<select id="key1" name="key1" onChange="Change_Select()" class="input-xlarge">
										<option value="">请选择大类</option>
								    		<%ArrayList<HashMap> fprotypelist = (ArrayList<HashMap>)dao.select("select * from protype where delstatus='0' and fatherid='0' "); 
								    		for(HashMap fprotype:fprotypelist){%>
								    		<option value="<%=fprotype.get("id") %>" <%if(key1.equals(fprotype.get("id"))){out.print("selected==selected");} %>><%=fprotype.get("typename") %></option>
								    		<%} %>
										</select>
										<select id="key2" name="key2" class="input-xlarge" >
									    		<option value="">请选择小类</option>
									    		<%ArrayList<HashMap> sprotypelist = (ArrayList<HashMap>)dao.select("select * from protype where  fatherid='"+key1+"' "); 
									    		for(HashMap sprotype:sprotypelist){%>
									    		<option value="<%=sprotype.get("id") %>" <%if(key2.equals(sprotype.get("id"))){out.print("selected==selected");} %>><%=sprotype.get("typename") %></option>
									    		<%} %>
									    </select>
									<input type="submit"  class="btn btn-small" value="查询">
									<input onclick="newsadd()" type="button"  class="btn btn-small" value="添加">
								</form>
							</th>
						</tr>
					</thead>
					<thead>
						<tr>
							<th>景点编号</th>
				          <th>景点名称</th>
				          <th>所属大类</th>
				          <th>所属小类</th>
				          <th>价格/特价</th>
				          <th>类型</th>
				          <th>是否推荐</th>
				          <th>景点评价</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
					 <%String did = request.getParameter("did");
				      if(did!=null)
				      {
				   	   dao.commOper("update goods set delstatus='1' where id="+did);
				      }
				      String tjid = request.getParameter("tjid");
				      if(tjid!=null)
				      {
				   	   dao.commOper("update goods set istj='yes' where id="+tjid);
				      }
				      String qxtjid = request.getParameter("qxtjid");
				      if(qxtjid!=null)
				      {
				   	   dao.commOper("update goods set istj='no' where id="+qxtjid);
				      }
					   PageManager pageManager = PageManager.getPage(url,10, request);
					   pageManager.doList(sql);
					   PageManager bean= (PageManager)request.getAttribute("page");
					   ArrayList<HashMap> list=(ArrayList)bean.getCollection();
					   	for(HashMap map:list){
					   		HashMap fmap = dao.select("select * from protype where id="+map.get("fid")).get(0);
					   		HashMap smap = dao.select("select * from protype where id="+map.get("sid")).get(0);
					   		HashMap ppmap = dao.select("select * from ppinfo where id="+map.get("goodpp")).get(0);
						    %>
						<tr class="odd gradeX" align="center">
							<td><%=map.get("goodno") %></td>
				          <td><%=map.get("goodname") %></td>
				          <td><%=fmap.get("typename") %></td>
				          <td><%=smap.get("typename") %></td>
				          <td><%=map.get("price") %>/<%=map.get("tprice")==null?"":map.get("tprice") %>
				          <a href="goodstjset.jsp?id=<%=map.get("id") %>">特价</a>
				          </td>
				          <td><%=ppmap.get("ppname") %></td>
				          <td><%=map.get("istj") %></td>
				          <td><a href="goodpj.jsp?gid=<%=map.get("id") %>">查看</a></td>
							<td align="center">
							<%
			    if(map.get("istj").equals("no")){ %>
			    <a href="goodsgl.jsp?tjid=<%=map.get("id") %>" title="推荐">推荐</a>
			    <%}else{ %>
			    <a href="goodsgl.jsp?qxtjid=<%=map.get("id") %>" title="取消推荐">取消推荐</a>
			    <%} %>
							<a href="goodsedit.jsp?id=<%=map.get("id") %>">编辑</a>
							|
							<a href="goodsgl.jsp?did=<%=map.get("id") %>" >删除</a>
							</td>
						</tr>
						<%} %>
						<tr class="odd gradeX">
							<td class="right" colspan="9">${page.info }</td>
						</tr>
						
						
					</tbody>
				</table>
                    
                    
                    
                </div>
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
    	function newsadd(){
			location.href="goodsadd.jsp";
        }
    	var req;
        function Change_Select(){//当第一个下拉框的选项发生改变时调用该函数
          var fprotype = document.getElementById('key1').value;
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
          var select_root = document.getElementById('key2');
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
