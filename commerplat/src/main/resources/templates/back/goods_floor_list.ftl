<!DOCTYPE>
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
	
	//删除选中楼层
	$("#delchecked").click(function(){
		var ids = "";
		$("input[name=ids]:checked").each(function(){
			ids+=$(this).val()+",";
		});
		if(ids.length > 0){
			$.ajax({
				type:"post",
				url:"/floor/ajaxdel",
				data:{"ids":ids},
				success:function(data){
					$.each(ids, function(i,id){
						$("#ids_"+id).parent().parent().remove();
					});
				}
			});
		}
	});
	
});
//分类的三级联动	
function addorsubtract(obj,id){
	var cls = $(obj).attr("cls");
	var level = $(obj).attr("level");
  	if(cls == "jian"){
  		$.ajax({
			type:"post",       
			url:"/floor/appendSonList",
			data:{"id":id},
			success:function(data){
				$("#"+id).after(data);
				$(obj).attr("src","/images/jian.jpg");
				$(obj).attr("cls","add");
			}
		});
  	}else{
  		if(level == "0_"+id){
  			$("tr[level=child_"+id+"]").remove();
  			$("tr[parent='"+id+"']").remove();
  		}else{
  			$("tr[parent='"+id+"']").remove();
  		}
  		$(obj).attr("src","/images/add.jpg");
  		$(obj).attr("cls","jian");	
  	}
}
//ajax编辑
function ajax_update(id,fieldName,obj){
	var val=$(obj).val();
    $.ajax({
		type:'post',
		url:'/floor/floor_ajax_update',
		data:{"id":id,"fieldName":fieldName,"value":val},
		success:function(data){
        	$(obj).attr("src","/images/"+data.cc.display+".png");
		}
	});
}
	
//查询一个主楼层下有几个子楼层
function addSonFloor(obj,id){
	$.ajax({
		type:'post',
		url:'/floor/countOfSonFloor',
		data:{"id":id},
		success:function(data){
        	if(data.aaa>=4){
        		alert("最多添加4个子楼层！！！");
        	}else{
        		window.location.href="/floor/floor_add?pid="+id+"";
        	}
		}
	});
}	
	
</script>

<style id="poshytip-css-tip-skyblue" type="text/css">div.tip-skyblue{visibility:hidden;position:absolute;top:0;left:0;}div.tip-skyblue table, div.tip-skyblue td{margin:0;font-family:inherit;font-size:inherit;font-weight:inherit;font-style:inherit;font-variant:inherit;}div.tip-skyblue td.tip-bg-image span{display:block;font:1px/1px sans-serif;height:10px;width:10px;overflow:hidden;}div.tip-skyblue td.tip-right{background-position:100% 0;}div.tip-skyblue td.tip-bottom{background-position:100% 100%;}div.tip-skyblue td.tip-left{background-position:0 100%;}div.tip-skyblue div.tip-inner{background-position:-10px -10px;}div.tip-skyblue div.tip-arrow{visibility:hidden;position:absolute;overflow:hidden;font:1px/1px sans-serif;}</style></head>





<body>
<div class="cont">
	<h1 class="seth1">首页楼层</h1>
	<div class="settab"><span class="tab-one"></span>
		<span class="tabs">
			<a href="" class="this">管理</a>
			|
			<a href="/floor/floor_add">新增</a>
		</span>
		<span class="tab-two"></span>
	</div>
   <div class="operation">
    <h3>友情提示</h3>
    <ul>
      <li> 通过首页楼层管理，你可以进行任意定制自己的商城首页楼层信息</li>
      <li> 楼层采用两层管理，第二层用来显示自定义商品信息</li>
    </ul>
  </div> 
  <div class="classtable">
  <form name="ListForm" id="ListForm" action="/floor/goods_floor_list" method="post">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="class_table">
      <tr style="background:#2A7AD2; height:30px; color:#FFF">
        <td width="38">&nbsp;</td>
        <td width="70">排序</td>
        <td width="450" align="left">楼层标题</td>
        <td width="52" align="center">显示</td>
        <td width="126" align="left">操作</td>
      </tr>
    <tbody>
	<#if list_floor??>
	<#list list_floor as floor>
	
      <tr id="${floor.id}">
	    <td align="center">
	    	<input name="ids" id="ids_${floor.id}" type="checkbox" value="${floor.id}">
	    </td>
        <td colspan="2" align="center">
	        <ul class="addclass">
	          <li class="ac1">
	            <input name="addorsubtract_${floor.id}" id="addorsubtract_${floor.id}" type="hidden" value="true">
	            <img src="/images/add.jpg" cls="jian" level="0_${floor.id}" width="14" height="14" id="jian_${floor.id}" onclick="addorsubtract(this,${floor.id});" style="cursor:pointer;"> </li>
	          <li class="ac2"><span class="num">
	            <input type="text" value="${floor.seq}" onblur="ajax_update('${floor.id}','floor_seq',this)" title="可编辑">
	            </span></li>
	          <li class="ac3"><span class="classies">
	            <input type="text" name="${floor.id}" id="${floor.id}" value="${floor.floorname}" onblur="ajax_update('${floor.id}','floor_name',this)" title="可编辑">
	            </span>
	             <span class="newclass"><a href="javascript:void(0);" onclick="addSonFloor(this,'${floor.id}')">新增下级</a></span>
	          </li>
	        </ul>
        </td>
        <td align="center"><img src="/images/${floor.display?string}.png" width="21" height="23" onclick="ajax_update('${floor.id}','floor_display',this)" style="cursor:pointer;" title="可编辑"></td>
        <td align="left" class="ac8">
	        <a href="/floor/floor_edit?id=${floor.id}">编辑</a>
	        |
	        <a href="javascript:void(0);" onclick="if(confirm('删除楼层会同步删除楼层所有数据，是否继续?'))window.location.href='/floor/floor_del?id=${floor.id}'">删除</a>
	        |
	        <a href="/floor/floor_model_edit?id=${floor.id}">模板编辑</a>
        </td>
      </tr>
            
     </#list>
     </#if>       
	</tbody>
	    
		<tr style="background:#F2F2F2; height:30px;">
			<td align="center">
				<input type="checkbox" name="all" id="all" value="" onclick="selectAll(this)">
			</td>
			<td colspan="2" align="center" class="sall">
				<span class="classall">全部</span>
				<span class="shop_btn_del" id="alldel">
					<input name="delchecked" id="delchecked" type="button" value="删除" style="cursor:pointer;" >
				</span>
			</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>   
    </table>
	</form>
	</div>  
</div>


<div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div></body></html>