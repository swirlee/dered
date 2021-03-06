
<script>
$(document).ready(function(){
	
	//给省市区下拉框设置默认值
// 	$("#city1").val(${(address.provinceid)?c})
// 	$("#city2").val(${(address.cityid)?c})
// 	$("#city3").val(${(address.areaid)?c})
// 	alert(${(address.provinceid)?c});
// 	alert(${(address.cityid)?c});
// 	alert(${(address.areaid)?c});
	
	//validate校验
	$("#theForm").validate({
		rules:{
			receiver:{required:true},
			detailaddress:{required:true},
			zipcode:{required:true},
			tel:{required:true}
		},
		messages:{
			receiver:{required:"请填入收件人姓名"},
			detailaddress:{required:"详细地址不能为空"},
			zipcode:{required:"请填写邮政编码"},
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
<body>
	
	<form action="/address/doedit_address" method="post" name="theForm" id="theForm">
		<input type="hidden" name="addressId" value="${address.id?c}">
		<table style="float: left;" width="100%" border="0" cellspacing="0" cellpadding="0" class="box_table">
			<tbody>
				<tr>
					<td width="100" align="right" valign="top">
						<span class="hui_table">收货人姓名：</span>
					</td>
					<td align="left">
						<span class="dia_txt">
							<input type="text" name="receiver" id="receiver" value="${address.receiver?default('')}" size="35">
							<label for="receiver" generated="true" class="error" style="display:none"></label>
						</span>
					</td>
				</tr>
				<tr>
					<td align="right" valign="top"><span class="hui_table">所在区域：</span></td>
					<td align="left"><span id="area_area_info"> </span>
						<select name="city1" id="city1" style="width: 77px" onchange="citySelect(this)">
							<option value="">=选择省=</option>
							<#if list_city??>
							<#list list_city as city>
							<#if city.id?c==address.provinceid?c>
							<option value="${(city.id)?c}" selected="selected">${city.cityname}</option>
							<#else>
							<option value="${(city.id)?c}">${city.cityname}</option>
							</#if>
							</#list>
							</#if>
						</select>
						
						<select name="city2" id="city2" style="width: 77px" onchange="citySelect(this)">
							<option value="">=选择市=</option>
							<#if list_city2??>
							<#list list_city2 as city2>
							<#if city2.id?c==address.cityid?c>
							<option value="${(city2.id)?c}" selected="selected">${city2.cityname}</option>
							<#else>
							<option value="${(city2.id)?c}">${city2.cityname}</option>
							</#if>
							</#list>
							</#if>
						</select>
						
						<select name="city3" id="city3" style="width: 77px">
							<option value="">=选择区=</option>
							<#if list_city3??>
							<#list list_city3 as city3>
							<#if city3.id?c==address.areaid?c>
							<option value="${(city3.id)?c}" selected="selected">${city3.cityname}</option>
							<#else>
							<option value="${(city3.id)?c}">${city3.cityname}</option>
							</#if>
							</#list>
							</#if>
						</select>
						
					</td>
				</tr>
				<tr>
					<td align="right" valign="top"><span class="hui_table">详细地址</span>：</td>
					<td align="left">
						<span class="dia_txt">
							<input type="text" name="detailaddress" id="detailaddress" value="${address.address}" size="35">
						</span>
					</td>
				</tr>
				<tr>
					<td align="right" valign="top"><span class="hui_table">邮政编码</span>：</td>
					<td align="left">
						<span class="dia_txt">
							<input type="text" name="zipcode" id="zipcode" value="${address.zipcode}" size="35">
						</span>
					</td>
				</tr>
				<tr>
					<td align="right" valign="top"><span class="hui_table">手机号码</span>：</td>
					<td align="left">
						<span class="dia_txt">
							<input name="tel" type="text" id="tel" value="${address.tel}" size="35">
						</span>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<span class="inputbtn">
							<input name="" type="submit" value="提交" style="cursor: pointer;">
						</span>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
			

</body>
</html>