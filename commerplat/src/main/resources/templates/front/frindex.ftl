<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>前台首页</title>

<link href="/css/public.css" type="text/css" rel="stylesheet">
<link href="/css/public_auto.css" type="text/css" rel="stylesheet">
<link href="/css/index.css" type="text/css" rel="stylesheet">
<script src="/js/jquery-1.6.2.js"></script>
<script src="/js/DataLazyLoad.min.js"></script>
<script src="/js/jquery.lazyload.js"></script>
<script src="/js/jquery.SuperSlide.2.1.1.js"></script>
<script src="/js/jquery.shop.common.js"></script>
<script src="/js/jquery.validate.min.js"></script>
<script src="/js/jquery-ui-1.8.21.js"></script>
<script src="/js/jquery.shop.validate.js"></script>
<script src="/js/jquery.KinSlideshow.min.js"></script>
<script src="/htm/advert_invoke(2).htm"></script>
<!-- <script src="/htm/advert_invoke.htm"></script> -->
<script>
$(document).ready(function(){
	
  $(".sale_two_img img").lazyload({effect:"fadeIn",width:150,height:150});
  
  //鼠标经过推荐商品tab
  $("#index_sale_tab ul li").mouseover(function(){	
	$(this).siblings().removeClass("this");
	$(this).addClass("this");
	var i = $(this).index();
	$("#index_sale_tab").siblings().hide();
	$("#index_sale_tab").siblings().eq(i).show();
	$("#sale_change").attr("mark",$(this).attr("id").replace("goodscase",""));	
  });
  
	//首页搜索栏背景图片定时切换效果
	$('.top_mid_slide').slide({
		mainCell:'.top_mid_slider_ul',
		titCell:'.banner_top li',
		titOnClassName:'this',
		trigger:'mouseover',
		autoPlay:true
	});
  	
 	$("div[name=floor_floor_goods_0]").show();
	//鼠标经过楼层tab时
	$(".floorul li").mouseover(function(){
		var store_gc=$(this).attr("store_gc");
	    $(".floorul li[store_gc="+store_gc+"]").css("cursor","pointer").removeClass("this");
		$(this).addClass("this");
	    var id=$(this).attr("id");
		$(".ftab[store_gc="+store_gc+"]").hide();
		$(".ftab[store_gc="+store_gc+"][id="+id+"]").show();
	});
 
  //团购图片轮播懒加载
  $(".goods_tab img").lazyload({effect:"fadeIn",width:210,height:210});
  //楼层懒加载
  $(".floor_main img").lazyload({effect:"fadeIn",width:147,height:147});
  
 
 $(".index_sales_left>h3>ul>li").mouseover(function(){
    $(".index_sales_left>h3>ul>li").removeClass("this");
	$(this).addClass("this");
	$(".index_sales_box>[class^=index_sales_]").hide();
	var div_index=$(this).attr("div_index");
	$(".index_sales_"+div_index).show();
 });

  //
  var size="6";
  if(size>0){
  	  $("html").scrollTop(0);	//刷新页面返回顶部	
	  //Call DataLazyLoad
	  $("#floors .floor_main").DataLazyLoad({load : function(page, unLocked) {
		var html = '';
		var max = 6+1;
		var count = page-1;
		var id =$(".floor_main[count="+count+"]").attr("id");
		var load_url =$(".floor_main[count="+count+"]").attr("load_url");
		//Generate the data
		$.get("http://aishang2018.vicp.io:11585/shopping/"+load_url,{"id":id,"count":count},function(data){
					html += data;
					$(html).appendTo('#floors .floor_main[count='+count+']');
					$(".floorclass img").lazyload({effect:"fadeIn",width:147,height:147});
					$(".ranking img").lazyload({effect:"fadeIn",width:73,height:73});
					//鼠标经过楼层tab时
					$(".floorul li").mouseover(function(){
						var store_gc=$(this).attr("store_gc");
					    $(".floorul li[store_gc="+store_gc+"]").css("cursor","pointer").removeClass("this");
						$(this).addClass("this");
					    var id=$(this).attr("id");
						$(".ftab[store_gc="+store_gc+"]").hide();
						$(".ftab[store_gc="+store_gc+"][id="+id+"]").show();
					});
					//Check whether to end
					page = page >= max ? 0 : page + 1;
					//To prevent repeated load, The first parameter to the next page, No page is 0
					unLocked(page);
			},"text");
	  }});
  }else{
	//$("#toolbar").load("toolbar.htm");	 
  }
  
  $(window).scroll(function(){
	var top = $(document).scrollTop();
	//楼层导航跟随
	$(".back_floor").css("display","none");
	$("li[floor_id^=floor_] b").css("display","block");
	$("div[id^=floor_]").each(function(){//循环每一个楼层
	    var floor_top=$(this).offset().top-top;
		 if(floor_top<=580&&floor_top>=0){//如果到达一个位置
			  var floor_id=$(this).attr("id");
			  if($("li[floor_id="+floor_id+"] b").css("display","none"))
			  {
				$(".back_floor").css("display","block");  
			  }
	 }
	});
  });	
  
  //back_floor
  $(".back_floor>ul>li").click(function(){
  	 var id=$(this).attr("floor_id");
     var top = $("#"+id).offset().top-80;
     $('body,html').animate({scrollTop:top},1000);
  });
  
  var l=$(".main").offset().left;
  $(".back_box_x").css("left",l-43+"px");
  
});

$(window).resize(function() {
   var l=$(".main").offset().left;
   $(".back_box_x").css("left",l-43+"px");
});


$(document).ready(function(){
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

  $(".two_code_a").click(function(){
	  $(this).parent().remove();
	  });
	
});
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

$(document).ready(function(){
   //
  $(".left_menu_dl").live("mouseover",function(){
    var sc_id=$(this).attr("id");
	var sc_color=$(this).attr("sc_color");
	var child_count = $(this).attr("child_count");
	var eq =$(this).index();
	
	if(child_count>0){
	  $("#dts_"+sc_id).addClass("left_menu_this").removeClass("left_menu_dt");
	  $("#child_"+sc_id).show();			
	}
	$("#left_menu_con_"+sc_id).attr("style","border:1px solid "+sc_color+"; border-left:1px solid "+sc_color+";").find(".menu_con_right_top").css("background-color",sc_color);
    var z = -35;
   	var x = eq*z;
    $("#left_menu_con_"+sc_id).css('margin-top',x+'px');
	$(".left_menu_dd[id=child_"+sc_id+"]").show();
	
  }).live("mouseleave",function(){
      $("dt[id^=dts_]").removeAttr("style");
	  $("div[id^=left_menu_con_]").removeAttr("style"); 
	  var child_count = $(this).attr("child_count");
	  $("dt[id^=dts_]").removeClass("left_menu_this").addClass("left_menu_dt");	  
	  $(".left_menu_dd[id^=child_]").hide();
  }); 
  //
});


$(function(){ 
	$(".top_mid_nav div").css("cursor","pointer").mouseover(function(){
		var target_tab_id=$(this).attr("target_tab_id");
		$(".top_mid_nav div").removeClass("this");
		$(this).addClass("this");
		$("#news_tab").hide();
		$("#group_tab").hide();
		$("#"+target_tab_id).show();
	});
	//
	$(".group_tab").slide({mainCell:".top_regiment ul",autoPlay:true,interTime:3000,prevCell:".top_mid_regiment_img_left",nextCell:".top_mid_regiment_img_right"});
	$(".goods_tab").slide({mainCell:".top_regiment ul",autoPlay:true,interTime:3000,prevCell:".top_mid_regiment_img_left",nextCell:".top_mid_regiment_img_right"});
	//
	$(".top_regiment").mouseenter(function(){
		$(".top_mid_regiment_img_left").show();
		$(".top_mid_regiment_img_right").show();
	}).mouseleave(function(){
		$(".top_mid_regiment_img_left").hide();
		$(".top_mid_regiment_img_right").hide();
	});
});



$(document).ready(function(){
	$(window).scroll(function(){
		var top = $(document).scrollTop();
		if(top==0){
			$("#back_box").hide();
			$(".back_box_x").hide();
		}else{
			$("#back_box").show();
			$(".back_box_x").show();
		}
	});	
	$("#toTop").click(function(){
		$('body,html').animate({scrollTop:0},1000);
		return false;
	});
});


</script>
</head>
<body>

<!-- 利用include标签引入网页顶部的登录栏 -->
<#include "/front/top.ftl"/>

<!-- 利用include标签引入网页顶部的搜索 -->
<#include "/front/search.ftl"/>


<div class="nav">
	<div class="nav_topp"></div>
    <div class="nav_left">
		<h2><span>全部分类<em><img src="/images/nav_left.png"></em></span></h2>
		<#if list_classes ??>
		<#list list_classes as classes1>
		<dl sc_color="#E60012"  id="${classes1.id}" child_count="5" class="left_menu_dl">
			<dt id="dts_15" class="left_menu_dt">
				<i class="left_menu_i">
					<img width="16" height="16" src="/images/65bc353f-9c86-46f2-8daa-f21adec4b772.png">
				</i> 
				<strong class="left_menu_str"> 
					<a href="/search/dotopsearch?classesid=${classes1.id}">${classes1.classname}</a>
				</strong>
			</dt>
			<dd id="child_${classes1.id}" style="display: none;" class="left_menu_dd">
				<div id="left_menu_con_15" class="left_menu_con this ">
					<span class="left_menu_sp">
						<div class="left_menu_con_center">
							<div class="menu_con_right_top" style="background-color: rgba(39, 174, 162, 0.83);">
								<dl>
									<dt>
										<#if classes1.list_sonclasses ??>
										<#list classes1.list_sonclasses as classes2>
										<span>
											<a href="/search/dotopsearch?classesid=${classes2.id}" target="_blank">${classes2.classname}</a>
										</span> 
										</#list>
										</#if>
									</dt>
								</dl>
							</div>
							<div class="left_menu_con_center_left">
								<#if classes1.list_sonclasses ??>
								<#list classes1.list_sonclasses as classes2>
								<dl>
									<dt>
										<b> &gt; </b>
										<a href="/search/dotopsearch?classesid=${classes2.id}" target="_blank">${classes2.classname}</a>
									</dt>
									<dd>
										<#if classes2.list_sonclasses ??>
										<#list classes2.list_sonclasses as classes3>
										<a href="/search/dotopsearch?classesid=${classes3.id}" target="_blank">${classes3.classname}</a>
										</#list>
										</#if>
									</dd>
								</dl>
								</#list>
								</#if>
							</div>
					</div>
				</span>
			</div>
		</dl>
		</#list>
		</#if>
	</div>
</div>


	<!-- 首页大广告轮播 -->
	<div class="top_mid_slide">
		<ul class="top_mid_slider_ul">
			<#if list_BigAd??>
			<#list list_BigAd as ad>
			<li class="top_mid_slider_ul_li">
				<a href=""><img src="${ad.path}" height="490px" width="1200px"></a>
			</li>
			</#list>
			</#if>
		</ul>
		<div class="banner_top">
			<ul>
			<#if list_BigAd??>
			<#list list_BigAd as ad>
				<li style="cursor:pointer;"></li>
			</#list>
			</#if>	
			</ul>
		</div>
	</div>

<div class="main">		
	<!-- 这是一条线  -->
	<div class="title_news"></div>
	
	<!-- tab页商品 -->
	<div class="index_center_box">
		<div class="index_sale">
		
			<div id="index_sale_tab" class="index_sale_tab">
				<ul>
					<li goods_random="1" id="goodscase1" class="this">人气商品<s></s></li>
					<li goods_random="1" id="goodscase2" class="">推荐商品<s></s></li>
					<li goods_random="1" id="goodscase3" class="">新品上架 <s></s></li>
				</ul>
			</div>

			<!--人气商品-->
			<div id="index_sale_box_1" class="index_sale_box" style="display: block;">         
				<div id="index_sale_con_1" class="index_sale_con">
					<#if list_inventoryGoods??>
					<#list list_inventoryGoods as inventoryGoods>
					<ul class="index_sale_two">
						<li class="sale_two_img"><a target="_blank" href="/frontGoods/goodsDetails?id=${inventoryGoods.id}"> 
							<span class="img_cspan"><p>
								<img width="150" height="150" src="${inventoryGoods.path?default('')}" onerror="javascript:this.src='images/good.jpg';this.onerror = null" style="display: inline;">
							</p></span>
						</a></li>
						<li class="sale_two_name"><a target="_blank" href="/frontGoods/goodsDetails?id=${inventoryGoods.id}">${inventoryGoods.goodsname}</a></li>
						<li class="sale_two_price">售价：<strong>¥${inventoryGoods.sellprice}</strong></li>
					</ul>
					</#list>
					</#if>
				</div>
			</div>

			<!--推荐商品-->	
			<div id="index_sale_box_2" class="index_sale_box" style="display: none;">         
				<div id="index_sale_con_2" class="index_sale_con">
					<#if list_recommendGoods??>
					<#list list_recommendGoods as recommendGoods>
					<ul class="index_sale_two">
						<li class="sale_two_img"><a target="_blank" href="/frontGoods/goodsDetails?id=${recommendGoods.id}"> 
							<span class="img_cspan"><p>
								<img width="150" height="150" src="${recommendGoods.path}" onerror="javascript:this.src='images/good.jpg';this.onerror = null" style="display: inline;">
							</p></span>
						</a></li>
						<li class="sale_two_name"><a target="_blank" href="/frontGoods/goodsDetails?id=${recommendGoods.id}">${recommendGoods.goodsname}</a></li>
						<li class="sale_two_price">售价：<strong>¥${recommendGoods.sellprice}</strong></li>
					</ul>
					</#list>
					</#if>
				</div>
			</div>
			
			<!--新品上架-->
			<div id="index_sale_box_3" class="index_sale_box" style="display: none;">         
				<div id="index_sale_con_3" class="index_sale_con">  
					<#if list_newGoods??>
					<#list list_newGoods as newGoods>
					<ul class="index_sale_two">
						<li class="sale_two_img"><a target="_blank" href="/frontGoods/goodsDetails?id=${newGoods.id}"> 
							<span class="img_cspan"><p>
								<img width="150" height="150" src="${newGoods.path?default('')}" onerror="javascript:this.src='images/good.jpg';this.onerror = null" style="display: inline;">
							</p></span>
						</a></li>
						<li class="sale_two_name"><a target="_blank" href="/frontGoods/goodsDetails?id=${newGoods.id}">${newGoods.goodsname}</a></li>
						<li class="sale_two_price">售价：<strong>¥${newGoods.sellprice}</strong></li>
					</ul>
					</#list>
					</#if>
				</div>
			</div>

		</div>
		
		<!--品牌推荐-->
		<div class="index_brand_right">
			<div class="brand">
				<h3><span><a href="/brand/showBrand">更多</a></span>推荐品牌</h3>
				<ul>
				<#if list_recommendBrand ??>
				<#list list_recommendBrand as brand>
					<li>
						<img width="142" height="89" src="${brand.path}"/>
						<a href="/search/dotopsearch?brand_ids=${brand.id}" target="_blank">${brand.brandname}</a>
					</li>
				</#list>
				</#if>
				</ul>
			</div>
		</div>

<!-- 楼层 -->
<div id="floors">
	<#if list_floor ??>
	<#list list_floor as floor1>
	<div load_url="floor_ajax.htm" id="${floor1.id}" count="${floor1_index+1}" class="floor_main">
	<div class="floor floor_orange">
	<div class="floor_box" id="floor_${floor1_index+1}">
	
	<div class="floor_menu">
		<div class="title">
			<div class="txt-type">
				<span>${floor1_index+1}</span>
				<h2 title="${floor1.floorname}">${floor1.floorname}</h2>
			</div>
		</div>
		<div class="flr_m_details">
			<ul class="flr_m_du">
				<#if floor1.list_classes ??>
				<#list floor1.list_classes as classes1>
				<#if classes1.pid == 0>
				<li>
					<h4><a href="/search/dotopsearch?classesid=${classes1.id}">${classes1.classname}</a></h4>
					<p>
						<#if classes1.list_sonclasses ??>
						<#list classes1.list_sonclasses as classes2>
						<#if classes2.pid == classes1.id>
						<span><a href="/search/dotopsearch?classesid=${classes2.id}" target="_blank">${classes2.classname}</a></span>
						</#if>
						</#list>
						</#if>
					</p>
				</li>
				</#if>
				</#list>
				</#if>
			</li>
			</ul>
		</div>
	</div>
	
	<div class="floorclass">
		<ul class="floorul">
			<#if floor1.list_floor ??>
			<#list floor1.list_floor as floor2>
				<#if floor2_index == 0>
					<li class="this" style="cursor:pointer;" id="${floor2.id}" store_gc="${floor1.id}">${floor2.floorname}<s></s></li>
				<#else>
					<li style="cursor:pointer;" id="${floor2.id}" store_gc="${floor1.id}">${floor2.floorname}<s></s></li>
				</#if>
			</#list>
			</#if>
		</ul>
		
		
		<#if floor1.list_floor ??>
		<#list floor1.list_floor as floor2>
		<div id="${floor2.id}" store_gc="${floor1.id}" name="floor_floor_goods_${floor2_index}" class="ftab" style="display: none;">
			<div class="ftabone">
			<div class="classpro">
			
			<#if floor2.list_goods ??>
			<#list floor2.list_goods as goods2>
			<div class="productone">
				<ul class="this">
					<li>
						<span class="center_span"><p>
						<a href="/frontGoods/goodsDetails?id=${goods2.id}" target="_blank">
						<img src="${goods2.path}" original="${goods2.path}" onerror="this.src='/images/good.jpg';" width="147" height="147" style="display: inline;">
						</a>
						</p></span>
					</li>
					<li class="pronames"><a href="/frontGoods/goodsDetails?id=${goods2.id}" target="_blank">${goods2.goodsname}</a></li>
					<li><span class="hui2">市场价：</span><span class="through hui">¥${goods2.originalprice?c}</span></li>
					<li><span class="hui2">商城价：</span><strong class="red">¥${goods2.sellprice?c}</strong></li>
				</ul>
			</div>
			</#list>
			</#if>
			
			</div>
			</div>
		</div>
		</#list>
		</#if>
	</div>
	
	
	<div class="ranking">
		<h1>商品排行</h1>
		<#if floor1.list_goods ??>
		<#list floor1.list_goods as goods1>
		<ul class="rankul">
			<li class="rankimg">
				<a href="/frontGoods/goodsDetails?id=${goods1.id}" target="_blank">
				<img src="${goods1.path}" onerror="this.src='/images/good.jpg';" width="73" height="73" style="display: inline;">
				</a>
				<span class="rankno1"></span>
			</li>
			<li class="rankhui"><strong><a href="/frontGoods/goodsDetails?id=${goods1.id}" target="_blank">${goods1.goodsname}</a></strong></li>
			<li class="rankmoney">¥${goods1.sellprice?c}</li>
		</ul>
		</#list>
		</#if>
	</div>
	
	
	
	</div>
	
	</div>
	</div>
	
	</#list>
	</#if>
</div>


		<div class="friendlink">
			<h1>合作伙伴</h1>
			<ul class="linkimg">
				<li>
					<a href="http://www.dltzsd.com/index.htm" target="_blank">
						<img src="/images/hezuohuoban.jpg" width="92" height="35">
					</a>
				</li>
			</ul>
		</div>

	</div>

<!--网页底部-->
<#include "/front/foot.ftl"/>
	
	
<!--返回最顶部-->
<div class="back_box" style="width: 50px; height: 50px; position: fixed; bottom: 180px; right: 25px;">
	<div class="back_index">
		<a href="/front/index" target="_blank" title="返回主页"></a>
	</div>
	<div class="back_top">
		<a id="toTop" href="/front/index" bosszone="hometop" style="display: block;" onclick="window.scrollTo(0,0);return false" title="返回顶部" target="_self"></a>
	</div>
</div> 


</body>
</html>