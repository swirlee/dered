<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title></title>
<link href="/css/template.css" rel="stylesheet" type="text/css">
<script src="/js/jquery-1.6.2.js"></script>
<script src="/js/jquery.shop.common.js"></script>
<script src="/js/jquery.poshytip.min.js"></script>
<script>
function ajax_update(id,fieldName,obj){
	var val=$(obj).val();
	$.ajax({
		type:"post",
    	url:"/goods/ajax_update",
		data:{"id":id,"fieldName":fieldName,"value":val},
		success:function(data){
			if(val == ""){
				$(obj).attr("src","/images/"+data.gg.recommend+".png");
			}  
			if(data.dd == 1){
				$(obj).parent().parent().remove();
			}
			if(data.dd == 0){
				alert("该商品已绑定至订单、楼层或广告页，无法删除！");
			}
		}
	});
}
</script>

<style id="poshytip-css-tip-skyblue" type="text/css">div.tip-skyblue{visibility:hidden;position:absolute;top:0;left:0;}div.tip-skyblue table, div.tip-skyblue td{margin:0;font-family:inherit;font-size:inherit;font-weight:inherit;font-style:inherit;font-variant:inherit;}div.tip-skyblue td.tip-bg-image span{display:block;font:1px/1px sans-serif;height:10px;width:10px;overflow:hidden;}div.tip-skyblue td.tip-right{background-position:100% 0;}div.tip-skyblue td.tip-bottom{background-position:100% 100%;}div.tip-skyblue td.tip-left{background-position:0 100%;}div.tip-skyblue div.tip-inner{background-position:-10px -10px;}div.tip-skyblue div.tip-arrow{visibility:hidden;position:absolute;overflow:hidden;font:1px/1px sans-serif;}</style></head>
<body scroll="yes">
<div class="cont">
  <h1 class="seth1">商品管理</h1>
  <div class="settab"> 
	<span class="tab-one"></span> <span class="tabs"> 
		<a href="/goods/showGoods" class="this">商品管理</a>
		|
		<a href="/goods/addGoods?pid=0">新增</a>
	</span> 
	<span class="tab-two"></span>	</div>
	<form name="queryForm" id="queryForm" action="" method="post">
    <div class="allmem_search">
      <ul>
        <li> <span>商品名称</span> <span class="allmen size4">
          <input type="text" name="goods_name" id="goods_name">
          </span> <span>品牌名称</span> 
		<select name="goods.goods_brand.id" id="goods.goods_brand.id">
	        <option value="">所有品牌</option>
	        <option value="84">burton(假)</option>
	        <option value="85">flow(假)</option>
	        <option value="86">ping&up(假)</option>
	        <option value="38">迪卡侬(假)</option>
		</select>
		<span>类别</span>
		<select name="goods.gc.id" id="goods.gc.id">
			<option value="">所有分类</option>   
			<option value="65889">儿童用品</option>
			<option value="65896">&nbsp;&nbsp;&nbsp;  营养系列</option>
			<option value="65922">&nbsp;&nbsp;&nbsp;  儿童绿色食品</option>
			<option value="65923">&nbsp;&nbsp;&nbsp;  学习用品</option>
		</select>
          <span>特别推荐</span>
			<select name="store_recommend" id="store_recommend">
				<option value="">是否特别推荐</option>
				<option value="true">是</option>
				<option value="false">否</option>
			</select>
          <span class="btn_search">
          <input name="" type="button" value="搜索" style="cursor:pointer;" onclick="query();">
        </span> </li>
      </ul>
    </div>
  </form>
  
  <form name="" id="" action="/goods/excelUpload" enctype="multipart/form-data" method="post">
  	<input type="file" name="excelFile"/>
  	<input name="" type="submit" value="上传EXCEL" style="cursor:pointer;">
  </form>
  
  <div class="operation">
    <h3>友情提示</h3>
    <ul>
      <li>上架商品，在商城前台所有访客均可查看，管理员和卖家都可以设置商品上架状态</li>
      <li>亲爱的工作人员，到点下班就行，老板没那么多钱给你们加班费！！！</li>
    </ul>
  </div>
  <form name="ListForm" id="ListForm" action="http://aishang2018.vicp.io:11585/shopping/admin/goods_list.htm" method="post">
    <div class="brandtable">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="brand_table">
        <tbody><tr style="background:  #2A7AD2       ; height:30px; color:#FFF">
          <td width="1%" align="center">&nbsp;</td>
          <td width="7%" align="center">商品大图</td>
          <td width="7%" align="center">商品名称</td>
          <td width="7%" align="center">品牌</td>
          <td width="7%" align="center">分类名</td>
          <td width="7%" align="center">商品状态</td>
          <td width="7%" align="center">商品库存</td>
          <td width="7%" align="center">商品货号</td>
          <td width="7%" align="center">商品原价</td>
          <td width="7%" align="center">商品售价</td>
          <td width="7%" align="center">特别推荐</td>
          <td width="12%" align="center">操作</td>
        </tr>
        
        <#if list_goods??> 
        <#list list_goods as goods>      
        <tr>
          <td width="1%"align="center">
          	<input name="checkbox" type="checkbox" id="checkbox" value="${goods.id?default('')}">
          </td>
          <td width="7%"align="center">
          	<img src="${goods.path?default('')}" width="70px" height="54px">
		  </td>
          <td width="7%" align="center">${goods.goodsname?default('')}</td>
          <td width="7%" align="center">${goods.brandname?default('')}</td>
          <td width="7%" align="center">${goods.classname?default('')}</td>
          <td width="7%" align="center">${goods.state?default('')}</td>
          <td width="7%" align="center">${goods.inventory?default('')}</td>
          <td width="7%" align="center">${goods.goodsnumber?default('')}</td>
          <td width="7%"align="center"><label>
            <textarea name="textarea" cols="8" rows="1" onblur="ajax_update('${goods.id?default('')}','originalprice',this)">${goods.originalprice}</textarea>
          </label></td>
          <td width="7%"align="center"><label>
            <textarea name="textarea" cols="8" rows="1" onblur="ajax_update('${goods.id?default('')}','sellprice',this)">${goods.sellprice}</textarea>
          </label></td>
          <td width="7%" align="center">
          	<img src="/images/${goods.recommend?string}.png" onclick="ajax_update('${goods.id?default('')}','recommend',this)" width="25" height="21" border="0" style="cursor:pointer;" title="特别推荐后在首页显示">
          </td>
          <td class="ac8" width="6%" align="center">
          	<a href="/goods/editGoods?id=${goods.id}">编辑</a>
          	<a href="javascript:void(0);" onclick="ajax_update('${goods.id}','delete',this)" >删除</a>
          </td>
        </tr>
        </#list>
        </#if>
            
     	<tr>
	        <td align="center"><input type="checkbox" name="all" id="all" value="" onclick="selectAll(this)">
	          <input name="mulitId" type="hidden" id="mulitId"></td>
	        <td colspan="2" class="bdel">
			<span class="sp1">全部</span><span class="sp2">
	          <div class="shop_btn_del shopbtn">
	            <input name="" type="button" value="删除" onclick="cmd(&#39;。。。。。。&#39;);" style="cursor:pointer;">
	          </div>
	          </span>		  </td>
	        <td colspan="7"></td>
      	</tr>
      
    </tbody>
    </table>
    
		<div class="fenye" align="right">
			<span id="queryCondition" style="display:none"></span>
			<input name="currentPage" type="hidden" id="currentPage" value="1">
			<a href="javascript:void(0);" onclick="return gotoPage(1)">首页</a>
			第
			<a class="this" href="javascript:void(0);" onclick="return gotoPage(1)">1</a>
			<a href="javascript:void(0);" onclick="return gotoPage(2)">2</a>
			页　
			<a href="javascript:void(0);" onclick="return gotoPage(2)">下一页</a>
			<a href="javascript:void(0);" onclick="return gotoPage(2)">末页</a>
		</div>
    </div>
  </form>
</div>


<div class="tip-skyblue">
<div class="tip-inner tip-bg-image"></div>
<div class="tip-arrow"></div>
</div>
<div class="tip-skyblue">
<div class="tip-inner tip-bg-image"></div>
<div class="tip-arrow"></div>
</div>
<div class="tip-skyblue">
<div class="tip-inner tip-bg-image"></div>
<div class="tip-arrow"></div>
</div>

</body>
</html>