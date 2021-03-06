package com.asjy.commerplat.controller.frontcontroller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.asjy.commerplat.model.Address;
import com.asjy.commerplat.model.Cart;
import com.asjy.commerplat.model.Goods;
import com.asjy.commerplat.model.GoodsImages;
import com.asjy.commerplat.model.GoodsSpec;
import com.asjy.commerplat.model.Spec;
import com.asjy.commerplat.model.Specv;
import com.asjy.commerplat.model.User;
import com.asjy.commerplat.service.GoodsService;
import com.asjy.commerplat.service.Impl.IAddressService;
import com.asjy.commerplat.service.Impl.ICartService;
import com.asjy.commerplat.service.Impl.IGoodsImagesService;
import com.asjy.commerplat.service.Impl.IGoodsService;
import com.asjy.commerplat.service.Impl.IGoodsSpecService;
import com.asjy.commerplat.service.Impl.ISpecService;
import com.github.pagehelper.StringUtil;

@Controller
@RequestMapping("/frontCart")
public class cartController {
	
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
	@Autowired
	IAddressService addressService;

	
	@RequestMapping("/goods_count_adjust")
	@ResponseBody
	public Map<String, Object> goods_count_adjust(Integer cart_id, Integer count,HttpSession session) {
		User sessionUser = (User)session.getAttribute("sessionUser");
		Map<String, Object> map1 = new HashMap<>();
		map1.put("cartid", cart_id);
		map1.put("count", count);
		map1.put("user", sessionUser);
		Map<String, Object> result = cartService.adjustCount(map1);
		return result;
	}
	
	
	@RequestMapping("/remove_goods_cart")
	@ResponseBody
	public Map<String, Object> remove_goods_cart(Integer id) {
		Map<String, Object> map = new HashMap<>();
		cartService.deleteById(id);
		return map;
	}
	
	/**
	 * 结算
	 */
	@RequestMapping("/orderPay")
	public String orderPay(Model model, @ModelAttribute("str")String str, HttpSession session) {
		User sessionUser = (User)session.getAttribute("sessionUser");
		String userid = sessionUser.getId().toString();
		
		//获得当前时间
		Date dd = new Date();
		//获得SimpleDateFormat类
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
		//修改时间成为指定格式，toString()是将时间格式转成字符串格式
		String date = sf.format(dd).toString();

		Random random = new Random();
		Integer randNumber1 =random.nextInt(10);
		Integer randNumber2 =random.nextInt(10);
		String ordernumber = date + userid + randNumber1 + randNumber2;
		model.addAttribute("ordernumber", ordernumber);
		if(userid == null) {
			return "redirect:front/frlogin";
		}
		if(!StringUtil.isEmpty(str)) {
			String[] arr_cartids = str.split(",");
			List<Cart> list_cart = cartService.findCartById(arr_cartids);
			model.addAttribute("list_cart", list_cart);
		}
		List<Address> list_address = addressService.findAddressByUserid(sessionUser.getId());
		model.addAttribute("list_address", list_address);
		Address address = addressService.findDefaultaddressByUserid(sessionUser.getId());
		model.addAttribute("address", address);
		model.addAttribute("str", str);
		return "front/order_confirm";
	}
	
	/**
	 * 商品详情-立即付款
	 */
	@RequestMapping("/rightNowPay")
	public String rightNowPay(Model model, Integer id, Integer count, HttpSession session) {
		User sessionUser = (User)session.getAttribute("sessionUser");
		String userid = sessionUser.getId().toString();
		
		//获得当前时间
		Date dd = new Date();
		//获得SimpleDateFormat类
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
		//修改时间成为指定格式，toString()是将时间格式转成字符串格式
		String date = sf.format(dd).toString();

		Random random = new Random();
		Integer randNumber1 =random.nextInt(10);
		Integer randNumber2 =random.nextInt(10);
		String ordernumber = date + userid + randNumber1 + randNumber2;
		model.addAttribute("ordernumber", ordernumber);
		if(userid == null) {
			return "redirect:front/frlogin";
		}
		List<Address> list_address = addressService.findAddressByUserid(sessionUser.getId());
		model.addAttribute("list_address", list_address);
		Address address = addressService.findDefaultaddressByUserid(sessionUser.getId());
		model.addAttribute("address", address);
		return "front/order_confirm";
	}
}
