<script>
$(document).ready(function(){
	//登录ajax查询该用户购物车共多少件商品
	//$("#cart_goods_top_menu").mouseover(function(){
		$.ajax({
			type:"post",
			url:"/frontGoods/look_goods_cart",
			success:function(data){
				//返回数据有值，则显示上方购物车中商品件数
				if(data.list_cart!=null && data.list_cart.length>0){
					var counts=0;
					$.each(data.list_cart,function(i,cart){
						counts=counts+cart.count;
					});
					$("#cart_goods_count_top").html(counts);
				}
			}	
		});
	//});
	
	
	//鼠标移上，购物车显示
	$("#cart_goods_top_menu").mouseover(function(){
		$.ajax({
			type:"post",
			url:"/frontGoods/look_goods_cart",
			beforeSend:function(){
		    	$("#cart_goods_top_info").empty().html('<div class="menu-bd-panel"><div style="text-align:center;"><img src="/images/loader.gif" /></div></div>');
		    	$("#cart_goods_top_info").show();
			},
			success:function(data){
				if(data.list_cart!=null && data.list_cart.length>0){//返回数据有值，则显示购物车
					$("#cart_goods_top_info").empty();
					var str="";
					var counts=0;
					list_cart=data.list_cart;
					$.each(list_cart,function(i,cart){
						str += "<div class='shopp_ingtop' id='"+cart.id+"'><div class='shopimg'><a href='/frontGoods/goodsDetails?id="+cart.goodsid+"' target='_blank'><img src='"+cart.goods.path+"' width='40' height='40'></a></div><div><span class='shopl'><a href='/frontGoods/goodsDetails?id="+cart.goodsid+"' target='_blank'>"+cart.goods.goodsname+"</a></span><span style='color:#F60; padding-left:15px;'>¥"+cart.goods.sellprice+"×"+cart.count+"</span></div></div>";
						counts=counts+cart.count;
					});
					$("#cart_goods_top_info").html("<div class='menu-bd-panel'><div class='gwc'><h1>购物车商品总价：¥<span id='cart_goods_price_top'>"+data.total_price+"</span></h1>"+str+"<div class='shopbtn'><a href='/frontGoods/mycart'>查看我的购物车</a></div></div></div>");
					//给查看购物车商品件数赋值
					$("#cart_goods_count_top").html(counts);
				}else if(data.list_cart!=null && data.list_cart.length==0){
					$("#cart_goods_top_info").empty();
					$("#cart_goods_top_info").html('<div class="menu-bd-panel"><div style="text-align:center;">购物车暂时为空，赶紧挑选喜欢的商品你吧！！！</div></div>');
				} 
				else{//没有返回数据 ，提示用户登录
					$("#cart_goods_top_info").empty();
					$("#cart_goods_top_info").html('<div class="menu-bd-panel"><div style="text-align:center;">您尚未登录，请登陆后再查看购物车！！！</div></div>');
				}
			}	
		});
	});
	//鼠标移除，购物车隐藏
	$("#cart_menu").mouseleave(function(){
		$("#cart_goods_top_info").hide();
	});
});
</script>


<div class="top" style="">

	<#if sessionUser?exists>
	<div class="pageleft">
		<span>${sessionUser.username}您好,欢迎来到童臻时代！</span>
	  	<a href="/front/index?s=0" class="lightblue">[退出]</a>
	</div>
	<#else>
	<div class="pageleft">
	    <span>亲，欢迎来到童臻时代！</span>
	    <span class="pxlr">
	    	<a href="/front/frlogin" class="lightblue">登录</a>
	    </span>
		<span class="pxlr">或</span>
		<span class="pxlr">
	   		<a href="/front/frzhuce" class="lightblue">注册</a>
		</span>
	</div>
	</#if>

	<div class="top_page">
	  <div class="pageright" id="site-nav">
	    <ul class="quick-menu">
	      <!--订单查看下拉框-->
	      <li class="mytaobao menu-item menupx">
	        <div class="menu"> <a class="menu-hd" href="/order/myorder" rel="nofollow">我的订单<b></b></a>
	          <div class="menu-bd">
	            <div class="menu-bd-panel">
	              <div>
	                <a href="/order/myorder?orderstate=待支付" rel="nofollow">待支付</a>
	          	    <a href="/order/myorder?orderstate=待发货" rel="nofollow">待发货</a>
	          	    <a href="/order/myorder?orderstate=已发货" rel="nofollow">已发货</a>
	          	    <a href="/order/myorder?orderstate=已完成" rel="nofollow">已完成</a>
	              </div>
	            </div>
	          </div>
	        </div>
	      </li>
		  <!--查看购物车-->
	      <li class="search menu-item menupx">
	        <div class="menu" id="cart_menu">
	        	<span class="menu-hd" id="cart_goods_top_menu"><s></s>购物车有<span id="cart_goods_count_top" class="top_car">0</span>件商品<b></b></span>
	        	<div class="menu-bd" id="cart_goods_top_info"></div>
	        </div>
	      </li>
	      <!--后台入口-->
	      <#if sessionUser??>
	      <#if sessionUser.authority == true>
	      <li class="menupx">
	      	<a target="_blank" href="/fronttoback/login">后台入口</a>
	      </li>
	      </#if>
	      </#if>
		  <!--个人中心入口-->
		  <li class="menupx" style="background:none;">
		  	<a href="/person/enterPersonCenter">个人中心</a>
		  </li>
		  
	    </ul>
	  </div>
	</div>
  	
</div>



