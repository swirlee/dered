<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人信息</title>
<link href="/css/public.css" type="text/css" rel="stylesheet">
<link href="/css/user.css" type="text/css" rel="stylesheet">
<link href="/css/jquery-ui-1.8.22.custom.css" type="text/css" rel="stylesheet">
<link href="/css/overlay.css" type="text/css" rel="stylesheet">
<script src="/js/jquery-1.6.2.js"></script>
<script src="/js/jquery-ui-1.8.21.js"></script>
<script src="/js/jquery.zh.cn.js"></script>
<script src="/js/jquery.validate.min.js"></script>
<script>
$(document).ready(function(){
	$('#birthday').datepicker({
	    dateFormat:"yy-mm-dd",
		yearRange:"1950:2020",
		changeMonth: true,
		changeYear: true
	});
	
	//给性别单选按钮赋值
	if("${user.sex?default('')}"=="男"){
		$("#man").attr("checked",true);	
	}else if("${user.sex?default('')}"=="女"){
		$("#woman").attr("checked",true);	
	}
	
	//修改用户基本信息的validate校验
	$("#detail_form").validate({
	  rules: {
		  username:{
			  required:true,
		  	  remote:{
			       url: "/person/validate",
                   type: "post",
                   dataType: "json",
                   data: {
                	   "validate": function(){return $("#username").val();},
 		        	   "ziduan":"username"
 		           }
		  	  }
		  }
	  },	  
	  messages: {
		  username:{required:"用户名不能为空！",remote:"用户名已被其他用户使用，请更换！"}
	  }
	  
	});
	//ajax修改用户详细信息	  
	$("#detail_submit").click(function(){
		var username = $("#username").val();
		var realname = $("#realname").val();
		var sex = $("input[name=sex]:checked").val();
		$.ajax({
			url:"/person/ajax_update_detail",
			type:"post",
			data:{"username":username,"realname":realname,"sex":sex},
			success:function(data){
				if(data === true){
					alert("您的用户基本信息已修改成功！");
				}
				if(data === false){
					$("#detail_msg").show();
					$("#detail_msg").html("请尝试修改用户名！");
				}
			}
		});
	});	
	
	
	
	
	
	//修改用户密码的validate校验
	$("#password_form").validate({
	  rules: {
			new_password:{required:true,minlength:6,maxlength:20},
			new_password1:{required:true,equalTo:"#new_password"},
			old_password:{required:true}
	  },
	  messages: {
		new_password:{required:"新密码不能为空",minlength:"新密码不能少于{0}位",maxlength:"新密码不能大于{0}位"},
		new_password1:{required:"重复密码不能为空",equalTo:"两次密码输入不一样"},
	    old_password:{required:"当前密码不能为空"}
	  }
	});
	//ajax修改用户密码	  
	$("#password_submit").click(function(){
		var old_password = $("#old_password").val();
		var new_password = $("#new_password").val();
		$.ajax({
			url:"/person/ajax_update_password",
			type:"post",
			data:{"old_password":old_password, "new_password":new_password},
			success:function(data){
				
					if(data === true){
						alert("您的密码已修改成功！");
						$("#old_password").val("");
						$("#new_password").val("");
						$("#new_password1").val("");
					}if(data === false){
						$("#password_msg").show();
						$("#password_msg").html("原始密码错误，请重新输入！！！");
					}
				
			}
		});
	});
	
	//修改邮箱的validate校验
 $("#email_form").validate({
      rules: {
			email:{
				   required:true,
			       email:true,
			       remote:{
				       url: "/person/validate",
                       type: "post",
                       dataType: "json",
                       data: {
                    	   "validate": function(){return $("#email").val();},
     		        	   "ziduan":"email"
     		           }
				   } ,
 			password:{required:true}
			}
	   },
	   messages: {
		   email:{required:"邮箱不能为空",email:"邮箱格式不对",remote:"该邮箱已存在"},
		    password:{required:"当前密码不能为空"}
			
	   }
 });
//ajax修改用户邮箱	  
	$("#email_submit").click(function(){
		var password = $("#password").val();
		var email = $("#email").val();
		$.ajax({
			url:"/person/ajax_update_email",
			type:"post",
			data:{"password":password,"email":email},
			
			success:function(data){
				if(data === true){
					alert("您的邮箱已修改成功！");
					$("#password").val("");
					$("#email").val("");
					$("#a_email").html(email);
				}
				if(data === false){
					$("#email_msg").show();
					$("#email_msg").html("密码错误，请重新输入！！！");
				}
			}
		});
	});	  

	//点击主菜单，收起、下放副菜单
	$(".sellul>li>a").click(function(){
	  var child_show=$(this).attr("child_show");
	  if(child_show=="true"){
	    $(this).parent().find("img").attr("src","/images/menucontract.jpg");
	    $(this).parent().find("ul").slideUp('normal');
	    $(this).attr("child_show","false");
	  }else{
	    $(this).parent().find("img").attr("src","/images/menuspread.jpg");
	    $(this).parent().find("ul").slideDown('normal');
	    $(this).attr("child_show","true");
	  }
	});
});
//点击“基本信息”、“修改密码”等选项修改内容
function updateCheck(obj,str){
	$(".orderul li").removeClass("this");
 	$(obj).parent().addClass("this");
 	$(".addnav").siblings().hide();
 	$("#"+str).show();
}
</script>
</head>
<body>
<!-- 利用include标签引入网页顶部的登录栏 -->
<#include "/front/top.ftl"/>
<!-- 利用include标签引入网页顶部的搜索 -->
<#include "/front/search.ftl"/>

<div class="main">

  <div class="user_center"></div>
   <table width="1200" border="0" cellspacing="0" cellpadding="0" class="user_table">
      <tbody>
      <tr>
		<td width="177" id="userbg" valign="top">
		<div class="user_photo">
		<dl>
		<dt><img src="${user.headimagepath?default('')}" onerror="this.src='/images/tx.jpg'" width="120" height="120" id="userImg"></dt>
		<dd><span><a href="">编辑资料</a></span></dd>
		</dl>
		</div>
	  <div class="seller">
	    <div class="product_manage2">
	      <ul class="sellul">
	        <li><a href="javascript:void(0);" child_show="true"><b><img src="/images/usercenter/menuspread.jpg" width="10" height="10"></b>我的账户</a>
	          <ul>
	            <li op="account" class="this"><a href="">个人资料</a></li>
	            <li op="address"><a href="/order/showaddress">收货地址</a></li>
           		<li op=""><a href="/order/myorder">我的订单</a></li>
	          </ul>
	        </li>
	      </ul>
	    </div>
	  </div>
</td>

 




     <td id="centerbg" valign="top">
        <div class="buyer_position"><div class="buyer_p_box"><a href="javascript:void(0);">我的账户</a> &gt; <span>个人资料</span></div></div>
        <div class="productmain">
            <div class="ordernav">
              <ul class="orderul">
                <li class="this"><a class="xuanze" href="javascript:void(0);" onclick="updateCheck(this,'update_detail')">基本信息</a></li>
                <li				><a class="xuanze" href="javascript:void(0);" onclick="updateCheck(this,'update_password')">修改密码</a></li>
                <li				><a class="xuanze" href="javascript:void(0);" onclick="updateCheck(this,'update_email')">修改电子邮件</a></li>
				<li				><a class="xuanze" href="javascript:void(0);" onclick="updateCheck(this,'update_phone')">修改手机号码</a></li>
                <li				><a class="xuanze" href="javascript:void(0);" onclick="updateCheck(this,'update_headimg')">更换头像</a></li>
              </ul>
            </div>
                       
                       
            <div class="ordercon">
              <!-- 用户详情 -->
              <div class="addnav" id="update_detail" style="display: block;">
                  <form id="detail_form" action="javascript:void(0)" method="post">
                  <table width="705" border="0" cellspacing="0" cellpadding="0" class="addnavtable">
                    <tbody>
                    <tr>
                      <td width="100" align="right">用户名称：</td>
                      <td class="px10"><span class="setinput">
                        <input type="text" name="username" id="username" value="${user.username?default('')}" readonly>
                        <label for="username" id ="username_msg" generated="true" class="error"></label>
                      </span></td>
                    </tr>
                    <tr>
                      <td align="right">真实姓名：</td>
                      <td class="px10"><span class="setinput">
                        <input type="text" name="realname" id="realname" value="${user.realname?default('')}">
                        </span></td>
                    </tr>
                    <tr>
                      <td align="right">性&nbsp; &nbsp; &nbsp; &nbsp;别：</td>
                      <td class="px10">
                      <label>
                        <label>
                        <input type="radio" name="sex" id="man" value="男" >男 
                        </label>
                        &nbsp; &nbsp; &nbsp; &nbsp;
                       <label>
                        <input type="radio" name="sex" id="woman" value="女">女 
                        </label></td>
                    </tr>
					<tr>
                      <td align="right">电子邮箱：</td>
                      <td class="px10"><a id="a_email">${user.email?default('')}</a><a href="">[去绑定]</a></td>
                    </tr>
                    <tr>
                      <td align="right">手机号码：</td>
                      <td class="px10"><a id="a_phone">${user.phone?default('')}</a><a href="">[去绑定]</a></td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                      <td class="px10"><span class="setsub">
                        <input type="submit" id="detail_submit" value="提交" style="cursor:pointer;">
                        </span></td>
                    </tr>
                  </tbody></table>
                  </form>
              </div>
              
              <!-- 修改密码 -->
              <div class="addnav" id="update_password" style="display: none;">
                <form id="password_form" action="javascript:void(0)" method="post">
                <table width="705" border="0" cellspacing="0" cellpadding="0" class="addnavtable">
                  <tbody><tr>
                    <td width="80" align="right" valign="top" class="modifysp"><span>您的密码：</span><span><strong class="red" style="font-size:14px;">*</strong></span></td>
                    <td class="px10"><span class="setinput">
                      <input type="password" name="old_password" id="old_password">
                      <label for="old_password" id ="password_msg" generated="true" class="error"></label>
                      </span></td>
                  </tr>
                  <tr>
                    <td width="80" align="right" valign="top" class="modifysp"><span>新密码：</span><span><strong class="red" style="font-size:14px;">*</strong></span></td>
                    <td class="px10"><span class="setinput">
                      <input name="new_password" type="password" id="new_password">
                      </span></td>
                  </tr>
                  <tr>
                    <td width="80" align="right" valign="top" class="modifysp"><span>重复密码：</span><span><strong class="red" style="font-size:14px;">*</strong></span></td>
                    <td class="px10"><span class="setinput">
                      <input name="new_password1" type="password" id="new_password1">
                      </span></td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td class="px10"><span class="setsub">
                      <input type="submit" id="password_submit" value="提交" style="cursor:pointer;">
                      </span></td>
                  </tr>
                </tbody></table>
                </form>
              </div>
              
              <!-- 修改email -->
              <div class="addnav" id="update_email" style="display: none;">
                <form id="email_form" action="javascript:void(0)" method="post">
                <table width="705" border="0" cellspacing="0" cellpadding="0" class="addnavtable">
                  <tbody><tr>
                    <td width="80" align="right" valign="top" class="modifysp"><span>您的密码：</span><span><strong class="red" style="font-size:14px;">*</strong></span></td>
                    <td class="px10"><span class="setinput">
                      <input name="password" type="password" id="password">
                      <label for="password" id ="email_msg" generated="true" class="error"></label>
                      </span></td>
                  </tr>
                  <tr>
                    <td width="80" align="right" valign="top" class="modifysp"><span>电子邮件：</span><span><strong class="red" style="font-size:14px;">*</strong></span></td>
                    <td class="px10"><span class="setinput">
                      <input name="email" type="text" id="email">
                      </span></td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td class="px10"><span class="setsub">
                       <input type="submit" id="email_submit" value="提交" style="cursor:pointer;">
                      </span></td>
                  </tr>
                </tbody></table>
                </form>
              </div>
              
              
              <!-- 修改手机号 -->
              <div class="addnav" id="update_phone" style="display: none;">
                <form id="phone_form" action="javascript:void(0)" method="post">
			    <input type="hidden" id="redisKey" name="redisKey">
                <table width="705" border="0" cellspacing="0" cellpadding="0" class="addnavtable">
                  <tbody><tr>
                    <td width="101" align="right" valign="top" class="modifysp"><span>新手机号码：</span><span><strong class="red" style="font-size:14px;">*</strong></span></td>
                    <td width="604" class="px10"><span class="setinput">
                      <input name="mobile" type="text" id="mobile">
                       <label for="password" id ="email_msg" generated="true" class="error"></label>
                      <a href="javascript:void(0);" onclick="generic_mobile_verify_code();" id="mobile_verify_code_generic">获取验证码</a><span id="time_out_generic"></span></span></td>
                  </tr>
                  <tr>
                    <td width="101" align="right" valign="top" class="modifysp"><span>手机验证码：</span><span><strong class="red" style="font-size:14px;">*</strong></span></td>
                    <td class="px10"><span class="setinput">
                      <input name="mobile_verify_code" type="text" id="mobile_verify_code">
                      </span></td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td class="px10"><span class="setsub">
                       <input type="submit" id="phone_submit" value="提交" style="cursor:pointer;">
                      </span></td>
                  </tr>
                </tbody></table>
                </form>
              </div>
              
              
              <!-- 修改头像 -->
              <div class="addnav"  id="update_headimg" style="display: none;"> 
    			 <table width="705" border="0" cellspacing="0" cellpadding="0" class="addnavtable">
              		<tbody>
              		<tr>              
		                 <td width="100" align="right">原头像：</td> 
			             <td class="px10"><div id="img_div">
					  		<img src="${user.headimagepath?default('')}" onerror="this.src='/images/add.jpg'" id="imgOfHead" width="132" height="132">
					  		<input type="file" id="userphoto" name="userphoto">
					  	 </div></td>
		  		 	</tr>	        
           		    <tr>
		               <td align="right"></td>
		               <td class="px10">点击图片选择头像<strong>，建议尺寸128*128像素</strong></td>
                    </tr> 
					<tr>  
						<td align="right"></td>
						<td class="px40">
							<input type="submit" value="保 存" style="cursor:pointer;width:64px;" id="savePhoto"> 
						</td>
					</tr>
					</tbody>
				</table>
			 </div>
               
               
               
               
            </div>
          </div></td>
      </tr>
    </tbody></table>
  </div>
   
</div>

<script>
var input = document.getElementById("userphoto");
//检测浏览器是否支持FileReader
 if (typeof (FileReader) === 'undefined') {
     result.innerHTML = "抱歉，你的浏览器不支持 FileReader，请使用现代浏览器操作！";
     input.setAttribute('disabled', 'disabled');
 } else {
 //开启监听
     input.addEventListener('change', readFile, false);
 }
function readFile() {
     var file = this.files[0];
     //限定上传文件的类型，判断是否是图片类型
     if (!/image\/\w+/.test(file.type)) {
         alert("只能选择图片");
         return false;
    }
     var reader = new FileReader();
     reader.readAsDataURL(file);
     reader.onload = function (e) {
       base64Code=this.result;
        //把得到的base64赋值到img标签显示
       $("#imgOfHead").attr("src",base64Code);
     }
  }
</script>

<script> 

	$("#savePhoto").click(function(){
		var formdata = new FormData();
		var img_file = document.getElementById("userphoto");
		var fileObj = img_file.files[0];
		formdata.append("imgFile", fileObj); 
		$.ajax({ 
			url: "/person/ajax_upload_userImg", 
			type:"post",
			data: formdata,
			contentType: false, 
			processData: false,
			success: function(data) { 
				if(data.user != null) {
					$("#imgOfHead").attr("src", data.user.headimagepath);
					$("#userImg").attr("src", data.user.headimagepath);
					alert("头像修改成功！！！");
				}
			} 
		}); 
	}); 

</script>
<!--网页底部-->
<#include "/front/foot.ftl"/>

</body>
</html>