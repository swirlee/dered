<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户登录</title>
<link href="/css/public.css" type="text/css" rel="stylesheet">
<link href="/css/goods.css" type="text/css" rel="stylesheet">
<script src="/js/jquery-1.6.2.js"></script>
<script src="/js/jquery.validate.min.js"></script>
<script>
$(document).ready(function(){
	//提示用户名或用户密码错误
	if("${msg?default('')}"=="用户不存在或密码错误！！！"){
		$("#usernameerror").empty();
		$("#usernameerror").append("<label for='username' generated='true' class='error'>${msg?default('')}</label>");
		$("#usernameerror").show();
	}
	if("${msg1?default('')}"=="验证码错误！！！"){
		$("#codeerror").empty();
		$("#codeerror").append("<label for='code' generated='true' class='error'>${msg1?default('')}</label>");
		$("#codeerror").show();
	}

	//validate校验
	$("#theForm").validate({
		errorPlacement:function(error,element) {
			error.appendTo(element.parent().find(".login_error_sp"));
			element.parent().find(".login_error_sp").show('normal');
    	},
		success:function(label){
		    label.parent().hide();
		},
		rules: {
				username: "required",
				password: "required",
				code:"required"
		},
		messages: {
				username: "用户名不能为空",
				password: "密码不能为空",
				code:"验证码不能为空"
		}
	});
	//滚动条滚动事件
	$(window).scroll(function(){
	var top = $(document).scrollTop();
	if(top==0){
		$(".back_box").hide();
	}else{
		$(".back_box").show();	
	}
	});						

});
//生成验证码(没用)
function refreshCode() {
	$.ajax({
		type : 'POST',
		url : '/front/random',
		dataType : "json",
		success : function(data) {
			if (data != null) {
				$("#verify_code").val(data.code);
				$("#code_img").attr("src", data.img);
			}
		}
	});
}

</script>
<script type="text/javascript">
	function refresh(obj) {
		obj.src = "random?"+Math.random();
	}
</script>
</head>
<body id="body_login">
<div class="main"> 

  <div class="index">
    <div class="index2" >
     
      <div class="login_usertb">
      <div class="login_logo">
	 	<a href="/front/index"><img src="/images/ff2232cb-7a55-47b2-b0b4-cd90793e5ea1.jpg"></a>
	 </div>
        <div class="login_usetbox">
          <div class="login_usrin">
            <ul>
              <form action="frdologin" method="post" name="theForm" id="theForm" novalidate="novalidate">
                <li class="login_usertxt">
                	<b>登录名：</b>
                  <input name="username" type="text" value="" id="username" class="login_utxt" autocomplete="off">
                  <span class="login_error_sp" id ="usernameerror"style="display:none">
                  	
                  </span>
                </li>
                <li class="login_usertxt">
					<b>密码：</b>
                  <input name="password" type="password" value="" id="password" autocomplete="off" class="login_utxt">
                  <span class="login_error_sp" style="display:none"></span>
                </li>
                <li class="login_usercode">
                <b>验证码：</b>
                  <input name="code" type="text" id="code" autocomplete="off" style="text-transform:uppercase;" class="usecode">
                  <input name="verify_code" type="hidden" id="verify_code" value="">
                  <input name="goodsid" type="hidden" id="goodsid" value="${goodsid?default('')}">
                  <span class="login_codeimg"> 
                  <img style="cursor:pointer;" src="random" id="code_img" onclick="refresh(this)" width="80" height="25"></span>
                  <span class="login_error_sp" style="display:none" id="codeerror"></span>
                  </li>
                  <li class="login_usercheck">
	                  <a href="" class="forgetpsw">忘记登录密码?</a>
	                  <a href="/front/frzhuce" class="user_regist">免费注册</a>
                  </li>
                <li>
                  <input name="" type="submit" class="login_userbtn" value="登录">
                </li>
              </form>
            </ul>
          </div>
        </div>
        
    </div>
  </div>
  

<!--网页底部-->
<#include "/front/foot.ftl"/>
  
</div>
</body>
</html>