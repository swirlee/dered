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
	//设置默认状态以及判断初始显示状态
		var state = $("#display").val();
		if(state==""){
			$("#display").val("true");
			$("#displayOff").hide();
		}else{
			 if(state=="true"){
				$("#displayOff").hide();
			}else{
				$("#displayOn").hide();
			}
		}
		
		var state1 = $("#recommend").val();
		if(state1==""){
			$("#recommend").val("true");
			$("#recommendOff").hide();
		}else{
			 if(state1=="true"){
				$("#recommendOff").hide();
			}else{
				$("#recommendOn").hide();
			}	
		}	
	//
	$("#pid").val(${pid});
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
	
	$("#theForm").validate({
	    rules:{
		  classname:{required :true},
		  seq:{required :true}
		 },
		messages:{
		  classname:{required:"分类名称不能为空"},
		  seq:{required:"排序不能为空"}
		}
	  });
	  //图标
	  $("#pid").change(function(){
		 var val = $(this).val();
		  if(val==""){
			 $("#icon").show(); 
			 $("#icon_sys_ul").show();
			  }else{
			 $("#icon").hide();	
			 $("#icon_sys_ul").hide();  
			 $("#icon_acc_ul").hide(); 
				  }
		  });
	  $("input[type='radio']").click(function(){
		 var val = $(this).attr("value");
		  if(val==1){
		  $("#icon_sys_ul").hide();
		  $("#icon_acc_ul").show();	  
		  }else{
		  $("#icon_sys_ul").show();
		  $("#icon_acc_ul").hide();		  
		  }
	  });
	  $(".icon_sys a").click(function(){
		  $("#icon_sys").val($(this).attr("icon"));
		  $(this).parent().find("a").removeClass("this");
		  $(this).addClass("this");
		  });
	   $("#icon_acc").change(function(){
		 $("#textfield1").val($("#icon_acc").val());
	   })
	     $("#logoShow").mouseover(function(){
		    $("#logoImg").css('display','block');
	   }).mouseout(function(){
			$("#logoImg").css('display','none');
		});
	});


	function saveForm(method){
		var id = $("#id").val();
	    var pid = $("#pid").val(); 
	    if(id==pid && (id!="")){
	       $("#tishi").css("display","");
	       return false;
	    }
		$("#theForm").submit();
	}

	//设置显示开关
	function displayState(){
		var state = $("#display").val();
		if(state=="true"){
			$("#display").val("false");
			$("#displayOff").show();
			$("#displayOn").hide();
		}else{
			$("#display").val("true");
			$("#displayOff").hide();
			$("#displayOn").show();
		}
	}

	//设置推荐开关
	function recommendState(){
		var state = $("#recommend").val();
		if(state=="true"){
			$("#recommend").val("false");
			$("#recommendOff").show();
			$("#recommendOn").hide();
		}else{
			$("#recommend").val("true");
			$("#recommendOff").hide();
			$("#recommendOn").show();
		}
	}


</script>
</head>
<body>
<div class="cont">
	<h1 class="seth1">商品分类</h1>
	<div class="settab"><span class="tab-one"></span>
      <span class="tabs">
       <a href="/classes/showclasses?pid=0">管理</a>
		|
       <a href="/classes/addclasses" class="this">新增</a>	   
      </span>
      <span class="tab-two"></span>
	</div>
	<form name="theForm" id="theForm" action="/classes/saveClasses" method="post" enctype="multipart/form-data" novalidate="novalidate">
	  <input name="id" type="hidden" id="id" value="">
	  <div class="setcont">
	    <ul class="set1">
	      <li><strong class="orange fontsize20">*</strong>分类名称</li>
	      <li><span class="webname">
	        <input name="classname" type="text" id="classname" value="" size="40">
	      </span></li>
	    </ul>
	    <!--鼠标未经过样式-->
	    <ul class="set1">
	      <li>
	      	上级分类
			<label class="error" style="display:none" id="tishi">不能选择当前分类作为上级</label>
	      </li>
	      <li>
	      <span class="webnamesec sizese">
	        <select name="pid" id="pid">
	              <option value="0">--请选择上级商品分类--</option>
	              <#if list_classes ??>
	              <#list list_classes as classes>
				  <option value="${classes.id}">${classes.classname}</option>
		              <#if classes.list_sonclasses ??>
		              <#list classes.list_sonclasses as sonclasses>
		              <option value="${sonclasses.id}">&nbsp;&nbsp;&nbsp;&nbsp;${sonclasses.classname}</option>
		              </#list>
		              </#if>
	              </#list>
	              </#if>
	         </select>
	      </span>
	      <span id="nothis"><strong class="q"></strong><strong class="w">如果选择上级分类，那么新增的分类则为被选择上级分类的子分类</strong><strong class="c"></strong>
	      </span>
	      </li>
	    </ul>
		
		<ul class="set1">
			<li>显示</li>
			<input name="display" id="display" type="hidden" value="true">
			<img src="/images/on.jpg" width="61" height="23" id="displayOn" onclick="displayState();" style="cursor:pointer">
			<img src="/images/off.jpg" width="61" height="23" id="displayOff" onclick="displayState();" style="cursor: pointer; display: none;">
	    </ul>
	    
	    <ul class="set1">
	      <li>排序</li>
	      <li>
		      <span class="webname">
   				  <input name="seq" type="text" id="seq" value="">
		      </span>
		      <span id="nothis">
			      <strong class="q"></strong>
			      <strong class="w">序号越小，分类显示越靠前</strong>
			      <strong class="c"></strong>
		      </span>
	      </li>
	    </ul>
	    
	    
	    </div>
  </form>
  <div class="submit">
    <input id="save" name="save" type="button" value="提交" onclick="saveForm()">
  </div>
</div>

</body></html>