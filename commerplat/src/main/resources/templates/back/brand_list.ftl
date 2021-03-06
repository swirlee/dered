<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link href="/css/template.css" rel="stylesheet" type="text/css">
<script src="/js/jquery-1.6.2.js"></script>
<script src="/js/jquery.shop.common.js"></script>
<script src="/js/jquery.poshytip.min.js"></script>
<script>
	$(document).ready(function(){
		
		
		
		
	  tipStyle();
	//设置推荐的默认装态
		function recommendState(){
		var state = $("#recommend").val();
		if(state == "true"){
			$("#recommend").val("false");
			$("#stateOff").show();
			$("#stateOn").hide();
		}else{
			$("#recommend").val("true");
			$("#stateOff").hide();
			$("#stateOn").show();
		}
	}
	
	});
	//网站logo file样式
	$(function(){
	    var textButton="<input type='text' name='textfield' id='textfield1' class='size13' /><input type='button' name='button' id='button1' value='' class='filebtn' />"
		$(textButton).insertBefore("#brandLogo");
		$("#brandLogo").change(function(){
		$("#textfield1").val($("#brandLogo").val());
		})
	});	
	function ajax_update(id,fieldName,obj){
		   var val=jQuery(obj).val();
		   jQuery.ajax({
			   type:"post",           
			   url:"/brand/updatebrand_ajax",
			   data:{"id":id,"fieldName":fieldName,"value":val},
			   success:function(data){
		         if(val == ""){
		        	 jQuery(obj).attr("src","/images/"+data.bb.recommend+".png");
				 }else{
					 jQuery(obj).val(val);
				 }      
		       }
		   });
		}
function ajax_delete_brand(obj,id){
		if(confirm("确认删除该品牌？？？")){
			$.ajax({
					type:"post",
					url:"/brand/goods_brand_del_ajax",
					data:{"id":id},
					success:function(data){
			            if(data.a==1){
			            	$(obj).parent().parent().remove();
			            }
			            if(data.a==0){
			            	alert("该品牌已经关联商品或推荐商品列表，无法删除！！！");
			            }
					}
			});
		}
	}
	
	
	
</script>
<style id="poshytip-css-tip-skyblue" type="text/css">
div.tip-skyblue {
	visibility: hidden;
	position: absolute;
	top: 0;
	left: 0;
}

div.tip-skyblue table, div.tip-skyblue td {
	margin: 0;
	font-family: inherit;
	font-size: inherit;
	font-weight: inherit;
	font-style: inherit;
	font-variant: inherit;
}

div.tip-skyblue td.tip-bg-image span {
	display: block;
	font: 1px/1px sans-serif;
	height: 10px;
	width: 10px;
	overflow: hidden;
}

div.tip-skyblue td.tip-right {
	background-position: 100% 0;
}

div.tip-skyblue td.tip-bottom {
	background-position: 100% 100%;
}

div.tip-skyblue td.tip-left {
	background-position: 0 100%;
}

div.tip-skyblue div.tip-inner {
	background-position: -10px -10px;
}

div.tip-skyblue div.tip-arrow {
	visibility: hidden;
	position: absolute;
	overflow: hidden;
	font: 1px/1px sans-serif;
}
</style>
</head>
<body>
	<div class="cont">
		<h1 class="seth1">品牌管理</h1>
		<div class="settab">
			<span class="tab-one"></span>
			<span class="tabs"> 
				<a href="javascript:void(0);" class="this">管理</a>
				 |
				<a href="/brand/addbrand">新增</a>
				 |
				<a href="javascript:void(0);">申请列表</a>
			</span>
			<span class="tab-two"></span>
		</div>
		
		<form name="queryForm" id="queryForm" action="#" method="post">
			<div class="allmem_search">
				<ul>
					<li><span>品牌名称</span> <span class="allmen size4"> 
					<input name="brandname" type="text" id="brandname"></span> 
					<span>类别</span> <span class="allmen size4"> 
					<input name="category" type="text" id="category"></span> 
					<span class="btn_search"> 
					<input name="" type="submit" value="搜索" style="cursor: pointer;"></span>
					</li>
				</ul>
			</div>
		</form>
		
		<div class="operation">
			<h3>友情提示</h3>
			<ul>
				<li>通过商品品牌管理，你可以进行查看、编辑、删除系统商品品牌</li>
				<li>设置推荐的品牌会在商城首页根据序号从小到大的顺利轮换显示</li>
			</ul>
		</div>
		
		
		<form name="ListForm" id="ListForm" action="#" method="post">
			<div class="brandtable">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="brand_table">
					<tbody>
						<tr style="background: #2A7AD2; height: 30px; color: #FFF">
							<td width="85">&nbsp;</td>
							<td width="110">排序</td>
							<td width="253">品牌名称</td>
							<td width="233">品牌图片标识</td>
							<td width="171" align="center">推荐</td>
							<td width="257" align="center">操作</td>
						</tr>
						<#if list_brand??>
						<#list list_brand as brand>
						<tr>
							<td align="center">
							  <input name="checkbox" type="checkbox" id="checkbox" value="${brand.id }">
							</td>
							<td>
							  <span class="pxnum size5"> 
							    <input type="text" name="seq" id="seq" value="${brand.seq?default(0)}" title="可编辑"
								       onblur="ajax_update(${brand.id },&#39;seq&#39;,this)" >
							  </span>
							</td>


							<td>
							  <span class="pxnum size8">
							    <input type="text" name="brandname" id="brandname" value="${brand.brandname}" title="可编辑"
									   onblur="ajax_update(${brand.id},&#39;brandname&#39;,this)">
							  </span>
							</td>


							<td>
							  <img src="${brand.path?default('')}" width="70px" height="50px">
							</td>
							<td align="center">
							<img src="/images/${brand.recommend?string}.png" width="25" height="21" border="0"
								 style="cursor: pointer;" title="可编辑"
								 onclick="ajax_update(${brand.id },&#39;recommend&#39;,this)">
							</td>
							<td class="ac8" align="center">
							  <a href="/brand/updatebrand?id=${brand.id}">编辑</a>
							  |
							  <a href="javascript:void(0)" onclick="ajax_delete_brand(this,${brand.id})">删除</a>
							</td>
						
						</tr>
						</#list>
						</#if>
						
						<tr>
							<td align="center">
							  <input type="checkbox" name="all" id="all" value="" onclick="selectAll(this)">
							</td>
							<td colspan="2" class="bdel">
							  <span class="sp1">全部</span>
							    <span class="sp2">
								  <div class="shop_btn_del shopbtn">
									<input name="" type="button" style="cursor: pointer;" value="删除"
										   onclick="cmd(&#39;http://aishang2018.vicp.io:11585/shopping/admin/goods_brand_del.htm?currentPage=1&#39;);">
								  </div>
							    </span>
							</td>
							<td colspan="4"></td>
						</tr>
					</tbody>
				</table>
				
				
				<div class="fenye" align="right" id="queryCondition">
					<input name="category" type="hidden" id="category" value="">
					<input name="brandname" type="hidden" id="brandname" value=""> 
					<input name="mulitId" type="hidden" id="mulitId"> 
					<input name="currentPage" type="hidden" id="currentPage" value="1">
						<a href="javascript:void(0);" onclick="return gotoPage(1)">首页</a>
						第 
						<a class="this" href="javascript:void(0);" onclick="return gotoPage(1)">1</a> 
						 页
						<a href="javascript:void(0);" onclick="return gotoPage(2)">下一页</a>
						<a href="javascript:void(0);" onclick="return gotoPage(4)">末页</a>
				</div>
			</div>
		</form>
	</div>
	
	
	
	<div class="tip-skyblue">
		<div class="tip-inner tip-bg-image"></div>
		<div class="tip-arrow"></div>
	</div>
	<div class="tip-skyblue">
		<div class="tip-inner tip-bg-image"></div>
		<div class="tip-arrow"></div>
	</div>
	<div class="tip-skyblue">
		<div class="tip-inner tip-bg-image"></div>
		<div class="tip-arrow"></div>
	</div>
	

</body>
</html>