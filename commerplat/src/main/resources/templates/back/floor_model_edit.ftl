<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="/css/template.css" rel="stylesheet" type="text/css">
<link href="/css/overlay.css" rel="stylesheet" type="text/css">
<script src="/js/jquery-1.6.2.js"></script>
<script src="/js/jquery-ui-1.8.21.js"></script>
<script src="/js/jquery.validate.min.js"></script>
<script src="/js/jquery.shop.common.js"></script>
<script>
	$(document).ready(function() {
		$(".floorul li").attr("cursor", "pointer").click(function() {
			var gc_id = $(this).attr("gc_id");
			$(".floorul li").removeClass("this");
			$(this).addClass("this");
			$(".ftab").hide();
			$("#gc_" + gc_id).show();
		});
	});
</script>
</head>

<body>
	<div class="cont">
		<h1 class="seth1">首页楼层</h1>
		<div class="settab">
			<span class="tab-one"></span>
			<span class="tabs">
				<a href="/floor/goods_floor_list">管理</a>|<a href="/floor/floor_add">新增</a>|<a class="this" href="">楼层模板</a>
			</span>
			<span class="tab-two"></span>
		</div>
		<div class="floor_editor">
			<!--楼层样式0-->
			<div class="floor_m">经典楼层</div>
			<div class="floor_rel">
				<div class="floor">
					<div class="floor_box">
						<div class="floor_menu">
							<h3>${floor.floorname}
								<a  class="edfloor" href="javascript:void(0);"
									dialog_id="goods_floor_cat" dialog_top="100"
									dialog_height="100" dialog_width="700" dialog_title="编辑分类"
									dialog_uri="/floor/floor_classes_edit?id=${floor.id}">编辑+</a>
							</h3>
							<div class="flr_m_details">
								<ul class="flr_m_du">
									<#if floor.list_classes??>
									<#list floor.list_classes as class1>
									<li>
										<#if class1.pid == 0>
										<h4>
											<a href="/find/findByClassId?id=${class1.id}" target="_blank">${class1.classname}</a>
										</h4>
										</#if>
										<p>
											<#if floor.list_classes??>
											<#list floor.list_classes as class2>
											<#if class2.pid == class1.id>
											<span>
												<a href="/find/findByClassId?id=${class2.id}"target="_blank">${class2.classname}</a>
											</span>
											</#if>
											</#list>
											</#if>
										</p>
									</li>
									</#list>
									</#if>
								</ul>
								
								
							</div>
						</div>
						
						<div class="floorclass">
							<ul class="floorul">
								<#if floor.list_floor??>
								<#list floor.list_floor as floor1>
								<#if floor1_index != 0>
								<li style="cursor: pointer;" gc_id="${floor1.id}">${floor1.floorname}
								<#else>
								<li class="this" style="cursor: pointer;" gc_id="${floor1.id}">${floor1.floorname}
								</#if>
								<a class="edfloor" href="javascript:void(0);"
									dialog_id="goods_floor_cat" dialog_top="80" dialog_height="100"
									dialog_width="750" dialog_title="编辑【${floor1.floorname}】楼层商品"
									dialog_uri="/floor/floor_floor_edit?id=${floor1.id}">编辑+</a>
								</li>
								</#list>
								</#if>
							</ul>
							
							<#if floor.list_floor??>
							<#list floor.list_floor as floor1>
							<div class="ftab" id="gc_${floor1.id}">
								<div class="ftabone">
									<div class="classpro">
										<#if floor1.list_goods??>
										<#list floor1.list_goods as goods>
										<div class="productone">
											<ul>
												<li><span class="center_span"><p>
													<a href="/frontGoods/goodsDetails?id=${goods.id}" target="_blank">
														<img width="147" height="147" src="${goods.path}">
													</a>
												</p></span></li>
												<li class="pronames">
													<a href="/frontGoods/goodsDetails?id=${goods.id}" target="_blank">${goods.goodsname}</a>
												</li>
												<li>
													<span class="hui2">市场价：</span>
													<span class="through hui">￥${goods.originalprice?c}</span>
												</li>
												<li>
													<span class="hui2">商城价：</span>
													<strong class="red">￥${goods.sellprice?c}</strong>
												</li>
											</ul>
										</div>
										</#list>
										</#if>
									</div>
								</div>
							</div>
							</#list>
							</#if>
						</div>
						
						
						<div class="ranking">
							<h1>商品排行
								<a  class="edfloor" href="javascript:void(0);"
									dialog_id="goods_floor_cat" 
									dialog_top="100"
									dialog_height="100" 
									dialog_width="750" 
									dialog_title="编辑列表信息"
									dialog_uri="/floor/floor_goods_edit?id=${floor.id}">编辑+</a>
							</h1>
							
							<#if floor.list_goods??>
							<#list floor.list_goods as goods>
							<ul class="rankul">
								<li class="rankimg">
									<a href="/frontGoods/goodsDetails?id=${goods.id}" target="_blank">
										<img width="73" height="55" src="${goods.path}">
									</a>
									<span class="rankno2"></span>
								</li>
								<li class="rankhui">
									<strong>
										<a href="/frontGoods/goodsDetails?id=${goods.id}" target="_blank">${goods.goodsname}</a>
									</strong>
								</li>
								<li class="rankmoney">￥${goods.sellprice?c}</li>
							</ul>
							</#list>
							</#if>
							
						</div>
						
					</div>
				
					
				</div>
			</div>
		</div>
	</div>
</body>
</html>
