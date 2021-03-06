<!DOCTYPE html PUBLIC>
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
		function displayState(){
		var state = $("#display").val();
		if(state == "true"){
			$("#display").val("false");
			$("#stateOff").show();
			$("#stateOn").hide();
		}else{
			$("#display").val("true");
			$("#stateOff").hide();
			$("#stateOn").show();
		}
	}
	
	});
	//网站logo file样式
	$(function(){
	    var textButton="<input type='text' name='textfield' id='textfield1' class='size13' /><input type='button' name='button' id='button1' value='' class='filebtn' />"
		$(textButton).insertBefore("#adLogo");
		$("#adLogo").change(function(){
		$("#textfield1").val($("#adLogo").val());
		})
	});	
	function ajax_update(id,fieldName,obj){
		   var val=$(obj).val();
		   $.ajax({
			   type:"post",           
			   url:"/ad/updatead_ajax",
			   data:{"id":id,"fieldName":fieldName,"value":val},
			   success:function(data){
		         if(val == ""){
		        	 $(obj).attr("src","/images/"+data.bb.display+".png");
				 }else{
					 $(obj).val(val);
				 }      
		       }
		   });
		}
	
//删除一条广告	
function ajax_delete_ad(obj,id){
	//确定是否删除
	if(confirm("确定删除该条广告？")){
		$.ajax({
				type:"post",
				url:"/ad/goods_ad_del_ajax",
				data:{"id":id},
				success:function(data){
		        	$(obj).parent().parent().remove();
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
		<h1 class="seth1">广告管理</h1>
		<div class="settab">
			<span class="tab-one"></span>
			<span class="tabs"> 
				<a href="javascript:void(0);" class="this">管理</a>
				 |
				<a href="/ad/addad">新增</a>
				 
			</span>
			<span class="tab-two"></span>
		</div>
		
		
		<div class="operation">
			<h3>友情提示</h3>
			<ul>
				<li>设置推荐的广告会在商城首页根据序号从小到大的顺利轮换显示</li>
			</ul>
		</div>
		
		
		<form name="ListForm" id="ListForm" action="#" method="post">
			<div class="brandtable">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="brand_table">
					<tbody>
						<tr style="background: #2A7AD2; height: 30px; color: #FFF">
							<td width="85">&nbsp;</td>
							<td width="110">排序</td>
							<td width="253">广告标题</td>
							<td width="233">广告图片标识</td>
							<td width="171" align="center">显示</td>
							<td width="257" align="center">操作</td>
						</tr>
						<#if list_ad??>
						<#list list_ad as ad>
						<tr>
							<td align="center">
							  <input name="checkbox" type="checkbox" id="checkbox" value="${ad.id }">
							</td>
							<td>
							  <span class="pxnum size5"> 
							    <input type="text" name="seq" id="seq" value="${ad.seq?default(0)}" title="可编辑"
								       onblur="ajax_update(${ad.id },'seq',this)" >
							  </span>
							</td>


							<td>
							  <span class="pxnum size8">
							    <input type="text" name="titlename" id="titlename" value="${ad.titlename}" title="可编辑"
									   onblur="ajax_update(${ad.id},'titlename',this)">
							  </span>
							</td>


							<td>
							  <img src="${ad.path?default('')}" width="70px" height="50px">
							</td>
							<td align="center">
							<img src="/images/${ad.display?string}.png" width="25" height="21" border="0"
								 style="cursor: pointer;" title="可编辑"
								 onclick="ajax_update(${ad.id },'display',this)">
							</td>
							<td class="ac8" align="center">
							  <a href="/ad/updatead?id=${ad.id}">编辑</a>
							  |
							  <a href="javascript:void(0)" onclick="ajax_delete_ad(this,${ad.id})">删除</a>
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
							   <!--  <span class="sp2">
								 <div class="shop_btn_del shopbtn">
									<input name="" type="button" style="cursor: pointer;" value="删除" onclick="cmd('/admin/goods_ad_del');">
								  </div>
							    </span> -->
							</td>
							
						</tr>
					</tbody>
				</table>
				
			</div>
		</form>
	</div>
	

</body>
</html>