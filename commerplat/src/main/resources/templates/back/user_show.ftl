<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title></title>
<link href="/css/template.css" rel="stylesheet" type="text/css">
<script src="/css/jquery-1.6.2.js"></script>
<script src="/css/jquery.poshytip.min.js"></script>
<script src="/css/jquery.shop.common.js"></script>
<script src="/css/jquery.validate.min.js"></script>
<script>
jQuery(document).ready(function(){
 jQuery.validator.addMethod("verify",function(value,element){
	  var re = /^[0-9a-zA-Z]*$/;
        if(re.test(jQuery("#userName").val())){			
			return true;
		  } 
		  else {
		    return false;
			  }		  
});
 
//判断手机号格式
 jQuery.validator.addMethod("num",function(value,element){
	  var re = /(1[3-9]\d{9}$)/;
       if(re.test(jQuery("#mobile").val())){			
			return true;
		  } 
		  else {
		    return false;
			  }		  
});

  jQuery("#theForm").validate({
    rules:{
	  userName:{
	    required :true,
		verify:true,
	     remote:{
		    url: "http://aishang2018.vicp.io:11585/shopping/verify_username.htm",     //后台处理程序
            type: "post",               //数据发送方式
            dataType: "json",           //接受数据格式   
            data: {                     //要传递的数据
                  "userName": function(){return jQuery("#userName").val();},
				  "id":function(){return jQuery("#id").val()}
		     }
			}
	  },
	  mobile:{
		  required:true,
		  num:true,
		  remote:{
			    url: "http://aishang2018.vicp.io:11585/shopping/verify_mobile.htm",     //后台处理程序
	            type: "post",               //数据发送方式
	            dataType: "json",           //接受数据格式   
	            data: {                     //要传递的数据
	                  "mobile": function(){return jQuery("#mobile").val();},
	                  "id":function(){return jQuery("#id").val()}
			     }
			}			  
		},
	  email:{
	    required :true,
		email:true,
		remote:{
		    url: "http://aishang2018.vicp.io:11585/shopping/verify_email.htm",     //后台处理程序
            type: "post",               //数据发送方式
            dataType: "json",           //接受数据格式   
            data: {                     //要传递的数据
                  "mail": function(){return jQuery("#userName").val();},
				  "id":function(){return jQuery("#id").val()}
		     }
			}
	  }	 },
	messages:{
	  userName:{required:"用户名不能为空",remote:"该用户名已经存在",verify:"不可输入特殊符号"},
	  mobile:{
		  required:"手机号不能为空",
		  num:"手机号格式不正确",
		  remote:"手机号已存在"
		},
	  email:{required:"电子邮箱不能为空",email:"邮箱格式不对",remote:"该邮箱已被使用"}	}
  });	
  jQuery(":radio[id=sex]").each(function(){
    if(jQuery(this).val()=="0")jQuery(this).attr("checked",true);
  });
  jQuery(":radio[id=report][value=0]").attr("checked",true);
});

function saveForm(){
   jQuery("#theForm").submit();
}


</script><style id="poshytip-css-tip-skyblue" type="text/css">div.tip-skyblue{visibility:hidden;position:absolute;top:0;left:0;}div.tip-skyblue table, div.tip-skyblue td{margin:0;font-family:inherit;font-size:inherit;font-weight:inherit;font-style:inherit;font-variant:inherit;}div.tip-skyblue td.tip-bg-image span{display:block;font:1px/1px sans-serif;height:10px;width:10px;overflow:hidden;}div.tip-skyblue td.tip-right{background-position:100% 0;}div.tip-skyblue td.tip-bottom{background-position:100% 100%;}div.tip-skyblue td.tip-left{background-position:0 100%;}div.tip-skyblue div.tip-inner{background-position:-10px -10px;}div.tip-skyblue div.tip-arrow{visibility:hidden;position:absolute;overflow:hidden;font:1px/1px sans-serif;}</style></head>






<body>
<div class="cont">
  <h1 class="seth1">会员管理</h1>
  <div class="settab"><span class="tab-one"></span>
      <span class="tabs">
	       <a href="/user/userManage">管理</a>|
		   <a href="javascript:void(0);" class="this">查看</a>
	  </span>
      
      <span class="tab-two"></span></div>
 
	<div class="setcont">
  		<ul class="set1">
	      <li>头像</li>
	      <li>
		  	<span class="webname">
		      	<img src="/images/tx.jpg" width="50px">
		  	</span>
	      </li>
	    </ul>
	    <ul class="set1">
	      <li>会员id</li>
	      <li>
		  	<span class="webname">
		      	<input name="mobile" type="text" value="${uu.id?default('')}" readonly="readonly">
		  	</span>
	      </li>
	    </ul>
	    <ul class="set1">
	      <li>会员姓名</li>
	      <li>
		  	<span class="webname">
		      	<input name="username" type="text" value="${uu.username?default('')}" readonly>
		  	</span>
	      </li>
	    </ul>
	    <ul class="set1">
	      <li>添加时间</li>
	      <li>
		  	<span class="webname">
		      	<input name="addtime" type="text" value="${(uu.addtime?string("yyyy-MM-dd HH:mm"))!}" readonly>
		  	</span>
	      </li>
	    </ul>
	    <ul class="set1">
	      <li>邮箱号码</li>
	      <li>
		  	<span class="webname">
		      	<input name="email" type="text"  value="${uu.email?default('')}" readonly>
		  	</span>
	      </li>
	    </ul>
	    <ul class="set1">
	      <li>手机号码</li>
	      <li>
		  	<span class="webname">
		      	<input name="mobile" type="text" value="${uu.phone?default('')}" readonly>
		  	</span>
	      </li>
	    </ul>
	    <ul class="set1">
	      <li>性别</li>
	      <li>
		  	<span class="webname">
		      	<input name="sex" type="text"  value="${uu.sex?default('')}" readonly>
		  	</span>
	      </li>
	    </ul>
	    
	</div>
  
  
</div>

</body>
</html>