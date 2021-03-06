<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- saved from url=(0074)http://aishang2018.vicp.io:11585/shopping/admin/goods_brand_edit.htm?id=86 -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link href="/css/template.css" rel="stylesheet" type="text/css">
<script src="/js/jquery-1.6.2.js"></script>
<script src="/js/jquery.validate.min.js"></script>
<script>
	$(document).ready(function(){
	 	//改变系统提示的样式
	  $("span .w").mousemove(function(){
		var id = $(this.parentNode).attr("id");
		if(id = "nothis"){
		   $(this.parentNode).attr("id","this")
		}
	  }).mouseout(function(){
	     var id = $(this.parentNode).attr("id");
		 if(id = "this"){
		   $(this.parentNode).attr("id","nothis")
		 }
	  });
	//设置推荐的默认装态
	var rec = $("#recommend").val();
		if(rec == "true"){
			$("#stateOn").show();
			$("#stateOff").hide();
		}else{
			$("#stateOn").hide();
			$("#stateOff").show();
		}
	//标志图片鼠标经过显示
	$("#brandImgShow").mouseover(function(){
		$("#brandImg").show();
	})
	$("#brandImgShow").mouseout(function(){
		$("#brandImg").hide();
	})
	$("#brandLogo").change(function(){
		$("#textfield1").val($("#brandLogo").val());
	})
	//
	$("#theForm").validate({
	    rules:{
		  brandname:{
		    required :true,
		    //remote:{
			   // url: "back_goods_brand_addorupdate_brandnameCheck",
	            //type: "post", 
// 	            dataType: "json",
	            //data: {"brandname": function(){return $("#brandname").val();},"id":function(){return $("#id").val()}}
			//}
		  }  	 
	    },
		messages:{
		  brandname:{required:"品牌名称不能为空",remote:"该品牌已经存在"}  
	    }
	});
	//编辑
// 	$("#cid").val('14');
	//结束
	});
	//修改推荐状态
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
	//品牌保存
	function saveBrand(method){
// 		$("#cmd").val(method);
		$("#theForm").submit();
	}
</script>
</head>
<body>
<form action="/brand/back_goods_brand_doupdate" method="post" enctype="multipart/form-data" name="theForm" id="theForm" novalidate="novalidate">
  <input name="id" id="id" type="hidden" value="${brand.id }">
  <input name="cmd" id="cmd" type="hidden">
  <input name="" type="hidden" id="list_url" value="">
  <input name="" type="hidden" id="add_url" value="">
  <div class="cont">
    <h1 class="seth1">品牌管理</h1>
    <div class="settab"> 
		<span class="tab-one"></span> <span class="tabs">
	     	<a href="back_goods_brand_list">管理</a> | <a href="back_goods_brand_add">新增</a>| <a href="javascript:void(0)" class="this">编辑</a>
	    </span> 
		<span class="tab-two"></span>	
	</div>
    <div class="setcont" id="base">
      <!--鼠标经过样式-->
      <ul class="set1">
        <li><strong class="orange fontsize20">*</strong>品牌名称</li>
        <li>
          <span class="webname">
            <input name="brandname" type="text" id="brandname" value="${brand.brandname }">
          </span>
        </li>
      </ul>
      

      <ul class="set1">
        <li>品牌图片</li>
        <li>
          <span class="size13">
            <input name="textfield" type="text" id="textfield1">
          </span>
	     
	      <span style="float:left;" class="file2">
	        <input name="brandLogo" type="file" id="brandLogo" size="30">
	      </span>
	      <span class="preview">
	  	    <img src="/images/preview.jpg" width="25" height="25" id="brandImgShow">
	  	  </span>
	      <span id="nothis"><strong class="q"></strong><strong class="w">最佳尺寸93*33，支持格式gif,jpg,jpeg,png</strong><strong class="c"></strong></span>
	      <div class="bigimgpre" id="brandImg" style="display:none;">
	        <img src="${brand.path }" width="100" height="100">
	      </div>
	    </li>
      </ul>
    
      <ul class="set1">
        <li>是否推荐</li>
        <li> 
          <span class="webSwitch">
            <input name="recommend" id="recommend" type="hidden" value="true">
            <img src="/images/on.jpg" width="61" height="23" id="stateOn" onclick="recommendState();" style="cursor:pointer"> 
            <img src="/images/off.jpg" width="61" height="23" id="stateOff" onclick="recommendState();" style="cursor: pointer; display: none;">
          </span>
          <span id="nothis"><strong class="q"></strong><strong class="w">推荐品牌将在首页轮换显示</strong><strong class="c"></strong></span>
        </li> 
      </ul>
      <ul class="set1">
        <li>排序</li>
        <li>
          <span class="webname">
            <input name="seq" type="number" id="seq" value="${brand.seq }">
          </span><span id="nothis"><strong class="q"></strong><strong class="w">序号越小显示越靠前</strong><strong class="c"></strong></span>
        </li>
      </ul>
    </div>
  </div>
  <div class="submit">
    <input name="" type="button" value="提交" onclick="saveBrand(&#39;save&#39;);">
  </div>
</form>
</body>
</html>