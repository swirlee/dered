<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

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
	
	//$("#details").html(${goods.details});

	$("#classes1").val("${c1id?default('')}");
	$("#classes2").val("${c2id?default('')}");
	$("#classes3").val("${c3id?default('')}");
	$("#brand").val("${goods.brandid?default('')}");
	$("#spec1").val("${spec1.id?default('')}");
	$("#specv1").val("${spec1.specvid?default('')}");
	$("#spec2").val("${spec2.id?default('')}");
	$("#specv2").val("${spec2.specvid?default('')}");
	
	
	$("#recommend").val(${goods.recommend?string});
	if($("#recommend").val() == "true"){
		$("#recommendOff").hide();
		$("#recommendOn").show();
	}if($("#recommend").val() == "false"){
		$("#recommendOff").show();
		$("#recommendOn").hide();
	}
	
	

	var states = "${goods.state}";
	if(states =="上架"){
 		$("#state1").attr("checked","checked");
	}
	if(states =="下架"){
		$("#state2").attr("checked","checked");
 	}
	
	
	
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
// 			goodsnumber:{
// 				required :true,
// 				remote:{
// 				    url: "/goods/findByGoodsNumber",
// 		            type: "post", 
// 	 	            dataType: "json",
// 		            data: {"goodsnumber": function(){return $("#goodsnumber").val();}},
// 		        }
// 			}
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
// 			goodsnumber:{
// 				required :"请主子录入货号",
// 				remote:"此货号已存在，请核对后再输入"
// 			}
		}
	});
	 	
});

	
	function saveForm(){
		$("#theForm").submit();
	}
	//显示规格值
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
						str += "<option value='"+this.id+"'>"+this.specvname+"</option>";
					})
					$(obj).next().empty();
					$(obj).next().append("<option value=''>==选择规格值==</option>");
					$(obj).next().append(str);
				}
			})
		}
	}

	//设置推荐开关
	function recommendState(){
		var recommend = $("#recommend").val();
		if(recommend=="true"){
			$("#recommend").val("false");
			$("#recommendOff").show();
			$("#recommendOn").hide();
		}else{
			$("#recommend").val("true");
			$("#recommendOff").hide();
			$("#recommendOn").show();
		}
	}
	
	function imageChange(obj){
		debugger;
		var src = $(obj).src();
		alert(src);
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
       <a href="#" class="this">编辑</a>	   
      </span>
      <span class="tab-two"></span>
	</div>
	<form name="theForm" id="theForm" action="/goods/doeditGoods" method="post" enctype="multipart/form-data" novalidate="novalidate">
	  <input name="goodsid" id="goodsid" type="hidden" value="${goods.id}">
	  <input type="hidden" id="file0" name="file0" />
	  <input type="hidden" name="oldimgids"/>
	  <input type="hidden" name="deltePictureArr" id="deltePictureArr" value=""/>
	  <div class="setcont">
	    <ul class="set1">
	      <li><strong class="orange fontsize20">*</strong>商品名称</li>
	      <li><span class="webname">
	        <input type="text" name="goodsname" id="goodsname" value="${goods.goodsname}" size="40">
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
					<#if list_classes2??> 
	    			<#list list_classes2 as classes2>  
					<option value="${classes2.id}">${classes2.classname}</option>
					</#list>
	       			</#if>
				</select>
				
				<select name="classes3" id="classes3">
					<option value="">==选择3级分类==</option>
					<#if list_classes3??> 
	    			<#list list_classes3 as classes3>  
					<option value="${classes3.id}">${classes3.classname}</option>
					</#list>
	       			</#if>
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
       			<select name="specv1" id="specv1">
					<option value="">==选择规格值==</option>
					<#if spp1.list_specv??> 
	    			<#list spp1.list_specv as specv>  
					<option value="${specv.id}">${specv.specvname}</option>
					</#list>
	       			</#if>
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
					<#if spp2.list_specv??> 
	    			<#list spp2.list_specv as specv>  
					<option value="${specv.id}">${specv.specvname}</option>
					</#list>
	       			</#if>
				</select>
			</span> 
	      </li>
	    </ul>
		<ul class="set1">
			<li>推荐</li>
			<li>
				<input name="recommend" id="recommend" type="hidden" value="">
				<img src="/images/on.jpg" width="61" height="23" id="recommendOn" onclick="recommendState();" style="cursor:pointer">
				<img src="/images/off.jpg" width="61" height="23" id="recommendOff" onclick="recommendState();" style="cursor: pointer">
	   		</li>
	    </ul>
	   <ul class="set1">
	   		<li>状态</li>
	   		<li>
	   			上架：
				<input type="radio" id="state1" name="state" value="上架" />
				下架：
				<input type="radio" id="state2" name="state" value="下架" />
			</li>
	    </ul>


	    <ul class="set1">
	      <li>原价</li>
	      <li><span class="webname">
			  <input type="text" name="sellprice" id="sellprice" value="${goods.sellprice?c}">
		  </span></li>
	    </ul>
	    
	    <ul class="set1">
	      <li>售价</li>
	      <li><span class="webname">
			  <input type="text" name="originalprice" id="originalprice" value="${goods.originalprice?c}">
		  </span></li>
	    </ul>
	    
	    <ul class="set1">
	      <li>库存</li>
	      <li><span class="webname">
			  <input type="text" name="inventory" id="inventory" value="${goods.inventory?c}">
		  </span></li>
	    </ul>
	    
	    <ul class="set1">
	    
		<li>添加商品展示图片</li>
	  	<li>
	  		<div class="divToGoodsPhoto2">
	  		<div class="divToGoodsPhotoup">
	  	 	<img id="img1"  width="150"  height="150" src="${goods.path?default('/images/add.jpg')}">
            <span  class="file">
	  			<input type="file" name="file1" onchange="PreviewImage(this,'img1')"/>
	  		</span>
	  		</div>
	  		<a href="javascript:void(0);" onclick="deletephoto(this)" pictureid="firstPicture"><div class="divToGoodsPhotodown">删除</div></a>
			</div>
		
			<#if list_imagesPath??> 
			<#assign count=1>
	        <#list list_imagesPath as p>
	        <#assign count=count+1>
			<div class="divToGoodsPhoto2">
				<div class="divToGoodsPhotoup">
					<input name="imagesPaths" id="imagesPaths" type="hidden" value="${p.id}">
			  	 	<img id="oldfile${count}"  width="150"  height="150" src="${p.path?default('/images/add.jpg')}">
		            <span  class="file">
			  			<input type="file" name="oldfile${count}"   onchange="PreviewImage(this,'oldfile${count}')" pathsid="${p.id?c}" oldids=""/>
			  		</span>
			  	</div>
		  		<a href="javascript:void(0);" onclick="deletephoto(this)" pictureid="${p.id}"><div class="divToGoodsPhotodown">删除</div></a>
			</div>
			</#list>
	        </#if>
	        
			<#if (list_imagesPath?size<4)>
			<#assign ccc=1>
			<#list 1..4-list_imagesPath?size as i>
			<#assign ccc=ccc+1>
			<div class="divToGoodsPhoto2">
				<div class="divToGoodsPhotoup">
				 	<img id="newfile${ccc}"  width="150"  height="150" src="/images/add.jpg" >
		            <span  class="file">
			  			<input type="file" name="newfile${ccc}"   onchange="PreviewImage(this,'newfile${ccc}')"/>
			  		</span>
		  		</div>
		  		<a href="javascript:void(0);" onclick="deletephoto(this)"pictureid=""><div class="divToGoodsPhotodown">删除</div></a>
			</div>
			</#list>
			</#if>
		</li>
      </ul>
      	
		<ul class="set1">
			<li>体积</li>
		 	<li><span class="webname">
		 		<input type="text" name="volume" id="volume" value="${goods.volume}">
		 	</span></li>
		</ul>
		
		<ul class="set1">
			<li>重量</li>
		 	<li><span class="webname">
		 		<input type="text" name="weight" id="weight" value="${goods.weight?default('')}">
		 	</span></li>
		</ul>
		
		<ul class="set1">
			<li>货号</li>
		 	<li><span class="webname">
		 		<input type="text" name="goodsnumber" id="goodsnumber" value="${goods.goodsnumber?default('')}">
		 	</span></li>
		</ul>
		
		<ul class="set1">
			<li>详情</li>
		 	<li><span class="webname">
		 		<textarea name="details" id="details" cols="55" rows="5">${goods.details?default('')}</textarea>
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


	var arr ="";
	function deletephoto(obj){
		var ppp = $(obj).attr("pictureid");
		
			if(ppp=="firstPicture"){
				alert("主图无法删除！！！");
			}else{
				arr+=ppp+",";
				$(obj).attr("pictureid","");
				$("#deltePictureArr").val(arr);
				$(obj).parent().find($("img")).attr("src","/images/add.jpg");
				alert(arr);
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
function PreviewImage(fileObj,imgPreviewId){  
		
    var allowExtention=".jpg,.bmp,.gif,.png";//允许上传文件的后缀名 
    var extention=fileObj.value.substring(fileObj.value.lastIndexOf(".")+1).toLowerCase();              
    var browserVersion= window.navigator.userAgent.toUpperCase();  
    if(allowExtention.indexOf(extention)>-1){   
        if(fileObj.files){//HTML5实现预览，兼容chrome、火狐7+等  
            if(window.FileReader){  
                var reader = new FileReader();   
                reader.onload = function(e){  
                    document.getElementById(imgPreviewId).setAttribute("src",e.target.result);  
                }    
                reader.readAsDataURL(fileObj.files[0]);  
            }else if(browserVersion.indexOf("SAFARI")>-1){  
                alert("不支持Safari6.0以下浏览器的图片预览!");  
            }  
        }else if (browserVersion.indexOf("MSIE")>-1){  
            if(browserVersion.indexOf("MSIE 6")>-1){//ie6  
                document.getElementById(imgPreviewId).setAttribute("src",fileObj.value);  
            }else{//ie[7-9]  
                fileObj.select();  
                if(browserVersion.indexOf("MSIE 9")>-1)  
                    fileObj.blur();//不加上document.selection.createRange().text在ie9会拒绝访问  
                  
                newPreview.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale',src='" + document.selection.createRange().text + "')";                              
                  
                tempDivPreview.parentNode.insertBefore(newPreview,tempDivPreview);  
                tempDivPreview.style.display="none";                      
            }  
        }else if(browserVersion.indexOf("FIREFOX")>-1){//firefox  
            var firefoxVersion= parseFloat(browserVersion.toLowerCase().match(/firefox\/([\d.]+)/)[1]);  
            if(firefoxVersion<7){//firefox7以下版本  
                document.getElementById(imgPreviewId).setAttribute("src",fileObj.files[0].getAsDataURL());  
            }else{//firefox7.0+                      
                document.getElementById(imgPreviewId).setAttribute("src",window.URL.createObjectURL(fileObj.files[0]));  
            }  
        }else{  
            document.getElementById(imgPreviewId).setAttribute("src",fileObj.value);  
        }           
    }else{
        alert("仅支持"+allowExtention+"为后缀名的文件!");
        fileObj.value="";//清空选中文件
        if(browserVersion.indexOf("MSIE")>-1){
            fileObj.select();
            document.selection.clear();
        }
        fileObj.outerHTML=fileObj.outerHTML;
    }
   
    $("#file0").val("change");
    var oldid = $(fileObj).attr("pathsid");
    $(fileObj).attr("oldids",oldid);
    var pathsid = [];
    var arr = $("input[name^=oldfile]");
    $.each(arr,function(i,id){
    	if($(this).attr("oldids")!=""){
    		pathsid.push($(this).attr("oldids"));
    	}
    });
    $("input[name=oldimgids]").val(pathsid);
}

</script>
</html>