<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台home页</title>

<link href="/css/template.css" rel="stylesheet" type="text/css">
<script src="/js/jquery-1.6.2.js"></script>
<script src="/js/jquery.shop.base.js"></script>
<script>
$(document).ready(function(){
    pagestyle();
	$(".webmap a").click(function(){
	    $(".webmap_box").fadeIn('normal');
	 });
	$(".close_map").click(function(){
	    $(".webmap_box").fadeOut('normal');
	});
	$("a[id^=complex_]").click(function(){
	  var suffix=$(this).attr("suffix");
	  if($("#"+suffix+"info").css("display")=="block"){
	      $("#"+suffix+"info").hide();
		  $("#"+suffix+"img").attr("src","/images/spread.jpg");
	   }else{
	      $("#"+suffix+"info").show();
		  $("#"+suffix+"img").attr("src","/images/contract.jpg");	  
	   }
	});
	$(".webskin em a img").click(function(){
	      var webcss = $(this).attr("webcss");
			$.post("/admin/set_websiteCss",{
						"webcss":webcss
						},function(data){
						window.location.href="/admin/index";	
							},"text");
		});
});	
</script>
</head>
<body scroll="yes">
<div class="main">
  <div class="top">
    <div class="login">您登录的身份是：<#if sessionUser? exists>${sessionUser.username}</#if>&nbsp;&nbsp;| <a href="/fronttoback/tuichu" target="_self">安全退出</a>|<a href="/admin/admin_pws" target="main_workspace">修改密码</a>| <a href="/front/index" target="_blank">商城首页</a></div>
    <div class="logo"></div>
    <div class="nav">
      <ul>
        <li><a href="javascript:void(0);" class="home" id="common_operation_menu" onclick="openURL('show','common_operation')">首页</a></li>
        <li><a href="javascript:void(0);" class="active" id="base_set_menu" onclick="openURL('show','base_set')">设置</a></li>
        <li><a href="javascript:void(0);" class="active" id="about_goods_menu" onclick="openURL('show','about_goods')">商品</a></li>
        <li><a href="javascript:void(0);" class="active" id="about_member_menu" onclick="openURL('show','about_member')">会员</a></li>
        <li><a href="javascript:void(0);" class="active" id="about_trade_menu" onclick="openURL('show','about_trade')">交易</a></li>
        <li><a href="javascript:void(0);" class="active" id="about_website_menu" onclick="openURL('show','about_website')">网站</a></li>
        <li><a href="javascript:void(0);" class="active" id="business_operation_menu" onclick="openURL('show','business_operation')">运营</a></li>
         <li><a href="javascript:void(0);" class="active" id="sys_tool_menu" onclick="openURL('show','sys_tool')">工具</a></li>
      </ul>
    </div>
  </div>
  <div class="index" id="workspace">
    <div class="left" style="width: 10%;">
      <div class="lefttop"> </div>
      <div class="left_ul">
        <ul class="ulleft" id="common_operation">
          <div class="leftone">常用操作</div>
          <li><a class="this" id="welcome_op" href="javascript:void(0);" onclick="openURL('url','/back/welcome','main_workspace','welcome_op')">欢迎页面</a></li>         
          <li><a href="javascript:void(0);" id="set_site_op_q" onclick="openURL('url','/admin/set_site','main_workspace','set_site_op_q')">站点设置</a></li>
          <li><a href="javascript:void(0);" id="user_list_op_q" onclick="openURL('url','/user/userManage','main_workspace','user_list_op_q')">会员管理</a></li>
          <li><a href="javascript:void(0);" id="store_list_op_q" onclick="openURL('url','/admin/store_list','main_workspace','store_list_op_q')">店铺管理</a></li>
          <li><a href="javascript:void(0);" id="goods_manage_op_q" onclick="openURL('url','/admin/goods_list','main_workspace','goods_manage_op_q')">商品管理</a></li>
          <li><a href="javascript:void(0);" id="order_list_op_q" onclick="openURL('url','/order/order_list','main_workspace','order_list_op_q')">订单管理</a></li>
        </ul>
        <ul class="ulleft" id="base_set" style="display:none;">
          <div class="leftone">基本设置</div>
          <li><a href="javascript:void(0);" id="set_site_op" class="this" onclick="openURL('url','/admin/set_site','main_workspace','set_site_op')">站点设置</a></li>
          <li><a href="javascript:void(0);" id="set_image_op" onclick="openURL('url','/admin/set_image','main_workspace','set_image_op')">上传设置</a></li>
          <li><a href="javascript:void(0);" id="set_seo_op" onclick="openURL('url','/admin/set_seo','main_workspace','set_seo_op')">SEO设置</a></li>
          <li><a href="javascript:void(0);" id="set_email_op" onclick="openURL('url','/admin/set_email','main_workspace','set_email_op')">Email设置</a></li>
          <li><a href="javascript:void(0);" id="template_list_op" onclick="openURL('url','/admin/template_list','main_workspace','template_list_op')">通知模板</a></li>
          <li><a href="javascript:void(0);" id="admin_list_op" onclick="openURL('url','/admin/admin_list','main_workspace','admin_list_op')">管理员管理</a></li>
          <li><a href="javascript:void(0);" id="complex_trans" suffix="trans_"><img id="trans_img" src="/images/contract.jpg" width="13" height="13">地区管理</a> 
           <ul id="trans_info">
              <li><a id="arealist_op" href="javascript:void(0);" onclick="openURL('url','/admin/area_list','main_workspace','arealist_op')">常用地区</a></li>
              <li><a href="javascript:void(0);" id="trans_area_op" onclick="openURL('url','/admin/trans_area_list','main_workspace','trans_area_op')">运费区域</a></li>
            </ul>
          </li>
          <li><a href="javascript:void(0);" id="complex_payment" suffix="payment_"><img id="payment_img" src="/images/contract.jpg" width="13" height="13">支付管理</a> 
           <ul id="payment_info">
              <li><a href="javascript:void(0);" id="payment_list_op" onclick="openURL('url','/admin/payment_list','main_workspace','payment_list_op')">支付方式</a></li>
              <li><a href="javascript:void(0);" id="fenrun_list_op" onclick="openURL('url','/admin/set_fenrun','main_workspace','fenrun_list_op')">分润管理</a></li>
            </ul>
          </li>
          <li><a href="javascript:void(0);" id="complex_kuaidi" suffix="kuaidi_"><img id="kuaidi_img" src="/images/contract.jpg" width="13" height="13">快递设置</a> 
           <ul id="kuaidi_info">
              <li><a href="javascript:void(0);" id="kaudi_set_op" onclick="openURL('url','/admin/set_kuaidi','main_workspace','kaudi_set_op')">快递设置</a></li>
               <li><a href="javascript:void(0);" id="kaudi_company_op" onclick="openURL('url','/admin/express_company_list','main_workspace','kaudi_company_op')">快递公司</a></li>
            </ul>
          </li>
        </ul>
        
        <ul class="ulleft" style="display:none;" id="about_goods">
          <div class="leftone">商品相关</div>
          <li><a href="javascript:void(0);" class="this" id="goods_class_op" onclick="openURL('url','/classes/showclasses?pid=0','main_workspace','goods_class_op')">分类管理</a> </li>
          <li><a href="javascript:void(0);" id="goods_brand_op" onclick="openURL('url','/brand/showbrand','main_workspace','goods_brand_op')">品牌管理</a></li>
          <li><a href="javascript:void(0);" id="goods_manage_op" onclick="openURL('url','/goods/showGoods','main_workspace','goods_manage_op')">商品管理</a></li>
          <li><a href="javascript:void(0);" id="goods_spec_op" onclick="openURL('url','/spec/showspec','main_workspace','goods_spec_op')">规格管理</a></li>
          <li><a href="javascript:void(0);" id="advert_set_op" onclick="openURL('url','/ad/showAd','main_workspace','advert_set_op')">广告管理</a></li>
          <li><a href="javascript:void(0);" id="goods_floor_op" onclick="openURL('url','/floor/goods_floor_list','main_workspace','goods_floor_op')">首页楼层</a></li>
          <li><a href="javascript:void(0);" id="order_manage_op" onclick="openURL('url','/order/order_list','main_workspace','order_manage_op')">订单管理</a> </li>
          <li><a href="javascript:void(0);" id="goods_type_op" onclick="openURL('url','/admin/goods_type_list','main_workspace','goods_type_op')">类型管理</a></li>
        </ul>
        
        <ul class="ulleft" style="display:none;" id="about_sparegoods">
          <div class="leftone">闲置相关</div>          
          <li><a href="javascript:void(0);" class="this" id="sharegoodsclass_op" onclick="openURL('url','/admin/sparegoods_class_list','main_workspace','sharegoodsclass_op')">闲置分类</a> </li>          
            <li><a href="javascript:void(0);" class="this" id="share_goods_op" onclick="openURL('url','/admin/sparegoods_list','main_workspace','share_goods_op')">闲置商品</a> </li>
             <li><a href="javascript:void(0);" class="this" id="sparegoodsfloor_op" onclick="openURL('url','/admin/sparegoodsfloor_list','main_workspace','sparegoodsfloor_op')">闲置楼层</a> </li>
        </ul>
        
        <ul class="ulleft" style="display:none;" id="about_member">
          <div class="leftone">会员相关</div>
          <li><a href="javascript:void(0);" class="this" id="member_manage_op" onclick="openURL('url','/admin/user_list','main_workspace','member_manage_op')">会员管理</a> </li>
          <li><a href="javascript:void(0);" class="this" id="user_creditrule_op" onclick="openURL('url','/admin/user_creditrule','main_workspace','user_creditrule_op')">会员信用</a> </li>
          <li><a href="javascript:void(0);" id="user_msg_op" onclick="openURL('url','/admin/user_msg','main_workspace','user_msg_op')">会员通知</a></li>
          <li><a href="javascript:void(0);" id="predeposit_list_op" onclick="openURL('url','/admin/predeposit_list','main_workspace','predeposit_list_op')">预存款管理</a></li>
          <li><a href="javascript:void(0);" id="predepositlog_list_op" onclick="openURL('url','/admin/predepositlog_list','main_workspace','predepositlog_list_op')">预存款明细</a></li>
          <li><a href="javascript:void(0);" id="img_op" onclick="openURL('url','/admin/user_photo_list','main_workspace','img_op')">图片管理</a></li> 
          <li>
          		<a href="javascript:void(0);" id="complex_sns" suffix="sns_"><img id="sns_img" src="/images/contract.jpg" width="13" height="13">SNS管理</a>
        		<ul id="sns_info">
		          <li><a id="user_sns_op" href="javascript:void(0);" onclick="openURL('url','/admin/sns_user','main_workspace','user_sns_op')">会员动态</a></li>
		          <li><a href="javascript:void(0);" id="store_sns_op" onclick="openURL('url','/admin/sns_store','main_workspace','store_sns_op')">店铺动态</a></li>
		        </ul>
          </li>
          <li><a href="javascript:void(0);" id="user_weixin_op" onclick="openURL('url','/admin/user_weixin','main_workspace','user_weixin_op')">微信会员</a></li> 
        </ul>
        
        <ul class="ulleft" style="display:none;" id="about_trade">
          <div class="leftone">交易管理</div>
          <li><a href="javascript:void(0);" class="this" id="order_manage_op" onclick="openURL('url','/order/order_list','main_workspace','order_manage_op')">订单管理</a> </li>
          <li><a href="javascript:void(0);" id="set_order_confirm_op" onclick="openURL('url','/admin/set_order_confirm','main_workspace','set_order_confirm_op')">订单设置</a> </li>
          <li><a href="javascript:void(0);" id="consult_manage_op" onclick="openURL('url','/admin/consult_list','main_workspace','consult_manage_op')">咨询管理</a></li>
          <li><a href="javascript:void(0);" id="report_manage_op" onclick="openURL('url','/admin/report_list','main_workspace','report_manage_op')">举报管理</a></li>
          <li><a href="javascript:void(0);" id="evaluate_manage_op" onclick="openURL('url','/admin/evaluate_list','main_workspace','evaluate_manage_op')">商品评价</a></li>
          <li><a href="javascript:void(0);" id="complaint_manage_op" onclick="openURL('url','/admin/complaint_list','main_workspace','complaint_manage_op')">投诉管理</a></li>
        </ul>
        
        <ul class="ulleft" style="display:none;" id="about_website">
          <div class="leftone">网站相关</div>
          <li><a href="javascript:void(0);" class="this" id="articleClass_op" onclick="openURL('url','/admin/articleclass_list','main_workspace','articleClass_op');">文章分类</a> </li>
          <li><a href="javascript:void(0);" id="article_op" onclick="openURL('url','/admin/article_list','main_workspace','article_op');">文章管理</a></li>
          <li><a href="javascript:void(0);" id="document_op" onclick="openURL('url','/admin/document_list','main_workspace','document_op');">系统文章</a></li>
          <li><a href="javascript:void(0);" id="partner_op" onclick="openURL('url','/admin/partner_list','main_workspace','partner_op');">合作伙伴</a></li>
          <li><a href="javascript:void(0);" id="nav_op" onclick="openURL('url','/admin/navigation_list','main_workspace','nav_op');">页面导航</a></li>
        </ul>
        
        <ul class="ulleft" style="display:none;" id="business_operation">
          <div class="leftone">运营管理</div>
          <li><a href="javascript:void(0);" class="this" id="operation_base_op" onclick="openURL('url','/admin/operation_base_set','main_workspace','operation_base_op')">基本设置</a> </li>
          <li><a href="javascript:void(0);" id="gold_record_op" onclick="openURL('url','/admin/gold_record','main_workspace','gold_record_op')">金币管理</a></li>
		  <li><a href="javascript:void(0);" id="coupon_set_op" onclick="openURL('url','/admin/coupon_list','main_workspace','coupon_set_op')">优惠券管理</a></li>
          <li><a href="javascript:void(0);" id="advert_set_op" onclick="openURL('url','/ad/showAd','main_workspace','advert_set_op')">广告管理</a></li>
		  <li><a href="javascript:void(0);" id="send_message" onclick="openURL('url','/admin/activityMessage_list','main_workspace','send_message')">发送消息</a></li>
		  <li><a href="javascript:void(0);" id="love_show" onclick="openURL('url','/admin/loveShow_list','main_workspace','love_show')">爱心公益</a></li>
          <li><a href="javascript:void(0);" id="show" onclick="openURL('url','/admin/show_list','main_workspace','show')">童臻秀场</a></li>
          <li><a href="javascript:void(0);" id="event" onclick="openURL('url','/admin/event_list','main_workspace','event')">童臻活动</a></li>
	    </ul>
	    
        <ul class="ulleft" style="display:none;" id="sys_tool">
          <div class="leftone">系统工具</div>
          <li><a href="javascript:void(0);" id="cache_list_op" onclick="openURL('url','/admin/cache_list','main_workspace','cache_list_op')">缓存管理</a></li>
          <li><a href="javascript:void(0);" id="database_add_op" onclick="openURL('url','/admin/database_add','main_workspace','database_add_op')">数据库管理</a></li>
          <li><a href="javascript:void(0);" id="lucene_op" onclick="openURL('url','/admin/lucene','main_workspace','lucene_op')">全文检索</a></li>          
        </ul>
          
      </div>
    </div>
    <div class="content" style="width: 90%; height: 615px;">
    <div class="navbar">
     
      <div style="line-height:36px;">您的位置：控制台&gt;<span id="top_nav_info">站点设置</span></div>
      </div>
      <iframe id="main_workspace" name="main_workspace" src="/back/welcome" style="overflow: auto; height: 513px; width: 1149px;" frameborder="0" width="100%" height="100%" scrolling="yes" onload="window.parent"></iframe>
    </div>
  </div>
</div>

</body>
</html>