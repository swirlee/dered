
<script>
$(document).ready(function(){
	//validate校验
	$("#theForm").validate({
		rules:{
			receiver:{required:true},
			detailaddress:{required:true},
			zipcode:{required:true},
			city3:{required:true},
			tel:{required:true}
		},
		messages:{
			receiver:{required:"请填入收件人姓名"},
			detailaddress:{required:"详细地址不能为空"},
			zipcode:{required:"请填写邮政编码"},
			city3:{required:"请选择收货城市"},
			tel:{required:"请输入联系方式电话"}
		}
	});

});
function citySelect(obj){
	var id = $(obj).val();
	var name = $(obj).attr("name");
	
	if($("#city1").val()==""){
		$("#city2").empty();
		$("#city3").empty();
		$("#city2").append("<option value=''>=选择市=</option>");
		$("#city3").append("<option value=''>=选择区=</option>");
	}
	
	if($("#city2").val()==""){
		$("#city3").empty();
		$("#city3").append("<option value=''>=选择区=</option>");
	}
	
	if(id != ""){
		$.ajax({
			url:"/order/ajax_city_select",
			data:{"pid":id},
			type:"post",
			success:function(msg){
			var str = "";
				$.each(msg.list_city,function(){
					str += "<option value='"+this.id+"'>"+this.cityname+"</option>";
				})
				
				if(name == "city1"){
					$("#city2").empty();
					$("#city3").empty();
					$("#city2").append("<option value=''>=选择市=</option>");
					$("#city3").append("<option value=''>=选择区=</option>");
					$("#city2").append(str);
				}
				
				if(name == "city2"){
					$("#city3").empty();
					$("#city3").append("<option value=''>=选择区=</option>");
					$("#city3").append(str);
				}
			}
		})
	}
}
</script>


<form action="/address/doadd_address" method="post" name="theForm" id="theForm">
	<table style="float: left;" width="100%" border="0" cellspacing="0" cellpadding="0" class="box_table">
		<tbody>
			<tr>
				<td width="100" align="right" valign="top">
					<span class="hui_table">收货人姓名：</span>
				</td>
				<td align="left">
					<span class="dia_txt">
						<input type="text" name="receiver" id="receiver" value="" size="35">
						<label for="receiver" generated="true" class="error" style="display:none"></label>
					</span>
				</td>
			</tr>
			<tr>
				<td align="right" valign="top"><span class="hui_table">所在区域：</span></td>
				<td align="left"><span id="area_area_info"> </span>
					<select name="city1" id="city1" style="width: 77px" onchange="citySelect(this)">
						<option value="" selected="selected">=选择省=</option>
						<#if list_city??>
						<#list list_city as city>
						<option value="${(city.id)?c}">${city.cityname}</option>
						</#list>
						</#if>
					</select>
					<select name="city2" id="city2" style="width: 77px" onchange="citySelect(this)">
						<option value="" selected="selected">=选择市=</option>
					</select>
					<select name="city3" id="city3" style="width: 77px">
						<option value="" selected="selected">=选择区=</option>
					</select>
				</td>
			</tr>
			<tr>
				<td align="right" valign="top"><span class="hui_table">详细地址</span>：</td>
				<td align="left">
					<span class="dia_txt">
						<input type="text" name="detailaddress" id="detailaddress" value="" size="35">
					</span>
				</td>
			</tr>
			<tr>
				<td align="right" valign="top"><span class="hui_table">邮政编码</span>：</td>
				<td align="left">
					<span class="dia_txt">
						<input type="text" name="zipcode" id="zipcode" value="" size="35">
					</span>
				</td>
			</tr>
			<tr>
				<td align="right" valign="top"><span class="hui_table">手机号码</span>：</td>
				<td align="left">
					<span class="dia_txt">
						<input name="tel" type="text" id="tel" value="" size="35">
					</span>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<span class="inputbtn">
					    <input name="str" type="hidden" id="str" value="${str?default('')}">
						<input name="" type="submit" value="提交" style="cursor: pointer;">
					</span>
				</td>
			</tr>
		</tbody>
	</table>
</form>
