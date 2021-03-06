<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单确认</title>
<link href="/css/window.css" type="text/css" rel="stylesheet">
<link href="/css/public.css" type="text/css" rel="stylesheet">
<link href="/css/goods.css" type="text/css" rel="stylesheet">
<link href="/css/jquery-ui-1.8.22.custom.css" type="text/css" rel="stylesheet">
<link href="/css/overlay.css" type="text/css" rel="stylesheet">
<script src="/js/jquery-1.6.2.js"></script>
<script src="/js/jquery-ui-1.8.21.js"></script>
<script src="/js/jquery.validate.min.js"></script>
<script src="/js/jquery.shop.common.js"></script>
<script src="/js/jquery.cookie.js"></script>
<script>
$(document).ready(function(){
	//计算总价格
	var totalprice = 0;
	var arr = $("input[name=smallprice]");
	$.each(arr,function(){
		totalprice += parseFloat($(this).val());
	});
	$("#order_store_amount").html(totalprice);
	$("#order_pay_fee").html(totalprice);
	$("#totalprice").val(totalprice);
	

	//
	$(":radio[id=invoiceType]").click(function(){
		var val=$(this).val();
		if(val=="1"){
			$("#invoice_info").show();
		}else{
			$("#invoice_info").hide();
		}
	});
	
	
	

	//
	$(".baby_gp>a").mouseover(function(){
		$(this).parent().find(".arrow").show();									  
		$(this).parent().find(".baby_group").show();
	});
	//
	$(".baby_gp").mouseleave(function(){
		$(this).parent().find(".arrow").hide();									  
		$(this).parent().find(".baby_group").hide();
	});
	//
	$("#coupon_id").val("0");
	$("#ship_price").find("option:first").attr("selected",true);
	$(":radio[id^=addr_id]:first").attr("checked",true);
	//
	$("#cart_goods_top_menu").mouseover(function(){
		$.ajax({type:'POST',url:'http://aishang2018.vicp.io:11585/shopping/cart_menu_detail.htm',data:'',
			beforeSend:function(){
				$("#cart_goods_top_info").empty().html('<div class="menu-bd-panel"><div style="text-align:center;"><img src="http://aishang2018.vicp.io:11585/shopping/resources/style/common/images/loader.gif" /></div></div>');
				$("#cart_goods_top_info").show();
			},
			success:function(data){
				$("#cart_goods_top_info").empty();
				$("#cart_goods_top_info").html(data);
			}
		});
	});
	//
	$("#cart_menu").mouseleave(function(){
		$("#cart_goods_top_info").hide();
	});
	//
	$(".toph_bgsear li").mouseover(function(){
		$(".toph_bgsear>li").show();
	}).mouseleave(function(){
		$(".toph_bgsear>li").last().hide();
	}).click(function(){
		var index=$(this).index();
		if(index==1){
			var f_text=$(".toph_bgsear li").find("a").first().text();
			var f_type= $(".toph_bgsear li").first().attr("type");
			$(".toph_bgsear li").find("a").first().html($(this).find("a").text()+"<s></s>");
			$(".toph_bgsear li").find("a").last().text(f_text);
			$("#type").val($(this).attr("type"));
			$(".toph_bgsear li").first().attr("type",$(this).attr("type"));
			$(".toph_bgsear li").last().attr("type",f_type);
			$(".toph_bgsear>li").last().hide();
		}
	});
	//
	$(".two_code_a").click(function(){
		$(this).parent().remove();
	});
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

//
function save_order(){
  $("#cart_form").submit();
}
//
var goods_count=4;
var total_price=0;
function cart_remove(id,store_id){
	$.post('http://aishang2018.vicp.io:11585/shopping/remove_goods_cart.htm',{"id":id,"store_id":store_id},function(data){
		$("div[class=table] tr[id="+id+"]").remove();
		$(".shopping[id="+id+"]").remove();
		$(".shopp_ingtop[id="+id+"]").remove();
		$("#cart_goods_count_top").html(data.count);
		$("#cart_goods_price_top").html(data.total_price);
		$("#top_total_price_"+store_id).html(data.total_price);
		if(store_id!=""){
			$("#total_price_"+store_id).html(data.sc_total_price);
		}
		if( $("form[id=cart_"+store_id+"]").find("tr[goods_list^=goods_info]").length==0){
			$("form[id=cart_"+store_id+"]").remove();
		}
		if($("tr[goods_list^=goods_info]").length==0){
			$(".car_nogoods").show();
		}
	},"json");
}
//
function search_form(){
	var keyword=arguments[0];
	var type=arguments[1];
	if(keyword!=""&&keyword!=undefined){
		$("#keyword").val(keyword);
	}
	if(type!=""&&type!=undefined){
		$("#type").val(type);
	}
	$("#searchForm").submit();	
	$("#keyword").val("");
}
</script>
</head>

<body>
<!-- 利用include标签引入网页顶部的登录栏 -->
<#include "/front/top.ftl"/>
<#include "/front/search.ftl"/>
<div class="main">


	<div class="Steps_box">
		<div class="Steps">
			<ul>
				<li class="done prev">1.查看购物车</li>
				<li class="this">2.确认订单信息</li>
				<li>3.付款到卖家</li>
				<li>4.确认收货</li>
				<li class="last">5.评价</li>
			</ul>
		</div>
		
		
		
		<form action="/order/submit_order" enctype="" id="cart_form" method="post">
			<div class="table">
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tbody>
						<tr>
							<td width="57%" align="center" class="title">店铺商品</td>
							<td width="10%" align="center" class="title">单价</td>
							<td width="11%" align="center" class="title">数量</td>
							<td width="11%" align="center" class="title">小计</td>
						</tr>
						<#if list_cart??>
						<#list list_cart as cart>
						<tr>
							<td class="baby" align="center">
								<a href="" target="_blank">
									<img src="${cart.goods.path}" width="65" height="65">
								</a>
								<p>
									<a href="" target="_blank">${cart.goods.goodsname}</a><br>
								</p>
							</td>
							<td align="center">
								<strong>￥</strong>
								<strong>${(cart.goods.sellprice)?c}</strong>
							</td>
							<td align="center">
								<strong>${cart.count}</strong>
							</td>
							<td align="center">
								<strong class="orange">￥</strong>
								<strong class="orange">${(cart.goods.sellprice*cart.count)?c}</strong>
								<input type="hidden" name="smallprice" value="${(cart.goods.sellprice*cart.count)?c}">
								<input type="hidden" name="str" id="str" value="${str}">
							</td>
						</tr>
						</#list>
						</#if>
					</tbody>
				</table>
			</div>
			<div class="sendadress">
				<h1>
					<div class="sendhright">
						<span class="sendperbtn">
						<#if address??>
							<a href="javascript:void(0);" dialog_uri="/address/address_choose?addressid=${address.id}&str=${str?default('')}&ordernumber=${ordernumber}" dialog_title="选择收货地址" dialog_width="550" dialog_height="300" dialog_id="buyer_address" id="buyer_address" class="button_common">选择收货地址</a>
						<#else>
							<a href="javascript:void(0);" dialog_uri="/order/address_add?str=${str?default('')}" dialog_title="新增地址" dialog_width="500" dialog_height="300" dialog_id="cart_address" id="add_address" class="button_common">新增地址</a>
						</#if>
						</span>
						<span class="sendperbtn">
							<a href="/order/showaddress" target="_blank">管理收货地址</a>
						</span>
					</div>
					<span class="sendperadr">收货人地址</span>
				</h1>
				<div class="writeok">
					<ul>
						<#if address??>
						<li>
							<strong><img src="/images/Steps_02.gif" width="14" height="23"></strong>
							<label>
								<span id="address">${address.province.cityname?default('')}${address.city.cityname?default('')}${address.area.cityname?default('')}${address.address?default('')}</span>
								<span id="person">${address.receiver?default('')}</span>
								<span id="mobile">${address.tel?default('')}</span>
							</label>
						</li>
						<#else>
						<li>
							<strong><img src="/images/Steps_02.gif" width="14" height="23"></strong>
							<label>
								<span id="address"></span>
								<span id="person"></span>
								<span id="mobile"></span>
							</label>
						</li>
						</#if>
					</ul>
				</div>
				<h1>
					<span class="sendperadr margin10">发票信息</span>
				</h1>
				<div class="sendmethod">
					<ul>
						<li>
							<label>
								<input name="invoiceType" type="radio" id="invoiceType" value="0" checked="checked"> 个人
							</label>
							<label>
								<input name="invoiceType" id="invoiceType" type="radio" value="1"> 单位
							</label>
						</li>
						<li id="invoice_info" style="display: none;">
							<span style="margin-bottom: 5px;">发票抬头：</span>
							<input name="invoice" type="text" id="invoice" size="40" style="height: 20px;">
						</li>
					</ul>
				</div>
				<h1>
					<span class="sendperadr margin10">配送方式</span>
				</h1>
				<div class="sendmethod">
					<ul>
						<li>
							<span style="margin-bottom: 5px;">可用配送方式：</span>
							<select name="ship_price" style="width: 110px;" id="ship_price">
								<option value="0">买家承担</option>
								<option value="1">卖家承担</option>
							</select>
							
						</li>
					</ul>
				</div>
				<h1>
					<span class="sendperadr margin10">买家附言</span>
				</h1>
				<div class="sendmeg">
					<textarea name="msg" cols="" rows="" id="msg"></textarea>
				</div>
				<div class="paysend" id="order_coupon_div" style="display: none;">
					优惠券抵消：
					<strong class="red" style="font-size: 24px;" id="order_coupon"></strong>
				</div>
				<div class="paysend">
					店铺合计：
					<strong class="red" style="font-size: 24px;">¥</strong>
					<strong class="red" style="font-size: 24px;"id="order_store_amount"></strong>
				<div class="paysend">
					<div class="paysd">
						<div class="paysd_box">
							<span>实付款：<strong></strong><b id="order_pay_fee" ></b></span>
							<ul>
							<#if address??>
								<li><span id="order_address_info">${address.province.cityname?default('')}${address.city.cityname?default('')}${address.area.cityname?default('')}${address.address?default('')}</span></li>
								<li><span id="order_person_info">${address.receiver?default('')}</span></li>
							<#else>
								<li><span id="order_address_info"></span></li>
								<li><span id="order_person_info"></span></li>	
							</#if>
							</ul>
						</div>
					</div>
				</div>
				<#if address??>
				<div class="paybtn">
					<input name="order_save" type="button" value="提交订单并支付" onclick="save_order();" style="cursor: pointer;" id="order_save">
					<input type="hidden" name="totalprice" id="totalprice" value="">
					<input type="hidden" name="cityaddress" value="${address.province.cityname?default('')}${address.city.cityname?default('')}${address.area.cityname?default('')}">
					<input type="hidden" name="detailaddress" value="${address.address?default('')}">
					<input type="hidden" name="receiver" value="${address.receiver?default('')}">
					<input type="hidden" name="zipcode" value="${address.zipcode?default('')}">
					<input type="hidden" name="tel" value="${address.tel?default('')}">
					<input type="hidden" name="ordernumber" value="${ordernumber?default('')}">
				</div>
				<#else>
				<div class="paybtn">
					<input name="order_save" type="button" value="提交订单并支付" onclick="save_order();" style="cursor: pointer;" id="order_save">
					<input type="hidden" name="totalprice" id="totalprice" value="">
					<input type="hidden" name="cityaddress" value="">
					<input type="hidden" name="detailaddress" value="">
					<input type="hidden" name="receiver" value="">
					<input type="hidden" name="zipcode" value="">
					<input type="hidden" name="tel" value="">
					<input type="hidden" name="ordernumber" value="">
				</div>
				</#if>
			</div>
		</form>
	</div>

<script type="text/javascript">
$(document).ready(function(){
	debugger
	var address = "${address?default('')}";
	if(address==""){
		$("#add_address").click();
	}
});
</script>
	<!--联系方式-->
	<div class="footer">
		<div class="footerArea">
			<ul>
				<li><a href="/shopping/article_join.htm" target="_blank">招聘英才</a>|
					<a href="/shopping/article_adver.htm" target="_blank">广告合作</a>| <a
					href="/shopping/article_contact.htm" target="_blank">联系我们</a>| <a
					href="/shopping/article_about.htm" target="_blank">关于shopping</a>
				</li>
				<li class="hui2">Copyright 2015-2016 tongzhenshidai Inc. All
					rights reserved</li>
				<li class="hui2">Powered by 童臻时代</li>
			</ul>
		</div>
	</div>
	<!--返回最顶部-->
	<div class="back_box" style="display: none; width: 50px; height: 50px; position: fixed; bottom: 180px; right: 25px; _position: absolute; /*兼容IE6的代码*/ _bottom: auto; /*兼容IE6的代码*/ _top: expression(eval(document.documentElement.scrollTop + document.documentElement.clientHeight-this.offsetHeight- ( parseInt(this.currentStyle.marginTop, 10)||0)-(parseInt(this.currentStyle.marginBottom, 10)||0)));">
		<div class="back_index">
			<a href="http://aishang2018.vicp.io:11585/shopping/index.htm" target="_blank" title="返回主页"></a>
		</div>
		<div class="back_top">
			<a id="toTop" href="http://aishang2018.vicp.io:11585/shopping/goods_cart1.htm#" bosszone="hometop" style="display: block;" onclick="window.scrollTo(0,0);return false" title="返回顶部" target="_self"></a>
		</div>
	</div>

</div>

</body>
</html>