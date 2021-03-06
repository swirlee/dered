<!DOCTYPE>
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
	 	
	//validate校验
	$("#theForm").validate({
		rules:{
			floor_name:{required :true}
		},
		messages:{
			floor_name:{required:"楼层标题不能为空"}
		}
	});
	
	//下拉框的默认值
	$("#pid").val(${floor.pid});
	
	//显示开关初始值
	if(${floor.display?string}==true){
	     $("#floor_display_img").attr("src","/images/on.jpg");
		 $("#floor_display").val("true");
	}else{
	     $("#floor_display_img").attr("src","/images/off.jpg");
		 $("#floor_display").val("false");
	 }
	
	//显示开关
	 $("#floor_display_img").click(function(){
	   var floor_display=$("#floor_display").val();
	   if(floor_display=="true"){
	     $("#floor_display_img").attr("src","/images/off.jpg");
		 $("#floor_display").val("false");
	    }else{
	     $("#floor_display_img").attr("src","/images/on.jpg");
		 $("#floor_display").val("true");
	   }
	 });

});

//提交按钮
function saveForm(){
	$("#theForm").submit();
}

</script>
</head>

<body>
	<div class="cont">
		<h1 class="seth1">首页楼层</h1>
		<div class="settab">
			<span class="tab-one"></span>
			<span class="tabs">
				<a href="/floor/goods_floor_list">管理</a>|<a href="/floor/floor_add">新增</a>|<a class="this" href="">编辑</a>	 	 
			</span>
			<span class="tab-two"></span>
		</div>
		
		<form name="theForm" id="theForm" action="/floor/floor_doupdate" method="post">
			<input type="hidden" name="id" id="id" value="${floor.id}">
			<input type="hidden" name="floor_display" id="floor_display" value="true">
					  
			<div class="setcont">
				<ul class="set1">
					<li><strong class="orange fontsize20">*</strong>楼层标题</li>
					<li><span class="webname"><input name="floor_name" id="floor_name" type="text" size="40" value="${floor.floorname}"></span></li>
				</ul>
				<ul class="set1">
					<li>
						<span class="webnamesec sizese">
							<select name="pid" id="pid">
								<option value="0">请选择上级楼层...</option>
								<#if list_floor??>
								<#list list_floor as floor>
								<option value="${floor.id}">${floor.floorname}</option>
								</#list>
     							</#if> 
							</select>
						</span>
						<span id="nothis">
							<strong class="q"></strong>
							<strong class="w">如果选择上级分类，那么新增的分类则为被选择上级分类的子分类</strong>
							<strong class="c"></strong>
						</span>
					</li>
				</ul>
		
				<ul class="set1">
					<li>显示</li>
					<img width="61" height="23" id="floor_display_img" style="cursor: pointer;" src="">
				</ul>
				<ul class="set1">
					<li>排序</li>
					<li>
						<span class="webname">
							<input name="floor_seq" id="floor_seq" type="text" value="${floor.seq}"> 
				        </span>
				        <span id="nothis">
					        <strong class="q"></strong>
					        <strong class="w">序号越小，楼层显示越靠前</strong>
					        <strong class="c"></strong>
				        </span>
			        </li>
		        </ul>
	        </div>
        </form>
        
		<div class="submit">
			<input name="save" onclick="saveForm()" type="button" value="提交"> 
		</div>
		
	</div>
</body>
</html>