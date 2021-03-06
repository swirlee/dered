<!DOCTYPE html PUBLIC>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title></title>
<link href="/css/template.css" rel="stylesheet" type="text/css">
<link href="/js/overlay.css" type="text/css" rel="stylesheet">
<script src="/js/jquery-1.6.2.js"></script>
<script src="/js/jquery-ui-1.8.21.js"></script>
<script src="/js/jquery.shop.common.js"></script>
<script src="/js/jquery.validate.min.js"></script>
<script src="/js/jquery.poshytip.min.js"></script>
<script>
$(document).ready(function(){
	$("#theForm").validate({
	    rules:{
	    	specname:{required :true},
			seq:{required :true},
	    	specvseq0:{required :true},
	    	specvname0:{required :true}
		},
		messages:{
			specname:{required:"规格名称不能为空"},
			seq:{required:"排序不能为空"},
			specvseq0:{required:"需添加一个规格值排序"},
			specvname0:{required:"需添加一个规格值"}
		}
	});
});
function saveForm(){
	$("#count").val(count);
	$("#theForm").submit();
}
function change_img(obj){
  var sequence=$(obj).attr("id").substring(10);
  var path=$(obj).val();
  var src=getFullPath($(obj)[0]);
  $("#image_"+sequence).attr("src",src);
  $("#textfield_"+sequence).val(path);
}



var count=1;
function img_spec(status){
  if(status=="1"){
    $("span[id^=goods_spec_property_img_]").show();
  }
  if(status=="0"){
    $("span[id^=goods_spec_property_img_]").hide();
  }
}

function add_goods_spec_property(){
count++;
 var goods_spec_property_img="<tr id='goods_spec_'><td width='82'><span class='pxnum size5'><input name='sequence_count' id='sequence_count' value='' type='text'></span></td><td width='271'><span class='pxnum size7'><input name='seq' id='seq' value='' type='text'></span></td><td class='liul' width='558'><span id='goods_spec_property_img_' class='size13'><input name='textfield_count' id='textfield_count' type='text'></span> <span class='filebtn' id='goods_spec_property_img_'><input name='button' id='button1' value='' type='button'></span> <span id='goods_spec_property_img_' style='float:left;' class='file'><input name='specImage_count' id='specImage_count' size='30' type='file' onchange='change_img(this);'></span><span id='goods_spec_property_img_' class='pic_spe'><img id='image_count' name='image_count' src='http://tongzhenpro.oss-cn-beijing.aliyuncs.com/resources/style/common/images/transparent.gif' height='16' width='16'></span></td><td class='ac8' align='center' width='116'><a href='javascript:void(0);' onclick='(this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode))'>删除</a></td></tr>";
  var goods_spec_property_text="<tr id='goods_spec_'><td width='82'><span class='pxnum size5'><input name='specvseq' id='specvseq' value='' type='text'></span></td><td width='271'><span class='pxnum size7'><input name='specvname' id='specvname' value='' type='text'></span></td><td class='liul' width='558'><span id='goods_spec_property_img_' style='display:none;' class='size13'><input name='textfield_count' id='textfield_count' type='text'></span> <span class='filebtn' id='goods_spec_property_img_'  style='display:none;'><input name='button' id='button1' value='' type='button'></span> <span id='goods_spec_property_img_'  style='float:left;display:none;' class='file'><input name='specImage_count' id='specImage_count' size='30' type='file'  onchange='change_img(this);'></span><span id='goods_spec_property_img_'  style='display:none;' class='pic_spe'><img   id='image_count' name='image_count' src='http://tongzhenpro.oss-cn-beijing.aliyuncs.com/resources/style/common/images/transparent.gif' height='16' width='16'></span></td><td class='ac8' align='center' width='116'><a href='javascript:void(0);' onclick='(this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode))'>删除</a></td></tr>";
  var type=$(":radio:checked").val();
  if(type=="img"){
    $(".addsx_table tr[id^=goods_spec_]").last().after(goods_spec_property_img.replace(/count/g,count));
  }else{
    $(".addsx_table tr[id^=goods_spec_]").last().after(goods_spec_property_text);
  }
}
</script>
<style id="poshytip-css-tip-skyblue" type="text/css">
	div.tip-skyblue{
		visibility:hidden;
		position:absolute;
		top:0;left:0;
	}
	div.tip-skyblue table, div.tip-skyblue td{
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
</head>
<body>
<form action="/spec/doaddspec" method="post" enctype="multipart/form-data" name="theForm" id="theForm">
  <input name="id" id="id" type="hidden" value="">
  <input name="add_url" type="hidden" id="add_url" value="">
  <input name="list_url" type="hidden" id="list_url" value="">
  <input name="count" type="hidden" id="count">
  <div class="cont">
    <h1 class="seth1">规格管理</h1>
	<div class="settab">
		<span class="tab-one"></span>
		<span class="tabs">
			<a href="/spec/showspec">管理</a>
			| 
			<a href="/spec/addspec" class="this">新增</a>
		</span>
	</div>
    
      <div class="editul ">
        <ul class="set3">
          <li><strong class="sred">*</strong>规格名称</li>
          <li><span class="pxnum">
            <input name="specname" type="text" id="specname" value="">
            </span><span id="nothis"><strong class="q"></strong><strong class="w">请填写常用的商品规格的名称；例如：颜色；尺寸等。</strong><strong class="c"></strong></span></li>
        </ul>
        <ul class="set3">
          <li>排序</li>
          <li><span class="pxnum">
         <input name="seq" type="text" id="seq" value="">
            </span><span id="nothis"><strong class="q"></strong><strong class="w">请填写整数。类型列表将会根据排序进行由小到大排列显示。</strong><strong class="c"></strong></span></li>
        </ul>
      </div>
      <div class="spec_type">
        <h3>规格类型</h3>
        <ul class="set3">
         <li>
		  <span class="ssp1">
            <input name="type" type="radio" id="type1" value="text" checked="checked" onclick="img_spec('0')">
            文字</span><span class="ssp2">
            <input name="type" id="type2" type="radio" value="img" onclick="img_spec('1')">
            图片</span><span id="nothis"><strong class="q"></strong><strong class="w">图片类型的规格值用于直观表现某些特殊规格类型，例如颜色规格，可用对应的色彩图片来表现其各种颜色值。</strong><strong class="c"></strong>
			</span>
		</li>
       </ul>
      </div>

      <div class="specification">
        <h2>新增规格值</h2>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="addsx_table">
          <tbody><tr id="goods_spec_">
            <td width="82"><strong>排序</strong></td>
            <td width="271"><strong>规格值</strong></td>
            <td width="558"><strong><span id="goods_spec_property_img_" style="display:none;">规格图片</span></strong></td>
            <td align="center">操作</td>
          </tr>
          
		   <tr id="goods_spec_property">
            <td width="82"><span class="pxnum size5">
            	<input  type="text" name="specvseq" id="specvseq" value="">
            </span></td>
            <td width="271"><span class="pxnum size7">
            	<input type="text" name="specvname" id="specvname" value="">
            </span></td>
            
            <td width="558" class="liul">
            	<span class="size13" id="goods_spec_property_img_" style="display:none;">
					<input type="text" name="textfield_1" id="textfield_1">
				</span>
				<span class="filebtn" id="goods_spec_property_img_" style="display:none;">
					<input type="button" name="button" id="button1" value="">
				</span>
				
				<span class="pic_spe" id="goods_spec_property_img_" style="display:none;">
					<img id="image_1" name="image_1" src="/images/transparent.gif" width="16" height="16">
				</span>
			</td>
            <td width="116" align="center" class="ac8"><a href="javascript:void(0);" onclick="(this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode))">删除</a></td>
          </tr>
          
		  <tr>
            <td colspan="3"><span class="newclass"><a href="javascript:void(0);" onclick="add_goods_spec_property();">新增规格值</a></span></td>
            <td>&nbsp;</td>
          </tr>
        </tbody></table>
      </div>

	</div>
    <div class="submit">
      <input name="" type="submit" value="提交" >
    </div>
  </div>
</form>


</body></html>