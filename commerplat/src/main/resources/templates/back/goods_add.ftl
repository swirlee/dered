<!DOCTYPE html PUBLIC>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title></title>
<link href="/css/template.css" rel="stylesheet" type="text/css">
<script src="/js/jquery-1.6.2.js"></script>
<script src="/js/jquery.validate.min.js"></script>
<!-- 这三个是配置ueditor的 -->
<script type="text/javascript" charset="utf-8" src="/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="/ueditor/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="/ueditor/lang/zh-cn/zh-cn.js"></script>
<script>

$(document).ready(function(){

	/* 将长文本框替换为ueditor */
    UE.getEditor('details');
	
	$("#theForm").validate({
		rules:{
			goodsname:{
				required :true
			},
			classes3:{
				required :true
			},
			sellprice:{
				required :true
			},
			originalprice:{
				required :true
			},
			inventory:{
				required :true
			},
			textfield:{
				required :true
			},
			goodsnumber:{
				required :true,
				//remote:{
				  //  url: "/goods/findByGoodsNumber",
		            //type: "post", 
	 	            //dataType: "json",
		            //data: {"goodsnumber": function(){return $("#goodsnumber").val();}},
		        //}
			}
		},
		messages:{
			goodsname:{
				required:"请主子输入商品名称"
			},
			classes3:{
				required:"请主子选择商品的详细分类"
			},
			sellprice:{
				required :"请主子输入售价"
			},
			originalprice:{
				required :"请主子输入原价"
			},
			inventory:{
				required :"请主子输入库存量"
			},
			textfield:{
				required :"请主子选择商品主图"
			},
			goodsnumber:{
				required :"请主子录入货号",
				//remote:"此货号已存在，请核对后再输入"
			}
		}
	});

});

	
	function saveForm(method){
		$("#theForm").submit();
	}

	

	//设置推荐开关
	function recommendState(){
		var state = $("#recommend").val();
		if(state=="true"){
			$("#recommend").val("false");
			$("#recommendOff").show();
			$("#recommendOn").hide();
		}else{
			$("#recommend").val("true");
			$("#recommendOff").hide();
			$("#recommendOn").show();
		}
	}


	

</script>
</head>
<body>
<div class="cont">
	<h1 class="seth1">商品分类</h1>
	<div class="settab"><span class="tab-one"></span>
      <span class="tabs">
       <a href="/goods/showGoods">商品管理</a>
		|
       <a href="/goods/addGoods" class="this">新增</a>	   
      </span>
      <span class="tab-two"></span>
	</div>
	<form name="theForm" id="theForm" action="/goods/saveGoods" method="post" enctype="multipart/form-data" novalidate="novalidate">
	  
	  <div class="setcont">
	    <ul class="set1">
	      <li><strong class="orange fontsize20">*</strong>商品名称</li>
	      <li><span class="webname">
	        <input type="text" name="goodsname" id="goodsname" value="" size="40">
	      </span></li>
	    </ul>
	    
	    <ul class="set1">
	      <li>上级分类</li>
	      <li>
			<span class="webnamesec sizese">
				<select name="classes1" id="classes1" onchange="classesSelect(this)">
					<option value="" >==选择1级分类==</option>
					<#if list_classes??> 
	    			<#list list_classes as classes1>  
					<option value="${classes1.id}">${classes1.classname}</option>
					</#list>
	       			</#if>
       			</select>
				<select name="classes2"  id="classes2" onchange="classesSelect(this)">
					<option value="">==选择2级分类==</option>
				</select>
				
				<select name="classes3" id="classes3">
					<option value="">==选择3级分类==</option>
				</select>
			</span> 
	      </li>
	    </ul>
	    
	    <ul class="set1">
	      <li>品牌</li>
	      <li>
			<span class="webnamesec sizese">
				<select name="brand" id="brand">
					<option value="" >==选择品牌==</option>
					<#if list_brand??> 
	    			<#list list_brand as brand>  
					<option value="${brand.id}">${brand.brandname}</option>
					</#list>
	       			</#if>
       			</select>
       			
			</span> 
	      </li>
	    </ul>
		
		<ul class="set1">
	      <li>规格选择</li>
	      <li>
			<span class="webnamesec sizese">
				<select name="spec1" id="spec1" onchange="specSelect(this,'spec1')">
					<option value="" >==选择规格1==</option>
					<#if list_spec??> 
	    			<#list list_spec as spec>  
					<option value="${spec.id}">${spec.specname}</option>
					</#list>
	       			</#if>
       			</select>
       			<select name="specv1"  id="specv1">
					<option value="">==选择规格值==</option>
				</select>
			</span> 
	      </li>
	      <li>
			<span class="webnamesec sizese">
				<select name="spec2" id="spec2" onchange="specSelect(this,'spec2')">
					<option value="" >==选择规格2==</option>
					<#if list_spec??> 
	    			<#list list_spec as spec>  
					<option value="${spec.id}">${spec.specname}</option>
					</#list>
	       			</#if>
       			</select>
       			<select name="specv2"  id="specv2">
					<option value="">==选择规格值==</option>
				</select>
			</span> 
	      </li>
	    </ul>
	    
		<ul class="set1">
			<li>推荐</li>
			<li>
				<input name="recommend" id="recommend" type="hidden" value="false">
				<img src="/images/on.jpg" width="61" height="23" id="recommendOn" onclick="recommendState();" style="cursor:pointer; display: none">
				<img src="/images/off.jpg" width="61" height="23" id="recommendOff" onclick="recommendState();" style="cursor: pointer">
	   		</li>
	    </ul>
	   <ul class="set1">
	   		<li>状态</li>
	   		<li>
		   		上架：
				<input type="radio" checked="checked" name="state" value="上架" />
				下架：
				<input type="radio" name="state" value="下架" />
			</li>
	    </ul>


	    <ul class="set1">
	      <li>原价</li>
	      <li><span class="webname">
			  <input type="text" name="sellprice" id="sellprice" value="">
		  </span></li>
	    </ul>
	    
	    <ul class="set1">
	      <li>售价</li>
	      <li><span class="webname">
			  <input type="text" name="originalprice" id="originalprice" value="">
		  </span></li>
	    </ul>
	    
	    <ul class="set1">
	      <li>库存</li>
	      <li><span class="webname">
			  <input type="text" name="inventory" id="inventory" value="">
		  </span></li>
	    </ul>
	    
	    <ul class="set1">

	  	<li>添加商品展示图片</li>
	  	<li>
	  	<div class="divToGoodsPhoto">
	  	 	<img id="img1"  width="150"  height="150" src="/images/add.jpg">
            <span  class="file">
	  			<input type="file" name="file1"   onchange="PreviewImage(this,'img1')"/>
	  		</span>
		</div>
		<div class="divToGoodsPhoto">
	  	 	<img id="img2"  width="150"  height="150" src="/images/add.jpg">
            <span  class="file">
	  			<input type="file" name="file2"   onchange="PreviewImage(this,'img2')"/>
	  		</span>
		</div>
		<div class="divToGoodsPhoto">
	  	 	<img id="img3"  width="150"  height="150" src="/images/add.jpg">
            <span  class="file">
	  			<input type="file" name="file3"   onchange="PreviewImage(this,'img3')"/>
	  		</span>
		</div>
		<div class="divToGoodsPhoto">
	  	 	<img id="img4"  width="150"  height="150" src="/images/add.jpg">
            <span  class="file">
	  			<input type="file" name="file4"   onchange="PreviewImage(this,'img4')"/>
	  		</span>
		</div>
		<div class="divToGoodsPhoto">
	  	 	<img id="img5"  width="150"  height="150" src="/images/add.jpg">
            <span  class="file">
	  			<input type="file" name="file5"   onchange="PreviewImage(this,'img5')"/>
	  		</span>
	  	</div>
		</li>
		
		
      </ul>
      	
		<ul class="set1">
			<li>体积</li>
		 	<li><span class="webname">
		 		<input type="text" name="volume" id="volume" value="">
		 	</span></li>
		</ul>
		
		<ul class="set1">
			<li>重量</li>
		 	<li><span class="webname">
		 		<input type="text" name="weight" id="weight" value="">
		 	</span></li>
		</ul>
		
		<ul class="set1">
			<li>货号</li>
		 	<li><span class="webname">
		 		<input type="text" name="goodsnumber" id="goodsnumber" value="">
		 	</span></li>
		</ul>
		
		<ul class="set1">
			<li>详情</li>
		 	<li><span class="webname">
		 	<textarea rows="99" cols="99" id="details" name="details" width="170" height="800"></textarea>
		 	</span></li>
		</ul>
		
	    </div>
  </form>
  <div class="submit">
    <input type="button" id="save" name="save" value="提交" onclick="saveForm()">
  </div>
</div>

</body>

<script type="text/javascript">

function specSelect(obj,spec){
		//选中一规格值，另一栏的规格列表隐藏该规格值
		if(spec=="spec1"){
			$("#spec2 option").show();
			var values = $("#spec1").val();
			$("#spec2 option[value="+values+"]").hide();
		}
		if(spec=="spec2"){
			$("#spec1 option").show();
			var values = $("#spec2").val();
			$("#spec1 option[value="+values+"]").hide();
		}
		var id = $(obj).val();
		if($(obj).val()==0)	{
			$(obj).next().empty();
			$(obj).next().append("<option value=''>==选择规格值==</option>");
		}
		if($(obj).val()!= 0){
			$.ajax({
				url:"ajax_spec_select",
				data:{"id":id},
				type:"post",
				success:function(msg){
					var str = "";
					
					$.each(msg.list_specv,function(){
						if($("#spec2").val() != this.id){
							str += "<option value='"+this.id+"'>"+this.specvname+"</option>";
						}
					})
					
					
					$(obj).next().empty();
					$(obj).next().append("<option value=''>==选择规格值==</option>");
					$(obj).next().append(str);
				}
			})
		}
	}
function classesSelect(obj){
		var id = $(obj).val();
		var name = $(obj).attr("name");
		
		if($("#classes1").val()==0)	{
			$("#classes2").empty();
			$("#classes3").empty();
			$("#classes2").append("<option value=''>==选择2级分类==</option>");
			$("#classes3").append("<option value=''>==选择3级分类==</option>");
		}
		
		if($("#classes2").val()==0)	{
			$("#classes3").empty();
			$("#classes3").append("<option value=''>==选择3级分类==</option>");
		}
		
		if(id != 0){
			$.ajax({
				url:"ajax_classes_select",
				data:{"pid":id},
				type:"post",
				success:function(msg){
				var str = "";
					$.each(msg.list_classes,function(){
						str += "<option value='"+this.id+"'>"+this.classname+"</option>";
					})
					
					if(name == "classes1"){
						$("#classes2").empty();
						$("#classes3").empty();
						$("#classes2").append("<option value=''>==选择2级分类==</option>");
						$("#classes3").append("<option value=''>==选择3级分类==</option>");
						$("#classes2").append(str);
					}
					
					if(name == "classes2"){
						$("#classes3").empty();
						$("#classes3").append("<option value=''>==选择3级分类==</option>");
						$("#classes3").append(str);
					}
				}
			})
		}
	}
	
	//标志图片鼠标经过显示
	$("#brandImgShow").mouseover(function(){
		$("#brandImg").show();
	})
	$("#brandImgShow").mouseout(function(){
		$("#brandImg").hide();
	})
	$("#brandLogo").change(function(){
		$("#textfield1").val($("#brandLogo").val());
	})
	
	
	
//即时显示要上传的图片
function PreviewImage(obj,imgPreviewId){
	//允许上传文件的扩展名
    var allowExtention=".jpg,.bmp,.gif,.png";
	//获取文件扩展名
    var extention=obj.value.substring(obj.value.lastIndexOf(".")+1).toLowerCase();
	//获取浏览器版本
    var browserVersion= window.navigator.userAgent.toUpperCase();  
    if(allowExtention.indexOf(extention)>-1){   
        if(obj.files){//HTML5实现预览，兼容chrome、火狐7+等  
            if(window.FileReader){  
                var reader = new FileReader();   
                reader.onload = function(e){  
                    document.getElementById(imgPreviewId).setAttribute("src",e.target.result);
                }    
                reader.readAsDataURL(obj.files[0]);  
            }else if(browserVersion.indexOf("SAFARI")>-1){  
                alert("不支持Safari6.0以下浏览器的图片预览!");  
            }  
        }else if (browserVersion.indexOf("MSIE")>-1){  
            if(browserVersion.indexOf("MSIE 6")>-1){//ie6  
                document.getElementById(imgPreviewId).setAttribute("src",obj.value);
            }else{//ie[7-9]  
                obj.select();  
                if(browserVersion.indexOf("MSIE 9")>-1)  
                    obj.blur();//不加上document.selection.createRange().text在ie9会拒绝访问  
                  
                newPreview.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale',src='" + document.selection.createRange().text + "')";                              
                  
                tempDivPreview.parentNode.insertBefore(newPreview,tempDivPreview);  
                tempDivPreview.style.display="none";                      
            }  
        }else if(browserVersion.indexOf("FIREFOX")>-1){//firefox  
            var firefoxVersion= parseFloat(browserVersion.toLowerCase().match(/firefox\/([\d.]+)/)[1]);  
            if(firefoxVersion<7){//firefox7以下版本  
                document.getElementById(imgPreviewId).setAttribute("src",obj.files[0].getAsDataURL());  
            }else{//firefox7.0+                      
                document.getElementById(imgPreviewId).setAttribute("src",window.URL.createObjectURL(obj.files[0]));  
            }  
        }else{  
            document.getElementById(imgPreviewId).setAttribute("src",obj.value);  
        }           
    }else{  
        alert("仅支持"+allowExtention+"为后缀名的文件!");
        obj.value="";//清空选中文件
        if(browserVersion.indexOf("MSIE")>-1){
            obj.select();
            document.selection.clear();
        }
        obj.outerHTML=obj.outerHTML;
    }  
}
	
</script>
</html>