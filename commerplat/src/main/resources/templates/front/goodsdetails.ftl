<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品详细页</title>
<link href="/css/public.css" type="text/css" rel="stylesheet">
<link href="/css/default.css" type="text/css" rel="stylesheet">
<link href="/css/overlay.css" type="text/css" rel="stylesheet">
<link href="/css/jquery.jqzoom.css" type="text/css" rel="stylesheet">
<link href="/css/bdsstyle.css" rel="stylesheet" type="text/css">
<link href="/css/goods.css" type="text/css" rel="stylesheet">
<script src="/js/logger.js"></script>
<script src="/js/jquery-1.6.2.js"></script>
<script src="/js/jquery-ui-1.8.21.js"></script>
<script src="/js/jquery.shop.common.js"></script>
<script src="/js/jquery.validate.min.js"></script>
<script src="/js/jquery.jqzoom-core.js"></script>
<script src="/js/jquery.lazyload.js"></script>
<script>
function img_switch(obj){
  $(".photoimgul li").removeClass("this");
  $(obj.parentNode.parentNode).addClass("this");
  var src=$(obj).attr("big_img");
  $("#main_img").attr("src",src);
}

  var goods_inventory=${goods.inventory?c};
  var goods_price=${goods.sellprice?c};
$(document).ready(function(){
   	$('.jqzoom').jqzoom({
            zoomType: 'standard',
			zoomWidth:480,
			zoomHeight:300,
            lens:true,
            preloadImages: false,
            alwaysOn:false,
			title:true,
			preloadText:'努力加载'
        });
//初始化数据
  var data='[]';
  if(data!=""){
    var properties=eval("("+data+")");
    $.each(properties,function(index,item){
        $(".goodsintro").append("<span>"+item.name+":"+item.val+"</span>");
    });
  }
//
$(".selled li").click(function(){
   $(".selled li").each(function(){
	   var id=$(this).attr("id")+"_tab";
	   $(this).removeClass("this");
    });
    $(this).addClass("this");
	var uri=$(this).attr("uri");
	$(".selleddetails").empty();
	$(".img_center_load").show();
	$.post(uri,"",function(data){
	    $(".img_center_load").hide();						
        $(".selleddetails").append(data);
	 },"text");
    	
}).mouseover(function(){
  $(this).css("cursor","pointer");	
});

//键入购买数量判断是否超过库存
$("input[id^=goods_count]").keyup(function(){
	var goods_count=$(this).val();
	var goods_count=$("#goods_count").val().replace(/\D/g,'');
	if(goods_count > goods_inventory){
		alert("超出库存数量，请重新输入购买数量");
		$(this).val(goods_inventory);
	}else{
		$(this).val(goods_count);
	}
});
  //
  $(".twocoad").css("cursor","pointer").mouseover(function(){
     $(".shop_botmhbox").fadeIn('fast'); 
  }).mouseleave(function(){
     $(".shop_botmhbox").fadeOut('fast'); 
  });
  $(".shop_report").css("cursor","pointer").mouseover(function(){
     $(".shop_reul").fadeIn("normal");
	 $(".shop_rep_top").hide();
	 $(".shop_rep_botm").show();
  }).mouseleave(function(){
     $(".shop_reul").fadeOut("normal");
	 $(".shop_rep_top").show();
	 $(".shop_rep_botm").hide();
  });;
//
var switch_loaded = true;
var goods_tab_loaded=true;
var switch_top = $("#switch_bar").offset().top;
var goods_tab_top = $("#goods_tab").offset().top;
var switch_left = $("#switch_bar").offset().left;

$(window).scroll(function(){
  var scrolla=$(window).scrollTop();
  var switch_cha=parseInt(switch_top)-parseInt(scrolla);
  if(switch_loaded && switch_cha<=30){
   $("#switch_bar").removeClass("switch_bar").css({"position":"fixed","top":"30px","z-index":"100"});	  
   switch_loaded=false;
  }
  if(!switch_loaded && switch_cha>30){
   switch_loaded=true;
   $("#switch_bar").removeClass().addClass("switch_bar").css({"position":"absolute","top":"30px","z-index":"100"});
  }
  var goods_tab_cha=parseInt(goods_tab_top)-parseInt(scrolla);
  if(goods_tab_loaded && goods_tab_cha<=0){
   $("#goods_tab").css({"position":"fixed","top":"0px","background":"#fff","border-bottom":"#ccc solid 1px","overflow":"hidden"});
   $(".selled_kf").show();
   goods_tab_loaded=false;
  }
  if(!goods_tab_loaded && goods_tab_cha>0){
   goods_tab_loaded=true;
   $(".selled_kf").hide();
   $("#goods_tab").css({"position":"relative","border-bottom":"none","overflow":"visible"});
  }
});
//
$(".sbar_close").attr("cursor","pointer").click(function(){
  $(".shopindex_left").fadeOut("normal");
  $(".sbar_open").show();
  $(".sbar_close").hide();
  $(".shopindex_right").css({"width":"100%"});
  $(".regoods").css("width","100%");
  $(".regoods h1").css("width","100%");
  $(".regoods .smallgoods").css("width","100%");
  $(".regoods .smallgoods ul").css("margin-right","40px");
});
$(".sbar_open").attr("cursor","pointer").click(function(){
  $(".shopindex_left").fadeIn("normal");
  $(".sbar_close").show();
  $(".sbar_open").hide();
  $(".shopindex_right").css("width","797px");
  $(".regoods h1").css("width","797px");
  $(".regoods .smallgoods").css("width","797px");
  $(".regoods .smallgoods ul").css("margin-right","4px");
});
$(".smallgoods .goodsimgs img").lazyload({effect:"fadeIn",width:178,height:170});
//
$(".log_d>a").click(function(){
   $(this).parent().parent().find(".goods_ct").show();
});
//
$(".h3_r>a").click(function(){
   $(".Cities").hide();									 
   $(this).parent().parent().parent().hide();
});
//
$(".item a").click(function(){
   $(".Cities").hide();								 
   $(this).parent().find(".Cities").show();
});
//
$(".Cities>ul>li>a").click(function(){
  var city_name=$(this).attr("city_name");	
  $.ajax({type:'POST',url:'http://aishang2018.vicp.io:11585/shopping/trans_fee.htm',dataType:'json',data:{"city_name":city_name,"goods_id":"98791"},
    beforeSend:function(){
        $("#current_city_info").html('<img style="padding-top:3px;" src="http://aishang2018.vicp.io:11585/shopping/resources/style/common/images/wait.gif" width="14" height="14" />');
        $("#goods_mail_fee").html('<img style="padding-top:3px;" src="http://aishang2018.vicp.io:11585/shopping/resources/style/common/images/wait.gif" width="14" height="14" />');
        $("#goods_express_fee").html('<img style="padding-top:3px;" src="http://aishang2018.vicp.io:11585/shopping/resources/style/common/images/wait.gif" width="14" height="14" />');
        $("#goods_ems_fee").html('<img style="padding-top:3px;" src="http://aishang2018.vicp.io:11585/shopping/resources/style/common/images/wait.gif" width="14" height="14" />');				
    },
    success:function(json){
        $("#current_city_info").html(json.current_city_info);
        $("#goods_mail_fee").html('¥'+json.mail_fee);
        $("#goods_express_fee").html('¥'+json.express_fee);
        $("#goods_ems_fee").html('¥'+json.ems_fee);
     }
    });
  $(".Cities").hide();	
  $(".goods_ct").hide();
});
//
$("#goods_spec_info_close>a").click(function(){
   $("#goods_spec_info").removeClass().addClass("detailsbottom");  
   $("#goods_spec_info_close").hide();
   $("#goods_spec_chose").hide();
});
//
$(".enjoy_btn").mouseover(function(){
   $(".enjoy_box").show();
 }).mouseleave(function(){
   $(".enjoy_box").hide();
 });
//
});
var time=0;
var time_id;
//添加至购物车
function add_cart(){
	var userid="${userid?default('')}";
	if(userid==""){
		window.location.href="/front/frlogin?goodsid=${goods.id}";
	}else{
				var store_price = $("#store_price").html();
				var goodsid = $("#goods_goodsname").attr("goodsid");
			  var add=true
			  var specvids="";
			  if($(".colordate").length==0){
			    add=true;
			  }else{
				$(".colordate").each(function(){
				   $.each($(this).find("a[class=this]"),function(){
					  gsp=$(this).attr("specvid")+","+specvids; 
				   });
			       if($(this).find("a[class=this]").length==0) add=false;
				});
			  } 
			  var count=$("#goods_count").val();
			  if(count==0){
			    add=false;
				alert("至少购买一件商品!");
				return;
			  }
			  if(goods_inventory==0){
			    add=false;
				alert("商品库存为0,不能购买!");
				return;
			  }  
			  if(add){
				$.post("/frontGoods/add_goods_cart",{"goodsid":goodsid,"count":count,"price":store_price,"specvids":specvids},function(data){
				     //判断用户是否登陆，如果传回来的参数a存在，则跳出用户登陆的浮窗，否则执行添加购物车操作
					if(data.a=="false"){
						$("#user_login").css("display","block")
					}else{
					 $("#cart_goods_count").html(data.count);
					 $("#cart_goods_totalprice").html(data.total_price);
					 $(".goodscar").fadeIn();
				     time_id=window.setInterval(cart_fadeOut,1000);
					 //更新顶部购物车信息
					 $("#cart_goods_count_top").html(data.count);}
				},"json");
			  }else{
			    $("#goods_spec_info").removeClass().addClass("detailsbottom detailsbottom_hover");  
				$("#goods_spec_info_close").show();
				$("#goods_spec_chose").show();
			  }
	}
 }

function cart_fadeOut(){
  time++;
  if(time==3){
    $(".goodscar").fadeOut();
	time=0;
	window.clearInterval(time_id);
  }
}

function buy_goods(){
	var goodsid = $("#goods_goodsname").attr("goodsid");
	var count=$("#goods_count").val();
	var price=$("#goods_count").val();
    var add=true
  
  if(count==0){
    add=false;
	alert("至少购买一件商品!");
	return;
  }
  if(goods_inventory==0){
    add=false;
	alert("商品库存为0,不能购买!");
	return;
  } 
  
  if(add){
	$.post("/frontCart/rightNowPay",{"id":goodsid,"count":count,"price":store_price},function(data){
	     $("#cart_goods_count").html(data.count);
		 $("#cart_goods_totalprice").html(data.total_price);
		 window.location.href="";
	},"json");
  }else{
	$("#goods_spec_info").removeClass().addClass("detailsbottom detailsbottom_hover");  
	$("#goods_spec_info_close").show();
	$("#goods_spec_chose").show();
  }
 }

</script>

</head>
<body>

<!-- 利用include标签引入网页顶部的登录栏 -->
<#include "/front/top.ftl"/>
<#include "/front/search.ftl"/>




  <script>
$(function($){
    $(".top_shop_seacher input[type=button]").click(function(){
    var search_area=$(this).attr("search_area");
	if(search_area=="site"){
	  $("#store_top_search_form").attr("action","http://aishang2018.vicp.io:11585/shopping/search.htm");
	}
	if(search_area=="store"){
	  $("#store_top_search_form").attr("action","http://aishang2018.vicp.io:11585/shopping/store_goods_search.htm");
	}
	$("#store_top_search_form").submit();
  });
  $(".top_nofilter").mouseover(function(){
	$(".top_b").hide();								
    $(".top_b2").show();  
	$(".top_sear_bom").fadeIn("normal");
  })
  $(".top_search_left").css("cursor","pointer").mouseleave(function(){
	$(".top_b").show();								
    $(".top_b2").hide();
	$(".top_sear_bom").fadeOut("normal");
  });
});
</script>

      
<div class="nav_width">
  <div class="main">
    <div class="nav_bg">
				<div class="shopnav">
		<div class="shopnavul">
		  <ul>
		    <li id="store_index"><a href="/front/index">首页</a></li>
		    <li id="store_goods" class="this"><a href="">商品详情</a></li>
		    <li id="store_credit"> <a href="">商品评价</a></li>
		  </ul>
		</div>
      </div>
    </div>
  </div>
</div>

<div class="main">
  <div class="shop">
    <div class="shop_index">
      
      <div class="productdeta">
        <h1><strong class="tuang_h" id="goods_goodsname" goodsid="${goods.id}">${goods.goodsname}</strong></h1>
        
        <div class="photoproduct">
          <div class="photopro">
          	<a href="${goods.path}" class="jqzoom" rel="gal1" title="" style="outline-style: none; text-decoration: none;">
	          	 <div class="zoomPad">
	          	 <img src="${goods.path}" title="商品细节图" id="main_img" width="300" height="300" style="border: 1px solid rgb(102, 102, 102); opacity: 1;">
	          	 <div class="zoomPup" style="top: 100px; left: 75px; width: 150px; height: 100px; position: absolute; border-width: 1px; display: none;"></div>
	          	 <div class="zoomWindow" style="position: absolute; z-index: 5001; left: 312px; top: 0px; display: none;">
	          	 <div class="zoomWrapper" style="width: 480px;">
	          	 <div class="zoomWrapperTitle" style="width: 100%; position: absolute; display: block;">商品细节图</div>
	          	 <div class="zoomWrapperImage" style="width: 100%; height: 300px;">
	          	 <img src="${goods.path}" style="position: absolute; border: 0px; display: block; left: -159px; top: -136px;">
	          	 </div>
	          	 </div>
	          	 </div>
	          	 <div class="zoomPreload" style="visibility: hidden; top: 129.5px; left: 106px; position: absolute;">努力加载</div>
	          	 </div>
			</a>
            <ul class="photoimgul">
            	<li class="this">
					<a class="" href="javascript:void(0);">
						<img src="${goods.path}" big_img="${goods.path}" id="photossss" width="40" height="40" onclick="img_switch(this);" style="cursor:pointer;">
					</a>
				</li>
				<span id="smallphotos">
            	<#if list_goodsImages??>
            	<#list list_goodsImages as goodsImage>
				<li class="">
					<a class="" href="javascript:void(0);">
						<img src="${goodsImage.path}" big_img="${goodsImage.path}" width="40" height="40" onclick="img_switch(this);" style="cursor:pointer;">
					</a>
				</li>
				</#list>
				</#if>
				</span>
            </ul>
            
            <!--分享-->
            <div class="collection_goods">
				<span>
					<a class="save_good" href="javascript:void(0);" dialog_uri="http://aishang2018.vicp.io:11585/shopping/user_dialog_login.htm" dialog_title="会员登录" dialog_width="450" dialog_height="100" dialog_id="user_login">收藏(0)</a>
				</span>
				<div class="enjoy_btn">
					<a class="enjoy_a" href="javascript:void(0);">分享到：站内/站外</a>
                	<div class="enjoy_box" style="display:none;">
						<span class="enjoy_b">
                  			<input name="goods_share_btn" type="button" id="goods_share_btn" value="分享商品" dialog_uri="http://aishang2018.vicp.io:11585/shopping/user_dialog_login.htm" dialog_title="会员登录" dialog_width="450" dialog_height="100" dialog_id="user_login">
                  		</span>
						<span class="enjoy">
							<div id="bdshare" class="bdshare_t bds_tools get-codes-bdshare">
								<a class="bds_tsina" title="分享到新浪微博" href="http://aishang2018.vicp.io:11585/shopping/goods_98791.htm#"></a>
								<a class="bds_tqq" title="分享到腾讯微博" href="http://aishang2018.vicp.io:11585/shopping/goods_98791.htm#"></a>
								<span class="bds_more">更多</span>
								<a class="shareCount" href="http://aishang2018.vicp.io:11585/shopping/goods_98791.htm#" title="累计分享0次">0</a>
							</div>
							<script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=5015224" src="/js/bds_s_v2.js"></script>
							<script type="text/javascript">
								document.getElementById("bdshell_js").src = "/js/shell_v2.js?cdnversion=" + Math.ceil(new Date()/3600000)
							</script>
						</span>
					</div>
              </div>
            </div>
            
          </div>
          <div class="productshop">
            <div class="detailstop">
              <ul>
                <li><span class="detbt">商品原价：</span><span class="through" id="original_price">￥${goods.originalprice?c}</span></li>
                <li>
                	<span class="detbt">店铺价格：</span><span class="pricedata">￥<strong class="orange" id="store_price">${goods.sellprice?c}</strong></span>
                	<span class="greenp">(节省：<b id="rest" style="font-weight:normal;">￥${goods.originalprice - goods.sellprice}</b>)</span>
                </li>
                <li><span class="detbt">商品重量：</span><span id="weight">${goods.weight?default('')}(千克)</span></li>
                <li> <span class="detbt">物流运费：</span>
                  <div class="logistics"> <span class="start">大连市 | 至</span>
                    <div class="log_ps"> <span class="log_d"><a href="javascript:void(0);"><em id="current_city_info">全国</em><i></i> </a></span>
                      <div class="goods_ct" style="display:none;">
                        <h3><span class="h3_l">选择你的收货城市</span><span class="h3_r"><a href="javascript:void(0);"><img src="/images/14-14.png"></a></span></h3>
                        <p>您当前所在地：全国</p>
                        <div class="Region">
                          <ul>
                              <li class="item"> <a href="javascript:void(0);" area_id="4522510" area_name="辽宁省">辽宁省</a>
                              <div class="Cities" style="display:none;">
                                <ul>
                                   <li><a href="javascript:void(0);" city_id="123" city_name="大连市">大连市</a></li>
                                </ul>
                              </div>
                            </li>
                            <li class="item">
								<a href="javascript:void(0);" area_id="4522512" area_name="3213">3213</a>
								<div class="Cities" style="display:none;"></div>
                            </li>
                            <li class="item">
                            	<a href="javascript:void(0);" area_id="4522514" area_name=""></a>
                              	<div class="Cities" style="display:none;"></div>
                            </li>
                          </ul>
                        </div>
                      </div>
                    </div>
                    <!--物流运费新增start-->
                     <span class="detbt"></span><span>卖家承担</span>                   </div>
                </li>
                                <!--物流运费新增end-->
                <li><span class="detbt">销售情况：</span><span>售出0件(0条评论)</span></li>
                <li><span class="detbt">关注次数：</span><span>48次</span></li>
              </ul>
            </div>
            <script>
              //商品规格切换
			  function goods_spec_set(obj){
				var goodsnumber=${goods.goodsnumber};
				var specid = $(obj).attr("specid");
				var specvids="";
				var load=true;
				$(".colordate a[specid="+specid+"]").removeClass();
			    $(obj).addClass("this");
				$(".colordate").each(function(){
                    $.each($(this).find("a[class=this]"),function(){
                    	specvids=$(this).attr("specvid")+","+specvids; 
					});
	            });
				$(".colordate").each(function(){
                     if($(this).find("a[class=this]").length==0) load=false;
	             });
			  if(load){
				$("#goods_spec_info").removeClass().addClass("detailsbottom");  
	            $("#goods_spec_info_close").hide();    
				$("#goods_spec_chose").hide();
				$.post("/frontGoods/ajax_goodsupdate",{"goodsnumber":goodsnumber,"specvids":specvids},function(data){
				   if(data!=null){
					   goods_inventory = data.goodsSpec.goods.inventory;
					   $("#goods_inventory").html(goods_inventory);
					   store_price = data.goodsSpec.goods.sellprice;
					   $("#store_price").html(store_price);
					   original_price = data.goodsSpec.goods.originalprice;
					   $("#original_price").html("¥"+original_price);
					   goods_goodsname = data.goodsSpec.goods.goodsname;
					   $("#goods_goodsname").html(goods_goodsname);
					   $("#goods_goodsname").attr("goodsid",data.goodsSpec.goods.id);
					   $("#rest").html("¥"+ (original_price-store_price));
					   $("#weight").html(data.goodsSpec.goods.weight+"(千克)");
					   $("#main_img").attr("src",data.goodsSpec.goods.path);
					   $("#photossss").attr("src",data.goodsSpec.goods.path);
					   $("#photossss").attr("big_img",data.goodsSpec.goods.path);
					   
					   var str="";
					   list_goodsImages=data.list_images;
					    $.each(list_goodsImages,function(i,goodsImages){
					        str += "<li class=''><a class='' href='javascript:void(0);'><img src='"+goodsImages.path+"' big_img='"+goodsImages.path+"' width='40' height='40' onclick='img_switch(this);' style='cursor:pointer;'></a></li>";
					    });
					   $("#smallphotos").empty();
					   $("#smallphotos").append(str);
					   $("#details_tab").empty();
					   $("#details_tab").append(data.goodsSpec.goods.details);
					   
					   //修改浏览器地址栏地址
					   var stateObject = {};
						var title = "";
						var newUrl = "/frontGoods/goodsDetails?id="+data.goodsSpec.goods.id+"";
						history.pushState(stateObject,title,newUrl);
					}else{
						alert("当前规格下无商品！！！");
				    }
				  },"json");
			    }
			  }
			  </script>
            <div class="detail_solid"></div>
            <div class="detailsbottom_ps">
              <div class="detailsbottom" id="goods_spec_info">
                <ul>
					<li id="goods_spec_chose" class="detail_chose" style="display:none;">请选择商品属性</li>
					<li class="colordate">
						<#if list_spec??>
						<#list list_spec as spec>
						<span class="datespan">${spec.specname}:</span>
						<span class="chosecolor">
							<#if spec.list_specv??>
							<#list spec.list_specv as specv>
								<#assign flag = false >
								<#list list_goods_spec as goodsspec>
									<#if goodsspec.specvid == specv.id>
										<#assign flag = true >
									</#if>
								</#list>
									<#if flag>
										<b>
											<a href="javascript:void(0);" class="this" onclick="goods_spec_set(this);" specid="${spec.id}" specvid="${specv.id}">${specv.specvname}</a>
										</b>
									<#else>
										<b>
											<a href="javascript:void(0);" onclick="goods_spec_set(this);" specid="${spec.id}" specvid="${specv.id}">${specv.specvname}</a>
										</b>
									</#if>                                                                                                       
							</#list>
							</#if>
						</span>
						</#list>
						</#if>
					</li>
 
                                    
                  <li class="stockdate">
	                  <span class="datespan">数量：</span>
	                  <span class="stock">
	                    <input name="goods_count" type="text" id="goods_count" value="1" onkeyup="this.value=this.value.replace(/\D/g,&#39;&#39;)" onafterpaste="this.value=this.value.replace(/\D/g,&#39;&#39;)">
	                  </span>
	                  <span class="stockparts">件(库存<b id="goods_inventory" style="font-weight:normal;">${goods.inventory?default('')}</b>件)</span>
                  </li>
                  <li>
					<span class="datespan">&nbsp;</span>
					<span class="addcar">
                    	<input name="input" type="button" value="添加到购物车" onclick="add_cart();">
                    </span>
                    <!-- <span class="atonce">
                    	<input name="input" type="button" value="立刻购买" onclick="buy_goods();">
                    </span> -->
                    <div class="goodscar" style="display:none;z-index:999;">
                      <div>
	                      <a href="javascript:void(0);" onclick="javascript:$('.goodscar').hide();" class="closed">
	                     	 <img src="/images/closed.jpg" width="12" height="12">
	                      </a>
                      </div>
                      <ul>
                        <li>已成功添加到购物车！</li>
                      </ul>
                    </div>
                  </li>
                </ul>
              </div>
             
            </div>
          
           
           
          </div>
        </div>
      </div>
    </div>
    <div class="shop_index_box"> <script>
$(function($){
  $(".collection a").click(function(){
      });
  //
  $("span[id^=ugc_]").css("cursor","pointer").click(function(){
     var ugc_type=$(this).attr("ugc_type");
	 var ugc_id=$(this).attr("ugc_id");
	 if(ugc_type=="show"){
	    $(this).find("img").attr("src","http://aishang2018.vicp.io:11585/shopping/resources/style/shop/default/images/add.jpg");
		$("#ugc_child_"+ugc_id).hide();
	    $(this).attr("ugc_type","hide");
	 }else{
	    $(this).find("img").attr("src","http://aishang2018.vicp.io:11585/shopping/resources/style/shop/default/images/add2.jpg");
		$("#ugc_child_"+ugc_id).show();
	    $(this).attr("ugc_type","show");
	 }
  });
  //
});
</script>

<div class="shopindex_left" style="display: none;">
  <div class="shopclassify">
    <h1>商品分类</h1>
    <ul class="shopcul">
      <li><span><img src="/images/add2.jpg" width="15" height="15"></span><a href="http://aishang2018.vicp.io:11585/shopping/goods_list.htm?store_id=32856" class="oneclass">所有商品</a> </li>
          </ul>
  </div>
    <form action="http://aishang2018.vicp.io:11585/shopping/store_goods_search.htm" method="post" id="store_search_form">
    <div class="shopsearch">
      <ul>
        <li><span class="searspan">关键字：</span><span class="shopsear1">
          <input name="keyword" type="text" id="keyword">
          </span></li>
        <li><span class="searspan">&nbsp;</span><span class="searbtns">
          <input name="input2" type="submit" value="搜索" style="cursor:pointer;">
          </span>
          <input name="store_id" type="hidden" id="store_id" value="32856">
        </li>
      </ul>
    </div>
  </form>
  <div class="shopf">
    <h1>友情链接</h1>
    <ul>
          </ul>
  </div>
</div>

      <div class="shopindex_right" style="width: 100%;">
        <div class="switch_bar" id="switch_bar" style="position: absolute; top: 30px; z-index: 100;">
	        <span class="sbar_open" style="" cursor="pointer"><a class="sbar_open_btn" href="javascript:void(0);"></a></span>
	        <span class="sbar_close" cursor="pointer" style="display: none;"><a class="sbar_close_btn" href="javascript:void(0);"></a></span>
        </div>
        <div class="shopselled" id="goods_anchor" name="goods_anchor">
          <div class="selled" id="goods_tab" style="position: relative; top: 0px; background: rgb(255, 255, 255); border-bottom: none; overflow: visible;">
            <ul class="selled_ul">
              <li id="details" class="this"><a href="">商品详情</a></li>
              <li id="evaluation">			<a href="">商品评价</a></li>
              <li id="strike">				<a href="">成交记录</a></li>
            </ul>
          </div>
          <div class="img_center_load" style="display:none;text-align:center; padding-top:5px;">
			<img height="28" width="28" src="/images/loader(1).gif">
		  </div>
          <div class="selleddetails">
            <!--商品详情-->
            <div class="goodsdetails" id="details_tab">
              ${goods.details?default('')}
            </div>
          </div>
        </div>
        

      </div>
    </div>
  </div>
 

<%-- <a href="javascript:void(0);" dialog_uri="/frontGoods/detailUserLogin?goodsid=${goods.id}" dialog_title="用户登录" dialog_width="355" dialog_height="88" dialog_id="detail_user_login" id="detail_user_login" class="button_common" style="display:none">登录</a> --%>

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
		<a id="toTop" href="/front/index" bosszone="hometop" style="display: block;" onclick="window.scrollTo(0,0);return false" title="返回顶部" target="_self"></a>
	</div>
</div> 

</body>
</html>