<!DOCTYPE html PUBLIC>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>用户注册</title>
<link href="/css/public.css" type="text/css" rel="stylesheet">
<link href="/css/goods.css" type="text/css" rel="stylesheet">
<link href="/css/index.css" type="text/css" rel="stylesheet">
<script src="/js/jquery-1.6.2.js"></script>
<script src="/js/jquery.validate.min.js"></script>

<script>
$(document).ready(function(){
	
	$.validator.addMethod("verify",function(value,element){
		  var re = /^[A-Za-z0-9\u4e00-\u9fa5]+$/;
		  if(re.test($("#username").val())){			
		  	return true;
		  }else {
	      	return false;
		  }		  
	});
	//判断手机号格式
	$.validator.addMethod("num",function(value,element){
		var re = /(1[3-9]\d{9}$)/;
		if(re.test($("#mobile").val())){			
			return true;
		} 
		else {
			return false;
		}
	});
	 
	$("#theForm").validate({				 
		errorPlacement:function(error, element) {
			element.parent().parent("td").next("td").html("");
			error.appendTo(element.parent().parent("td").next("td"));  
		},
    	//自定义规则
		rules:{
			username:{
				required:true,
				verify:true,
				remote:{
					url: "/frzhuce/validate",
					type: "post",
					dataType: "json",
					data: {
						"validate": function(){return $("#username").val();},
						"ziduan":"username"
					}
				}
			},
			password:{
				required:true,
				minlength:6,
				maxlength:20  
			},
			repassword:{
				required:true,
				verify:true,
				equalTo:"#password" 
			},
			mobile:{
				required:true,
				num:true,
				remote:{
				    url: "/frzhuce/validate",
					type: "post",
					dataType: "json",
					data: {
						"validate": function(){return $("#mobile").val();},
						"ziduan":"phone"
					}
				}			  
			},
		email:{
		  required:true,
		  email:true,
		  remote:{
		    	  url:"/frzhuce/validate",
		          type: "post",
		          dataType: "json",
		          data: {
		        	  "validate": function(){return $("#email").val();},
		        	  "ziduan":"email"
		        	  }
		    
		  }
		},
		mobilecode:{
			required:true,
		},		
		agree:{
		  required:true,
		},
		 },
		 
		 messages:{
			username:{
				required:"用户名不能为空",
				verify:"不可使用特殊字符",
				remote:"用户名已存在"
			},
		      password:{
		  required:"密码不能为空",
		  minlength:"密码不能小于{0}个字符",
		  maxlength:"密码不能大于{0}个字符" 
		},
		repassword:{
		  required:"重复密码不能为空",
		  verify:"不可使用特殊字符",
		  equalTo:"两次输入密码不一致"
		},
		mobile:{
		  required:"手机号不能为空",
		  num:"手机号格式不正确",
		  remote:"手机号已存在"
		},		
		email:{
		  required:"email不能为空",
		  email:"email格式不正确",
		  remote:"该email已经存在"
		},
		mobilecode:{
			  required:"手机验证码不能为空"
		},
		agree:{
		  required:"请接受用户协议"
		}
			  }
	});
});


//发送手机验证码
var wait=60;
function scode(o){
	var mobile = $("#mobile").val();
	if(mobile==null||mobile==""){
		alert("手机号未填");
		wait = 0;
	}		
    //读秒
    if (wait == 0) {
        o.removeAttribute("disabled");           
        o.value="手机验证码";
        o.style.color="#000000";
        o.style.backgroundColor="#f7f7f7";
        wait = 60;
    } else {   	
        o.setAttribute("disabled", true);
        o.value="重新发送(" + wait + ")";
        wait--;
         //发送验证码
        if(wait==59){
    		$.ajax({  
    	    	type: "POST",
    	   		url: "http://aishang2018.vicp.io:11585/shopping/sendSMS.htm",
    			data: "mobile="+mobile,
    			error: function(){ 
    				alert("验证码发送失败");
    			}, 
    	   		success: function(redisKey) {
    	   			$("#redisKey").val(redisKey); 	   			   	   			
    	   		}
    	    });
    		o.style.color="#FFFFFF";
        	o.style.backgroundColor="#DCDCDC";
        }
        //验证码结束
        setTimeout(function() {scode(o);},1000);
    }    
}
</script>
</head>
<body>


<!-- 利用include标签引入网页顶部的登录栏 -->
<#include "/front/top.ftl"/>

<!-- 利用include标签引入网页顶部的搜索 -->
<#include "/front/search.ftl"/>

  <script>
$(document).ready(function(){
  $(".navul a").each(function(){
    var original_url=$(this).attr("original_url");
	if("/shopping/register.htm".indexOf(original_url)>=0){
	   $(this).addClass("this");	
	}
  });
  $(".left_menu_dl").mouseover(function(){
	    var child_count = $(this).attr("child_count");
		var sc_id=$(this).attr("id");
		var sc_color=$(this).attr("sc_color");		
	    var eq =$(this).index();
		if($(".left_menu_dd[id=child_"+sc_id+"]").html()==null){
	   	  $.ajax({type:'POST',url:'http://b2b2c.iskyshop.com/nav_data.htm',data:{"sc_id":sc_id},success:function(data){
		    if($(".left_menu_dd[id=child_"+sc_id+"]").html()==null){																						
      	      $(".left_menu_dt[id=dts_"+sc_id+"]").after(data);
		    }
	        if(child_count>0){
		     $("#dts_"+sc_id).addClass("left_menu_this").removeClass("left_menu_dt");
		     $("#child_"+sc_id).show();			
		    }
	    	$("#left_menu_con_"+sc_id).attr("style","border:1px solid "+sc_color+"; border-left:1px solid "+sc_color+";").find(".menu_con_right_top").css("background-color",sc_color);
	        var z = -35;
        	var x = eq*z;
	        $("#left_menu_con_"+sc_id).css('margin-top',x+'px');
		    $(".left_menu_dd[id=child_"+sc_id+"]").show();
	      }});
		}else{
		   if(child_count>0){
		      $("#dts_"+sc_id).addClass("left_menu_this").removeClass("left_menu_dt");
		      $("#child_"+sc_id).show();			
		    }
		    $("#left_menu_con_"+sc_id).attr("style","border:1px solid "+sc_color+"; border-left:1px solid "+sc_color+";").find(".menu_con_right_top").css("background-color",sc_color);
	        var z = -35;
    	    var x = eq*z;
	        $("#left_menu_con_"+sc_id).css('margin-top',x+'px');
		    $(".left_menu_dd[id=child_"+sc_id+"]").show();
		}
		
  }).mouseleave(function(e){
	  $("dt[id^=dts_]").removeAttr("style");
	  $("div[id^=left_menu_con_]").removeAttr("style"); 
	  var child_count = $(this).attr("child_count");
	$("dt[id^=dts_]").removeClass("left_menu_this").addClass("left_menu_dt");	  
	  $(".left_menu_dd[id^=child_]").hide();
  });
  $(".nav_left").mouseover(function(){
	  $("#other_menu").show();
	  
   });
  $(".nav_left").mouseleave(function(){
	  $("#other_menu").hide();
   });	
});

</script>
<div class="main">

<div class="nav"></div>
  
  <div class="index">
    <div class="index2">
      <div class="login_user">
        <div class="login_user_left">
          <div class="login_user_in">
            <h1>用户注册<span>REGISTER</span></h1>
            <h2>填写用户注册信息</h2>
            <div class="login_user_bottom">
              <form action="/frzhuce/dozhuce" method="post" name="theForm" id="theForm" novalidate="novalidate">
                <table width="500" border="0" cellspacing="0" cellpadding="0" class="user_zc_table">
                  <tbody><tr>
                    <td width="95" class="login_nameu">用户名：</td>
                    <td width="200"><span class="login_user_input input_size">
                      <input name="username" type="text" id="username">
                      </span></td>
                    <td class="login_nameu2">登录用户名</td>
                  </tr>
                  <tr>
                    <td class="login_nameu">密码：</td>
                    <td><span class="login_user_input input_size">
                      <input name="password" type="password" id="password">
                      </span></td>
                    <td class="login_nameu2">登录密码,6位以上字母数组组合，不区分大小写</td>
                  </tr>
                  <tr>
                    <td class="login_nameu">确认密码：</td>
                    <td><span class="login_user_input input_size">
                      <input name="repassword" type="password" id="repassword">
                      </span></td>
                    <td class="login_nameu2">再次输入您的密码</td>
                  </tr>
                  <tr>
                    <td class="login_nameu">手机号：</td>
                    <td><span class="login_user_input input_size">
                      <input name="mobile" type="text" id="mobile">
                      </span></td>
                    <td class="login_nameu2">填写真实的手机号</td>
                  </tr>
                  <tr>
                    <td class="login_nameu">电子邮件：</td>
                    <td><span class="login_user_input input_size">
                      <input name="email" type="text" id="email">
                      </span></td>
                    <td class="login_nameu2">录入后不可修改</td>
                  </tr>
                <tr>
                  <!--  <td class="login_nameu">验证码：</td>
                    <td><span class="login_user_input input_size2">
                      <input name="code" type="text" id="code" style="text-transform:uppercase;">
                      <input name="verify_code" type="hidden" id="verify_code" value="0829424ffa0d3a2547b6c9622c77de03">
                      </span><span class="yzm"><img style="cursor:pointer;" src="" id="code_img" onclick="refreshCode();" width="59" height="27"></span>
					 </td>
                    <td class="login_nameu2">点击图片更新验证码</td>
                  </tr>
                  -->
                  <!--                   获取手机验证码 -->
                  <!-- <tr>
                  	<td class="login_nameu">手机验证码：</td>
                  	<td>
                  		<span class="login_user_input input_size2">
                      		<input name="mobilecode" type="text" id="mobilecode">          			
                      	</span>
                      	<span class="yzm">
                      		<input type="button" id="butt" value="手机验证码" class="btn1" onclick="scode(this)">                   		
                      	</span>
                      	<input type="hidden" id="redisKey" name="redisKey">
                    </td>
                    <td class="login_nameu2">点击获取手机验证码</td> 
                  </tr>
                  <tr> -->
<!--                   end -->
                  </tr><tr>
                    <td>&nbsp;</td>
                    <td class="login_nameu2"><span>
                    <input name="agree" type="checkbox" id="agree" value="true">
                      <label for="agree">  &nbsp;我已阅读并同意&nbsp;</label>                      
                      <a href="" class="s_red">用户服务协议</a></span></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><span class="login_user_btn_free">
                      <input name="save" type="submit" id="save" style="cursor:pointer" value>
                      </span></td>
                    <td>&nbsp;</td>
                  </tr>
                </tbody></table>
              </form>
            </div>
          </div>
        </div>
        <div class="login_user_right">
          <h1 class="login_user_h">shopping提示</h1>
          <h2 class="login_user_h2">所有会员享受</h2>
          <ul class="login_user_ul">
 
            <li><span class="login_user_span"><img src="/images/user1.jpg" width="25" height="25"></span><span class="login_user_span2">提交完善您的个人资料</span></li>
            <li><span class="login_user_span"><img src="/images/user4.jpg" width="25" height="25"></span><span class="login_user_span2">在线购买商城任意商品</span></li>
            <li><span class="login_user_span"><img src="/images/user2.jpg" width="25" height="25"></span><span class="login_user_span2">收藏关注的商及品店铺</span></li>
          </ul>
          <h1 class="login_user_h">如果已经拥有账户</h1>
          <div class="login_sys"> <span class="login_user_free"><a href="/front/frlogin"><img src="/images/loginde.jpg" width="98" height="32" border="0"> </a></span>
          </div>
              </div>
      </div>
    </div>
  </div>
  

</div>

<!--网页底部-->
<#include "/front/foot.ftl"/>

</body>
</html>