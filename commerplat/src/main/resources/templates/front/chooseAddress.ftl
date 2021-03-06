
<script>
$(document).ready(function(){
	$("#submit").click(function(){
		var addressid = $("input[name=defaultaddress]:checked").attr("addressid");
		$("#addressId").val(addressid);
		$("#theForm").submit();
	});
});
</script>
	
<form action="/address/chooseaddress" method="post" name="theForm" id="theForm">
	<input type="hidden" value="" id="addressId" name="addressId">
	<input type="hidden" value="${str}" id="str" name="str">
	<input type="hidden" value="${ordernumber}" id="ordernumber" name="ordernumber">
	<table style="float: left;" width="100%" border="0" cellspacing="0" cellpadding="0" class="box_table">
	 	<#if list_address??>
           <#list list_address as address>
		<tr class="opertr" id="${address.id}">
			<#if address.id == addressid>
			<td align="center"><input type="radio" addressid="${address.id}" id="defaultaddress" name="defaultaddress" checked></td>
			<#else>
			<td align="center"><input type="radio" addressid="${address.id}" id="defaultaddress" name="defaultaddress"></td>
			</#if>
			<td>${address.receiver}</td>
			<td>${address.tel}</td>
			<td area_info_id="${address.id}">${address.province.cityname} ${address.city.cityname} ${address.area.cityname} ${address.address}</td>
		</tr>
           </#list>
           </#if>

		<tr>
			<td colspan="5" align="center">
				<span class="inputbtn">
					<input name="submit" id="submit" type="submit" onclick="dianji" value="确定" style="cursor: pointer;">
				</span>
			</td>
		</tr>
		
	</table>
</form>