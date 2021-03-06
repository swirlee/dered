<script>
$(document).ready(function(){
	//分类选择栏改变，添加分类栏
	$("#classesSelect").change(function(){
		var id = $(this).val();
		var pid = $(this).find("option:selected").attr("pid");
		var classname = $(this).find("option:selected").attr("classname");
		if(id != null){
			$.ajax({
				type:"post",
				url:"/floor/ajax_edit_classes",
				data:{"id":id},
				success:function(data){
					//选择的为1级分类
					if(pid == 0){								
						var str ="<li class='box_edit_li'><h6><a name='see_id' ondblclick='javascript:$(this.parentNode.parentNode).remove();' id='"+data.classes.id+"' classids='"+data.classes.id+"' href='javascript:void(0);'>"+data.classes.classname+"</a></h6><span id='child_"+data.classes.id+"' class='ui-sortable'>";
						$.each(data.classes.list_sonclasses,function(i,classes){
							str += "<a name='see_id' href='javascript:void(0);' ondblclick='javascript:$(this).remove();' id='"+classes.id+"' classids='"+classes.id+"'>"+classes.classname+"</a>";
						});
						str +="</span></li>";
						$("#pinjie").append(str);
					}
					//选择的为2级分类
					if(pid != 0){								
						var str = "<li class='box_edit_li'><h6><a name='see_id' ondblclick='javascript:$(this.parentNode.parentNode).remove();' id='"+data.classes.id+"' classids='"+data.classes.id+"' href='javascript:void(0);'>"+data.classes.classname+"</a></h6></li>";
						$("#pinjie").append(str);
					}
				}
			});	
			
		}
		
	});

});
function save_form(){
	if($("ul[name=seengoods]").length>0){
		var arr = new Array();
		$("ul[name=seengoods]").each(function(){
			arr.push($(this).attr("goods_id"));
		});
		$("#arr").val(arr);
	}
	$("#theForm").submit();
	
}

//选择商品，显示在上方
function goods_list_set(obj){
	var count = $("ul[name=seengoods]").length;
	var a= 0;
	var goodsid = $(obj).attr("goods_id");
	var arr = $("ul[name=seengoods]");
	$.each(arr,function(){
		if($(this).attr("goods_id") == goodsid){
			alert("已添加该商品！");
			a=1;
    	}
	}); 
	
	if(a!=1){
		if(count>=6){
			alert("最多添加6件商品！！！");
		}else{
			var goodspath = $(obj).attr("img_uri");
			var goodsid = $(obj).attr("goods_id");
			var goodsname = $(obj).attr("goods_name");
			$("#floor_goods_info").append("<ul ondblclick='$(this).remove();' name='seengoods' goods_id='"+goodsid+"' class='floor_pro'><li class='floor_pro_img'><img src='"+goodspath+"' width='100' height='100'></li><li class='floor_pro_name'>"+goodsname+"</li></ul>")
		}
	}
	
	
}

//选择商品，显示在上方
function goods_floor_list_goods_load(){
	
	var goodsname = $("#search_goodsname").val();
	var classesid = $("#gc_id").val();
	$.ajax({
		type:"post",
		data:JSON.stringify({"goodsname":goodsname,"classesid":classesid}),
		contentType:"application/json",
		url:"/floor/floor_floor_select_goods",
		success:function(data){
			var str = "";
			$.each(data.list_goods,function(i,goods){
				str += "<li><a href='javascript:void(0);' onclick='goods_list_set(this);' img_uri='"+goods.path+"' goods_name='"+goods.goodsname+"' goods_id='"+goods.id+"' class='floor_sear_a'><span class='floor_sear_img'> <img src='"+goods.path+"' width='70' height='70'></span><span class='floor_sear_name'>"+goods.goodsname+"</span></a></li>";
			});
			$("#floor_sear_pro").empty();
			$("#floor_sear_pro").append(str);
			var pp = "<a href='javascript:void(0);' onclick='gotoPage(1)'>首页</a>";
			for(var i = 1; i <= data.totalPage; i++){
				if(i == data.PageNum){
					pp+="<a class='this' href='javascript:void(0);' onclick='gotoPage("+i+")'>"+i+"</a>";
				}else{
					pp+="<a href='javascript:void(0);' onclick='gotoPage("+i+")'>"+i+"</a>";
				}
			}
			pp+="<a href='javascript:void(0);' onclick='gotoPage("+data.totalPage+")'>末页</a>";
			$("#fenyeyey").empty();
			$("#fenyeyey").append(pp);
		}
	});
	
}

function gotoPage(pagenum){
	var goodsname = $("#search_goodsname").val();
	var classesid = $("#gc_id").val();
	$.ajax({
		type:"post",
		data:JSON.stringify({"goodsname":goodsname,"classesid":classesid,"currentPage":pagenum}),
		contentType:"application/json",
		url:"/floor/floor_floor_select_goods",
		success:function(data){
			var str = "";
			$.each(data.list_goods,function(i,goods){
				str += "<li><a href='javascript:void(0);' onclick='goods_list_set(this);' img_uri='"+goods.path+"' goods_name='"+goods.goodsname+"' goods_id='"+goods.id+"' class='floor_sear_a'><span class='floor_sear_img'> <img src='"+goods.path+"' width='70' height='70'></span><span class='floor_sear_name'>"+goods.goodsname+"</span></a></li>";
			});
			$("#floor_sear_pro").empty();
			$("#floor_sear_pro").append(str);
			var pp = "<a href='javascript:void(0);' onclick='gotoPage(1)'>首页</a>";
			for(var i = 1; i <= data.totalPage; i++){
				if(i == data.PageNum){
					pp+="<a class='this' href='javascript:void(0);' onclick='gotoPage("+i+")'>"+i+"</a>";
				}else{
					pp+="<a href='javascript:void(0);' onclick='gotoPage("+i+")'>"+i+"</a>";
				}
			}
			pp+="<a href='javascript:void(0);' onclick='gotoPage("+data.totalPage+")'>末页</a>";
			$("#fenyeyey").empty();
			$("#fenyeyey").append(pp);
		}
	});
}
</script>
<body>
	
<form action="/floor/floor_goods_doedit" method="post" id="theForm">
<div class="box_floor">
  <div class="box_floor_six">
    <div class="box_floor_class">
      <input type="hidden" name="id" id="id" value="${floor.id}">
      <input type="hidden" name="arr" id="arr">
      <b>楼层标题：</b>
      <input name="gf_name" type="text" id="gf_name" value="${floor.floorname}">
    </div>
    <span class="floor_choose">已选推荐商品：</span>
    <div class="box_floor_prodel"> <em class="floor_warning">注释：最多选择10件商品，双击删除已有商品信息，按下鼠标拖动商品次序</em>
      <div class="floor_box_pls ui-sortable" id="floor_goods_info">
        <#if floor.list_goods??>
		<#list floor.list_goods as goods>             
        <ul ondblclick="$(this).remove();" name='seengoods' goods_id="${goods.id}" class="floor_pro">
          <li class="floor_pro_img"><img src="${goods.path}" width="100" height="100"></li>
          <li class="floor_pro_name">${goods.goodsname}</li>
        </ul>
		</#list>
		</#if>
      </div>
    </div>
    
    <span class="floor_choose">选择要展示的商品：</span>
    <div class="floor_choose_box">
     <span class="floor_choose_sp">
	     <b>选择分类：</b>
	      <select name="gc_id" id="gc_id">
	        <option value="">请选择商品分类...</option>
	        <#if list_classes??>
			<#list list_classes as classes>
	        <option value="${classes.id}" pid="${classes.pid}" classname="${classes.classname}">${classes.classname}</option>
	        	<#if classes.list_sonclasses??>
				<#list classes.list_sonclasses as sonclasses>
				<option value="${sonclasses.id}" pid="${sonclasses.pid}" classname="${sonclasses.classname}">&nbsp;&nbsp;&nbsp;${sonclasses.classname}</option>
				</#list>
				</#if>
			</#list>
			</#if>
	      </select>
      </span>
      
		<span class="floor_search_sp">
			<b>商品名称：</b>
			<input name="search_goodsname" id="search_goodsname" type="text">
			<input type="button" class="floor_sear_btn" value="搜索" onclick="goods_floor_list_goods_load();" style="cursor:pointer;">
		</span>
		<em class="floor_warning">注释：点击商品加入楼层，最多选择8件商品</em>
		
		<div id="floor_goods_list">
		<ul class="floor_sear_pro" id="floor_sear_pro"></ul>

<!--分页-->
<div class="floor_page">
	<span id="fenyeyey">
		<#if totalPage??>
		<a href="javascript:void(0);" onclick="gotoPage(1)">首页</a> 
		第　
		<#list 1..totalPage as page>
		<#if page == PageNum>
			<a class="this" href="javascript:void(0);" onclick="gotoPage(${page})">${page}</a> 
		<#else>
			<a href="javascript:void(0);" onclick="gotoPage(${page})">${page}</a> 
		</#if>
		</#list>
		页　
		<a href="javascript:void(0);" onclick="gotoPage(${totalPage?default('0')})">末页</a>
		</#if>
	</span>
</div>


</div>
    </div>
  </div>
  <!--图片开始-->
  <div class="submit">
    <input type="button" value="保存" onclick="save_form();">
  </div>
</div>
</form>
			

</body>
</html>