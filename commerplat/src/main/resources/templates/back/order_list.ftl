<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title></title>
<link href="/css/template.css" rel="stylesheet" type="text/css">
<link href="/css/jquery-ui-1.8.22.custom.css" type="text/css" rel="stylesheet">
<script src="/js/jquery-1.6.2.js"></script>
<script src="/js/jquery.validate.min.js"></script>
<script src="/js/jquery.shop.common.js"></script>
<script src="/js/jquery.poshytip.min.js"></script>
<script src="/js/jquery-ui-1.8.21.js"></script>
<script src="/js/jquery.zh.cn.js"></script>
<script>

$(document).ready(function(){
	//给订单状态的下拉列表框添加默认值
	$("#order_status").val("${orderstate?default('')}");
	
  $('#beginTime').datepicker({
	  dateFormat:"yy-mm-dd",
	  changeMonth: true,
	  changeYear: true
  });
  $('#endTime').datepicker({
	  dateFormat:"yy-mm-dd",
	  changeMonth: true,
	  changeYear: true
  });
  //
  

});

//修改退款金额
var refund_id=0;
function refund(refund_id,obj){
 	var refundment = $(obj).val();
	$.ajax({
			type:'POST',
	        url:'http://aishang2018.vicp.io:11585/shopping/admin/order_refund.htm',
	        data:{"refundment":refundment,"refund_id":refund_id},
			success:function(){
            	alert("退款金额保存成功");           
       		}
	});	
}
//ajax删除订单
function deleteorder(obj){
	var deleteid = $(obj).attr("deleteid");
	$.ajax({
		type:'post',
		url:'/order/backorderdelete',
		data:{"deleteid":deleteid},
		success:function(data){
			if(data){
				$(obj).parent().parent().remove();
			}
		}
	});
}


//ajax后台一键发货
function sendGoodsButton(obj){
	var orderid = $(obj).attr("orderid");
	$.ajax({
		type:'post',
		url:'/order/sendGoods',
		data:{"orderid":orderid},
		success:function(data){
			if(data){
				$(obj).parent().empty().append("<input type='button' value='已发货' disabled='disabled'>");
			}
		}
	});
}
</script>
<style id="poshytip-css-tip-skyblue" type="text/css">div.tip-skyblue{visibility:hidden;position:absolute;top:0;left:0;}div.tip-skyblue table, div.tip-skyblue td{margin:0;font-family:inherit;font-size:inherit;font-weight:inherit;font-style:inherit;font-variant:inherit;}div.tip-skyblue td.tip-bg-image span{display:block;font:1px/1px sans-serif;height:10px;width:10px;overflow:hidden;}div.tip-skyblue td.tip-right{background-position:100% 0;}div.tip-skyblue td.tip-bottom{background-position:100% 100%;}div.tip-skyblue td.tip-left{background-position:0 100%;}div.tip-skyblue div.tip-inner{background-position:-10px -10px;}div.tip-skyblue div.tip-arrow{visibility:hidden;position:absolute;overflow:hidden;font:1px/1px sans-serif;}</style></head>
<body>

<div class="cont">
  <h1 class="seth1">订单管理</h1>
  <div class="settab">
	  <span class="tab-one"></span> 
	  <span class="tabs"> <a href="javascript:void(0);" class="this">所有订单</a></span> 
	  <span class="tab-two"></span>
	  <span class="tabs"><a href="/order/downloadExcel?ordernumber=${ordernumber?default('')}&begintime=${begintime?default('')}&endtime=${endtime?default('')}&orderstate=${orderstate?default('')}">生成excel表格</a></span>
  </div>
  <form action="/order/order_list" method="post" id="queryForm">
  <div class="orders">
    <ul>
      <li>
		<span>订单状态</span>
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
      </li>
      
      <li> <span>下单时间</span><span class="order_input size2">
        <input name="begintime" type="text" id="beginTime" value="${begintime?default('')}">
        </span><span>—</span><span class="order_input size2">
        <input name="endtime" type="text" id="endTime" value="${endtime?default('')}">
        </span> <span>订单编号</span>
        <span class="order_input size2">
        <input name="ordernumber" type="text" id="ordernumber" value="${ordernumber?default('')}">
        </span> 
        <span class="btn_search">
        <input name="" type="submit" value="搜索" style="cursor:pointer;">
      </span> </li>
    </ul>
  </div>
  </form>
  <form action="/order/findOrderByConditions" method="post" id="ListForm">
    <div class="allshop_table">
    <table width="98%" border="0" cellspacing="0" cellpadding="0">
      <tbody>
      <tr style="background:#2A7AD2; height:30px; color:#FFF">
        <td width="10%">买家名称</td>
        <td width="10%">订单号</td>
        <td width="10%">下单时间</td>
        <td width="8%">订单总额</td>
        <td width="6%">订单状态</td>
        <td width="9%" align="left" colspan="2">操作</td>
      </tr>
            
     <#if list_order ??>
     <#list list_order as order>
     
       <tr>
        <td>${order.user.username?default('')}</td>
        <td>${order.ordernumber?default('')}</td>
        <td>${order.addtime?string('yyyy-MM-dd hh:mm:ss')}</td>
        <td>${order.totalprice?default('')}</td>
        
		<#if order.orderstate =="待发货">
        <td width="1%" align="left"><input type="button" onclick="sendGoodsButton(this)" orderid="${order.id}" value="发货"></td> 
         <#elseif order.orderstate =="已发货">  
         <td width="1%" align="left"><input type='button' value='已发货' disabled='disabled'></td> 
		<#elseif order.orderstate =="已完成">
		<td width="1%" align="left"><input type='button' value='已完成' disabled='disabled'></td>
		<#elseif order.orderstate =="已取消">
		<td width="1%" align="left"><input type='button' value='已取消' disabled='disabled'></td>
		<#elseif order.orderstate =="用户看不到">
		<td width="1%" align="left"><input type='button' value='已完成（用户删除）' disabled='disabled'></td>
		<#elseif order.orderstate =="待支付">
        <td width="1%" align="left"><input type="button" onclick="deleteorder(this)" deleteid="${order.id}" value="待支付（点击删除）"></td>  
        <#else>    
         <td width="1%" align="left"></td>
         </#if>  
        <td width="2%" align="left"><a href="/order/order_view?orderid=${order.id}">查看</a></td>
      </tr>
           
         </#list>
         </#if>  
         
           
          
           
           
           
           
        
           
         </tbody></table>
  </div>
	<div class="fenye">
    <input name="end_price" type="hidden" id="end_price" value="">
    <input name="begin_price" type="hidden" id="begin_price" value="">
    <input name="endTime" type="hidden" id="endTime" value="">
    <input name="beginTime" type="hidden" id="beginTime" value="">
    <input name="type_data" type="hidden" id="type_data" value="">
    <input name="type" type="hidden" id="type" value="">
    <input name="order_status" type="hidden" id="order_status" value="">
    <input name="currentPage" type="hidden" id="currentPage" value="1">
    
    
	<a href="javascript:void(0);" onclick="return gotoPage(1)">首页</a>
	<a href="javascript:void(0);" onclick="return gotoPage(1)">上一页</a>
	第
	<a href="javascript:void(0);" onclick="return gotoPage(1)">1</a>
	<a class="this" href="javascript:void(0);" onclick="return gotoPage(2)">2</a>
	<a href="javascript:void(0);" onclick="return gotoPage(3)">3</a>
	页
	<a href="javascript:void(0);" onclick="return gotoPage(3)">下一页</a>
	<a href="javascript:void(0);" onclick="return gotoPage(3)">末页</a> 
	</div>
  </form>
</div>


</body></html>