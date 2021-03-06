
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title></title>
<link href="/css/template.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="cont">
  <div class="orderdetail">
    <div class="orderh">订单状态</div>
    <div class="orderul">
      <ul>
        <li><span class="ordertitle">订单号:</span><span>${order.ordernumber}</span></li>
        <li><span class="ordertitle"> 订单状态:</span><span>${order.orderstate}</span></li>
        <li><span class="ordertitle">运费:</span><span>¥0.00</span></li>
        <li><span class="ordertitle">订单总额:</span><span><strong class="orange" style="padding-right:10px;">¥${order.totalprice}</strong></span></li>
      </ul>
    </div>
    <div class="orderh">订单详情</div>
    <div class="orderhh">订单信息</div>
    <div class="orderul">
      <ul>
        <li><span class="ordertitle">买家名称:</span><span>${order.user.username}</span></li>
        <li><span class="ordertitle">支付方式:</span><span></span></li>
        <li><span class="ordertitle">下单时间:</span><span>${order.addtime?string("yyyy-MM-dd hh:mm:ss")}</span></li>
      </ul>
    </div>
    <div class="orderhhh">收货人及发货信息</div>
    <div class="orderul">
      <ul>
        <li><span class="ordertitle">收货人姓名:</span><span>${order.receiver}</span></li>
        <li><span class="ordertitle">所在地区:</span><span>${order.cityaddress}</span></li>
        <li><span class="ordertitle">邮政编码:</span><span>${order.zipcode}</span></li>
        <li><span class="ordertitle">手机号码:</span><span>${order.tel}</span></li>
        <li><span class="ordertitle">详细地址:</span><span>${order.detailaddress}</span></li>
        <li><span class="ordertitle">配送方式:</span><span></span></li>
      </ul>
    </div>
    <div class="orderhhh">商品信息</div>
    <div class="ordetable">
      <table width="90%" border="0" cellspacing="0" cellpadding="0" class="orde_table">
        <tbody>
	        <tr style="border-bottom:1px dotted #CCEAF4">
	          <td width="20%">&nbsp;</td>
	          <td width="30%"><strong>商品信息</strong></td>
	          <td width="20%"><strong>上下架状态</strong></td>
	          <td width="10%"><strong>单价</strong></td>
	          <td width="10%"><strong>小计</strong></td>
	        </tr>
	        <#if order.list_detailorder ??>
	        <#list order.list_detailorder as detail>
	        <tr style="border-bottom:1px dotted #CCEAF4">
				<td><img src="${detail.goods.path}" width="45" height="45"></td>
				<td><a href="/frontGoods/goodsDetails?id=${detail.goods.id?default('')}" target="_blank" class="blue">${detail.goods.goodsname?default('')}</a></td>
	          	<td>${detail.goods.state?default('上架')}</td>
	            <td><strong class="orange">¥</strong><strong style="color:#F90"> ${detail.goods.sellprice}</strong>*${detail.count}</td>
	            <td><strong class="orange">¥</strong><strong style="color:#F90"> ${detail.count*detail.goods.sellprice}</strong></td>
	        </tr>
	        </#list>
	        </#if>
        </tbody>
      </table>
    </div>
    <div class="orderhhh">物流信息</div>
    <div class="orderul_record">
      <ul>
      </ul>
    </div>
    
    
    <div class="orderhhh">操作历史</div>
    <div class="orderul_record">
      <ul>
          <li><strong style="color:#F90">${order.user.username}</strong>于<strong><em>${order.addtime?string("yyyy-MM-dd hh:mm:ss")}</em></strong>提交订单 </li>
      </ul>
    </div>
        </div>
  <div class="submit">
    <input name="go" type="button" value="返回列表" onclick="window.location.href='/order/order_list'">
  </div>
</div>


</body></html>