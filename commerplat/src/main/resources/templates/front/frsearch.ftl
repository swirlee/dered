<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>搜索页</title>

<link href="/css/public.css" type="text/css" rel="stylesheet">
<link href="/css/index.css" type="text/css" rel="stylesheet">
<link href="/css/goods.css" type="text/css" rel="stylesheet">
<link href="/css/goodshidden.css" type="text/css" rel="stylesheet">
<script src="/js/jquery-1.6.2.js"></script>
<script src="/js/jquery.shop.common.js"></script>
<script src="/js/jquery.lazyload.js"></script>
<script>
$(document).ready(function(){						
  $(".brandsort_show a").click(function(){								 
     var goods_view=$(this).attr("goods_view");
	 if(goods_view=="list"){
	   $(".goodstyletwo").show();
	   $(".smallgoods").hide();
	   $(this).addClass("brandsort_show_list2");
	   $("#thumb_view").removeClass().addClass("brandsort_show_big");
	 }
	 if(goods_view=="thumb"){
	   $(".smallgoods").show();
	   $(".goodstyletwo").hide();
	   $(this).addClass("brandsort_show_big2");
	   $("#list_view").removeClass().addClass("brandsort_show_list");	  
	 }
	 $("#goods_view").val(goods_view);
  });
    	 $(".smallgoods").show();
	 $(".goodstyletwo").hide();
	 $("#thumb_view").addClass("brandsort_show_big2");
	 $("#list_view").removeClass().addClass("brandsort_show_list");	 

		$(".brandsort_sort a").removeClass("this");
	$(".brandsort_sort a[orderBy='addTime']").addClass("this");
	
$(".smallgoods ul").hover(function(){
	  $(this).addClass("this");
	  $("li[class='goodshidden']").hide();
	  $(this).find("li[class='goodshidden']").show();
	  },function(){
	  $(this).removeClass("this").find("li[class='goodshidden']").hide(); 
	  });
 $(".classia:gt(2)").hide();
 if($(".classia").length<=3){
   $("#all_property_open").hide();
   $("#all_property_close").hide();
 }
 $("#all_property_open").mouseover(function(){
    $(this).css("cursor","pointer");
  }).click(function(){
	$("#all_property_status").val("open"); 
    $(".classia").show();
	$("#all_property_close").show();
	$("#all_property_open").hide();
 });
 $("#all_property_close").mouseover(function(){
    $(this).css("cursor","pointer");
  }).click(function(){
	$("#all_property_status").val("close"); 
    $(".classia:gt(2)").hide();
	$("#all_property_open").show();
	$("#all_property_close").hide();
 });
 
   
 $(".classia").each(function(){
   $(this).find(".classb span:gt(12)").hide(); 
 });
 $(".classmore a").each(function(){
    $(this).click(function(){
	   if($(this).index()==0){ 
	   	var mark = $(this).attr("mark");
		 $("#detail_property_status").val($("#detail_property_status").val()+","+mark);					
	     $(this).parent().parent().find(".classb span").show();
	     $(this).hide();
	     $(this).parent().find("a:last").show();
	   }
	   if($(this).index()==1){ 
	     $(this).parent().parent().find(".classb span:gt(12)").hide();
		 $(this).hide();
	     $(this).parent().find("a:first").show();
	   }
	});
 });
 
  
 $(".goodsimgs img").lazyload({effect:"fadeIn",width:178,height:178});
  $(".goodstwo img").lazyload({effect:"fadeIn",width:86,height:86});

  $("#price").hover(function(){
		$("#lowahigh").css("display","block");
		},function(){
			$("#lowahigh").css("display","none");	
		});
  $("#sales").hover(function(){
		$("#saleslowahigh").css("display","block");
		},function(){
			$("#saleslowahigh").css("display","none");	
		});

  $(".brandsort_fineprice").hover(function(){
		$(".brandsort_price_bottom").css("display","block");	
		},function(){
		$(".brandsort_price_bottom").css("display","none");	
			});			
  $(".brandsort_price_bottom a").click(function(){
	 	var mark = $(this).attr("mark");
	    if(mark=="clear"){
		$(".brandsort_price_top input").val("");	
			}
		$("#ListForm").submit();						   
		});		
		
  $("ul.areaul").find("a").click(function(){
		$("#area_id").val($(this).attr("area_id"));
		$("#ListForm").submit();
		});
  
  
//升序和降序的 点击事件  开始
	$("#saleslow").click(function(){
	   var orderBy = $(this).attr("orderby");
	   var orderType = $(this).attr("ordertype");
	   $("#orderBy").val(orderBy);
	   $("#orderType").val(orderType);
	   $("#ListForm").submit();
	});
	$("#saleshigh").click(function(){
		   var orderBy = $(this).attr("orderby");
		   var orderType = $(this).attr("ordertype");
		   $("#orderBy").val(orderBy);
		   $("#orderType").val(orderType);
		   $("#ListForm").submit();
		});
	$("#xiaoliang").click(function(){
		   var orderBy = $(this).attr("orderby");
		   var orderType = $(this).attr("ordertype");
		   $("#orderBy").val(orderBy);
		   $("#orderType").val(orderType);
		   $("#ListForm").submit();
		});
 $("#low").click(function(){
	   var orderBy = $(this).attr("orderby");
	   var orderType = $(this).attr("ordertype");
	   $("#orderBy").val(orderBy);
	   $("#orderType").val(orderType);
	   $("#ListForm").submit();
	});
 $("#high").click(function(){
	   var orderBy = $(this).attr("orderby");
	   var orderType = $(this).attr("ordertype");
	   $("#orderBy").val(orderBy);
	   $("#orderType").val(orderType);
	   $("#ListForm").submit();
	});
 $("#defaultseq").click(function(){
	   var orderBy = $(this).attr("orderby");
	   var orderType = $(this).attr("ordertype");
	   $("#orderBy").val(orderBy);
	   $("#orderType").val(orderType);
	   $("#ListForm").submit();
	});
//升序和降序的 点击事件  结束
  //
  var search_bar_top=$("#search_bar").offset().top;
  $(window).scroll(function(){
      var top= $("#search_bar").offset().top;
	  var scrolla=$(window).scrollTop();
	  var i=top-scrolla;
	 if(i<=0){
	   $("#search_bar").addClass("brandsort_screen_top");	  
	 }
	 if(scrolla<search_bar_top){
	   $("#search_bar").removeClass("brandsort_screen_top");
	 }
  });
  //
  
});
function goods_property_remove(type,id){
	if(type=="brand"){
       var brand_ids=$("#brand_ids").val();
	   brand_ids=brand_ids.replace("|"+id,"");
	   $("#brand_ids").val(brand_ids);
	   $("#ListForm").submit();	  
	}
	if(type=="gs"){
       var gs_ids=$("#gs_ids").val();
	   gs_ids=gs_ids.replace("|"+id,"");
	   $("#gs_ids").val(gs_ids);
	   $("#ListForm").submit();	 
	}
	if(type=="properties"){
       var properties=$("#properties").val();
	   properties=properties.replace("|"+id,"");
	   $("#properties").val(properties);
	   $("#ListForm").submit();	 
	}	
}
function goods_property_generic(type,id,value){
   if(type=="brand"){
	  var brand_ids=$("#brand_ids").val();
	  var s="|"+id+","+value;
	  if(brand_ids.indexOf(s)<0){
	    brand_ids=brand_ids+"|"+id+","+value;
	    $("#brand_ids").val(brand_ids);
		$("#ListForm").submit();  
	  } 
   }
   if(type=="gs"){
	  var gs_ids=$("#gs_ids").val();
	  var s="|"+id+","+value;
	  if(gs_ids.indexOf(s)<0){
	    gs_ids=gs_ids+"|"+id+","+value;
	    $("#gs_ids").val(gs_ids);
		$("#ListForm").submit();  
	  }
   }
   if(type=="properties"){
	  var properties=$("#properties").val();
	  var s="|"+id+","+value;
	  if(properties.indexOf(s)<0){
	    properties=properties+"|"+id+","+value;
	    $("#properties").val(properties);
		$("#ListForm").submit();  
	  }
   }   
}
</script>
</head>
<body>

<!-- 利用include标签引入网页顶部的登录栏 -->
<#include "/front/top.ftl"/>

<!-- 利用include标签引入网页顶部的搜索 -->
<#include "/front/search.ftl"/>

<div class="main">

  <script>
$(document).ready(function(){
  $(".navul a").each(function(){
    var original_url=$(this).attr("original_url");
	if("/shopping/store_goods_list.htm?gc_id=65935".indexOf(original_url)>=0){
	   $(this).addClass("this");	
	}
  });
  $(".left_menu_dl").mouseover(function(){
	    var child_count = $(this).attr("child_count");
		var sc_id=$(this).attr("id");
		var sc_color=$(this).attr("sc_color");		
	    var eq =$(this).index();
		if($(".left_menu_dd[id=child_"+sc_id+"]").html()==null){
	   	  $.ajax({type:'POST',url:'http://b2b2c.iskyshop.com/nav_data.htm',data:{"sc_id":sc_id},success:function(data){
		    if($(".left_menu_dd[id=child_"+sc_id+"]").html()==null){																						
      	      $(".left_menu_dt[id=dts_"+sc_id+"]").after(data);
		    }
	        if(child_count>0){
		     $("#dts_"+sc_id).addClass("left_menu_this").removeClass("left_menu_dt");
		     $("#child_"+sc_id).show();			
		    }
	    	$("#left_menu_con_"+sc_id).attr("style","border:1px solid "+sc_color+"; border-left:1px solid "+sc_color+";").find(".menu_con_right_top").css("background-color",sc_color);
	        var z = -35;
        	var x = eq*z;
	        $("#left_menu_con_"+sc_id).css('margin-top',x+'px');
		    $(".left_menu_dd[id=child_"+sc_id+"]").show();
	      }});
		}else{
		   if(child_count>0){
		      $("#dts_"+sc_id).addClass("left_menu_this").removeClass("left_menu_dt");
		      $("#child_"+sc_id).show();			
		    }
		    $("#left_menu_con_"+sc_id).attr("style","border:1px solid "+sc_color+"; border-left:1px solid "+sc_color+";").find(".menu_con_right_top").css("background-color",sc_color);
	        var z = -35;
    	    var x = eq*z;
	        $("#left_menu_con_"+sc_id).css('margin-top',x+'px');
		    $(".left_menu_dd[id=child_"+sc_id+"]").show();
		}
		
  }).mouseleave(function(e){
	  $("dt[id^=dts_]").removeAttr("style");
	  $("div[id^=left_menu_con_]").removeAttr("style"); 
	  var child_count = $(this).attr("child_count");
	$("dt[id^=dts_]").removeClass("left_menu_this").addClass("left_menu_dt");	  
	  $(".left_menu_dd[id^=child_]").hide();
  });
  $(".nav_left").mouseover(function(){
	  $("#other_menu").show();
	  
   });
  $(".nav_left").mouseleave(function(){
	  $("#other_menu").hide();
   });	
});

</script>
<div class="nav">

  <div class="nav_center">
  
    <div class="nav_left">
    
      
      <div id="other_menu" class="other_menu" style="display:none;">
      
        
		
      </div>
    </div>
    
    
    
  </div>
  
</div>
  
  <div class="index">
    <div class="position">
		当前位置：<a href="/front/index">首页</a>&gt;<a href="javascript:void(0);" class="pos">搜索结果</a> 
    </div>
    <div class="index2">
      <form action="/search/dotopsearch" method="post" id="ListForm">
      
        <div class="index2_list">
          <div class="opclass">
          
          
          <!-- 商品规格 -->
           <!--  <div class="classify">
              <div class="chosen">
                <div class="chosena">您已经选择：</div>
                <div class="chosenb">
                  <span class="chose">
                   <strong class="hui2">课程:</strong>
                    <strong class="orange">阿斯顿“亲亲英语”系列Gym1/2</strong>
                     <strong class="close_chose"></strong>
                      <strong class="del_chose">
                      <img src="/images/close.jpg" width="14" height="14" onclick="goods_property_remove('gs','32821,阿斯顿“亲亲英语”系列Gym1/2')"></strong>
                       </span>
                         </div>
                 <span class="chosen_sp"> 
                <img src="/images/more_sp.gif" width="26" height="26" id="all_property_open" style="display: none;"> 
                <img src="/images/more_sp2.gif" width="26" height="26" style="display:none" id="all_property_close"> 
                </span> </div>
                            <div class="classia"> 
                               <div class="classa">课程:</div>
                <div class="classb">
                                   <span>
                  <a href="javascript:void(0);" onclick="goods_property_generic('gs','32821','阿斯顿“亲亲英语”系列Gym1/2')">阿斯顿“亲亲英语”系列Gym1/2</a>
                  </span>
                                    <span>
                  <a href="javascript:void(0);" onclick="goods_property_generic('gs','32822','阿斯顿“亲亲英语”系列Gym3/4')">阿斯顿“亲亲英语”系列Gym3/4</a>
                  </span>
              </div>
              </div>
              <div class="classia"> 
              <div class="classa">品牌:</div>
              <div class="classb"> 
                <span>
                <a href="javascript:void(0);" onclick="goods_property_generic('brand','41','阿斯顿未来英语')">阿斯顿未来英语</a>
                </span>
              </div>
              </div>
               </div> -->
               
               
             </div>
             
          <!--商品列表开始-->
          <div class="allgoods">
            <div class="brandsort_screen" id="search_bar">
              <div class="brandsort_show">
               <a href="javascript:void(0);" goods_view="thumb" id="thumb_view" class="brandsort_show_big"><i class="big_hide"></i>大图</a>
                <a href="javascript:void(0);" goods_view="list" id="list_view" class="brandsort_show_list brandsort_show_list2"><i class="list_hide"></i>列表</a> 
                </div>
              <div class="brandsort_sort">
               <a id="defaultseq" href="javascript:void(0);" class="sort_a this" orderby="" ordertype="">默认排序</a>
               <div id="price">
                  <a href="javascript:void(0);" class="sort_a" orderby="sellprice" ordertype="desc">价格</a>
               	 
					<!--下面是隐藏的价格由高到低    由低到高 -->
		    		<div id="lowahigh" style="display:none;">
		                <h1><a id="low" href="javascript:void(0);" class="sort_a" orderby="sellprice" ordertype="desc">价格由高到低</a></h1>
		                <h1><a id="high" href="javascript:void(0);" class="sort_a" orderby="sellprice" ordertype="asc">价格由低到高</a></h1>
    				</div>
               </div>

				<a id="xiaoliang" href="javascript:void(0);" class="sort_a" orderby="salevolume" ordertype="desc">销量</a> 
               </div>
              <div class="brandsort_fineprice">
                <div class="brandsort_price_top">
                  <input placeholder="¥" name="store_price_begin" value="${store_price_begin?default('')}" type="text" title="按照价格区间筛选 最低价" class="brandsort_price_input">
                  <i>-</i>
                  <input placeholder="¥" name="store_price_end" value="${store_price_end?default('')}" type="text" title="按照价格区间筛选 高价" class="brandsort_price_input">
                </div>
                <div class="brandsort_price_bottom" style="display:none"> <a href="javascript:void(0);" mark="clear" class="brandsort_btn_clear">清空</a> <a href="javascript:void(0);" class="brandsort_btn_com">确定</a> </div>
              </div>
             	
              <div class="brandsort_input">
                <input class="brandsort_input_txt" type="text" id="goods_name" name="goodsname" value="${goodsname?default('')}" placeholder="搜索关键字">
                <input type="submit" style="cursor:pointer;" value="确定" class="brandsort_input_btn">
              </div>
            </div>
            
            
<!-- 样式一：长条排列 -->
<div class="smallgoods" style="display: none;">
<#if list_goods ??>
<#list list_goods as goods>       
	<ul class="this">
		<li class="goodsimgs">
			<span class="goods_sp_span">
				<p>
					<a href="/frontGoods/goodsDetails?id=${goods.id}" target="_blank">
					<img src="${goods.path}" onerror="this.src='/images/good.jpg';" width="178" height="178" style="display: inline;"></a>
				</p>
			</span>
		</li>
		<li class="goodslook"><strong>商城价：¥${goods.originalprice}</strong></li>
		<li class="goodslook"><span class="marketprice">市场价：¥${goods.sellprice}</span></li>
		<li class="goodsnames">
			<a href="/frontGoods/goodsDetails?id=${goods.id}" target="_blank">${goods.goodsname}</a>
		</li>
		<li class="recentgoodsok">最近成交<strong>0</strong>笔</li>
		<li class="goodshidden" style="display:none">
			<span class="goods_description">与描述相符: <b style="color:#F00">0.0</b> 分 </span>
		</li>
	</ul>
</#list>
</#if>
</div>

<!-- 样式二：方块排列 -->
<div class="goodstyletwo" style="display: block;">
<#if list_goods ??>
<#list list_goods as goods>
	<div class="goodstwo">
		<span class="goodtwoimg"> 
			<span class="goodtwoimg_span">
				<p> 
					<a href="/frontGoods/goodsDetails?id=${goods.id}" target="_blank">
						<img src="${goods.path}" onerror="this.src='/images/good.jpg';" width="86" height="86" style="display: inline;">
					</a>
				</p>
			</span> 
		</span>
		<ul class="goodsul">
			<li class="goodsli1">
				<span class="goods2name">
					<a href="/frontGoods/goodsDetails?id=${goods.id}" target="_blank">${goods.goodsname}</a>
				</span>
				<span class="goods2market">市场价：¥${goods.originalprice}</span>
				<span class="goods2shop">商城价：<strong>¥${goods.sellprice}</strong></span>
				<span class="recent">累计售出<strong class="orange">0</strong>笔</span>
			</li>
			<li class="goodsli2">
				<p class="goodsli2_p">
					<span class="goodsli2_p_sp">与描述相符：<b style="color:#F00">0.0</b> 分</span>
					<span class="goodsli2_p_eva">累计评价：<i>0</i></span>
				</p>
			</li>
		</ul>
	</div>
</#list>
</#if>
</div>

               
</div>


<div class="fenye" style="width:1200px;">
	<div class="fenyes">
		<input type="hidden" value="${area_id?default('')}" name="area_id" id="area_id">
		<input type="hidden" value="${gs_ids?default('')}" name="gs_ids" id="gs_ids">
		<input type="hidden" value="${brand_ids?default('')}" name="brand_ids" id="brand_ids">
		<input type="hidden" value="${properties?default('')}" name="properties" id="properties">
		<input type="hidden" value="${keyword?default('')}" name="keyword" id="keyword">
		<input type="hidden" value="${currentPage?default('')}" name="currentPage" id="currentPage">
		<input type="hidden" value="${goods_view?default('')}" name="goods_view" id="goods_view">
		<input type="hidden" value="${orderBy?default('')}" name="orderBy" id="orderBy">
		<input type="hidden" value="${orderType?default('')}" name="orderType" id="orderType"> 
		<input type="hidden" value="${all_property_status?default('')}" name="all_property_status" id="all_property_status">
		<input type="hidden" value="${detail_property_status?default('')}" name="detail_property_status" id="detail_property_status"> 
		<input type="hidden" value="${classesid?default('')}" name="classesid" id="classesid">
		
		<a href="javascript:void(0);" onclick="return gotoPage(1)">首页</a> 
		第　
		<#if totalPage??>
		<#list 1..totalPage as page>
		<#if page == PageNum>
			<a class="this" href="javascript:void(0);" onclick="return gotoPage(${page})">${page}</a> 
		<#else>
			<a href="javascript:void(0);" onclick="return gotoPage(${page})">${page}</a> 
		</#if>
		</#list>
		</#if>
		页　
		<a href="javascript:void(0);" onclick="return gotoPage(${totalPage})">末页</a>
	</div>
</div>
      </div>
      </form>

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
		<a id="toTop" href="/search/dotopsearch" bosszone="hometop" style="display: block;" onclick="window.scrollTo(0,0);return false" title="返回顶部" target="_self"></a>
	</div>
</div> 

</div>


</div>
</body>
</html>