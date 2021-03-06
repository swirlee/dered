<#list classes_Sonlist as classes>
<tr id="${classes.id}" parent="${classes.pid}" level="child_${pid0}">
 <td align="center"><input name="ids" id="ids" type="checkbox" value="${classes.id}"></td>
   <td colspan="2" align="center">
 	<ul class="addclass">
	   <li class="accc1"><img src="" cls="" width="14" height="14" onclick="" style="cursor:pointer;"></li>
	   <li class="ac2"><span class="num"><input type="text" name="1" id="1" value="1" onblur="ajax_update('${classes.id}','seq',this)" title="可编辑"></span></li>
	   <li class="accc3"><span class="classies"><input type="text" name="${classes.classname}" id="${classes.classname}" value="${classes.classname}" onblur="ajax_update('${classes.id}','classname',this)" title="可编辑"></span></li>
    </ul>
   </td>
   <td align="center"><img src="/images/true.png" width="21" height="23" onclick="ajax_update('${classes.id}','display',this)" style="cursor:pointer;" title="可编辑"></td>
   <td align="center" class="ac8">
	   <a href="/classes/class_update?id=${classes.id}">编辑</a>|
	   <a href="javascript:void(0);" 
	   	  onclick="if(confirm('删除分类会同时删除该分类的所有下级，是否继续?')){ajax_update('${classes.id}','delete',this)}">删除</a>
   </td>
</tr>
</#list>