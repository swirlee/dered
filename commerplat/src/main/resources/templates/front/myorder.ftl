
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>我的订单</title>
<link href="/css/public.css" type="text/css" rel="stylesheet">
<link href="/css/user.css" type="text/css" rel="stylesheet">
<link href="/css/overlay.css" type="text/css" rel="stylesheet">
<link href="/css/jquery-ui-1.8.22.custom.css" type="text/css" rel="stylesheet">
<link href="/css/overlay.css" type="text/css" rel="stylesheet"> 
<script src="/js/jquery-1.6.2.js"></script>
<script src="/js/jquery.shop.common.js"></script>
<script src="/js/jquery-ui-1.8.21.js"></script>
<script src="/js/jquery.zh.cn.js"></script>
<script>
$(document).ready(function(){
	//给订单状态的下拉列表框添加默认值
	$("#order_status").val("${orderstate?default('')}");
	
  $('#begintime').datepicker({
	  dateFormat:"yy-mm-dd",
	  changeMonth: true,
	  changeYear: true
  });
  $('#endtime').datepicker({
	  dateFormat:"yy-mm-dd",
	  changeMonth: true,
	  changeYear: true
  });

  //QueryShip
  $(".li_10>a[id^=li_ship_]").click(function(){
     $("div[id^=li_ship_box]").hide();
					var ordernumber =$(this).attr("ordernumber");
					var display =$("#li_ship_box_"+ordernumber).css("display");
							if(display=="none"){
							$("#li_ship_box_loading_"+ordernumber).show();
							}
							$.post("http://aishang2018.vicp.io:11585/shopping/buyer/query_ship.htm",{
									"id":ordernumber
									},
									function(data){
											if(data){
											   $(".li_ship_box_loading").hide();
											   $("#li_ship_box_"+ordernumber).show().find("ul").html(data);
											  }	
										},"text"); 
  });
  $("div[id^=li_ship_box_]").mouseleave(function(){
	  $(this).hide();
  });
//订单删除提示浮窗
$("a[id^=delete_order_]").click(function(){									
		var ordernumber=$(this).attr("order_id");	
		$("#delete_ordernumber").val(ordernumber);
		showDialog("share_sns","订单删除提示","订单删除无法恢复，确认删除？",1,"question","",order_delete);	
	});
//确定删除订单
function order_delete(){
	 var ordernumber=$("#delete_ordernumber").val();
	 window.location.href="/order/deletePayOrder?id="+ordernumber;
}

});
</script>
</head>
<body>

<!-- 利用include标签引入网页顶部的登录栏 -->
<#include "/front/top.ftl"/>

<div class="main">
	<!-- 利用include标签引入网页顶部的搜索 -->
	<#include "/front/search.ftl"/>
  <div class="user_center">
   
      <table width="1200" border="0" cellspacing="0" cellpadding="0" class="user_table">
        <tbody><tr> <script>
        $(document).ready(function(){
        	//点击主菜单，收起、下放副菜单
        	$(".sellul>li>a").click(function(){
        	  var child_show=$(this).attr("child_show");
        	  if(child_show=="true"){
        	    $(this).parent().find("img").attr("src","/images/menucontract.jpg");
        	    $(this).parent().find("ul").slideUp('normal');
        	    $(this).attr("child_show","false");
        	  }else{
        	    $(this).parent().find("img").attr("src","/images/usercenter/menuspread.jpg");
        	    $(this).parent().find("ul").slideDown('normal');
        	    $(this).attr("child_show","true");
        	  }
        	});
        	
        });


</script>

<td width="177" id="userbg" valign="top">

  <div class="seller">
    <!--店铺设置-->
    <div class="product_manage2">
      
      <div class="user_photo">
    <dl>
      <dt><img src="${user.headimagepath?default('')}" onerror="this.src='/images/tx.jpg'" width="120" height="120" ></dt>
      <dd><b></b><span><a href="">编辑资料</a></span></dd>
    </dl>
  </div>
     
      <ul class="sellul">
      	<li>
      	  <a href="javascript:void(0);" child_show="true"><b><img src="/images/usercenter/menuspread.jpg" width="10" height="10"></b>我的账户</a>
          <ul>
            <li op="account"><a href="/person/enterPersonCenter">个人资料</a></li>
            <li op="address"><a href="/order/showaddress">收货地址</a></li>
            <li op="order" class="this"><a href="">我的订单</a></li>
          </ul>
	  	</li>
      </ul>
    </div>
    
  </div>
  

  </td>

	<td id="centerbg" valign="top">
        <div class="buyer_position">
			<div class="buyer_p_box"><a>我的账户</a> &gt; <span>我的订单</span></div>
        </div>
		<div class="productmain">
            <div class="pdctitle blue2">订单列表
				<input type="hidden" name="delete_ordernumber" id="delete_ordernumber">
            </div>
            
            
            <form action="/order/myorder" method="post">
			<div class="ordersear">
				<span>订单号：</span>
				<span class="ordersp1 size7"><input name="ordernumber" type="text" id="ordernumber" value="${ordernumber?default('')}"></span>
				<span>下单时间：</span>
				<span class="ordersp1 size8"><input name="begintime" type="text" id="begintime" value="${begintime?default('')}"></span>
				<span>——</span>
				<span class="ordersp1 size8"><input name="endtime" type="text" id="endtime" value="${endtime?default('')}"></span>
				<span>订单号：</span><span>订单状态：</span>
				<span class="ordersel">
					<select name="orderstate" id="order_status">
						<option value="">所有订单</option>
						<option value="待支付">待支付</option>
						<option value="待发货">待发货</option>
						<option value="已发货">已发货</option>
						<option value="已完成">已完成</option>
						<option value="已取消">已取消</option>
					</select>
				</span>
				<span class="orderbtn">
					<input name="input" type="submit" value="搜索" style="cursor:pointer;">
				</span>
			</div>
            
              <div class="myorder">
              
              <#if list_order??>
              <#list list_order as order>
              <div class="Order">
                  <div class="Order_box">
                    <div class="line01">
                      <ul>
                        <li class="li_01">订单号：<span>${order.ordernumber}</span></li>
                        <li class="li_02">下单时间：<span>${order.addtime?string("yyyy-MM-dd HH:mm")}</span></li>
                        <li></li>
                        <li class="li_02">订单状态：<span>${order.orderstate}</span></li>
                      </ul>
                    </div>
                    
                    <div class="line_02">
                      <table width="100%" cellpadding="0" cellspacing="0" class="order_table">
                        <tbody><tr>
                          <td>
                        <#if order.list_detailorder??>
             			<#list order.list_detailorder as detailorder>
             				<span>
							<ul class="ul_01">
                              <li class="li_05">
	                              <a href="/frontGoods/goodsDetails?id=${detailorder.goods.id}" target="_blank">
	                              	<img src="${detailorder.goods.path?default('')}" width="60" height="60">
	                              </a>
                              </li>
                              <li class="li_06">
                              	<a href="/frontGoods/goodsDetails?id=${detailorder.goods.id}" target="_blank">${detailorder.goods.goodsname}</a>
                              	<span>数量:${detailorder.count}</span>
                                <span>库存:${detailorder.goods.inventory}</span>
                              </li>
                            </ul>
                            </span>
                            <span>
                            	<li class="li_88">
	                              	<span>小计:${detailorder.count*detailorder.goods.sellprice}</span>
                            	</li>
                            </span>
                           </#list>
                  			</#if>  
                          </td>
                          <td><ul class="ul_03">
                              <li style="color:#999;">物流跟踪</li>
                              <li class="li_07"> 暂无物流信息</li>
                         </ul></td>
                         <td><ul class="ul_03">
                              <li style="color:#999;">收货地址</li>
                              <li class="li_07"> ${order.cityaddress}${order.detailaddress}</li>
                         </ul></td>
                         <td><ul class="ul_03">
                              <li>收件人:${order.receiver}</li>
                              <li>联系电话:${order.tel}</li>
                         </ul></td>
                         <td><ul class="ul_03">                             
	                            <li style="color:#999;">¥${order.totalprice}</li>
	                            <li style="color:#59cfff;">(含运费:¥0.0)</li>
						</ul></td>
						<td style="border:none"><ul class="ul_04">
							<#if order.orderstate == "待支付">
                                <li><a style="color:#ff4f19; text-decoration:underline;" href="javascript:void(0);" dialog_uri="/order/cancel_order?id=${order.id}&ordernumber=${order.ordernumber}" dialog_title="取消订单" dialog_width="400" dialog_height="100" dialog_id="order_cancel">取消订单</a></li>
                                <li class="li_09"><a href="/order/order_pay_view?id=${order.id}" target="_blank">付款</a></li>
                           
                            <#elseif order.orderstate == "待发货">
                           		<li>待发货</li>
                           		
                            <#elseif order.orderstate == "已发货">
                           		<li>已发货</li>
                           		<li><a style="color:#ff4f19; text-decoration:underline;" href="/order/receiveGoods?id=${order.id}">确认收货</a></li>
                            <#elseif order.orderstate == "已取消">
                                <li>已取消</li>
                                <li><a style="color:#ff4f19; text-decoration:underline;" href="/order/deleteNoPayOrder?id=${order.id}" order_id="${order.id}">删除订单</a></li>
                           
                           <#elseif order.orderstate == "已完成">
                           		<li>已完成</li>
                                <li><a style="color:#ff4f19; text-decoration:underline;" href="/order/deletePayOrder?id=${order.id}" order_id="${order.id}">删除订单</a></li>
                           </#if>
						</ul></td>
                        </tr>
                      </tbody>
                      </table>
                    </div>
                   
                  </div>
                </div>
                
                </#list>
                  </#if>      
                          </div></div>                                                                                                                                                                                                                                                                                             
                 </div>
                 </div> 
                </div>
                 </div>
                 
              
            </div>
            </td>
            
        </tr>
      </tbody>
      </table>
  
  </div>
  
<script>
$(document).ready(function(){
	//滚动条滚动事件
	$(window).scroll(function(){
		var top = $(document).scrollTop();
		if(top==0){
			$(".back_box").hide();
		}else{
			$(".back_box").show();	
		}
	});						
});
</script>
<!--网页底部-->
<#include "/front/foot.ftl"/>
<!--返回最顶部-->
<div class="back_box" style="width: 50px; height: 50px; position: fixed; bottom: 180px; right: 25px;">
	<div class="back_index">
		<a href="/front/index" target="_blank" title="返回主页"></a>
	</div>
	<div class="back_top">
		<a id="toTop" href="/order/myorder" bosszone="hometop" style="display: block;" onclick="window.scrollTo(0,0);return false" title="返回顶部" target="_self"></a>
	</div>
</div> 
<div id="ui-datepicker-div" class="ui-datepicker ui-widget ui-widget-content ui-helper-clearfix ui-corner-all"></div>
</body>
</html>