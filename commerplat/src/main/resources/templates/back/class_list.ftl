<!DOCTYPE html PUBLIC>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/css/template.css" rel="stylesheet" type="text/css">
<script src="/js/jquery-1.6.2.js"></script>
<script src="/js/jquery.shop.common.js"></script>
<script src="/js/jquery.poshytip.min.js"></script>

<style id="poshytip-css-tip-skyblue" type="text/css">
	div.tip-skyblue{
		visibility:hidden;
		position:absolute;
		top:0;
		left:0;
	}
	div.tip-skyblue table,div.tip-skyblue td{
		margin:0;
		font-family:inherit;
		font-size:inherit;
		font-weight:inherit;
		font-style:inherit;
		font-variant:inherit;
	}
	div.tip-skyblue td.tip-bg-image span{
		display:block;
		font:1px/1px sans-serif;
		height:10px;
		width:10px;
		overflow:hidden;
	}
	div.tip-skyblue td.tip-right{
		background-position:100% 0;
	}
	div.tip-skyblue td.tip-bottom{
		background-position:100% 100%;
	}
	div.tip-skyblue td.tip-left{
		background-position:0 100%;
	}
	div.tip-skyblue div.tip-inner{
		background-position:-10px -10px;
	}
	div.tip-skyblue div.tip-arrow{
		visibility:hidden;
		position:absolute;
		overflow:hidden;
		font:1px/1px sans-serif;
	}
</style>

<script>

//分类的三级联动	
function addorsubtract(obj,id){
	var cls = $(obj).attr("cls");
	var level = $(obj).attr("level");
  	if(cls == "jian"){
  		$.ajax({
			type:"post",
			url:"/classes/appendSonList",
			data:{"id":id},
			success:function(data){
				$(obj).parent().parent().parent().parent().after(data);
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
	if(fieldName == "classname"){
		if(val==""){
			alert("分类名不能为空！！！");
		}
		var classname = $("#cname_"+id+"").val();
		$(obj).val(classname);
		return;
	}
	if(fieldName == "seq"){
		if(val==""){
			alert("排序不能为空！！！");
		}
		var seq = $("#cseq_"+id+"").val();
		$(obj).val(seq);
		return;
	}
    $.ajax({
		type:'post',
		url:'/classes/goods_class_ajax',
		data:{"id":id,"fieldName":fieldName,"value":val},
		success:function(data){
        	if(val == ""){
        		$(obj).attr("src","/images/"+data.cc.display+".png");
			} 
        	if(data.dd == 1){
				$(obj).parent().parent().remove();
			}
			if(data.dd == 0){
				alert("该商品已绑定至订单、楼层或广告页，无法删除！");
			}
			if(fieldName == "classname"){
				$("#cname_"+id+"").val();
			}
			if(fieldName == "seq"){
				$("#cseq_"+id+"").val();
			}
		}
	});
}
	
</script>

</head>

<body>
<div class="cont">
	<h1 class="seth1">商品分类</h1>
	<div class="settab">
		<span class="tab-one"></span>
			<span class="tabs">
				<a href="/classes/showclasses?pid=0" class="this">管理</a>
				|
				<a href="/classes/addclasses">新增</a>
			</span>
		<span class="tab-two"></span>
	</div>
   <div class="operation">
    <h3>友情提示</h3>
    <ul>
      <li>通过商品分类管理，你可以进行查看、编辑、删除系统商品分类</li>
      <li>你可以根据需要控制商品分类是否显示</li>
    </ul>
  </div> 
  <div class="classtable">
  <form name="ListForm" id="ListForm" action="http://y14u504114.imwork.net:12111/shopping/admin/goods_class_list.htm" method="post">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="class_table">
		<tbody>
		<tr style="background:#2A7AD2; height:30px; color:#FFF">
	        <td width="38">&nbsp;</td>
	        <td width="70">排序</td>
	        <td width="450" align="left">分类名称</td>
	        <td width="99" align="center">类型</td>
	        <td width="52" align="center">显示</td>
	        <td width="126" align="left">操作</td>
		</tr>
    
    	<#list list_classes as classes>
		<tr id="${classes.id}">
		    <td align="center"><input name="ids" id="ids" type="checkbox" value="${classes.id}"></td>
	        <td colspan="2" align="center">
	        	<ul class="addclass">
					<li class="ac1">
			            <input name="addorsubtract_${classes.id}" id="addorsubtract_${classes.id}" type="hidden" value="true">
			            <img src="/images/add.jpg" cls="jian" level="0_${classes.id}" width="14" height="14" id="jian_${classes.id}" onclick="addorsubtract(this,${classes.id});" style="cursor:pointer;">
					</li>
					<li class="ac2">
						<span class="num">
							<input type="text" name="0" id="0" value="${classes.seq}" onblur="ajax_update('${classes.id}','seq',this)" title="可编辑">
							<input type="hidden" name="cseq_${classes.id}" id="cseq_${classes.id}" value="${classes.seq}">
						</span>
					</li>
					<li class="ac3">
						<span class="classies">
							<input type="text" name="${classes.id}" id="${classes.id}" value="${classes.classname}" onblur="ajax_update('${classes.id}','classname',this)">
							 <input type="hidden" name="cname_${classes.id}" id="cname_${classes.id}" value="${classes.classname}">
						</span>
						<span class="newclass">
							<a href="/classes/addclasses?pid=${classes.id}">新增下级</a>
						</span>
					</li>
				</ul>
	        </td>
	        <td id="ccc" align="center">${classes.classname}</td>
	        <td align="center"><img src="/images/${classes.display?string}.png" width="21" height="23" onclick="ajax_update('${classes.id}','display',this)" style="cursor:pointer;" title="可编辑"></td>
	        
	        <td align="left" class="ac8">
		        <a href="/classes/class_update?id=${classes.id}">编辑</a>
		        |
		        <a href="javascript:void(0);" onclick="if(confirm('删除分类会同时删除该分类的所有下级，是否继续?')){ajax_update('${classes.id}','delete',this)}">删除</a>
	        </td>
		</tr>
    	</#list>
      
      
      
     <tr style="background:#F2F2F2; height:30px;">
		<td align="center"><input type="checkbox" name="all" id="all" value="" onclick="selectAll(this)"></td>
        <td colspan="2" align="center" class="sall"><span class="classall">全部</span><span class="shop_btn_del" id="alldel">
          <input name="input" type="button" value="删除" style="cursor:pointer;" onclick="cmd('back/goods_class_del.htm')">
          </span><span class="shop_btn_del" id="alldel">
            <input name="input" type="button" value="推荐" style="cursor:pointer;" onclick="cmd('back/goods_class_recommend.htm')">
          </span></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr> 
        
    </tbody></table>
    
	  <input type="hidden" name="currentPage" id="currentPage" value="1">
	  <input name="mulitId" type="hidden" id="mulitId">
		<div class="fenye">
		<a href="back/goods_class_list.htm?currentPage=1">首页</a>
		 第
		<a class="this" href="back/goods_class_list.htm?currentPage=1">1</a>
		页
		<a href="back/goods_class_list.htm?currentPage=1">末页</a>
		</div>	 
   </form>
  </div>  
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