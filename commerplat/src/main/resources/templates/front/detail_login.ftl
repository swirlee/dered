
<script>
$(document).ready(function(){
	//validate校验
	$("#theForm").validate({
		rules:{
			username:{required:true},
			password:{required:true}
		},
		messages:{
			username:{required:"用户名不为空！！！"},
			password:{required:"密码不能为空！！！"}
		}
	});
});
</script>


	<form action="/front/shoppingDologin" method="post" name="theForm" id="theForm">
	<input type="hidden" id="detailsgoodsid" name="detailsgoodsid" value="${goodsid}">
	    <table style="text-align:center;">
	     <tr style="text-align:center;">
	     	<td>登录名：</td>
	     	<td><input type="text" name="username" id="username"></td>
	     </tr text-align:center;>
	     <tr style="text-align:center;">
	     	<td>密码：</td>
	     	<td><input type="password" name="password" id="password"></td>
	     </tr>
	   
	                  
           
	     <tr style="text-align:center;" >
	     	<td colspan="2"><input type="submit" class="login_userbtn" value="登录"></td>
	     </tr>
	     <tr style="text-align:center;">
	     	<td colspan="2"><a href="" class="forgetpsw">忘记登录密码?</a><a href="/front/frzhuce" class="user_regist" target="_blank">免费注册</a></td>
	     </tr>
	    </table>
	</form>
