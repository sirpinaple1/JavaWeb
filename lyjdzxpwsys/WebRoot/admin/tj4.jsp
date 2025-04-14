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
    <script type="text/javascript" src="js/echarts.js"></script>  
	<script type="text/javascript" src="js/china.js"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=53oVIOgmSIejwV7EfphPgTynOZbIiVYu"></script>
  </head>
 
  <body onload="init()">
<div class="container_12">
        <jsp:include page="/admin/top.jsp"></jsp:include>
        <jsp:include page="/admin/left.jsp"></jsp:include>
        
        <div class="grid_10">
            <div class="box round first fullpage">
                <h2>订单量走势图</h2>
                <div class="block ">
                    <table class="data display" id="example">
	                    <thead>
							<tr>
								<th colspan="3" align="left">
										<input class="input-xlarge" placeholder="开始日期..." id="sdate" name="sdate" type="date" >
										<input class="input-xlarge" placeholder="结束日期..." id="edate" name="edate" type="date" >
										<input type="button" onclick="search()" class="btn btn-small" value="查询">
								</th>
							</tr>
						</thead>
						<thead>
							<tr>
		                        <td class="col1">
		                     		<div id="tx" name="tx" style="height:400px;width:100% "></div>
		                		</td>
		                	</tr>
	                	</thead>
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
	var sdate = "";
	var edate = "";
	function search(){
		sdate = document.getElementById('sdate').value;
		edate = document.getElementById('edate').value;
		init();
	}
	function init(){
	    var myChart = echarts.init(document.getElementById('tx'));
	    var xdata = "";
	    var ydata = "";
	    $.ajax({
			url : '/lyjdzxpwsys/lyjdzxpwsys?ac=tj4&sdate='+sdate+'&edate='+edate,
			type : 'post',
			dataType : 'json',
			async : false,
			success : function(rtn) {
			xdata = eval('(' + rtn.split('$')[0] + ')'); 
			ydata = eval('(' + rtn.split('$')[1] + ')');
			}
		});
	
	
	
	    option = {
	    	    title: {
	    	        text: '订单量走势图',
	    	        subtext: ''
	    	    },
	    	    tooltip: {
	    	        trigger: 'axis'
	    	    },
	    	    
	    	    toolbox: {
	    	        show: true,
	    	        feature: {
	    	            dataZoom: {
	    	                yAxisIndex: 'none'
	    	            },
	    	            dataView: {readOnly: false},
	    	            magicType: {type: ['line', 'bar']},
	    	            restore: {},
	    	            saveAsImage: {}
	    	        }
	    	    },
	    	    xAxis:  {
	    	        type: 'category',
	    	        boundaryGap: false,
	    	        data: xdata
	    	    },
	    	    yAxis: {
	    	        type: 'value',
	    	        axisLabel: {
	    	    	formatter: '{value} 笔'
	    	        }
	    	    },
	    	    series: [
	    	        {
	    	            name:'订单量',
	    	            type:'line',
	    	            data:ydata,
	    	            markPoint: {
	    	                data: [
	    	                    {type: 'max', name: '最大笔'},
	    	                    {type: 'min', name: '最小笔'}
	    	                ]
	    	            },
	    	            markLine: {
	    	                data: [
	    	                    {type: 'average', name: '平均订单量'}
	    	                ]
	    	            }
	    	        }
	    	    ]
	    	};
	
	    myChart.setOption(option);
	}
	</script>
</html>
