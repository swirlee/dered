<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- saved from url=(0074)http://aishang2018.vicp.io:11585/shopping/admin/goods_ad_edit.htm?id=86 -->
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
	var rec = $("#display").val();
		if(rec == "true"){
			$("#stateOn").show();
			$("#stateOff").hide();
		}else{
			$("#stateOn").hide();
			$("#stateOff").show();
		}
	//标志图片鼠标经过显示
	$("#adImgShow").mouseover(function(){
		$("#adImg").show();
	})
	$("#adImgShow").mouseout(function(){
		$("#adImg").hide();
	})
	$("#adLogo").change(function(){
		$("#textfield1").val($("#adLogo").val());
	})
	//
	$("#theForm").validate({
	    rules:{
		  adname:{
		    required :true,
		    //remote:{
			   // url: "back_goods_ad_addorupdate_adnameCheck",
	            //type: "post", 
// 	            dataType: "json",
	            //data: {"adname": function(){return $("#adname").val();},"id":function(){return $("#id").val()}}
			//}
		  }  	 
	    },
		messages:{
		  adname:{required:"品牌名称不能为空",remote:"该品牌已经存在"}  
	    }
	});
	//编辑
// 	$("#cid").val('14');
	//结束
	});
	//修改推荐状态
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
	//广告保存
	function saveAd(){
		$("#theForm").submit();
	}
</script>
</head>
<body>
<form action="/ad/back_goods_ad_doupdate" method="post" enctype="multipart/form-data" name="theForm" id="theForm" novalidate="novalidate">
  <input name="id" id="id" type="hidden" value="${ad.id}">
  <input name="cmd" id="cmd" type="hidden">
  <input name="" type="hidden" id="list_url" value="">
  <input name="" type="hidden" id="add_url" value="">
  <div class="cont">
    <h1 class="seth1">广告管理</h1>
    <div class="settab"> 
		<span class="tab-one"></span> <span class="tabs">
	     	<a href="/ad/showAd">管理</a> | <a href="/ad/addad">新增</a> | <a href="javascript:void(0)" class="this">编辑</a>
	    </span> 
		<span class="tab-two"></span>	
	</div>
    <div class="setcont" id="base">
      <!--鼠标经过样式-->
      <ul class="set1">
        <li><strong class="orange fontsize20">*</strong>广告标题</lzi>
        <li>
          <span class="webname">
            <input name="titlename" type="text" id="titlename" value="${ad.titlename}">
          </span>
        </li>
      </ul>

      
      <ul class="set1">
        <li>广告图片</li>
        <li>
          <span class="size13">
            <input name="textfield" type="text" id="textfield1">
          </span>
	      <span style="float:left;" class="file2">
	        <input name="adLogo" type="file" id="adLogo" size="30">
	      </span>
	      <span class="preview">
	  	    <img src="/images/preview.jpg" width="25" height="25" id="adImgShow">
	  	  </span>
	      <span id="nothis"><strong class="q"></strong><strong class="w">最佳尺寸93*33，支持格式gif,jpg,jpeg,png</strong><strong class="c"></strong></span>
	      <div class="bigimgpre" id="adImg" style="display:none;">
	        <img src="${ad.path }" width="100" height="100">
	      </div>
	    </li>
      </ul>
    
      <ul class="set1">
        <li>是否推荐</li>
        <li> 
          <span class="webSwitch">
            <input name="display" id="display" type="hidden" value="true">
            <img src="/images/on.jpg" width="61" height="23" id="stateOn" onclick="displayState();" style="cursor:pointer"> 
            <img src="/images/off.jpg" width="61" height="23" id="stateOff" onclick="displayState();" style="cursor: pointer; display: none;">
          </span>
          <span id="nothis"><strong class="q"></strong><strong class="w">推荐品牌将在首页轮换显示</strong><strong class="c"></strong></span>
        </li> 
      </ul>
      <ul class="set1">
        <li>排序</li>
        <li>
          <span class="webname">
            <input name="seq" type="number" id="seq" value="${ad.seq?default('')}">
          </span><span id="nothis"><strong class="q"></strong><strong class="w">序号越小显示越靠前</strong><strong class="c"></strong></span>
        </li>
      </ul>
    </div>
  </div>
  <div class="submit">
    <input name="" type="button" value="提交" onclick="saveAd();">
  </div>
</form>
</body>
</html>