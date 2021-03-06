 <script>
$(document).ready(function(){
	  $(".toph_bgsear li").mouseover(function(){
		  
	      $(".toph_bgsear>li").show();
	  }).mouseleave(function(){
	       $(".toph_bgsear>li").last().hide();
	  }).click(function(){
		 
		 var index=$(this).index();
		 if(index==1){
		   var f_text=$(".toph_bgsear li").find("a").first().text();
		   var f_type= $(".toph_bgsear li").first().attr("type");
	       $(".toph_bgsear li").find("a").first().html($(this).find("a").text()+"<s></s>");
		   $(".toph_bgsear li").find("a").last().text(f_text);
		   $("#type").val($(this).attr("type"));
		   $(".toph_bgsear li").first().attr("type",$(this).attr("type"));
		   $(".toph_bgsear li").last().attr("type",f_type);
		   $(".toph_bgsear>li").last().hide();
		 }
	  });

	  $(".two_code_a").click(function(){
		  $(this).parent().remove();
		  });
		
	});
	
</script>





<div id="header_form">
  
  <div id="head_h" class="head_width">
	  <div class="head clearFix">
	    <div class="logo"> 
	     <a href="/front/index">
	     	<img src="/images/ff2232cb-7a55-47b2-b0b4-cd90793e5ea1.jpg" border="0">
	     </a>
	    </div>
	    
		<div class="searchForm">
			<form action="/search/dotopsearch" method="post" target="_blank" id="searchForm">
				<input name="type" type="hidden" id="type" value="goods">
				<div class="toph_bigsearch">
					<div class="toph_sear">
						<ul class="toph_bgsear">
							<li class="this" type="goods"><a href="javascript:void(0);">宝贝</a></li>
							<li style="display:none" type="store"><a href="javascript:void(0);">店铺</a></li>
						</ul>
						<input name="goodsname" type="text" id="keyword" placeholder="搜索其实真的很简单！" x-webkit-speech="" lang="zh-CN" onwebkitspeechchange="$('#searchForm').submit()" class="toph_sear_txt">
						<input name="input" type="submit" value="搜索" style="cursor:pointer;" class="toph_sear_btn">
					</div>
					     
					<div class="keyword">
						<a href="javascript:void(0);">Burton2019款单板雪鞋</a>
						<a href="javascript:void(0);">Flow保暖手套</a>
						<a href="javascript:void(0);">Ping&up新款滑雪服</a>  
					</div>
				</div>
			</form>
		</div>

	  </div>
  </div>
</div>

