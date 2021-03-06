<#list list_floor as floor>
<tr id="${floor.id}" parent="${floor.pid}" level="child_${floor.pid}">
	<td align="center">
 		<input name="ids" id="ids_${floor.id}" type="checkbox" value="${floor.id}">
 	</td>
    <td colspan="2" align="center">
 		<ul class="addclass">
    		<li class="accc1" style="margin-left:30px;">
    			<img src="/images/expandtable.gif" cls="jian">
    		</li>
   			<li class="ac2">
   				<span class="num">
   					<input type="text" name="seq_2" id="seq_2_${floor.id}" value="${floor.seq}" onblur="ajax_update('${floor.id}','floor_seq',this)" title="可编辑">
   				</span>
   			</li>
   			<li class="acc3">
   				<span class="classies">
   					<input type="text" name="floor_2" id="floor_2_${floor.id}" value="${floor.floorname}" onblur="ajax_update('${floor.id}','floor_name',this)" title="可编辑">
   				</span>
   			</li>
       </ul>    
    </td>
    <td align="center">
    	<img src="/images/${(floor.display)?string}.png" width="21" height="23" onclick="ajax_update('${floor.id}','floor_display',this)" style="cursor:pointer;" title="可编辑">
    </td>
    <td align="left" class="ac8">
    	<a href="/floor/floor_edit?id=${floor.id}">编辑</a> | 
    	<a href="javascript:void(0);" onclick="if(confirm('删除分类会同时关联数据，是否继续?'))window.location.href='/floor/floor_del?id=${floor.id}'">删除</a>
    </td>
</tr>
</#list>

