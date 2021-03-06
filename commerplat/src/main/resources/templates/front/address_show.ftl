<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>收货地址管理</title>
<link href="/css/window.css" type="text/css" rel="stylesheet">
<link href="/css/public.css" type="text/css" rel="stylesheet">
<link href="/css/user.css" type="text/css" rel="stylesheet">
<link href="/css/jquery-ui-1.8.22.custom.css" type="text/css" rel="stylesheet">
<link href="/css/overlay.css" type="text/css" rel="stylesheet">
<script src="/js/jquery-1.6.2.js"></script>
<script src="/js/jquery-ui-1.8.21.js"></script>
<script src="/js/jquery.poshytip.min.js"></script>
<script src="/js/jquery.shop.common.js"></script>
<script src="/js/jquery.validate.min.js"></script>
<script>


$(document).ready(function(){
	//点击主菜单，收起、下放副菜单
	$(".sellul>li>a").click(function(){
	  var child_show=$(this).attr("child_show");
	  if(child_show=="true"){
	    $(this).parent().find("img").attr("src","/images/menucontract.jpg");
	    $(this).parent().find("ul").slideUp('normal');
	    $(this).attr("child_show","false");
	  }else{
	    $(this).parent().find("img").attr("src","/images/usercenter/menuspread.jpg");
	    $(this).parent().find("ul").slideDown('normal');
	    $(this).attr("child_show","true");
	  }
	});
});
function defaultAddress(obj){
	var addressId = $(obj).val();
	$.ajax({
		url:"/address/ajax_update_defaultAddress",
		type:"post",
		data:{"addressId":addressId},
		success:function(data){
			if(data===true){
				alert("默认地址修改成功！！！");
			}else{
				alert("修改失败！！！");
			}
		}
	});
}

</script>
</head>
<body>
<!-- 利用include标签引入网页顶部的登录栏 -->
<#include "/front/top.ftl"/>
<!-- 利用include标签引入网页顶部的搜索 -->
<#include "/front/search.ftl"/>

<div class="main">


  <div class="user_center">
  
  
   <table width="1200" border="0" cellspacing="0" cellpadding="0" class="user_table">
      <tbody><tr height="372">

<td width="177" id="userbg" valign="top">

		<div class="user_photo">
			<dl>
				<dt><img src="${user.headimagepath?default('')}" onerror="this.src='/images/tx.jpg'" width="120" height="120" ></dt>
				<dd><span><a href="">编辑资料</a></span></dd>
			</dl>
		</div>
  
  <div class="seller">

    <div class="product_manage2">
      <ul class="sellul">
         <li><a href="javascript:void(0);" child_show="true"><b><img src="/images/usercenter/menuspread.jpg" width="10" height="10"></b>我的账户</a>
          <ul>
            <li op="account"><a href="/person/enterPersonCenter">个人资料</a></li>
            <li op="address" class="this"><a href="">收货地址</a></li>
            <li op=""><a href="/order/myorder">我的订单</a></li>
          </ul>
        </li>
      </ul>
    </div>

  </div>
</td>



<input id="online_un" name="online_un" type="hidden" value="">
<input id="contact_un" name="contact_un" type="hidden" value="">

        <td id="centerbg" valign="top">
        <div class="buyer_position"><div class="buyer_p_box"><a href="javascript:void(0);">我的账户</a> &gt; <span>收货地址</span></div></div>
        <div class="productmain">
            <div class="pdctitle blue2">地址列表</div>
            <div class="alldel">
              <div class="right">
               <a href="javascript:void(0);" dialog_uri="/order/address_add" dialog_title="新增地址" dialog_width="500" dialog_height="300" dialog_id="buyer_address" class="button_common">新增地址</a>
              </div>
            </div>
            <div class="operation">
              <table width="980" border="0" cellspacing="0" cellpadding="0" id="opertable">
                <tbody>
                <tr id="opertitle">
                  <td align="center" width="60">默认地址</td>
                  <td align="center" width="150">收货人姓名</td>
                  <td align="center" width="150">所在地区</td>
                  <td align="center" width="250">详细地址</td>
                  <td align="center" width="88">手机号码</td>
                  <td align="center" width="211" align="center">操作</td>
                </tr>
                <#if list_address??>
                <#list list_address as address>
                <tr class="opertr" id="${address.id}">
                  <#if address.defaultaddress==true>
                  <td align="center"><input type="radio" name="defaultaddress" value="${address.id}" checked onclick="defaultAddress(this)"></td>
                  <#else>
                  <td align="center"><input type="radio" name="defaultaddress" value="${address.id}" onclick="defaultAddress(this)"></td>
                  </#if>
                  <td>${address.receiver}</td>
                  <td area_info_id="${address.id}">${address.province.cityname}${address.city.cityname}${address.area.cityname}</td>
                  <td>${address.address} </td>
                  <td>${address.tel}</td>
                  <td align="center">
	                  <span class="edit">
	                  	<a href="javascript:void(0);" dialog_uri="/address/editaddress?addressId=${address.id}" dialog_title="编辑地址" dialog_width="500" dialog_height="100" dialog_id="cart_address">编辑</a>
	                  </span>
	                  <span class="del">
	                  	<a href="javascript:void(0);" onclick="if(confirm('删除后不可恢复，是否继续?'))window.location.href='/address/deleteaddress?id=${address.id}'">删除</a>
	                  </span>
                  </td>
                </tr>
                </#list>
                </#if>
               </tbody>
              </table>
            </div>
         
          </div>
        </td>
      </tr>
    </tbody>
    </table>
  </div>

</div>

<!--网页底部-->
<#include "/front/foot.ftl"/>

</body>
</html>