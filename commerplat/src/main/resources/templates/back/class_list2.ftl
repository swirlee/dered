<#list classes_Sonlist as classes>
<tr id="${classes.id}" parent="${classes.pid}" level="child_${classes.pid}">
 <td align="center"><input name="ids" id="ids" type="checkbox" value="${classes.id}"></td>
   <td colspan="2" align="center">
	  <ul class="addclass">
	   <li class="acc1"><img src="/images/add.jpg" cls="jian" width="14" height="14" onclick="addorsubtract(this,${classes.id})" style="cursor:pointer;"></li>
	   <li class="ac2"><span class="num"><input type="text" name="${classes.seq}" id="${classes.seq}" value="${classes.seq}" onblur="ajax_update('${classes.id}','seq',this)" title="可编辑"></span></li>
	   <li class="acc3"><span class="classies"><input type="text" name="${classes.classname}" id="${classes.classname}" value="${classes.classname}" onblur="ajax_update('${classes.id}','classname',this)" title="可编辑"></span>
	   <span class="newclass" style="$sty"><a href="/classes/addclasses?pid=${classes.id}">新增下级</a></span></li>
      </ul>
   </td>
<!--    <td align="center"></td> -->
   <td align="center"><img src="/images/true.png" width="21" height="23" onclick="ajax_update('${classes.id}','display',this)" style="cursor:pointer;" title="可编辑"></td>
   <td align="center" class="ac8">
	   <a href="/classes/class_update?id=${classes.id}">编辑</a>|
	   <a href="javascript:void(0);" 
	      onclick="if(confirm('删除分类会同时删除该分类的所有下级，是否继续?')){ajax_update('${classes.id}','delete',this)}">删除</a>
   </td>
</tr>
</#list>