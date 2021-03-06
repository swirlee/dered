<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
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
			var id=$(this.parentNode).attr("id");
			if(id="nothis"){
			   $(this.parentNode).attr("id","this")
			}
		  }).mouseout(function(){
		     var id=$(this.parentNode).attr("id");
			 if(id="this"){
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
// 			    remote:{
// 				    url: "",
// 		            type: "post", 
// 	// 	            dataType: "json",
// 		            data: {"brandname": function(){return $("#brandname").val();}}
// 				}
			  },
			  brandLogo:{
			   required :true,
			   accept:"gif|jpg|png"
			  }	 
			},
			messages:{
			  brandname:{required:"品牌名称不能为空"}  ,
			  brandLogo:{required :"品牌图片不能为空",accept:"系统不允许的文件类型"}	
		   }
		});
		//编辑
		$("#cid").val('');
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
	function saveBrand(){
		$("#theForm").submit();
	}
</script>
</head>
<body>
<form action="/brand/doaddbrand" method="post" enctype="multipart/form-data" name="theForm" id="theForm" novalidate="novalidate">
  
    <div class="cont">
    <h1 class="seth1">品牌管理</h1>
    <div class="settab"> 
		<span class="tab-one"></span> <span class="tabs">
	         <a href="/brand/showbrand">管理</a>|<a class="this" href="/brand/addbrand">新增</a>
	    </span><span class="tab-two"></span>	
	</div>
    <div class="setcont" id="base">
      <!--鼠标经过样式-->
      <ul class="set1">
        <li><strong class="orange fontsize20">*</strong>品牌名称</li>
        <li>
          <span class="webname">
            <input type="text" name="brandname" id="brandname" value="">
          </span>
        </li>
      </ul>

      <ul class="set1">
        <li>品牌图片</li>
        <li>
         <span class="size13">
           <input type="text" name="textfield" id="textfield1">
         </span>
	     
	     <span style="float:left;" class="file2">
	       <input type="file" name="brandLogo" id="brandLogo" size="30">
	     </span>
	    </li>
      </ul>
      
      <ul class="set1">
        <li>是否推荐</li>
        <li> 
          <span class="webSwitch">
            <input type="hidden" name="recommend" id="recommend" value="true">
            <img src="/images/on.jpg" width="61" height="23" id="stateOn" onclick="recommendState();" style="cursor: pointer; display: none;"> 
            <img src="/images/off.jpg" width="61" height="23" id="stateOff" onclick="recommendState();" style="cursor:pointer">
          </span>
          <span id="nothis"><strong class="q"></strong><strong class="w">推荐品牌将在首页轮换显示</strong><strong class="c"></strong></span>
        </li> 
      </ul>
      <ul class="set1">
        <li>排序</li>
        <li>
          <span class="webname">
            <input type="number" name="seq" id="seq" value="">
          </span>
          <span id="nothis"><strong class="q"></strong><strong class="w">序号越小显示越靠前</strong><strong class="c"></strong></span>
        </li>
      </ul>
    </div>
  </div>
  <div class="submit">
    <input name="save" id="save" type="button" value="提交" onclick="saveBrand()">
  </div>
</form>
</body>
</html>