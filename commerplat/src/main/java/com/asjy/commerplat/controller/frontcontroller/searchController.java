package com.asjy.commerplat.controller.frontcontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asjy.commerplat.model.Goods;
import com.asjy.commerplat.service.Impl.IGoodsService;

@Controller
@RequestMapping("/search")
public class searchController {

	@Autowired
	IGoodsService goodsService;
	
	
	@RequestMapping("/dotopsearch")
	public String dotopsearch(Model model, Integer classesid, String goodsname, Integer currentPage, String orderBy, String orderType, 
								Integer area_id, Integer gs_ids ,Integer brand_ids, String properties, String keyword, 
								String all_property_status,String detail_property_status,String store_price_begin,String store_price_end) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("classesid",classesid);
		map.put("goodsname",goodsname);
		map.put("currentPage",currentPage);
		map.put("orderBy",orderBy);
		map.put("orderType",orderType);
		map.put("area_id",area_id);
		map.put("gs_ids",gs_ids);
		map.put("brand_ids",brand_ids);
		map.put("properties",properties);
		map.put("keyword",keyword);
		map.put("all_property_status",all_property_status);
		map.put("detail_property_status",detail_property_status);
		map.put("store_price_begin",store_price_begin);
		map.put("store_price_end",store_price_end);
		
		
		Map<String, Object> result = goodsService.findByConditions(map);
		List<Goods> list_goods = (List<Goods>)result.get("list_goods");
		Integer PageNum = (Integer)result.get("PageNum");
		Integer totalPage = (Integer)result.get("totalPage");
		
		model.addAttribute("list_goods",list_goods);
		model.addAttribute("PageNum",PageNum);
		model.addAttribute("totalPage",totalPage);
		model.addAttribute("classesid",classesid);
		model.addAttribute("orderBy",orderBy);
		model.addAttribute("orderType",orderType);
		model.addAttribute("goodsname",goodsname);
		model.addAttribute("store_price_begin",store_price_begin);
		model.addAttribute("store_price_end",store_price_end);
		return "/front/frsearch";
	}
	
}
