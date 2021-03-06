
 <link href="/css/window.css" type="text/css" rel="stylesheet">

<form action="/order/order_cancel_save" method="post" id="theForm">
  <table style="float:left;" width="390" border="0" cellspacing="0" cellpadding="0" class="box_table">
   
    <tr>
      <td colspan="2" align="left" valign="top">您确定要取消下面的订单吗?</td>
    </tr>
    <tr>
      <td width="100" align="right" valign="top">订单号：
        <input name="id" type="hidden" id="id" value="230097">
      </td>
      <td align="left">${ordernumber}</td>
    </tr>
    <tr>
      <td rowspan="4" align="right" valign="top">取消原因：</td>
      <td align="left"><label><input name="state_info" type="radio" id="radio" value="改买其他商品" checked="checked" onclick="switch_reason();">
      改买其他商品</label></td>
    </tr>
    <tr>
      <td align="left"><label><input name="state_info" type="radio" id="radio2" value="从其他店铺购买" onclick="switch_reason();">
      从其他店铺购买</label></td>
    </tr>
    <tr>
      <td align="left"><label><input name="state_info" type="radio" id="reason_other" value="other" onclick="switch_reason();">
      其他原因</label></td>
    </tr>
    <tr>
      <td align="left" id="other_reason" style="display:none;"><textarea name="other_state_info" id="other_state_info" cols="30" rows="5"></textarea></td>
    </tr>
    <tr>
      <td colspan="2" align="center"><span class="inputbtn">
        <input name="" type="submit" value="提交" style="cursor:pointer;">
        <input name="orderid" type="hidden" id="orderid" value="${id}">
        <input name="orderstate" type="hidden" id="orderstate" value="已取消">
      </span></td>
    </tr>
 
  </table>
</form>