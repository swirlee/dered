
<script>
$(document).ready(function(){
	//分类选择栏改变，添加分类栏
	$("#classesSelect").change(function(){
		debugger
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
	
	if($("a[name=see_id]").length>0){
		var arr = new Array();
		$("a[name=see_id]").each(function(){
			arr.push($(this).attr("classids"));
		});
		$("#arr").val(arr);
	}
	$("#theForm").submit();
	
}

</script>
<body>

	<form action="/floor/floor_classes_doedit" method="post" id="theForm">
	
		<div class="box_floor">
			<!--分类开始-->
			<div class="box_floor_class">
				<input name="id" type="hidden" id="id" value="${floor.id}">
				 <input type="hidden" name="arr" id="arr">
				  <b>楼层标题：</b>
				  <input name="gf_name" type="text" id="gf_name" value="${floor.floorname}">
			</div>
			<h6 class="box_floor_h6">当前分类</h6>
			<em class="floor_warning" style="margin-left: 20px; margin-bottom: 5px;">注释:双击删除已选分类，按下鼠标拖动分类次序</em>
			<div class="box_edits">
				<ul class="box_edit_class ui-sortable" id="pinjie">
					<#if floor.list_classes??>
					<#list floor.list_classes as f1classes>
					<#if f1classes.pid == 0>
					<li class="box_edit_li">
						<h6><a name="see_id" ondblclick="javascript:$(this.parentNode.parentNode).remove();" id="${f1classes.id}" classids="${f1classes.id}" href="javascript:void(0);">${f1classes.classname}</a></h6>
						<span id="child_${f1classes.id}" class="ui-sortable">
					  	<#if floor.list_classes??>
						<#list floor.list_classes as f2classes>
						<#if f2classes.pid == f1classes.id>
				        	<a name="see_id" href="javascript:void(0);" ondblclick="javascript:$(this).remove();" id="${f2classes.id}" classids="${f2classes.id}" >${f2classes.classname}</a>
						</#if>
						</#list>
						</#if>
						</span>
					</li>
					</#if>
					</#list>
					</#if>
				</ul>
			</div>
			<div class="box_floor_class">
			<b>选择商品分类：</b>
			<select name="classesSelect" id="classesSelect">
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
			</div>
			<div class="submit">
				<input name="按钮" type="button" value="保存" onclick="save_form();">
			</div>
		</div>
	</form>


</body>
</html>