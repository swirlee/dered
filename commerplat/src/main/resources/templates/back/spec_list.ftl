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
function ajax_update(id,fieldName,obj){
	var val=$(obj).val();
	$.ajax({
		type:"post",
    	url:"/spec/ajax_update",
		data:{"id":id,"fieldName":fieldName,"value":val},
		success:function(data){
			if(data.dd == 1){
				$(obj).parent().parent().remove();
			}
			if(data.dd == 0){
				alert("该规格已经绑定商品，目前无法删除！");
			}
		}
	});
}
</script>
<style id="poshytip-css-tip-skyblue" type="text/css">div.tip-skyblue{visibility:hidden;position:absolute;top:0;left:0;}div.tip-skyblue table, div.tip-skyblue td{margin:0;font-family:inherit;font-size:inherit;font-weight:inherit;font-style:inherit;font-variant:inherit;}div.tip-skyblue td.tip-bg-image span{display:block;font:1px/1px sans-serif;height:10px;width:10px;overflow:hidden;}div.tip-skyblue td.tip-right{background-position:100% 0;}div.tip-skyblue td.tip-bottom{background-position:100% 100%;}div.tip-skyblue td.tip-left{background-position:0 100%;}div.tip-skyblue div.tip-inner{background-position:-10px -10px;}div.tip-skyblue div.tip-arrow{visibility:hidden;position:absolute;overflow:hidden;font:1px/1px sans-serif;}</style></head>





<body>
<div class="cont">
	<h1 class="seth1">规格管理</h1>
	<div class="settab">
		<span class="tab-one"></span>
		<span class="tabs">
			<a href="/spec/showspec" class="this">管理</a>
			| 
			<a href="/spec/addspec">新增</a>
		</span>
		<span class="tab-two"></span>
	</div>
  <form name="ListForm" id="ListForm" action="http://aishang2018.vicp.io:11585/shopping/admin/goods_spec_list.htm" method="post">
  <div id="list">
    <div class="typemanager">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="specific_table">
        <tbody><tr style="background:  #2A7AD2       ; height:30px; color:#FFF">
          <td width="5%">&nbsp;</td>
          <td width="10%">排序</td>
          <td width="20%">规格名称</td>
          <td width="40%">规格值</td>
          <td align="center">操作</td>
        </tr>
		<#if list_spec??>
			<#list list_spec as spec>
				<tr>
					<td align="center">
						<input name="id" type="checkbox" id="id" value="${spec.id}">
					</td>
					<td><span class="pxnum size5">
						<input type="text" name="${spec.seq?default('')}" id="${spec.seq?default('')}" value="${spec.seq?default('')}" onblur="ajax_update('${spec.id}','seq',this)" title="可编辑">
					</span></td>
					<td><span class="pxnum size7"><span class="pxnum size5">
						<input type="text" name="${spec.specname?default('')}" id="${spec.specname?default('')}" value="${spec.specname?default('')}" onblur="ajax_update('${spec.id}','specname',this)" title="可编辑">
					</span></span></td>
					<td>${spec.specvnames?default("")}</td>
					<td align="center" class="ac8">
						<a href="/spec/spec_edit?id=${spec.id}">编辑</a>
						|
						<a href="javascript:voud(0);" onclick="if(confirm('删除后不可恢复，是否继续?')){return ajax_update('${spec.id}','delete',this)}">删除</a>
					</td>
				</tr>
			</#list>
		</#if>      
                <tr>
          <td align="center"><input type="checkbox" name="all" id="all" value="" onclick="selectAll(this)">
             
          </td>
          <td colspan="2" class="bdel"><span class="sp1">全部</span> <span class="sp2">
            <div class="shop_btn_del shopbtn">
              <input name="Input" type="button" value="删除" onclick="cmd('http://aishang2018.vicp.io:11585/shopping/admin/goods_spec_del.htm');" style="cursor:pointer;">
            </div>
          </span> </td>
          <td colspan="4"></td>
        </tr>
      </tbody></table>
    </div>
    <div class="fenye">
      <input name="currentPage" type="hidden" id="currentPage" value="1">
	  <input name="mulitId" type="hidden" id="mulitId">
      <a href="javascript:void(0);" onclick="return gotoPage(1)">首页</a> 第　<a class="this" href="javascript:void(0);" onclick="return gotoPage(1)">1</a> <a href="javascript:void(0);" onclick="return gotoPage(2)">2</a> 页　<a href="javascript:void(0);" onclick="return gotoPage(2)">下一页</a> <a href="javascript:void(0);" onclick="return gotoPage(2)">末页</a> </div>
  </div>
</form>
</div>


<div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div><div class="tip-skyblue"><div class="tip-inner tip-bg-image"></div><div class="tip-arrow"></div></div></body></html>