package control;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.SocketException;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.RequestContext;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.servlet.ServletRequestContext;




import util.Info;
import util.StrUtil;

import dao.CommDAO;

public class MainCtrl extends HttpServlet {
	
	public MainCtrl() {
		super();
	}

	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
	this.doPost(request, response);
	}

		public void go(String url,HttpServletRequest request, HttpServletResponse response)
		{
		try {
			request.getRequestDispatcher(url).forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		}
		
		public void gor(String url,HttpServletRequest request, HttpServletResponse response)
		{
			try {
				response.sendRedirect(url);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
        response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		HashMap admin = (HashMap)session.getAttribute("admin");
		HashMap member = (HashMap)session.getAttribute("member");
		String ac = request.getParameter("ac");
		if(ac==null)ac="";
		CommDAO dao = new CommDAO();
		String date = Info.getDateStr();
		String today = date.substring(0,10);
		String tomonth = date.substring(0,7);
		
		//登录
		if(ac.equals("login"))
		{
			    String username = request.getParameter("username");
			    String userpwd = request.getParameter("userpwd");
			    	String sql = "select * from sysuser where username='"+username+"' and userpwd='"+userpwd+"' and usertype in ('管理员') ";
			    	List<HashMap> list = dao.select(sql);
			    	if(list.size()==1)
			    	{
			    	session.setAttribute("admin", list.get(0));
			    	gor("/lyjdzxpwsys/admin/newslist.jsp", request, response);
			    	}else{
			    		request.setAttribute("error", "");
				    	gor("/lyjdzxpwsys/admin/newslist.jsp", request, response);
			    	}
		}
		//后台退出
		if(ac.equals("backexit")){
			session.removeAttribute("admin");
			gor("/lyjdzxpwsys/admin/login.jsp", request, response);
		}

		//新增新闻
		if(ac.equals("newsadd")){
			try {
				String title = "";
				String img = "";
				String note="";
			request.setCharacterEncoding("utf-8");
			RequestContext  requestContext = new ServletRequestContext(request);
			if(FileUpload.isMultipartContent(requestContext)){
			   DiskFileItemFactory factory = new DiskFileItemFactory();
			   factory.setRepository(new File(request.getRealPath("/upfile/")+"/"));
			   ServletFileUpload upload = new ServletFileUpload(factory);
			   upload.setSizeMax(100*1024*1024);
			   List items = new ArrayList();
			     items = upload.parseRequest(request);
			     
			     title = ((FileItem) items.get(0)).getString();
			     title = Info.getUTFStr(title);
			     
			     note = ((FileItem) items.get(2)).getString();
			     note = Info.getUTFStr(note);

			    FileItem fileItem = (FileItem) items.get(1);
			   if(fileItem.getName()!=null && fileItem.getSize()!=0)
			    {
			    if(fileItem.getName()!=null && fileItem.getSize()!=0){
			      File fullFile = new File(fileItem.getName());
			      img = Info.generalFileName(fullFile.getName());
			      File newFile = new File(request.getRealPath("/upfile/")+"/" + img);
			      try {
			       fileItem.write(newFile);
			      } catch (Exception e) {
			       e.printStackTrace();
			      }
			     }else{
			     }
			    }
			}

			String sql = "insert into news (title,img,note,savetime,type) " +
					"values('"+title+"','"+img+"','"+note+"','"+Info.getDateStr()+"','新闻')" ;
			dao.commOper(sql);
			
			request.setAttribute("suc", "操作成功!");
			gor("/lyjdzxpwsys/admin/newslist.jsp", request, response);
			
			} catch (Exception e1) {
				e1.printStackTrace();
				request.setAttribute("error", "");
			     request.getRequestDispatcher("/lyjdzxpwsys/admin/newsadd.jsp").forward(request, response);
			    }
		}
		//编辑新闻
		if(ac.equals("newsedit")){
			String id = request.getParameter("id");
			HashMap map = dao.select("select * from news where id="+id).get(0);
			try {
				String title="";
				String note="";
				String img=map.get("img").toString();
			request.setCharacterEncoding("utf-8");
			RequestContext  requestContext = new ServletRequestContext(request);
			if(FileUpload.isMultipartContent(requestContext)){

			   DiskFileItemFactory factory = new DiskFileItemFactory();
			   factory.setRepository(new File(request.getRealPath("/upfile/")+"/"));
			   ServletFileUpload upload = new ServletFileUpload(factory);
			   upload.setSizeMax(100*1024*1024);
			   List items = new ArrayList();
			     items = upload.parseRequest(request);
			     title = ((FileItem) items.get(0)).getString();
			     title = Info.getUTFStr(title);
			     
			     note = ((FileItem) items.get(2)).getString();
			     note = Info.getUTFStr(note);
			     
			    FileItem fileItem = (FileItem) items.get(1);
			   if(fileItem.getName()!=null && fileItem.getSize()!=0)
			    {
			    if(fileItem.getName()!=null && fileItem.getSize()!=0){
			      File fullFile = new File(fileItem.getName());
			      img = Info.generalFileName(fullFile.getName());
			      File newFile = new File(request.getRealPath("/upfile/")+"/" + img);
			      try {
			       fileItem.write(newFile);
			      } catch (Exception e) {
			       e.printStackTrace();
			      }
			     }else{
			     }
			    }
			}
			String sql = "update news set title='"+title+"',note='"+note+"',img='"+img+"' where id="+id ;
			dao.commOper(sql);
			request.setAttribute("suc", "操作成功!");
			gor("/lyjdzxpwsys/admin/newslist.jsp?id="+id, request, response);
			} catch (Exception e1) {
				e1.printStackTrace();
				request.setAttribute("error", "");
			     request.getRequestDispatcher("/lyjdzxpwsys/admin/newsedit.jsp?id="+id).forward(request, response);
			    }
	}
		//新增公告
		if(ac.equals("noticesadd")){
			String title = request.getParameter("title");
			String note = request.getParameter("note");
			String savetime = Info.getDateStr();
			String type = "公告";
			dao.commOper("insert into news (title,note,savetime,type) " +
					" values ('"+title+"','"+note+"','"+savetime+"','"+type+"')");
			request.setAttribute("suc", "");
			go("admin/noticesadd.jsp", request, response);
		}
		//编辑公告
		if(ac.equals("noticesedit")){
			String id = request.getParameter("id");
			String title = request.getParameter("title");
			String note = request.getParameter("note");
			dao.commOper("update news set title='"+title+"',note='"+note+"' where id="+id);
			request.setAttribute("suc", "");
			go("admin/noticesedit.jsp?id="+id, request, response);
		}
		//新增链接
		if(ac.equals("yqlinkadd")){
			String linkname = request.getParameter("linkname");
			String linkurl = request.getParameter("linkurl");
			dao.commOper("insert into yqlink (linkname,linkurl) " +
					" values ('"+linkname+"','"+linkurl+"')");
			request.setAttribute("suc", "操作成功!");
			gor("/lyjdzxpwsys/admin/yqlink.jsp", request, response);
		}
		//编辑公告
		if(ac.equals("yqlinkedit")){
			String id = request.getParameter("id");
			String linkname = request.getParameter("linkname");
			String linkurl = request.getParameter("linkurl");
			dao.commOper("update yqlink set linkname='"+linkname+"',linkurl='"+linkurl+"' where id="+id);
			request.setAttribute("suc", "操作成功!");
			gor("/lyjdzxpwsys/admin/yqlink.jsp", request, response);
		}
	//网站信息编辑
		if(ac.equals("siteinfoedit")){
			String id = request.getParameter("id");
			HashMap map = dao.select("select * from siteinfo where id="+id).get(0);
			try {
				String tel="";
				String addr="";
				String note="";
				String logoimg = map.get("logoimg").toString();
			request.setCharacterEncoding("utf-8");
			RequestContext  requestContext = new ServletRequestContext(request);
			if(FileUpload.isMultipartContent(requestContext)){

			   DiskFileItemFactory factory = new DiskFileItemFactory();
			   factory.setRepository(new File(request.getRealPath("/upfile/")+"/"));
			   ServletFileUpload upload = new ServletFileUpload(factory);
			   upload.setSizeMax(100*1024*1024);
			   List items = new ArrayList();
			     items = upload.parseRequest(request);
			     tel = ((FileItem) items.get(0)).getString();
			     tel = Info.getUTFStr(tel);
			     addr = ((FileItem) items.get(1)).getString();
			     addr = Info.getUTFStr(addr);
			     note = ((FileItem) items.get(3)).getString();
			     note = Info.getUTFStr(note);
			     
			    FileItem fileItem = (FileItem) items.get(2);
			   if(fileItem.getName()!=null && fileItem.getSize()!=0)
			    {
			    if(fileItem.getName()!=null && fileItem.getSize()!=0){
			      File fullFile = new File(fileItem.getName());
			      logoimg = Info.generalFileName(fullFile.getName());
			      File newFile = new File(request.getRealPath("/upfile/")+"/" + logoimg);
			      try {
			       fileItem.write(newFile);
			      } catch (Exception e) {
			       e.printStackTrace();
			      }
			     }else{
			     }
			    }
			}
			String sql = "update siteinfo set tel='"+tel+"',addr='"+addr+"',note='"+note+"',logoimg='"+logoimg+"' where id="+id ;
			dao.commOper(sql);
			request.setAttribute("suc", "");
			go("/admin/siteinfo.jsp?id="+id, request, response);
			} catch (Exception e1) {
				e1.printStackTrace();
				request.setAttribute("error", "");
			     request.getRequestDispatcher("/admin/siteinfo.jsp?id="+id).forward(request, response);
			    }
	}
		//检查用户名唯一性AJAX
		if(ac.equals("sysuserscheck")){
			String username = request.getParameter("username");
			ArrayList cklist = (ArrayList)dao.select("select * from sysuser where username='"+username+"' and delstatus='0' ");
			if(cklist.size()>0){
				out.write("1");  
			}else{
				out.write("0");  
			}
		}
		//新增管理员
		if(ac.equals("sysuseradd")){
			String usertype = "管理员";
			String username = request.getParameter("username");
			String userpwd = request.getParameter("userpwd");
			String realname = request.getParameter("realname");
			String sex = request.getParameter("sex");
			String idcard = request.getParameter("idcard");
			String tel = request.getParameter("tel");
			String email = request.getParameter("email");
			String addr = request.getParameter("addr");
			String delstatus = "0";
			String savetime = Info.getDateStr();
			dao.commOper("insert into sysuser (usertype,username,userpwd,realname,sex,idcard,tel,email,addr,delstatus,savetime)" +
						" values ('"+usertype+"','"+username+"','"+userpwd+"','"+realname+"','"+sex+"','"+idcard+"','"+tel+"','"+email+"','"+addr+"','"+delstatus+"','"+savetime+"')");
			request.setAttribute("suc", "");
			go("/admin/sysuseradd.jsp", request, response);
		}
		//编辑管理员
		if(ac.equals("sysuseredit")){
			String id = request.getParameter("id");
			String userpwd = request.getParameter("userpwd");
			String realname = request.getParameter("realname");
			String sex = request.getParameter("sex");
			String idcard = request.getParameter("idcard");
			String tel = request.getParameter("tel");
			String email = request.getParameter("email");
			String addr = request.getParameter("addr");
			dao.commOper("update sysuser set userpwd='"+userpwd+"',realname='"+realname+"',sex='"+sex+"',idcard='"+idcard+"',tel='"+tel+"',email='"+email+"',addr='"+addr+"' where id="+id);
			request.setAttribute("suc", "");
			go("/admin/sysuseredit.jsp?id="+id, request, response);
		}
		//类别新增
		if(ac.equals("protypeadd")){
			String typename = request.getParameter("typename");
			String fatherid = request.getParameter("fatherid");
			dao.commOper("insert into protype (typename,fatherid,delstatus) values ('"+typename+"','"+fatherid+"','0') ");
			request.setAttribute("suc", "操作成功!");
			gor("/lyjdzxpwsys/admin/protype.jsp", request, response);
		}
		//类别编辑
		if(ac.equals("protypeedit")){
			String id = request.getParameter("id");
			String typename = request.getParameter("typename");
			dao.commOper("update protype set typename='"+typename+"' where id="+id);
			request.setAttribute("suc", "操作成功!");
			gor("/lyjdzxpwsys/admin/protype.jsp", request, response);
		}
		//景点属性新增
		if(ac.equals("propertyadd")){
			String propertyname = request.getParameter("propertyname");
			dao.commOper("insert into property (propertyname,delstatus) values ('"+propertyname+"','0') ");
			request.setAttribute("suc", "");
			go("/admin/propertyadd.jsp", request, response);
		}
		//景点属性编辑
		if(ac.equals("propertyedit")){
			String id = request.getParameter("id");
			String propertyname = request.getParameter("propertyname");
			dao.commOper("update property set propertyname='"+propertyname+"' where id="+id);
			request.setAttribute("suc", "");
			go("/admin/propertyedit.jsp?id="+id, request, response);
		}
		//AJAX根据父类查子类
		if(ac.equals("searchsontype")){
			String xml_start = "<selects>";
	        String xml_end = "</selects>";
	        String xml = "";
	        String fprotype = request.getParameter("fprotype");
	        ArrayList<HashMap> list = (ArrayList<HashMap>)dao.select("select * from protype where fatherid='"+fprotype+"' and delstatus='0' ");
			if(list.size()>0){
		        for(HashMap map:list){
					xml += "<select><value>"+map.get("id")+"</value><text>"+map.get("typename")+"</text><value>"+map.get("id")+"</value><text>"+map.get("typename")+"</text></select>";
				}
			}
			String last_xml = xml_start + xml + xml_end;
			response.setContentType("text/xml;charset=GB2312"); 
			response.setCharacterEncoding("utf-8");
			response.getWriter().write(last_xml);
			response.getWriter().flush();
			
		}
		//公用方法，图片上传
		if(ac.equals("uploadimg"))
		{
			try {
				String filename="";
			request.setCharacterEncoding("utf-8");
			RequestContext  requestContext = new ServletRequestContext(request);
			if(FileUpload.isMultipartContent(requestContext)){

			   DiskFileItemFactory factory = new DiskFileItemFactory();
			   factory.setRepository(new File(request.getRealPath("/upfile/")+"/"));
			   ServletFileUpload upload = new ServletFileUpload(factory);
			   upload.setSizeMax(100*1024*1024);
			   List items = new ArrayList();
			     items = upload.parseRequest(request);
			    FileItem fileItem = (FileItem) items.get(0);
			   if(fileItem.getName()!=null && fileItem.getSize()!=0)
			    {
			    if(fileItem.getName()!=null && fileItem.getSize()!=0){
			      File fullFile = new File(fileItem.getName());
			      filename = Info.generalFileName(fullFile.getName());
			      File newFile = new File(request.getRealPath("/upfile/")+"/" + filename);
			      try {
			       fileItem.write(newFile);
			      } catch (Exception e) {
			       e.printStackTrace();
			      }
			     }else{
			     }
			    }
			}
			
			go("/js/uploadimg.jsp?filename="+filename, request, response);
			} catch (Exception e1) {
				e1.printStackTrace();
			    }
		}
		
		
		//库存预警数值设置
		if(ac.equals("kcwarningset")){
			String num = request.getParameter("num");
			String id = request.getParameter("id");
			dao.commOper("update kcwarnning set num="+Integer.parseInt(num)+" where id="+id);
			request.setAttribute("suc", "");
			go("/admin/kcwarningset.jsp", request, response);
		}
		//景点入库
		if(ac.equals("kcinto")){
			String pid = request.getParameter("pid");
			String num = request.getParameter("num");
			String type = request.getParameter("type");
			String reason = request.getParameter("reason");
			String savetime = Info.getDateStr();
			dao.commOper("insert into kcrecord (pid,num,type,reason,savetime) values" +
					" ('"+pid+"','"+Integer.parseInt(num)+"','"+type+"','"+reason+"','"+savetime+"') ");
			request.setAttribute("suc", "");
			go("/admin/kcinto.jsp", request, response);
		}
		//景点出库
		if(ac.equals("kcout")){
			String pid = request.getParameter("pid");
			String num = request.getParameter("num");
			String type = request.getParameter("type");
			String reason = request.getParameter("reason");
			String savetime = Info.getDateStr();
			
			int znum = 0;
	    	int innum = 0;
	    	int outnum = 0;
	    	ArrayList<HashMap> inlist = (ArrayList<HashMap>)dao.select("select * from kcrecord where  type='in' and pid='"+pid+"' ");
	    	ArrayList<HashMap> outlist = (ArrayList<HashMap>)dao.select("select * from kcrecord where  type='out' and pid='"+pid+"' ");
	    	if(inlist.size()>0){
	    		for(HashMap inmap:inlist){
	    			innum += Integer.parseInt(inmap.get("num").toString());//总入库量
	    		}
	    	}
	    	if(outlist.size()>0){
	    		for(HashMap outmap:outlist){
	    			outnum += Integer.parseInt(outmap.get("num").toString());//总出库量
	    		}
	    	}
	    	znum = innum - outnum;//库存量
	    	if(Integer.parseInt(num)>znum){
	    		request.setAttribute("no", "");
				go("/admin/kcout.jsp", request, response);
	    	}else{
				dao.commOper("insert into kcrecord (pid,num,type,reason,savetime) values" +
						" ('"+pid+"','"+Integer.parseInt(num)+"','"+type+"','"+reason+"','"+savetime+"') ");
				request.setAttribute("suc", "");
				go("/admin/kcout.jsp", request, response);
	    	}
		}
		
		//新增图片
		if(ac.equals("imgadvaddold")){
			try {
				String img = "";
				String imgtype="";
			request.setCharacterEncoding("utf-8");
			RequestContext  requestContext = new ServletRequestContext(request);
			if(FileUpload.isMultipartContent(requestContext)){
			   DiskFileItemFactory factory = new DiskFileItemFactory();
			   factory.setRepository(new File(request.getRealPath("/upfile/")+"/"));
			   ServletFileUpload upload = new ServletFileUpload(factory);
			   upload.setSizeMax(100*1024*1024);
			   List items = new ArrayList();
			     items = upload.parseRequest(request);
			     
			     imgtype = ((FileItem) items.get(1)).getString();
			     imgtype = Info.getUTFStr(imgtype);

			    FileItem fileItem = (FileItem) items.get(0);
			   if(fileItem.getName()!=null && fileItem.getSize()!=0)
			    {
			    if(fileItem.getName()!=null && fileItem.getSize()!=0){
			      File fullFile = new File(fileItem.getName());
			      img = Info.generalFileName(fullFile.getName());
			      File newFile = new File(request.getRealPath("/upfile/")+"/" + img);
			      try {
			       fileItem.write(newFile);
			      } catch (Exception e) {
			       e.printStackTrace();
			      }
			     }else{
			     }
			    }
			}
			
			String cksql = "select * from imgadv where imgtype='banner'";
			ArrayList cklist = (ArrayList)dao.select(cksql);
			if(imgtype.equals("banner")&&cklist.size()!=0){
				request.setAttribute("no", "");
				go("/admin/imgadvadd.jsp", request, response);
			}else{
				String sql = "insert into imgadv (filename,imgtype) " +
				"values('"+img+"','"+imgtype+"')" ;
				dao.commOper(sql);
				request.setAttribute("suc", "");
				go("/admin/imgadvadd.jsp", request, response);
			}
			} catch (Exception e1) {
				e1.printStackTrace();
				request.setAttribute("no", "");
			     request.getRequestDispatcher("/admin/imgadvadd.jsp").forward(request, response);
			    }
		}
		//编辑图片
		if(ac.equals("imgadvedit")){
			String id = request.getParameter("id");
			HashMap map = dao.select("select * from imgadv where id="+id).get(0);
			try {
				String img = map.get("filename").toString();
			request.setCharacterEncoding("utf-8");
			RequestContext  requestContext = new ServletRequestContext(request);
			if(FileUpload.isMultipartContent(requestContext)){

			   DiskFileItemFactory factory = new DiskFileItemFactory();
			   factory.setRepository(new File(request.getRealPath("/upfile/")+"/"));
			   ServletFileUpload upload = new ServletFileUpload(factory);
			   upload.setSizeMax(100*1024*1024);
			   List items = new ArrayList();
			     items = upload.parseRequest(request);
			     
			    FileItem fileItem = (FileItem) items.get(0);
			   if(fileItem.getName()!=null && fileItem.getSize()!=0)
			    {
			    if(fileItem.getName()!=null && fileItem.getSize()!=0){
			      File fullFile = new File(fileItem.getName());
			      img = Info.generalFileName(fullFile.getName());
			      File newFile = new File(request.getRealPath("/upfile/")+"/" + img);
			      try {
			       fileItem.write(newFile);
			      } catch (Exception e) {
			       e.printStackTrace();
			      }
			     }else{
			     }
			    }
			}
					String sql = "update imgadv set filename='"+img+"' where id="+id ;
					dao.commOper(sql);
					request.setAttribute("suc", "");
					go("/admin/imgadvedit.jsp?id="+id, request, response);
			} catch (Exception e1) {
				e1.printStackTrace();
				request.setAttribute("error", "");
			     request.getRequestDispatcher("/admin/imgadvedit.jsp?id="+id).forward(request, response);
			    }
	}
		
		//检查用户名唯一性AJAX 会员注册
		if(ac.equals("memberunamecheck")){
			String uname = request.getParameter("username");
			ArrayList cklist = (ArrayList)dao.select("select * from member where uname='"+uname+"' and delstatus='0' ");
			if(cklist.size()>0){
				out.print("false");
				
			}else{
				out.print("true");
			}
		}
		
		//检查景点的库存
		if(ac.equals("checkgoodkc")){
			String gid = request.getParameter("gid");
			String sl = request.getParameter("sl");
			if(Integer.valueOf(sl)>Info.getkc(gid)){
				out.write("1");  
			}else{
				out.write("0");  
			}
		}
		//景点加入购物车
		if(ac.equals("tocar")){
			String gid = request.getParameter("gid");
			int sl = Integer.valueOf(request.getParameter("sl"));
			if(member!=null){
				String mid = member.get("id").toString();
				//检查该人的购物车是否有该物品
				ArrayList<HashMap>  cklist = (ArrayList<HashMap>)dao.select("select * from car where mid='"+mid+"' and gid='"+gid+"'");
				if(cklist.size()>0){
					dao.commOper("update car set sl=sl+"+sl+" where mid='"+mid+"' and gid='"+gid+"' ");
				}else{
					dao.commOper("insert into car (gid,sl,mid) values ('"+gid+"','"+sl+"','"+mid+"')");
				}
				out.print("true");
			}else{
				out.print("false");
			}
//			request.setAttribute("suc", "");
//			go("/tocar.jsp?gid="+gid, request, response);
		}
		//从购物车移出景点
		if(ac.equals("removecart")){
			String cartid = request.getParameter("cartid");
			dao.commOper("delete from car where id="+cartid);
			out.print("true");
		}
		
		
		//直接购买
		if(ac.equals("tobuy")){
			String gid = request.getParameter("gid");
			int sl = Integer.valueOf(request.getParameter("sl"));
			String ddno = Info.getAutoNo();
			String shrname = "";
			String shrtel = "";
			String shraddr = request.getParameter("addr");
			double ddprice = 0.0;
			String fhstatus = "待发货";
			String shstatus = "待收货";
			String fkstatus = "待付款";
			String wlinfo = "暂无物流信息";
			String savetime = Info.getDateStr();
			
			if(member!=null){
				String memberid = member.get("id").toString();
				ArrayList<HashMap> addrlist = (ArrayList<HashMap>)dao.select("select * from addr where delstatus='0' and isdefault='yes' and memberid="+member.get("id"));
				if(addrlist.size()==0){
					out.print("false");
				}else{
					shraddr = addrlist.get(0).get("id").toString();
					HashMap gmap = dao.select("select * from goods where id="+gid).get(0);
					String price = gmap.get("price").toString();
					if(gmap.get("tprice")!=null&&!gmap.get("tprice").equals("")){
						price = gmap.get("tprice").toString();
					}
					ddprice = Double.valueOf(price)*sl;
					//直接生成订单
					dao.commOper("insert into ddinfo (ddno,memberid,ddprice,fhstatus,savetime,shstatus,wlinfo,fkstatus,shrname,shrtel,shraddr) values " +
							"('"+ddno+"','"+memberid+"','"+ddprice+"','"+fhstatus+"','"+savetime+"','"+shstatus+"','"+wlinfo+"','"+fkstatus+"','"+shrname+"','"+shrtel+"','"+shraddr+"')");
					dao.commOper("insert into dddetail (ddno,goodid,sl) values ('"+ddno+"','"+gid+"','"+sl+"') ");
					
					out.print("true");
				}
			}else{
				out.print("false");
			}
//			request.setAttribute("suc", "");
//			go("/tocar.jsp?gid="+gid, request, response);
		}
		
		//购物车内景点数量修改
		if(ac.equals("updatecart")){
			String id = request.getParameter("carid");
			int sl = Integer.valueOf(request.getParameter("sl"));
			dao.commOper("update car set sl="+sl+" where id="+id);
			out.print("true");
		}
		
		//购物车内景点总价
		if(ac.equals("updatetprice")){
			ArrayList<HashMap> goodlist = (ArrayList<HashMap>)dao.select("select *,a.id as aid,b.id as bid from car a,goods b where a.gid=b.id and a.mid='"+member.get("id")+"' and b.delstatus='0' order by a.id desc");
			double totalprice = 0.0;
			for(HashMap carmap:goodlist){  
				if(carmap.get("tprice")!=null&&!carmap.get("tprice").equals("")){ 
					totalprice += Double.valueOf(carmap.get("tprice").toString())*Integer.valueOf(carmap.get("sl").toString());
				}else{
					totalprice += Double.valueOf(carmap.get("price").toString())*Integer.valueOf(carmap.get("sl").toString());
				}
			}
			out.print(totalprice);
		}
		
		//提交生成订单 填写收货信息
		if(ac.equals("submitorder")){
			String memberid= member.get("id").toString();
			//生成订单号
			String ddno = Info.getAutoNo();
			String shrname = "";
			String shrtel = "";
			String shraddr = request.getParameter("addr");
			double ddprice = 0.0;
			String fhstatus = "待发货";
			String shstatus = "待收货";
			String fkstatus = "待付款";
			String wlinfo = "暂无物流信息";
			String savetime = Info.getDateStr();
			//查询该会员的购物车所有景点
			ArrayList<HashMap> carlist = (ArrayList<HashMap>)dao.select("select * from car where mid="+memberid);
			for(HashMap carmap:carlist){
				HashMap goodmap = dao.select("select * from goods where id="+carmap.get("gid")).get(0);
				if(goodmap.get("tprice")!=null&&!goodmap.get("tprice").equals("")){ 
					ddprice += Double.valueOf(goodmap.get("tprice").toString())*Integer.valueOf(carmap.get("sl").toString());
				}else{
					ddprice += Double.valueOf(goodmap.get("price").toString())*Integer.valueOf(carmap.get("sl").toString());
				}
				
				
				dao.commOper("insert into dddetail (ddno,goodid,sl) values ('"+ddno+"','"+carmap.get("gid")+"','"+carmap.get("sl")+"') ");
			}
			dao.commOper("insert into ddinfo (ddno,memberid,ddprice,fhstatus,savetime,shstatus,wlinfo,fkstatus,shrname,shrtel,shraddr) values " +
			"('"+ddno+"','"+memberid+"','"+ddprice+"','"+fhstatus+"','"+savetime+"','"+shstatus+"','"+wlinfo+"','"+fkstatus+"','"+shrname+"','"+shrtel+"','"+shraddr+"')");
			//删除购物车下的景点
			dao.commOper("delete from car where mid="+memberid);
			request.setAttribute("suc", "订单生成成功!");
			go("/mydd.jsp", request, response);
		}
		
		//
		if(ac.equals("pay")){
			String ddid = request.getParameter("ddid");
			String fkstatus = "已付款";
			String fhstatus = "待发货";
			String shstatus = "待收货";
			dao.commOper("update ddinfo set fkstatus='"+fkstatus+"',fhstatus='"+fhstatus+"',shstatus='"+shstatus+"' where id='"+ddid+"'");
			request.setAttribute("suc", "支付成功!");
			go("/mydd.jsp?ddid="+ddid, request, response);
		}
		//订单发货
		if(ac.equals("ddfh")){
			String ddid = request.getParameter("ddid");
			String yxq = request.getParameter("yxq");
			//查询订单及订单详情表
			HashMap ddmap = dao.select("select * from ddinfo where id="+ddid).get(0);
			ArrayList<HashMap> dddetaillist = (ArrayList<HashMap>)dao.select("select * from dddetail where ddno="+ddmap.get("ddno"));
			boolean flag = true;//用作订单景点票务库存校验结果
			for(HashMap dddetailmap:dddetaillist){
				//如果其中某个景点的数量大于其库存量 则置 FLASE标识
				if(Integer.valueOf(dddetailmap.get("sl").toString())>Info.getkc(dddetailmap.get("goodid").toString())){
					flag = false;
				}
			}
			if(flag){
				dao.commOper("update ddinfo set fhstatus='已发货' where id="+ddid);
				//发货后减库存 
				int i = 0;
				for(HashMap dddetailmap:dddetaillist){
					i++;
					String ticketno = Info.getAutoNo()+String.valueOf(i);
					dao.commOper("update dddetail set ticketno='"+ticketno+"' , yxq='"+yxq+"' where id="+dddetailmap.get("id"));
					dao.commOper("insert into kcrecord (gid,happennum,type,savetime) values " +
							"('"+dddetailmap.get("goodid")+"','"+dddetailmap.get("sl")+"','out','"+Info.getDateStr()+"')");
				}
				
				request.setAttribute("info", "订单已发货!");
				//gor("/lyjdzxpwsys/admin/ddgl.jsp", request, response);
				out.print("true");
			}else{
				request.setAttribute("info", "订单中景点票务库存不足，发货失败!");
				//gor("/lyjdzxpwsys/admin/ddgl.jsp", request, response);
				out.print("false");
			}
		}
		
		//会员注册
		if(ac.equals("register")){
				String uname = request.getParameter("username");
				String upass = request.getParameter("upass");
				String email = request.getParameter("email")==null?"":request.getParameter("email");
				String tname = request.getParameter("tname")==null?"":request.getParameter("tname");
				String sex = request.getParameter("sex")==null?"":request.getParameter("sex");
				String addr = request.getParameter("addr")==null?"":request.getParameter("addr");
				String ybcode = request.getParameter("ybcode")==null?"":request.getParameter("ybcode");
				String qq = request.getParameter("qq")==null?"":request.getParameter("qq");
				String tel = request.getParameter("tel")==null?"":request.getParameter("tel");
				String birthday = request.getParameter("birthday")==null?"":request.getParameter("birthday");
				
				String delstatus = "0";
				String savetime = Info.getDateStr();
				dao.commOper("insert into member (birthday,uname,upass,email,tname,sex,addr,ybcode,qq,tel,delstatus,savetime)" +
							" values ('"+birthday+"','"+uname+"','"+upass+"','"+email+"','"+tname+"','"+sex+"','"+addr+"','"+ybcode+"','"+qq+"','"+tel+"','"+delstatus+"','"+savetime+"')");
				request.setAttribute("info", "注册成功");
				go("/reg.jsp", request, response);
		}
		
		//会员修改个人信息
		if(ac.equals("memberinfo")){
				String id = request.getParameter("id");
				String upass = request.getParameter("upass");
				String email = request.getParameter("email")==null?"":request.getParameter("email");
				String tname = request.getParameter("tname")==null?"":request.getParameter("tname");
				String sex = request.getParameter("sex")==null?"":request.getParameter("sex");
				String addr = request.getParameter("addr")==null?"":request.getParameter("addr");
				String ybcode = request.getParameter("ybcode")==null?"":request.getParameter("ybcode");
				String qq = request.getParameter("qq")==null?"":request.getParameter("qq");
				String tel = request.getParameter("tel")==null?"":request.getParameter("tel");
				String birthday = request.getParameter("birthday")==null?"":request.getParameter("birthday");
				dao.commOper("update member set birthday='"+birthday+"',upass='"+upass+"',email='"+email+"',tname='"+tname+"',sex='"+sex+"',addr='"+addr+"',ybcode='"+ybcode+"',qq='"+qq+"',tel='"+tel+"' where id="+id);
				request.setAttribute("info", "会员信息修改成功!");
				go("/grinfo.jsp", request, response);
		}
		
		//会员登录
		if(ac.equals("frontlogin")){
			String uname = request.getParameter("uname");
			String upass = request.getParameter("upass");
			ArrayList cklist = (ArrayList)dao.select("select * from member where uname='"+uname+"' and upass='"+upass+"' and delstatus='0'");
			if(cklist.size()>0){
				session.setAttribute("member", cklist.get(0));
				go("/index.jsp", request, response);
			}else{
				request.setAttribute("info", "用户名或密码错误!");
				go("/login.jsp", request, response);
			}
			
		}
		
		//前台退出
		if(ac.equals("frontexit")){
			Cookie cookie = new Cookie("key", null);
			cookie.setMaxAge(0);
			session.removeAttribute("member");
			go("/index.jsp", request, response);
		}
		
		
	
		
		//发布景点
		if(ac.equals("goodsadd")){
			try {
				String goodno = Info.getAutoNo();
				String goodname = "";
				String fid = "";
				String sid="";
				String goodpp="";
				String price="";
				String filename="";
				String remark="";
				String note="";
				String shstatus = "通过";
				String istj = "no";
				String savetime = Info.getDateStr();
				String tprice="";
			request.setCharacterEncoding("utf-8");
			RequestContext  requestContext = new ServletRequestContext(request);
			if(FileUpload.isMultipartContent(requestContext)){
			   DiskFileItemFactory factory = new DiskFileItemFactory();
			   factory.setRepository(new File(request.getRealPath("/upfile/")+"/"));
			   ServletFileUpload upload = new ServletFileUpload(factory);
			   upload.setSizeMax(100*1024*1024);
			   List items = new ArrayList();
			     items = upload.parseRequest(request);
			     goodname = ((FileItem) items.get(0)).getString();
			     goodname = Info.getUTFStr(goodname);
			     fid = ((FileItem) items.get(1)).getString();
			     fid = Info.getUTFStr(fid);
			     sid = ((FileItem) items.get(2)).getString();
			     sid = Info.getUTFStr(sid);
			     goodpp = ((FileItem) items.get(3)).getString();
			     goodpp = Info.getUTFStr(goodpp);
			     price = ((FileItem) items.get(4)).getString();
			     price = Info.getUTFStr(price);
			     remark = ((FileItem) items.get(6)).getString();
			     remark = Info.getUTFStr(remark);
			     note = ((FileItem) items.get(7)).getString();
			     note = Info.getUTFStr(note);
					FileItem fileItem = (FileItem) items.get(5);
					if (fileItem.getName() != null && fileItem.getSize() != 0) {
						if (fileItem.getName() != null
								&& fileItem.getSize() != 0) {
							File fullFile = new File(fileItem.getName());
							filename = Info.generalFileName(fullFile.getName());
							File newFile = new File(request
									.getRealPath("/upfile/")
									+ "/" + filename);
							try {
								fileItem.write(newFile);
							} catch (Exception e) {
								e.printStackTrace();
							}
						} else {
						}
					}
				}
			dao.commOper("insert into goods (goodno,goodname,fid,sid,price,remark,note,savetime,shstatus,filename,istj,tprice,delstatus,salestatus,goodpp) " +
					"values ('"+goodno+"','"+goodname+"','"+fid+"','"+sid+"','"+price+"','"+remark+"','"+note+"','"+savetime+"','通过','"+filename+"','"+istj+"','"+tprice+"','0','在售','"+goodpp+"') ");
			request.setAttribute("suc", "操作成功!");
			gor("/lyjdzxpwsys/admin/goodsgl.jsp", request, response);
			
			} catch (Exception e1) {
				e1.printStackTrace();
				request.setAttribute("error", "");
			     request.getRequestDispatcher("/admin/goodsgl.jsp").forward(request, response);
			    }
			
			
		}
		//修改景点
		if(ac.equals("goodsedit")){
			String id = request.getParameter("id");
			HashMap map = dao.select("select * from goods where id="+id).get(0);
			try {
				String goodname = "";
				String fid = "";
				String sid="";
				String goodpp="";
				String price="";
				String remark="";
				String note="";
				String filename=map.get("filename").toString();
			request.setCharacterEncoding("utf-8");
			RequestContext  requestContext = new ServletRequestContext(request);
			if(FileUpload.isMultipartContent(requestContext)){

			   DiskFileItemFactory factory = new DiskFileItemFactory();
			   factory.setRepository(new File(request.getRealPath("/upfile/")+"/"));
			   ServletFileUpload upload = new ServletFileUpload(factory);
			   upload.setSizeMax(100*1024*1024);
			   List items = new ArrayList();
			     items = upload.parseRequest(request);
			     goodname = ((FileItem) items.get(0)).getString();
			     goodname = Info.getUTFStr(goodname);
			     fid = ((FileItem) items.get(1)).getString();
			     fid = Info.getUTFStr(fid);
			     sid = ((FileItem) items.get(2)).getString();
			     sid = Info.getUTFStr(sid);
			     goodpp = ((FileItem) items.get(3)).getString();
			     goodpp = Info.getUTFStr(goodpp);
			     price = ((FileItem) items.get(4)).getString();
			     price = Info.getUTFStr(price);
			     remark = ((FileItem) items.get(6)).getString();
			     remark = Info.getUTFStr(remark);
			     note = ((FileItem) items.get(7)).getString();
			     note = Info.getUTFStr(note);
			    FileItem fileItem = (FileItem) items.get(5);
			   if(fileItem.getName()!=null && fileItem.getSize()!=0)
			    {
			    if(fileItem.getName()!=null && fileItem.getSize()!=0){
			      File fullFile = new File(fileItem.getName());
			      filename = Info.generalFileName(fullFile.getName());
			      File newFile = new File(request.getRealPath("/upfile/")+"/" + filename);
			      try {
			       fileItem.write(newFile);
			      } catch (Exception e) {
			       e.printStackTrace();
			      }
			     }else{
			     }
			    }
			}
			dao.commOper("update goods set goodname='"+goodname+"',fid='"+fid+"',sid='"+sid+"',price='"+price+"',remark='"+remark+"',note='"+note+"',filename='"+filename+"',goodpp='"+goodpp+"' where id="+id);
			request.setAttribute("suc", "操作成功!");
			gor("/lyjdzxpwsys/admin/goodsgl.jsp?id="+id, request, response);
			} catch (Exception e1) {
				e1.printStackTrace();
				request.setAttribute("error", "");
			     request.getRequestDispatcher("/admin/goodsgl.jsp").forward(request, response);
			    }

		}
		//景点入库
		if(ac.equals("goodskcadd")){
			String gid = request.getParameter("gid");
			String happennum = request.getParameter("happennum");
			String type = "in";
			String savetime = Info.getDateStr();
			dao.commOper("insert into kcrecord (gid,happennum,type,savetime) values " +
					"('"+gid+"','"+happennum+"','"+type+"','"+savetime+"') ");
			request.setAttribute("suc", "操作成功!");
			gor("/lyjdzxpwsys/admin/goodskc.jsp", request, response);
		}
		
		//评价
		if(ac.equals("goodpj")){
			String goodid = request.getParameter("id");
			String memberid = member.get("id").toString();
			String note = request.getParameter("note");
			String savetime = Info.getDateStr();
			dao.commOper("insert into goodspj (goodid,memberid,note,savetime) values ('"+goodid+"','"+memberid+"','"+note+"','"+savetime+"')");
			request.setAttribute("suc", "");
			go("/goodsx.jsp?id="+goodid, request, response);
		}
		
		
		
		
		
		
		//景点购买成功后的评价
		if(ac.equals("pj")){
			String goodid = request.getParameter("goodid");
			String ddid = request.getParameter("ddid");
			String memberid = member.get("id").toString();
			String jb = request.getParameter("jb");
			String msg = request.getParameter("msg");
			String savetime = Info.getDateStr();
			HashMap mm = dao.select("select * from goods where id="+goodid).get(0);
			dao.commOper("insert into pj (goodid,goodsaver,memberid,jb,msg,savetime,hf,ddid) values " +
					"('"+goodid+"','"+mm.get("saver")+"','"+memberid+"','"+jb+"','"+msg+"','"+savetime+"','','"+ddid+"') ");
			request.setAttribute("suc", "评价成功!");
			go("/mydd.jsp", request, response);
		}
		//管理员回复评价
		if(ac.equals("pjhf")){
			String id = request.getParameter("id");
			String gid = request.getParameter("gid");
			String hf = request.getParameter("hf");
			dao.commOper("update pj set hf='"+hf+"' where id="+id);
			request.setAttribute("suc", "评价回复成功!");
			gor("/lyjdzxpwsys/admin/goodpj.jsp?gid="+gid, request, response);
		}
		
		
		//滚动图片
		if(ac.equals("imgadvadd")){
			try {
				String filename="";
			request.setCharacterEncoding("utf-8");
			RequestContext  requestContext = new ServletRequestContext(request);
			if(FileUpload.isMultipartContent(requestContext)){
			   DiskFileItemFactory factory = new DiskFileItemFactory();
			   factory.setRepository(new File(request.getRealPath("/upfile/")+"/"));
			   ServletFileUpload upload = new ServletFileUpload(factory);
			   upload.setSizeMax(100*1024*1024);
			   List items = new ArrayList();
			     items = upload.parseRequest(request);
					FileItem fileItem = (FileItem) items.get(0);
					if (fileItem.getName() != null && fileItem.getSize() != 0) {
						if (fileItem.getName() != null
								&& fileItem.getSize() != 0) {
							File fullFile = new File(fileItem.getName());
							filename = Info.generalFileName(fullFile.getName());
							File newFile = new File(request
									.getRealPath("/upfile/")
									+ "/" + filename);
							try {
								fileItem.write(newFile);
							} catch (Exception e) {
								e.printStackTrace();
							}
						} else {
						}
					}
				}
			dao.commOper("insert into imgadv (filename) " +
					"values ('"+filename+"') ");
			request.setAttribute("suc", "操作成功!");
			gor("/lyjdzxpwsys/admin/imgadv.jsp", request, response);
			
			} catch (Exception e1) {
				e1.printStackTrace();
				request.setAttribute("error", "");
			     request.getRequestDispatcher("/lyjdzxpwsys/admin/imgadv.jsp").forward(request, response);
			    }
		}
		
		//类型新增
		if(ac.equals("ppinfoadd")){
			String ppname = request.getParameter("ppname");
			String delstatus = "0";
			dao.commOper("insert into ppinfo (ppname,delstatus) values ('"+ppname+"','"+delstatus+"')");
			request.setAttribute("suc", "操作成功!");
			gor("/lyjdzxpwsys/admin/ppinfo.jsp", request, response);
		}
		//类型编辑
		if(ac.equals("ppinfoedit")){
			String id = request.getParameter("id");
			String ppname = request.getParameter("ppname");
			dao.commOper("update ppinfo set  ppname='"+ppname+"' where id="+id);
			request.setAttribute("suc", "操作成功!");
			gor("/lyjdzxpwsys/admin/ppinfo.jsp", request, response);
		}
		//会员收藏景点
		if(ac.equals("addfav")){
			String goodid = request.getParameter("goodid");
			if(member==null){
				out.print("unlogin");
			}else{
				ArrayList cklist = (ArrayList)dao.select("select * from fav where memberid='"+member.get("id")+"' and goodid='"+goodid+"'");
				if(cklist.size()==0){
					dao.commOper("insert into fav (goodid,memberid) values ('"+goodid+"','"+member.get("id")+"')");
					out.print("true");
				}else{
					out.print("false");
				}
			}
		}
		//取消收藏 
		if(ac.equals("delfav")){
			String favid = request.getParameter("favid");
			dao.commOper("delete from fav where id='"+favid+"'");
			out.print("true");
		}
		//新增收货地址
		if(ac.equals("addradd")){
			String memberid = member.get("id").toString();
			String shr = request.getParameter("shr");
			String shrtel = request.getParameter("shrtel");
			String shraddr = request.getParameter("shraddr");
			String isdefault = "no";
			String delstatus = "0";
			dao.commOper("insert into addr (memberid,shr,shrtel,shraddr,delstatus,isdefault) values " +
					"('"+memberid+"','"+shr+"','"+shrtel+"','"+shraddr+"','"+delstatus+"','"+isdefault+"') ");
			request.setAttribute("suc", "操作成功!");
			go("/addr.jsp", request, response);
		}
		
		if(ac.equals("addrdel")){
			String id = request.getParameter("id");
			dao.commOper("update addr set delstatus=1 where id="+id);
			out.print("true");

		}
		//设置为默认收货地址
		if(ac.equals("setdefault")){
			String id = request.getParameter("id");
			String memberid = request.getParameter("memberid");
			dao.commOper("update addr set isdefault='no' where memberid="+memberid);
			dao.commOper("update addr set isdefault='yes' where id="+id);
			request.setAttribute("suc", "操作成功!");
			go("/addr.jsp", request, response);
			
		}
		
		//检查用户名唯一性AJAX 系统用户
		if(ac.equals("usernamecheck")){
			String username = request.getParameter("username");
			ArrayList cklist = (ArrayList)dao.select("select * from sysuser where username='"+username+"' and delstatus='0' ");
			if(cklist.size()>0){
				out.print("false");
			}else{
				out.print("true");
			}
		}
		
		
		if(ac.equals("useradd")){
			String username = request.getParameter("username");
			String userpwd = request.getParameter("userpwd");
			String email = request.getParameter("email")==null?"":request.getParameter("email");
			String realname = request.getParameter("realname")==null?"":request.getParameter("realname");
			String sex = request.getParameter("sex")==null?"":request.getParameter("sex");
			String addr = request.getParameter("addr")==null?"":request.getParameter("addr");
			String idcard = request.getParameter("idcard")==null?"":request.getParameter("idcard");
			String tel = request.getParameter("tel")==null?"":request.getParameter("tel");
			String delstatus = "0";
			String savetime = Info.getDateStr();
			dao.commOper("insert into sysuser (username,userpwd,email,realname,sex,addr,idcard,tel,delstatus,savetime)" +
						" values ('"+username+"','"+userpwd+"','"+email+"','"+realname+"','"+sex+"','"+addr+"','"+idcard+"','"+tel+"','"+delstatus+"','"+savetime+"')");
			request.setAttribute("suc", "操作成功!");
			gor("/lyjdzxpwsys/admin/userlist.jsp", request, response);
	}
		
		if(ac.equals("useredit")){
			String id = request.getParameter("id");
			String userpwd = request.getParameter("userpwd");
			String email = request.getParameter("email")==null?"":request.getParameter("email");
			String realname = request.getParameter("realname")==null?"":request.getParameter("realname");
			String sex = request.getParameter("sex")==null?"":request.getParameter("sex");
			String addr = request.getParameter("addr")==null?"":request.getParameter("addr");
			String idcard = request.getParameter("idcard")==null?"":request.getParameter("idcard");
			String tel = request.getParameter("tel")==null?"":request.getParameter("tel");
			String delstatus = "0";
			String savetime = Info.getDateStr();
			dao.commOper("update sysuser set userpwd='"+userpwd+"',email='"+email+"',realname='"+realname+"'," +
					"sex='"+sex+"',addr='"+addr+"',idcard='"+idcard+"',tel='"+tel+"' where id="+id);
			request.setAttribute("suc", "操作成功!");
			gor("/lyjdzxpwsys/admin/userlist.jsp", request, response);
	}
		
		if(ac.equals("pwdedit")){
			String oldpwd = request.getParameter("oldpwd");
			String newpwd = request.getParameter("newpwd");
			HashMap oldmap = dao.select("select * from sysuser where id="+admin.get("id")).get(0);
			if(oldpwd.equals(oldmap.get("userpwd"))){
				dao.commOper("update sysuser set userpwd = '"+newpwd+"' where id="+admin.get("id"));
				out.print("true");
			}else{
				out.print("false");
			}
		}
		
		if(ac.equals("aboutedit")){
			String lxr = request.getParameter("lxr");
			String tel = request.getParameter("tel");
			String addr = request.getParameter("addr");
			String note = request.getParameter("note");
			dao.commOper("update about set lxr='"+lxr+"',tel='"+tel+"',addr='"+addr+"',note='"+note+"' where id=1");
			request.setAttribute("suc", "操作成功!");
			gor("/lyjdzxpwsys/admin/aboutedit.jsp", request, response);
		}
		
		if(ac.equals("msgadd")){
			String msg = request.getParameter("msg");
			String hfmsg = "";
			String savetime = Info.getDateStr();
			String memberid = member.get("id").toString();
			dao.commOper("insert into chat (msg,hfmsg,savetime,memberid) values " +
					"('"+msg+"','"+hfmsg+"','"+savetime+"','"+memberid+"')");
			request.setAttribute("suc", "留言成功!");
			go("/msg.jsp", request, response);
		}
		
		if(ac.equals("msghf")){
			String id = request.getParameter("id");
			String hfmsg = request.getParameter("hfmsg");
			dao.commOper("update chat set  hfmsg='"+hfmsg+"' where id="+id);
			request.setAttribute("suc", "回复成功!");
			gor("/lyjdzxpwsys/admin/msglist.jsp", request, response);
		}
		if(ac.equals("validatortprice")){
			String gid = request.getParameter("gid");
			String tprice = request.getParameter("tprice")==null?"":request.getParameter("tprice");
			if(!tprice.equals("")){
				HashMap map = dao.select("select * from goods where id="+gid).get(0);
				if(Double.valueOf(tprice)<Double.valueOf(map.get("price").toString())){
					out.print("true");
				}else{
					out.print("false");
				}
			}else{
				out.print("true");
			}
		}
		if(ac.equals("goodstjset")){
			String id = request.getParameter("id");
			String tprice = request.getParameter("tprice")==null?"":request.getParameter("tprice");
			if(!tprice.equals("")){
				HashMap map = dao.select("select * from goods where id="+id).get(0);
				if(Double.valueOf(tprice)>=Double.valueOf(map.get("price").toString())){
					request.setAttribute("info", "特价必须低于原价!");
					go("/lyjdzxpwsys/admin/goodstjset.jsp?id="+id, request, response);
				}else{
					dao.commOper("update goods set tprice='"+tprice+"' where id="+id);
					request.setAttribute("suc", "特价设置成功!");
					gor("/lyjdzxpwsys/admin/goodsgl.jsp", request, response);
				}
			}else{
				dao.commOper("update goods set tprice='' where id="+id);
				request.setAttribute("info", "特价已取消!");
				gor("/lyjdzxpwsys/admin/goodsgl.jsp", request, response);
			}
		}
		if(ac.equals("removedd")){
			String id  = request.getParameter("id");
			HashMap mm = dao.select("select * from ddinfo where id="+id).get(0);
       		dao.commOper("delete from ddinfo where id="+id);
       		dao.commOper("delete from dddetail where ddno="+mm.get("ddno"));
       		out.print("true");
		}
		
		if(ac.equals("confirmorder")){
			String id = request.getParameter("id");
			dao.commOper("update ddinfo set shstatus='已收货' where id="+id);
			out.print("true");
		}
		
		if(ac.equals("tj1")){
			System.out.println("aa");
			ArrayList<HashMap> list = (ArrayList<HashMap>)dao.select("SELECT a.goodname ,(select sum(sl) from dddetail b where a.id=b.goodid ) as sl FROM goods a where delstatus=0 order by sl");
			String xdata = "[";
			String ydata = "[";
			for(int i=0;i<list.size();i++){
				//['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
				xdata += "'"+list.get(i).get("goodname")+"'";
				ydata += list.get(i).get("sl");
				if(i<list.size()-1){
					xdata+=",";
					ydata+=",";
				}
			}
			xdata += "]";
			ydata += "]";
			String rtn = xdata+"$"+ydata;
			Gson gson = new Gson();
			rtn = gson.toJson(rtn);
			System.out.println(rtn);
			out.write(rtn);
		}
		
		
		
		if(ac.equals("tj2")){
			ArrayList<HashMap> list = (ArrayList<HashMap>)dao.select("SELECT a.goodname ,(select count(*) from fav b where a.id=b.goodid ) as sl FROM goods a where delstatus=0");
			String xdata = "[";
			String ydata = "[";
			for(int i=0;i<list.size();i++){
				xdata += "'"+list.get(i).get("goodname")+"'";
				ydata += "{value:"+list.get(i).get("sl")+",name:'"+list.get(i).get("goodname")+"'}";
				if(i<list.size()-1){
					xdata+=",";
					ydata+=",";
				}
			}
			xdata += "]";
			ydata += "]";
			String rtn = xdata+"$"+ydata;
			Gson gson = new Gson();
			rtn = gson.toJson(rtn);
			out.write(rtn);
		}
		
		if(ac.equals("tj3")){
			String sdate = request.getParameter("sdate");
			String edate = request.getParameter("edate");
			String sql = "select date_format(savetime,'%Y-%m-%d') as days,sum(ddprice) as ddprice from ddinfo where fkstatus='已付款' ";
			if(!sdate.equals("")){
				sql += " and savetime>='"+sdate+"' ";
			}
			if(!edate.equals("")){
				sql += " and savetime<='"+edate+"' ";
			}
			sql += " group by days";
			ArrayList<HashMap> list = (ArrayList<HashMap>)dao.select(sql);
			//['周一','周二','周三','周四','周五','周六','周日']
			//[11, 11, 15, 13, 12, 13, 10],
			String xdata = "[";
			String ydata = "[";
			for(int i=0;i<list.size();i++){
				xdata += "'"+list.get(i).get("days")+"'";
				ydata += list.get(i).get("ddprice");
				if(i<list.size()-1){
					xdata+=",";
					ydata+=",";
				}
			}
			xdata += "]";
			ydata += "]";
			String rtn = xdata+"$"+ydata;
			Gson gson = new Gson();
			rtn = gson.toJson(rtn);
			out.write(rtn);
		}
		
		
		if(ac.equals("tj4")){
			String sdate = request.getParameter("sdate");
			String edate = request.getParameter("edate");
			String sql = "select date_format(savetime,'%Y-%m-%d') as days ,count(*) as count from ddinfo where fkstatus='已付款' ";
			if(!sdate.equals("")){
				sql += " and savetime>='"+sdate+"' ";
			}
			if(!edate.equals("")){
				sql += " and savetime<='"+edate+"' ";
			}
			sql += " group by days";
			ArrayList<HashMap> list = (ArrayList<HashMap>)dao.select(sql);
			//['周一','周二','周三','周四','周五','周六','周日']
			//[11, 11, 15, 13, 12, 13, 10],
			String xdata = "[";
			String ydata = "[";
			for(int i=0;i<list.size();i++){
				xdata += "'"+list.get(i).get("days")+"'";
				ydata += list.get(i).get("count");
				if(i<list.size()-1){
					xdata+=",";
					ydata+=",";
				}
			}
			xdata += "]";
			ydata += "]";
			String rtn = xdata+"$"+ydata;
			Gson gson = new Gson();
			rtn = gson.toJson(rtn);
			out.write(rtn);
		}
		
		
		
		//添加手办信息
		if(ac.equals("sbadd")){
			String title = request.getParameter("title");
			String note = request.getParameter("note");
			String memberid = member.get("id").toString();
			String shstatus = "待审核";
			String savetime = Info.getDateStr();
			dao.commOper("insert into sbinfo (title,note,memberid,shstatus,savetime) values " +
					"('"+title+"','"+note+"','"+memberid+"','"+shstatus+"','"+savetime+"') ");
			request.setAttribute("suc", "提交成功!");
			go("/mysbinfo.jsp", request, response);
		}
		//删除手办
		if(ac.equals("sbinfodel")){
			String id = request.getParameter("id");
			dao.commOper("delete from sbinfo where id="+id);
			out.print("true");
		}
		
	dao.close();
	out.flush();
	out.close();
}

	private static Properties config = null;
	 static {
		 try {
	  config = new Properties(); 
	  // InputStream in = config.getClass().getResourceAsStream("dbconnection.properties");
     InputStream in =  CommDAO.class.getClassLoader().getResourceAsStream("dbconnection.properties");
	   config.load(in);
	   in.close();
	  } catch (Exception e) {
	  e.printStackTrace();
	  }
	 }
	public void init()throws ServletException{

	}
	public static void main(String[] args) {
		System.out.println(new CommDAO().select("select * from mixinfo"));
	}
	

}
