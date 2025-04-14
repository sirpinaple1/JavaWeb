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
	 String sql = "select * from sbinfo where 1=1   ";
	 String url = "/lyjdzxpwsys/admin/sbinfolist.jsp?1=1";
	 String key = request.getParameter("key")==null?"":request.getParameter("key");
	 String key1 = request.getParameter("key1")==null?"":request.getParameter("key1");
	 String f = request.getParameter("f");
	 
	 if(!key.equals(""))
	 {
	 sql+=" and (title like'%"+key+"%')";
	 url+="&key="+key;
	 }
	 sql+=" order by id desc";
%>

  <body>
<div class="container_12">
        <jsp:include page="/admin/top.jsp"></jsp:include>
        <jsp:include page="/admin/left.jsp"></jsp:include>
        
        <div class="grid_10">
            <div class="box round first grid">
                <h2>手办投递管理</h2>
                <div class="block">
                    
                    
                    
                    <table class="data display" id="example">
                    <thead>
						<tr>
							<th colspan="3" align="left">
								<form action="sbinfolist.jsp?f=f" method="post" class="form-inline">
									<input class="input-xlarge" placeholder="标题..." id="key" name="key" type="text" value="<%=key %>">
				                    <button class="btn btn-small" type="submit"><i class="icon-search"></i> 查询</button>
								</form>	
							</th>
						</tr>
					</thead>
					<thead>
						<tr>
						  <th>标题</th>
				          <th>投递人</th>
				          <th>投递日期</th>
				          <th>审核状态</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
					 <%String did = request.getParameter("did");
					   if(did!=null)
					   {
						   dao.commOper("delete from  sbinfo  where id="+did);
					   }
					   String tgid = request.getParameter("tgid");
					   if(tgid!=null)
					   {
						   dao.commOper("update  sbinfo set shstatus='通过' where id="+tgid);
					   }
					   String jjid = request.getParameter("jjid");
					   if(jjid!=null)
					   {
						   dao.commOper("update  sbinfo set shstatus='拒绝' where id="+jjid);
					   }
					   PageManager pageManager = PageManager.getPage(url,10, request);
					   pageManager.doList(sql);
					   PageManager bean= (PageManager)request.getAttribute("page");
					   ArrayList<HashMap> list=(ArrayList)bean.getCollection();
					   	for(HashMap map:list){
					   		HashMap mbmap = dao.select("select * from member where id="+map.get("memberid")).get(0);
						    %>
						<tr class="odd gradeX" align="center">
							<td align="left"><a href="/lyjdzxpwsys/sbinfodetailforadmin.jsp?id=<%=map.get("id") %>" target="_blank"><%=map.get("title") %></a></td>
					          <td><%=mbmap.get("tname") %></td>
					          <td><%=map.get("savetime") %></td>
					          <td><%=map.get("shstatus") %></td>
							<td align="center">
							<%if(map.get("shstatus").equals("待审核")){ %>
							<a href="sbinfolist.jsp?tgid=<%=map.get("id") %>" >通过</a>
							<a href="sbinfolist.jsp?jjid=<%=map.get("id") %>" >拒绝</a>
							<%} %>
							<a href="sbinfolist.jsp?did=<%=map.get("id") %>" >删除</a>
							</td>
						</tr>
						<%} %>
						<tr class="odd gradeX">
							<td class="right" colspan="5">${page.info }</td>
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
			location.href="yqlinkadd.jsp";
        }
    </script>
</html>
