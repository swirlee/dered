<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的购物车</title>
<link href="/css/public.css" type="text/css" rel="stylesheet">
<link href="/css/goods.css" type="text/css" rel="stylesheet">
<link href="/css/overlay.css" type="text/css" rel="stylesheet">
<script src="/js/jquery-1.6.2.js"></script>
<script src="/js/jquery.cookie.js"></script>
<script src="/js/jquery-ui-1.8.21.js"></script>
<script src="/js/jquery.shop.common.js"></script>
<script>
$(document).ready(function(){
	//全选框点击事件
	$("input[name=checkedAll]").change(function(){
		if($(this).prop("checked")){
			$("input[name=goodsChecked]").prop("checked",true);
		}else{
			$("input[name=goodsChecked]").prop("checked",false);
		}
		total_price_adjust();
	});
	//点击复选框，全选框跟随改变
	$("input[name=goodsChecked]").change(function(){
		var arr = $("input[name=goodsChecked]:checked");
		var length = $("input[name=goodsChecked]").length;
		if(arr.length == length){
			$("input[name=checkedAll]").prop("checked",true);
		}else{
			$("input[name=checkedAll]").prop("checked",false);
		}
	});
	//点击复选框，确定商品的总价钱
	$("input[name=goodsChecked]").change(function(){
		total_price_adjust();
	}); 
	//删除购物车商品
	$("a[id^=delete_]").click(function(){
		var id=$(this).attr("cartid");
		var oldcount = $("#goods_count_"+id).attr("goods_count");
		var oldcounts = $("#cart_goods_count_top").html();
		if(confirm("确定删除该商品？")){
			$.post('/frontCart/remove_goods_cart',{"id":id},function(data){
				$("#goods_info_"+id).remove();
				$("#cart_goods_count_top").html(oldcounts-oldcount);
				total_price_adjust();
			},"json");
		}
	});
	//商品数量减少1件的<按钮>
	$("a[id^=count_down]").click(function(){
		var cart_id=$(this).attr("cart_id");
		var count=$("#goods_count_"+cart_id).val();
		var oldcount = $("#goods_count_"+cart_id).attr("goods_count");
		count--;
		if(count<1){
			count = 1;
			$("#goods_count_"+cart_id).val(count);
			$("#goods_count_"+cart_id).attr("goods_count",count);
		}else{
			$("#goods_count_"+cart_id).val(count);
			$("#goods_count_"+cart_id).attr("goods_count",count);
		}
		goods_count_adjust(cart_id,count,oldcount);
	});
	//商品数量增加1件的<按钮>
	$("a[id^=count_up]").click(function(){
		var cart_id=$(this).attr("cart_id");
		var count=$("#goods_count_"+cart_id).val();
		var oldcount = $("#goods_count_"+cart_id).attr("goods_count");
		count++;
		goods_count_adjust(cart_id,count,oldcount);
	});
	//商品数量输入框的数量改变
	$("input[id^=goods_count_]").keyup(function(){
		var cart_id=$(this).attr("cart_id");
		var count=$("#goods_count_"+cart_id).val().replace(/\D/g,'');//将输入不为数字的字符替换为“”
		var oldcount = $("#goods_count_"+cart_id).attr("goods_count");
		if(count == "" || count < 1){
			count=1;
			$("#goods_count_"+cart_id).val(count);
			$("#goods_count_"+cart_id).attr("goods_count",count);
		}
		goods_count_adjust(cart_id,count,oldcount);
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

//总价格调整的方法
function total_price_adjust(){
	var totalprice = 0;
	var arr = $("input[name=goodsChecked]:checked");
	$.each(arr,function(){
		var cartid = $(this).attr("carts_id");
		totalprice += parseFloat($("#goods_total_price_"+cartid).html());
		/* totalprice += $(obj).parent("input[id^=goods_total_price_]").html(); */
	}); 
	$("#total_price").html(totalprice);
}
//购买商品数量调整
function goods_count_adjust(cart_id,count,oldcount){
	$.post("/frontCart/goods_count_adjust",{"cart_id":cart_id,"count":count},function(data){
		if(data.msg=="数量超出库存~"){
			alert("数量超出库存~");
			$("#goods_count_"+cart_id).val(data.cart.count);
			$("#goods_count_"+cart_id).attr("goods_count",data.cart.count);
			$("#goods_count_"+cart_id).attr("disabled",false);
	 	}
	 	if(data.msg=="东西刚被其他用户买走，您暂时不能购买！"){
			alert("东西刚被其他用户买走，您暂时不能购买！");
			$("#goods_count_"+cart_id).val("1");
			$("#goods_count_"+cart_id).attr("goods_count","1");
			$("#goods_info_"+cart_id).attr("disabled",true);
	 	}
	 	if(data.msg=="success"){
			$("#goods_count_"+cart_id).val(data.cart.count);
			$("#goods_count_"+cart_id).attr("goods_count",data.cart.count);
			$("#goods_info_"+cart_id).attr("disabled",false);
	 	}
	 	$("#goods_total_price_"+cart_id).html(data.cart.count*data.cart.goods.sellprice);
	 	var oldcounts = $("#cart_goods_count_top").html();
	 	$("#cart_goods_count_top").html(oldcounts-oldcount+data.cart.count);
	 	total_price_adjust();
	},"json");
}
 
//确认购买商品
function confirm_cart(){
	var str = "";
	$("input[name=goodsChecked]:checked").each(function(){
		str += $(this).attr("carts_id")+",";
	});
	
	if(str!=""){
		$("#str").val(str);
		$("#cart_pay").submit();
	}else{
		alert("请选择需要结算的商品！");
	}		
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
<!-- 利用include标签引入网页顶部的搜索 -->
<#include "/front/search.ftl"/>
<div class="main">

	<div class="Steps_box">
	  <div class="Steps">
	    <ul>
	      <li class="this">1.查看购物车</li>
	      <li>2.确认订单信息</li>
	      <li>3.付款到卖家</li>
	      <li>4.确认收货</li>
	      <li class="last">5.评价</li>
	    </ul>
	  </div>
	  
	  <form method="post" name="cart_pay" id="cart_pay" action="/frontCart/orderPay">
	  	<input type="hidden" name="str" id="str" value="">
		<div class="table">
	      <table width="115%" cellpadding="0" cellspacing="0" border="0">
	        <tbody>
	        <tr>
	          <td width="5%" align="center" class="title">选择</td>
	          <td width="15%" align="center" class="title">商品名称</td>
	          <td width="10%" align="center" class="title">单价</td>
	          <td width="20%" align="center" class="title">数量</td>
	          <td width="20%" align="center" class="title">小计（元）</td>
	          <td width="20%" align="center" class="title">操作</td>
	        </tr>
	        <#if cartMap ??>
	        <#if cartMap.list_cart ??>
	        <#list cartMap.list_cart as cart>
	        <tr goods_list="goods_info_${cart.id}" id="goods_info_${cart.id}">
	          <input type="hidden" name="cartids" value="${cart.id}">
           	  <td width="5%" align="center"><input type="checkbox" name="goodsChecked" carts_id="${cart.id}"></td>
	          <td class="baby"> 
	              <img src="${cart.goods.path}" width="65" height="65">
	              <p><a href="" target="_blank">${cart.goods.goodsname}</a><br></p>
	          </td>
	          <td align="center">¥${cart.goods.sellprice}</td>
	          <td class="input" align="center">
		          <span><a href="javascript:void(0);" id="count_down_${cart.id}" cart_id="${cart.id}">
		          	<img src="/images/jian.jpg" width="12" height="12">
		          </a></span>
	              <input type="text" name="goods_count_${cart.id}" id="goods_count_${cart.id}" value="${cart.count}" cart_id="${cart.id}" goods_count="${cart.count}">
	              <span><a href="javascript:void(0);" id="count_up_${cart.id}" cart_id="${cart.id}">
	              	<img src="/images/add.jpg" width="12" height="12">
	              </a></span>
	          </td>
	          <td align="center" class="orange">¥<strong class="orange" id="goods_total_price_${cart.id}">${(cart.count*cart.goods.sellprice)?c}</strong></td>
	          <td align="center">
	          	<a href="javascript:void(0);" id="delete_${cart.id}" cartid="${cart.id}">删除</a>
	          </td>
	        </tr>
	        </#list>
	        </#if>
	        </#if>
	        </tbody>
	      </table>
	    </div>
	    <div class="h2">
	    	<span class="h2_l"><input type="checkbox" id="checkedAll" name="checkedAll" value="">全选</span>
			<span class="h2_r">
				<em>商品总价：</em>
				<b>¥<strong class="orange" id="total_price">0.00</strong></b>
				<a href="javascript:void(0);" onclick="confirm_cart();">结算</a>
			</span>
	    </div>
	  </form>
	  
      <div class="car_nogoods" style="display:none;">
        <div class="shopcar">
          <dl>
            <dt><img src="/images/shopping_cart.jpg" width="130" height="118"></dt>
            <dd>
              <h1>您的购物车还没有商品</h1>
              <span><a href="http://aishang2018.vicp.io:11585/shopping/index.htm">马上去购物&gt;&gt;</a></span><span><a href="http://aishang2018.vicp.io:11585/shopping/buyer/order.htm">查看自己的订单&gt;&gt;</a></span> </dd>
          </dl>
        </div>
      </div>
	  <div class="tm_hot">
		<h1>
			<span class="tm_h1_left">商家热卖</span>
			<span class="tm_h1_right">
				<a href="http://aishang2018.vicp.io:11585/shopping/ztc_goods_list.htm" target="_blank">更多&gt;&gt;</a>
			</span>
		</h1>
	  </div> 
	
	</div>
	<!--联系方式-->
	<div class="footer">
		<div class="footerArea">
		  <ul>
			<li>
		    	<a href="/shopping/article_join.htm" target="_blank">招聘英才</a>|
		    	<a href="/shopping/article_adver.htm" target="_blank">广告合作</a>|
				<a href="/shopping/article_contact.htm" target="_blank">联系我们</a>|
				<a href="/shopping/article_about.htm" target="_blank">关于shopping</a>
			</li>
		    <li class="hui2">Copyright 2015-2016 tongzhenshidai Inc. All rights reserved</li>
		    <li class="hui2">Powered by 童臻时代</li>
		  </ul>
		</div>
	</div>
	<!--返回最顶部-->
	<div class="back_box" style=" display:none;width:50px; height:50px;position:fixed; bottom:180px; right:25px; _position:absolute;/*兼容IE6的代码*/_bottom:auto;/*兼容IE6的代码*/_top:expression(eval(document.documentElement.scrollTop+document.documentElement.clientHeight-this.offsetHeight-(parseInt(this.currentStyle.marginTop,10)||0)-(parseInt(this.currentStyle.marginBottom,10)||0))); ">
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