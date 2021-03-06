
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单支付</title>
<link href="/css/public.css" type="text/css" rel="stylesheet">
<link href="/css/goods.css" type="text/css" rel="stylesheet">
<link href="/css/overlay.css" type="text/css" rel="stylesheet">
<script src="/js/jquery-1.6.2.js"></script>
<script src="/js/jquery-ui-1.8.21.js"></script>
<script src="/js/jquery.shop.common.js"></script>
<script>

$(document).ready(function() {	
	var totalprice = $("#totalprice").val();
	if(totalprice == 0.0){
		//如果获取到支付价格为0的话，那么就可以支付宝和微信隐藏
		 $("#onpay").hide();
		 $("#alipay").hide();
		 $("#wx").hide();
});

window.onscroll=function(){
  var h = document.body.clientHeight;
  var top = document.documentElement.scrollTop;
  top = top-50+(h-top)/2;
  $(".white_content").css("top",top);
}
</script>
</head>
<body>

<!-- 利用include标签引入网页顶部的登录栏 -->
<#include "/front/top.ftl"/>
<#include "/front/search.ftl"/>
<div class="main">

  <div class="index">
    <div class="index2">
      <div class="Steps">
            <ul>
                <li>1.查看购物车</li>
                <li>2.确认订单信息</li>
                <li class="this">3.付款到卖家</li>
                <li>4.确认收货</li>
                <li class="last">5.评价</li>
            </ul>
        </div>
        
      
      <div class="payorder">
        <div class="pay_top">
          <div class="payhh"></div>
          <div class="paybot">
            <h1>订单提交成功</h1>
            <h2>您的订单已成功生成，选择您想用的支付支付方式进行支付</h2>
            <ul>
              <li><strong>订单编号：</strong><strong class="orange">${ordernumber?default('')}</strong></li>
              <li><strong>应付金额：</strong><strong class="orange">¥${totalprice?default('0.0') }</strong></li>
            </ul>
            <h3>您可以在用户中心中<a href="/order/myorder">"我的订单"</a>查看该订单</h3>
          </div>
        </div>
        <div class="bank">
          <div class="banktitle">
            <h1><span>您可以选择付款方式</span></h1>
          </div>
          <div id="selectpay" class="bankcar">
             <ul>
              	<li>
                   <h1>预存款支付</h1>
                   <div class="bankone"> 
                     <span class="banksp">
                       <input name="payType" type="radio" value="balance" checked="checked">
                     </span> 
                     <span class="bankimg">
                       <img src="/images/balance.jpg" width="125" height="47">
                     </span> 
                     <span class="bank_txt"></span> 
                  </div>
                  </li>
                <li>
                   <h1 id="onpay">在线支付</h1>
                   <div id="alipay" class="bankone"> 
                  	<span class="banksp">
                      <input name="payType" type="radio" value="alipay">
                    </span> 
                    <span class="bankimg">
                      <img src="/images/alipay.jpg" width="125" height="47">
                    </span> 
                    <span class="bank_txt"></span> 
                   </div>
                   <div id="wx" class="bankone"> 
                  	<span class="banksp">
                      <input name="payType" type="radio" value="wxcodepay">
                    </span> 
                    <span class="bankimg">
                      <img src="/images/weixin.png" width="125" height="47">
                    </span> 
                    <span class="bank_txt"></span> 
                  </div>
                 </li>
              </ul>
          </div>
          <div class="banknextbtn">
            <input id="pay" type="button" value="确认支付" style="cursor:pointer;">
            <input type="hidden" id="orderid" name="orderid" value="${orderid?default('')}"/>
            <input name="totalprice" type="hidden" id="totalprice" value="${totalprice?default('0.0') }">
          </div>
        </div>
      </div>
    </div>
  </div>
    
<script>
$(document).ready(function(){
	

	$("#pay").click(function(){
		var orderid = $("#orderid").val();
		$.ajax({
			url:"/order/front_order_pay",
			type:"post",
			data:{"orderid":orderid},
			success:function(data){
				if(data.STATUS == "SUCCESS"){
					alert("支付成功");
					window.location.href="/front/index";
				}else{
					alert("支付失败");
				}
			}
		});
	});
	
	//滚动条滚动事件
	$(window).scroll(function(){
	var top = $(document).scrollTop();
	if(top == 0){
		$(".back_box").hide();
		}else{
		$(".back_box").show();	
			}
	});						
});
</script>
<div class="footer">
<div class="footerArea">
  <ul>
    <li>
	    <a href="http://aishang2018.vicp.io:11585/shopping/article_join.htm" target="_blank">招聘英才</a>|                 
	    <a href="http://aishang2018.vicp.io:11585/shopping/article_adver.htm" target="_blank">广告合作</a>|                 
	    <a href="http://aishang2018.vicp.io:11585/shopping/article_contact.htm" target="_blank">联系我们</a>|                 
	    <a href="http://aishang2018.vicp.io:11585/shopping/article_about.htm" target="_blank">关于shopping</a>        
    </li>
    <li class="hui2">Copyright 2018-2019 tz Inc. All rights reserved</li>
    <li class="hui2">Powered by tz</li>
    <li></li>
  </ul>
</div>
</div>


<!--返回最顶部-->
<div class="back_box" style="width: 50px; height: 50px; position: fixed; bottom: 180px; right: 25px;">
    <div class="back_index"><a href="http://aishang2018.vicp.io:11585/shopping/index.htm" target="_blank" title="返回主页"></a></div>
    <div class="back_top"><a id="toTop" href="http://aishang2018.vicp.io:11585/shopping/goods_cart3.htm#" bosszone="hometop" style="display: block;" onclick="window.scrollTo(0,0);return false" title="返回顶部" target="_self"></a></div>
</div>
</div>
<div style="display:none;" id="pay_overlay">
  <div class="white_content" style="top: 424px;"> 
  	<a href="javascript:void(0);" onclick="javascript:$(&#39;#pay_overlay&#39;).hide();" class="white_close"><img src="/images/close.jpg" width="14" height="14"></a>
    <div class="white_box">
      <h1>支付提醒</h1>
      <dl class="white_dl">
        <dt></dt>
        <dd>
          <div class="payf"><a href="http://aishang2018.vicp.io:11585/shopping/order_finish.htm?order_id=230067">已经完成支付！</a></div>
          <div class="payf"><a href="javascript:void(0);" onclick="javascript:$(&#39;#pay_overlay&#39;).hide();">支付出现问题！</a></div>
        </dd>
      </dl>
    </div>
  </div>
  <div class="black_overlay"></div>
</div>

<div style="display:none;" id="wxcodepay_overlay">
  <div class="wx_content"> 
  	<a href="javascript:void(0);" onclick="javascript:$(&#39;#wxcodepay_overlay&#39;).hide();" class="white_close"><img src="/images/close.jpg" width="14" height="14"></a>
    <div class="wx_box">
      <h1>微信二维码扫码支付</h1>
      <dl class="wx_dl">
        <dt id="wxPayCode"></dt>
        <dd>
          <div class="payf"><a href="http://aishang2018.vicp.io:11585/shopping/order_finish.htm?order_id=230067">完成支付！</a></div>
          <div class="payf"><a href="javascript:void(0);" onclick="javascript:$(&#39;#wxcodepay_overlay&#39;).hide();">支付出现问题！</a></div>
        </dd>
      </dl>
    </div>
  </div>
  <div class="black_overlay"></div>
</div>
</body>
</html>