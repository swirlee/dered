<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商城系统后台管理</title>
<link href="/css/template.css" rel="stylesheet" type="text/css">
<script src="/js/jquery-1.6.2.js"></script>
<script src="/js/echarts.js"></script>

<script type="text/javascript">
$(function(){
        // 基于准备好的dom，初始化echarts实例
        var dom = document.getElementById("mainnn");
		var myChart = echarts.init(dom);
        //var myChart = echarts.init(document.getElementById('mainnn'));
		var obj = {}
        // 指定图表的配置项和数据
    	option = {
   		color: ['#3398DB'],
    	tooltip : {
        trigger: 'axis',
        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        }
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    xAxis : [
        {
            type : 'category',
            data : ['一月份','二月份','三月份','四月份','五月份','六月份','七月份','八月份','九月份','十月份','十一月份','十二月份'],
            axisTick: {
                alignWithLabel: true
            }
        }
    ],
    yAxis : [
        {
            type : 'value'
        }
    ],
    series : [
        {
            name:'直接访问',
            type:'bar',
            barWidth: '60%',
            data:[]
        }
    ]
};
debugger
        $.ajax({
        	url:"/welcome/showWelcome",
        	data:"",
        	type:"post",
        	success:function(data){
        		//alert(data);
        		var arr = [];
        		for(var i = 1; i<=12; i++){
        			arr.push(data[i]);
        		}
//         		alert(arr);
        		option.series[0].data = arr;
        		// 使用刚指定的配置项和数据显示图表。
                myChart.setOption(option);
        	}
        })
});        
    </script>
    </head>
<body>

      <div class="cont">
        <h1 class="seth1">欢迎页面</h1>
        <div class="welcome">
	        <strong>您好,
	         <#if sessionUser?exists>
		        <span style="color:#06F">
		        	${sessionUser.username},
		        </span>
		     </#if>
		       		 欢迎使用
		        <span style="color:#F60">
		       		 童臻时代
		        </span>
	     	   商城系统. 您上次登录的时间：2017-03-09 15:09:46,登录IP:113.227.133.83
	        </strong>
        </div>

          <div class="wela">
            <h2>一周动态[本次统计时间：2017-03-10 08:30:00,下次统计时间：2017-03-10 09:00:00]</h2>
            <ul>
              <li>新增会员数：    0个</li>
              <li>新增商品数：    0件</li>
              <li>新增店铺数：    0个</li>
              <li>新增订单数：    1单</li>
              <li>待处理投诉： <a href="javascript:void(0);" onclick="window.parent.openURL(&#39;url&#39;,&#39;http://y14u504114.imwork.net:12111/shopping/admin/complaint_list.htm?status=new&#39;,&#39;main_workspace&#39;,&#39;complaint_manage_op&#39;)" style="color:#fff; background-color:#FF6600; padding:2px 4px; border-radius:4px 4px 4px 4px;">0起</a></li>
              <li>待处理举报：  <a href="javascript:void(0);" onclick="window.parent.openURL(&#39;url&#39;,&#39;http://y14u504114.imwork.net:12111/shopping/admin/report_list.htm&#39;,&#39;main_workspace&#39;,&#39;report_manage_op&#39;)" style="color:#fff; background-color:#FF6600; padding:2px 4px; border-radius:4px 4px 4px 4px;">  0次</a></li>
            </ul>
          </div>
          <div class="wela">
            <h2>订单统计</h2>
            <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
   		 	<div id="mainnn" style="width: 800px;height:400px;"></div>
    
          </div>

      </div>



</body></html>