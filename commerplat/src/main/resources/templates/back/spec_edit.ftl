<!DOCTYPE html PUBLIC>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title></title>
<link href="/css/template.css" rel="stylesheet" type="text/css">
<link href="/css/overlay.css" type="text/css" rel="stylesheet">
<script src="/js/jquery-1.6.2.js"></script>
<script src="/js/jquery-ui-1.8.21.js"></script>
<script src="/js/jquery.shop.common.js"></script>
<script src="/js/jquery.validate.min.js"></script>
<script src="/js/jquery.poshytip.min.js"></script>
<script>
$(document).ready(function(){
	//validate校验
	$("#theForm").validate({
		rules:{
			specname:{required :true}
		},
		messages:{
			specname:{required:"规格名称不能为空"}
		}
	});

	var type="text";
	if(type=="text"){
		$("#type1").attr("checked",true);
	}else{
		$("#type2").attr("checked",true);
	}
});
function saveForm(){
	
	$("#theForm").submit();
}
function change_img(obj){
  var sequence=$(obj).attr("id").substring(10);
  var path=$(obj).val();
  var src=getFullPath($(obj)[0]);
  $("#image_"+sequence).attr("src",src);
  $("#textfield_"+sequence).val(path);
}
</script>
<style id="poshytip-css-tip-skyblue" type="text/css">div.tip-skyblue{visibility:hidden;position:absolute;top:0;left:0;}div.tip-skyblue table, div.tip-skyblue td{margin:0;font-family:inherit;font-size:inherit;font-weight:inherit;font-style:inherit;font-variant:inherit;}div.tip-skyblue td.tip-bg-image span{display:block;font:1px/1px sans-serif;height:10px;width:10px;overflow:hidden;}div.tip-skyblue td.tip-right{background-position:100% 0;}div.tip-skyblue td.tip-bottom{background-position:100% 100%;}div.tip-skyblue td.tip-left{background-position:0 100%;}div.tip-skyblue div.tip-inner{background-position:-10px -10px;}div.tip-skyblue div.tip-arrow{visibility:hidden;position:absolute;overflow:hidden;font:1px/1px sans-serif;}</style></head>
<body>
<form action="/spec/doeditspec" method="post" enctype="multipart/form-data" name="theForm" id="theForm" novalidate="novalidate">
  <input type="hidden" name="specid" id="specid" value="${spec.id}">
  <input type="hidden" name="delids" id="delids" value="">
  <div class="cont">
    <h1 class="seth1">规格管理</h1>
    <div class="settab"><span class="tab-one"></span> <span class="tabs"> <a href="http://aishang2018.vicp.io:11585/shopping/admin/goods_spec_list.htm">管理</a> | <a href="http://aishang2018.vicp.io:11585/shopping/admin/goods_spec_add.htm">新增</a> 	   <a href="javascript:void(0);" class="this">编辑</a>
	   </span> <span class="tab-two"></span></div>
    <div class="edit">
      <div class="editul ">
        <ul class="set3">
          <li><strong class="sred">*</strong>规格名称</li>
          <li><span class="pxnum">
            <input type="text" name="specname" id="specname" value="${spec.specname}">
            </span><span id="nothis"><strong class="q"></strong><strong class="w">请填写常用的商品规格的名称；例如：颜色；尺寸等。</strong><strong class="c"></strong></span></li>
        </ul>
        <ul class="set3">
          <li>排序</li>
          <li><span class="pxnum">
         <input type="text" name="seq" id="seq" value="${spec.seq?default('')}">
            </span><span id="nothis"><strong class="q"></strong><strong class="w">请填写整数。类型列表将会根据排序进行由小到大排列显示。</strong><strong class="c"></strong></span></li>
        </ul>
      </div>
      
      
<!--       <div class="spec_type"> -->
<!--         <h3>规格类型</h3> -->
<!--         <ul class="set3"> -->
<!--          <li> -->
<!-- 		  <span class="ssp1"> -->
<!--             <input name="type" type="radio" id="type1" value="text" checked="checked" onclick="img_spec(&#39;0&#39;)"> -->
<!--             文字</span><span class="ssp2"> -->
<!--             <input name="type" id="type2" type="radio" value="img" onclick="img_spec(&#39;1&#39;)"> -->
<!--             图片</span><span id="nothis"><strong class="q"></strong><strong class="w">图片类型的规格值用于直观表现某些特殊规格类型，例如颜色规格，可用对应的色彩图片来表现其各种颜色值。</strong><strong class="c"></strong> -->
<!-- 			</span> -->
<!-- 		</li> -->
<!--        </ul> -->
<!--       </div> -->
      
      
<script>

function img_spec(status){
  if(status=="1"){
    $("span[id^=goods_spec_property_img_]").show();
  }
  if(status=="0"){
    $("span[id^=goods_spec_property_img_]").hide();
  }
}

var delids="";
function remove_goods_spec_property(obj){
	var delid = $(obj).find("#specvid").val();
	$.ajax({
		type:"post",
    	url:"/spec/ajax_edit_del",
		data:{"id":delid,"fieldName":"delete"},
		success:function(data){
			if(data.dd == 1){
				delids += $(obj).find("#specvid").val()+",";
			    $("#delids").val(delids);
			    $(obj).remove();
			}
			if(data.dd == 0){
				alert("该规格已经绑定商品，目前无法删除！");
			}
		}
	});
   
}
function remove_goods_spec_property_2(obj){
	$(obj).remove();
}

function add_goods_spec_property(){
	var goods_spec_property_text="<tr id='goods_spec_'><td width='82'><span class='pxnum size5'><input name='specvseq' id='specvseq' value='' type='text'></span></td><td width='271'><span class='pxnum size7'><input name='specvname' id='specvname' value='' type='text'></span></td><td class='ac8' align='center' width='116'><a href='javascript:void(0);' onclick='remove_goods_spec_property_2(this.parentNode.parentNode)'>删除</a></td></tr>";
	var type=$(":radio:checked").val();
	$(".addsx_table tr[id^=goods_spec_]").last().after(goods_spec_property_text);
}

</script>


      <div class="specification">
        <h2>新增规格值</h2>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="addsx_table">
          <tbody><tr id="goods_spec_">
            <td width="82"><strong>排序</strong></td>
            <td width="271"><strong>规格值</strong></td>
            <td align="center">操作</td>
          </tr>
		  
          <#if list_specv ??>
          <#list list_specv as specv>
          
			<tr id="goods_spec_property">
				<td width="82"><span class="pxnum size5">
					<input type="text" name="oldspecvseq" id="oldspecvseq" value="${specv.seq}">
					<input type="hidden" name="specvid" id="specvid" value="${specv.id}">
				</span></td>
				<td><span class="pxnum size7">
					<input type="text" name="oldspecvname" id="oldspecvname" value="${specv.specvname}" class="valid">
				</span></td>
				<td width="116" align="center" class="ac8">
					<a href="javascript:void(0);" id="${specv.id}" onclick="remove_goods_spec_property(this.parentNode.parentNode,id)">删除</a>
				</td>
            </tr>
          
          </#list>
          </#if>
          
		  <tr>
            <td colspan="3"><span class="newclass"><a href="javascript:void(0);" onclick="add_goods_spec_property();">新增规格值</a></span></td>
            <td>&nbsp;</td>
          </tr>
        </tbody></table>
      </div>

	</div>
    <div class="submit">
      <input name="" type="button" value="提交" onclick="saveForm();">
    </div>
  </div>
</form>


</body></html>