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
    String sql = "select * from ddinfo where 1=1  ";
	 String url = "/lyjdzxpwsys/admin/ddgl.jsp?1=1";
	 String key = request.getParameter("key")==null?"":request.getParameter("key");
	 String key1 = request.getParameter("key1")==null?"":request.getParameter("key1");
	 String key2 = request.getParameter("key2")==null?"":request.getParameter("key2");
	 String f = request.getParameter("f");
	 
	 if(!key.equals(""))
	 {
	 sql+=" and (ddno = '"+key+"')";
	 url+="&key="+key;
	 }
	 if(!key1.equals(""))
	 {
	 sql+=" and (fkstatus ='"+key1+"')";
	 url+="&key1="+key1;
	 }
	 if(!key2.equals(""))
	 {
	 sql+=" and (fhstatus ='"+key2+"')";
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
                <h2>订单管理</h2>
                <div class="block">
                    
                    
                    
                    <table class="data display" id="example">
                    <thead>
						<tr>
							<th colspan="9" align="left">
								<form action="ddgl.jsp?f=f" method="post" class="form-inline">
									<input class="input-xlarge" placeholder="订单号..." id="key" name="key" type="text" value="<%=key %>">
									<select id="key2" name="key2">
							    		<option value="">发货状态</option>
							    		<option value="待发货" <%if(key2.equals("待发货")){out.print("selected==selected");} %>>待发货</option>
							    		<option value="已发货" <%if(key2.equals("已发货")){out.print("selected==selected");} %>>已发货</option>
							    	</select>
				                    <button class="btn btn-small" type="submit">查询</button>
								</form>	
							</th>
						</tr>
					</thead>
					<thead>
						<tr>
							<th>订单编号</th>
				          <th>订单景点</th>
				          <th>订单金额</th>
				          <th>订单人信息</th>
				          <th>付款状态</th>
				          <th>发货状态</th>
				          <th>收货状态</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
					 <%String did = request.getParameter("did");
					   if(did!=null)
					   {
						   dao.commOper("delete from ddinfo where id="+did);
					   }
					   PageManager pageManager = PageManager.getPage(url,10, request);
					   pageManager.doList(sql);
					   PageManager bean= (PageManager)request.getAttribute("page");
					   ArrayList<HashMap> list=(ArrayList)bean.getCollection();
					   	for(HashMap map:list){
					   		HashMap mbmap = dao.select("select * from member where id="+map.get("memberid")).get(0);
						    %>
						<tr class="odd gradeX" align="center">
							<td><%=map.get("ddno") %></td>
					          <td align="left">
					          		<%ArrayList<HashMap> dddetaillist = (ArrayList<HashMap>)dao.select("select * from dddetail where ddno="+map.get("ddno")); 
					                for(HashMap dddetail:dddetaillist){
					                	HashMap gmap = dao.select("select * from goods where id="+dddetail.get("goodid")).get(0);
					                %>
					                <%=gmap.get("goodname") %>&nbsp;&nbsp;&nbsp;数量：<%=dddetail.get("sl") %>
					                		<%if(dddetail.get("ticketno")!=null  && !dddetail.get("ticketno").equals("")){ %>
							                	票号:<%=dddetail.get("ticketno") %>[有效期:<%=dddetail.get("yxq") %>]
							                <%} %>
							                <br/>
					                <%} %>
					                
					          </td>
					          <td><%=map.get("ddprice") %></td>
					          <td><%=mbmap.get("tname") %>/<%=mbmap.get("tel") %></td>
					          <td><%=map.get("fkstatus") %></td>
					          <td><%=map.get("fhstatus") %></td>
					          <td><%=map.get("shstatus") %></td>
					          <td>
					          <%if(map.get("fkstatus").equals("已付款")&&map.get("fhstatus").equals("待发货")){ %>
								<a href="ddfh.jsp?ddid=<%=map.get("id") %>" title="发货">发货</a>
							   <%} %>
							   <%if(map.get("fkstatus").equals("待付款")){ %>
							    <a href="ddgl.jsp?did=<%=map.get("id") %>" title="删除">删除</a>
							    <%} %>
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
			location.href="yqlinkadd.jsp";
        }
    </script>
</html>
