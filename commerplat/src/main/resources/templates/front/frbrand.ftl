<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>商城品牌</title>
<link href="/css/public.css" type="text/css" rel="stylesheet">
<link href="/css/index.css" type="text/css" rel="stylesheet">
<link href="/css/goods.css" type="text/css" rel="stylesheet">
<script src="/js/jquery-1.6.2.js"></script>
<script src="/js/jquery.cookie.js"></script>
</head>

<body>

<#include "/front/top.ftl"/>
<#include "/front/search.ftl"/>

<div class="recommend">
  <div class="recommend_top"><span><img src="/images/recommend_brand.png"></span></div>
  <div class="recommend_center">
    <div class="recommend_center_bd_m">
      <div style="overflow:hidden; position:relative; width:1200px" class="tempWrap">
		<ul>
			<li style="float: left; width: 1200px;">
			<#if list_recommendBrand??>
			<#list list_recommendBrand as recBrand>
				<a target="_blank" href="/search/dotopsearch?brand_ids=${recBrand.id}"><img src="${recBrand.path}" width="80px" height="80px"></a>
			</#list>
			</#if>
			</li>
		</ul>
      </div>
    </div>
    
  </div>
</div>

<div class="main">

	<div class="index">
		<div class="recommend_top"><span><img src="/images/brand_company.png"></span></div>
		<div id="float_box" class="brand_list_nav"> 
			<span>BRANDS A-Z ：</span> 
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">A</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">B</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">C</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">D</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">E</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">F</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">G</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">H</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">I</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">J</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">K</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">L</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">M</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">N</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">O</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">P</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">Q</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">R</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">S</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">T</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">U</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">V</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">W</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">X</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">Y</a>
  	      	<a mark="A" id="ReturnWord_" href="javascript:void(0);">Z</a>
		</div>
		<div class="brand_list_main">
			<div class="brand_list">
				<h3 id="brand_A" status="0">A-Z</h3>
				<div class="brand_list_box">
				<#if list_Brand??>
				<#list list_Brand as Brand>
					<span>
						<a href="/search/dotopsearch?brand_ids=${Brand.id}">
							<b><img src="${Brand.path}" width="98" height="35"></b>
							<em>${Brand.brandname}</em>
						</a>
					</span>
				</#list>
				</#if>
				</div>                 
			</div>
		</div>
	</div>
	
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
		<a id="toTop" href="/front/index" bosszone="hometop" style="display: block;" onclick="window.scrollTo(0,0);return false" title="返回顶部" target="_self"></a>
	</div>
</div> 

</body>
</html>