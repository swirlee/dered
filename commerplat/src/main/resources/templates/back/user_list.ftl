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
		$(document).ready(function(){
		  $(".memimg").mouseover(function(){
		     $(this).css("cursor","pointer");
			 $(".mem_detail[id^=user_detail_]").hide();
		     var id=$(this).attr("id");
			 $("#user_detail_"+id).show();
		  });
		  $(".mem_detail[id^=user_detail_]").mouseleave(function(){
		    $(this).hide();
		  });
		});
</script>

<style id="poshytip-css-tip-skyblue" type="text/css">
div.tip-skyblue{visibility:hidden;position:absolute;top:0;left:0;}
div.tip-skyblue table, 
div.tip-skyblue td{margin:0;font-family:inherit;font-size:inherit;font-weight:inherit;font-style:inherit;font-variant:inherit;}
div.tip-skyblue td.tip-bg-image span{display:block;font:1px/1px sans-serif;height:10px;width:10px;overflow:hidden;}
div.tip-skyblue td.tip-right{background-position:100% 0;}
div.tip-skyblue td.tip-bottom{background-position:100% 100%;}
div.tip-skyblue td.tip-left{background-position:0 100%;}
div.tip-skyblue div.tip-inner{background-position:-10px -10px;}
div.tip-skyblue div.tip-arrow{visibility:hidden;position:absolute;overflow:hidden;font:1px/1px sans-serif;}
</style>
</head>

<body>
  <div class="cont">
    <h1 class="seth1">会员管理</h1>
    <div class="settab">
    <span class="tab-one"></span>
	<span class="tabs">
		<a href="javascript:void(0);" class="this">管理</a>
	</span>
	<span class="tab-two"></span>
	</div>
	<form method="post">
    <div class="allmem_search">
      <ul>
        <li> <span>
          <select name="condition" id="condition">
            <option value="userName">会员名</option>
            <option value="email">注册邮箱</option>
            <option value="trueName">真实姓名</option>
          </select>
          </span> <span class="allmen size4">
          <input name="value" type="text" id="value">
          </span><span class="btn_search">
          <input name="" type="submit" value="搜索" style="cursor:pointer;" title="搜索会员">
          </span> </li>
      </ul>
    </div>
	</form>
    <div class="operation">
      <h3>友情提示</h3>
      <ul>
        <li>可用金额，买家会员可以用来支付订单、提现，卖家可以用来支付商城收费服务</li>
        <li>冻结金额，当会员进行提现操作后，提现金额变为冻结金额等待管理员审核操作。</li>
      </ul>
    </div>
	<form name="ListForm" id="ListForm" action="http://192.168.1.3:8080/shopping/admin/user_list.htm" method="post">
    <div class="allmem_table">
      <table width="98%" border="0" cellspacing="0" cellpadding="0">
      <tbody>
      		 <tr style="background:#2A7AD2; height:30px; color:#FFF">
				<td width="12%" align="center">头像</td>
				<td width="12%" align="center">会员id</td>
				<td width="12%" align="center">会员名</td>
				<td width="12%" align="center">注册时间</td>
				<td width="12%" align="center">联系电话</td>
				<td width="12%" align="center">邮箱号码</td>
				<td width="12%" align="center">性别</td>
				<td width="12%" align="center">操作</td>
			</tr>
	        <#list list_user as user>
			<tr style="background:; height:30px; color:#4876FF">
				<td width="12%" align="center"><img src="${user.headimagepath?default('/images/tx.jpg')}" width="50px"></td>
				<td width="12%" align="center">${user.id}</td>
				<td width="12%" align="center">${user.username}</td>
				<td width="12%" align="center">${user.addtime?string("yyyy-MM-dd HH:mm")}</td>
				<td width="12%" align="center">${user.phone?default('')}</td>
				<td width="12%" align="center">${user.email?default('')}</td>
				<td width="12%" align="center">${user.sex?default('')}</td>
				<td width="12%" align="center"><a href="/user/showuser?id=${user.id}">详细信息</a></td>
			</tr>
			</#list>
			<tr style="background:#F2F2F2; height:30px;">
				<td colspan="9">
					<div class="shopbtn shopfx">
						<input name="all" type="checkbox" id="all" onclick="selectAll(this)" value="">
						&nbsp;&nbsp;全部</div>
						<div class="shop_btn_del shopbtn">
						<input name="" type="button" value="删除" style="cursor:pointer;" onclick="cmd(&#39;http://192.168.1.3:8080/shopping/admin/user_del.htm&#39;)">
					</div>
				</td>
			</tr>
      </tbody>
      </table>
    </div>
    <!-- 分页 -->
    <div class="fenye">
      <input type="hidden" name="currentPage" id="currentPage" value="1">
      <input name="mulitId" type="hidden" id="mulitId">
      <a href="http://192.168.1.3:8080/shopping/admin/user_list.htm?currentPage=1">首页</a> 第　<a class="this" href="http://192.168.1.3:8080/shopping/admin/user_list.htm?currentPage=1">1</a> <a href="http://192.168.1.3:8080/shopping/admin/user_list.htm?currentPage=2">2</a> 页　<a href="http://192.168.1.3:8080/shopping/admin/user_list.htm?currentPage=2">下一页</a> <a href="http://192.168.1.3:8080/shopping/admin/user_list.htm?currentPage=2">末页</a> 
	</div>
	
	</form>
  </div>

</div>
</body>
</html>