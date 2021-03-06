package com.asjy.commerplat.controller.frontcontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.asjy.commerplat.model.Goods;
import com.asjy.commerplat.model.GoodsImages;
import com.asjy.commerplat.model.GoodsSpec;
import com.asjy.commerplat.model.Spec;
import com.asjy.commerplat.model.Specv;
import com.asjy.commerplat.model.User;
import com.asjy.commerplat.service.GoodsService;
import com.asjy.commerplat.service.Impl.ICartService;
import com.asjy.commerplat.service.Impl.IGoodsImagesService;
import com.asjy.commerplat.service.Impl.IGoodsService;
import com.asjy.commerplat.service.Impl.IGoodsSpecService;
import com.asjy.commerplat.service.Impl.ISpecService;

@Controller
@RequestMapping("/frontGoods")
public class goodsdetailcontroller {
	
	@Autowired
	IGoodsService goodsService;
	@Autowired
	IGoodsImagesService goodsImagesService;
	@Autowired
	ISpecService specService;
	@Autowired
	IGoodsSpecService goodsSpecService;
	@Autowired
	ICartService cartService;
	
	@RequestMapping("/goodsDetails")
	public String goodsDetails(Model model, @ModelAttribute("id")Integer id, HttpSession session) {
		Goods goods = goodsService.findById(id);
		List<GoodsImages> list_goodsImages = goodsImagesService.findByGoodsId(id);
		model.addAttribute("goods", goods);
		model.addAttribute("list_goodsImages", list_goodsImages);
		
		List<Spec> list_spec = specService.findByGoodsNumber(goods.getGoodsnumber());
		model.addAttribute("list_spec", list_spec);
		
		List<Spec> list_goods_spec = specService.findByGoodsId(goods.getId());
		System.out.println("goods的id为："+goods.getId());
		model.addAttribute("list_goods_spec", list_goods_spec);
		User sessionUser = (User)session.getAttribute("sessionUser");
		if(sessionUser!=null) {
			Integer userid = sessionUser.getId();
			model.addAttribute("userid", userid);
		}else {
			model.addAttribute("userid", null);
		}
		return "front/goodsdetails";
	}
	
	
	@RequestMapping("/ajax_goodsupdate")
	@ResponseBody
	public Map<String, Object> ajax_goodsupdate(String goodsnumber, String specvids) {
		
		Map<String, Object> result = goodsSpecService.findByGoodsnumberAndSpecvid(goodsnumber,specvids);
		return result;
		
	}
	
	
	@RequestMapping("/add_goods_cart")
	@ResponseBody
	public Map<String, Object> add_goods_cart(HttpSession session, Integer goodsid, Integer count, String specvids,Long price) {
		Map<String, Object> map = new HashMap<>();
		User sessionUser = (User)session.getAttribute("sessionUser");
		String a = "true";
		if(sessionUser == null) {
			a = "false";
			map.put("a", a);
			return map;
		}
		map.put("goodsid", goodsid);
		map.put("count", count);
		map.put("specvids", specvids);
		map.put("price", price);
		map.put("userid", (Integer)sessionUser.getId());
		Map<String, Object> result = cartService.addInCart(map);
		result.put("a", a);
		return result;
		
	}
	
	
	@RequestMapping("/look_goods_cart")
	@ResponseBody
	public Map<String, Object> look_goods_cart(HttpSession session) {
		User sessionUser = (User)session.getAttribute("sessionUser");
		if(sessionUser != null) {
			Map<String, Object> result = cartService.findCartByUserid((Integer)sessionUser.getId());
			return result;
		}else {
			return null;
		}
	}
	
	@RequestMapping("/mycart")
	public String mycart(HttpSession session,Model model) {
		User sessionUser = (User)session.getAttribute("sessionUser");
		if(sessionUser != null) {
			Map<String, Object> cartMap = cartService.findCartByUserid((Integer)sessionUser.getId());
			model.addAttribute("cartMap", cartMap);
		}
		return "front/mycart";
	}
	
	@RequestMapping("/detailUserLogin")
	public String detailUserLogin(Integer goodsid, Model model) {
		model.addAttribute("goodsid", goodsid);
		return "front/detail_login";
	}
	
}
