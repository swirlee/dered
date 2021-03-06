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
				  titlename:{
				    required :true,
	// 			    remote:{
	// 				    url: "",
	// 		            type: "post", 
	// 	 	            dataType: "json",
	// 		            data: {"titlename": function(){return $("#titlename").val();}}
	// 				}
				  },
				  adLogo:{
				   required :true,
				   accept:"gif|jpg|png"
				  },
				  seq:{
					  required :true,
				  }
			  
			},
			messages:{
			  titlename:{required:"广告标题不能为空"},
			  adLogo:{required :"广告图片不能为空",accept:"系统不允许的文件类型"},
			  seq:{required:"请填入排序"}
		   }
		});
		//编辑
		$("#cid").val('');
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
	//品牌保存
	function saveAd(){
		$("#theForm").submit();
	}
</script>
</head>
<body>
<form action="/ad/doaddad" method="post" enctype="multipart/form-data" name="theForm" id="theForm" novalidate="novalidate">
  
    <div class="cont">
    <h1 class="seth1">品牌管理</h1>
    <div class="settab"> 
		<span class="tab-one"></span> <span class="tabs">
	         <a href="/ad/showAd">管理</a> | <a class="this" href="/ad/addad">新增</a></span> 
		<span class="tab-two"></span>	
	</div>
    <div class="setcont" id="base">
      <!--鼠标经过样式-->
      <ul class="set1">
        <li><strong class="orange fontsize20">*</strong>广告标题</li>
        <li>
          <span class="webname">
            <input type="text" name="titlename" id="titlename" value="">
          </span>
        </li>
      </ul>

      
      <ul class="set1">
        <li>广告图片</li>
        <li>
         <span class="size13">
           <input type="text" name="textfield" id="textfield1">
         </span>
	     
	     <span style="float:left;" class="file2">
	       <input type="file" name="adLogo" id="adLogo" size="30">
	     </span>
	  </li>
      </ul>
      <ul class="set1">
        <li>是否推荐</li>
        <li> 
          <span class="webSwitch">
            <input type="hidden" name="display" id="display" value="true">
            <img src="/images/on.jpg" width="61" height="23" id="stateOn" onclick="displayState();" style="cursor: pointer; display: none;"> 
            <img src="/images/off.jpg" width="61" height="23" id="stateOff" onclick="displayState();" style="cursor:pointer">
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
    <input name="save" id="save" type="button" value="提交" onclick="saveAd()">
  </div>
</form>
</body>
</html>