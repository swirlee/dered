package com.asjy.commerplat.controller.frontcontroller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.asjy.commerplat.model.Address;
import com.asjy.commerplat.model.Cart;
import com.asjy.commerplat.model.City;
import com.asjy.commerplat.model.User;
import com.asjy.commerplat.service.Impl.IAddressService;
import com.asjy.commerplat.service.Impl.ICartService;
import com.asjy.commerplat.service.Impl.ICityService;
import com.asjy.commerplat.service.Impl.IGoodsImagesService;
import com.asjy.commerplat.service.Impl.IGoodsService;
import com.asjy.commerplat.service.Impl.IGoodsSpecService;
import com.asjy.commerplat.service.Impl.ISpecService;
import com.github.pagehelper.StringUtil;

@Controller
@RequestMapping("/address")
public class addressController {

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
	ICityService cityService;
	@Autowired
	IAddressService addressService;
	
	@RequestMapping("/doadd_address")
	public String doadd_address(Model model, HttpSession session,String receiver, Integer city1, Integer city2, Integer city3, String detailaddress, String zipcode, String tel, String str,RedirectAttributes redirectAttributes) {
		Map<String, Object> map = new HashMap<>();
		User sessionUser = (User)session.getAttribute("sessionUser");
		Integer userid = sessionUser.getId();
		if(StringUtil.isEmpty(receiver)) {
			return "redirect:/order/address_add";
		}
		List<Address> list = addressService.findAddressByUserid(userid);
		
		if(list.size()>0) {
			Address address = new Address();
			address.setAddress(detailaddress);
			address.setAreaid(city3);
			address.setCityid(city2);
			address.setDefaultaddress(false);
			address.setProvinceid(city1);
			address.setReceiver(receiver);
			address.setTel(tel);
			address.setUserid(userid);
			address.setZipcode(zipcode);
			address.setAddtime(new Date());
			map.put("address", address);
			addressService.addAddress(address);
			return "redirect:/order/showaddress";
		}
		if(list.size()==0) {
			Address address = new Address();
			address.setAddress(detailaddress);
			address.setAreaid(city3);
			address.setCityid(city2);
			address.setDefaultaddress(true);
			address.setProvinceid(city1);
			address.setReceiver(receiver);
			address.setTel(tel);
			address.setUserid(userid);
			address.setZipcode(zipcode);
			address.setAddtime(new Date());
			addressService.addAddress(address);
			redirectAttributes.addAttribute("str", str);
			return "redirect:/frontCart/orderPay";
		}
		return null;
	}
	
	
	
	@RequestMapping("/deleteaddress")
	public String deleteaddress(Model model, Integer id) {
		addressService.deleteaddress(id);
		return "redirect:/order/showaddress";
	}
	
	@RequestMapping("/address_choose")
	public String address_choose(Model model, HttpSession session,Integer addressid,String str,String ordernumber) {
		User sessionUser = (User)session.getAttribute("sessionUser");
		Integer userid = sessionUser.getId();
		List<Address> list_address = addressService.findAddressByUserid(userid);
		model.addAttribute("list_address", list_address);
		model.addAttribute("addressid", addressid);
		model.addAttribute("str", str);
		model.addAttribute("ordernumber", ordernumber);
		return "front/chooseAddress";
	}
	
	@RequestMapping("/editaddress")
	public String editaddress(Model model, HttpSession session,Integer addressId) {
		List<City> list_city = cityService.findBypid(0);
		model.addAttribute("list_city", list_city);
		Address address = addressService.findAddressByid(addressId);
		model.addAttribute("address", address);
		List<City> list_city2 = cityService.findBypid(address.getProvinceid());
		List<City> list_city3 = cityService.findBypid(address.getCityid());
		model.addAttribute("list_city2", list_city2);
		model.addAttribute("list_city3", list_city3);
		return "front/editAddress";
	}
	
	@RequestMapping("/doedit_address")
	public String doedit_address(Model model, HttpSession session,String receiver, Integer city1, Integer city2, Integer city3, String detailaddress, String zipcode, String tel, Integer addressId) {
		Map<String, Object> map = new HashMap<>();
		User sessionUser = (User)session.getAttribute("sessionUser");
		Integer userid = sessionUser.getId();
		if(StringUtil.isEmpty(receiver)) {
			return "redirect:/order/address_add";
		}
		Address address = addressService.findAddressByid(addressId);
		address.setAddress(detailaddress);
		address.setAreaid(city3);
		address.setCityid(city2);
		address.setProvinceid(city1);
		address.setReceiver(receiver);
		address.setTel(tel);
		address.setUserid(userid);
		address.setZipcode(zipcode);
		map.put("address", address);
		addressService.updateAddress(address);
		return "redirect:/order/showaddress";
	}
	
	@RequestMapping("/defalutaddress")
	@ResponseBody
	public Map<String, Object> defalutaddress(Integer addressid, HttpSession session){
		User user = (User)session.getAttribute("sessionUser");
		addressService.updateDefaultAddressToZero(user.getId());
		addressService.updateDefaultAddress(addressid);
		return null;
	}
	@RequestMapping("/chooseaddress")
	public String chooseaddress(Model model, Integer addressId, String str,HttpSession session,String ordernumber) {
		Address address = addressService.findAddressByid(addressId);
		model.addAttribute("address", address);
		User user = (User)session.getAttribute("sessionUser");
		if(user == null) {
			return "redirect:front/frlogin";
		}
		if(!StringUtil.isEmpty(str)) {
			String[] arr_cartids = str.split(",");
			List<Cart> list_cart = cartService.findCartById(arr_cartids);
			model.addAttribute("list_cart", list_cart);
		}
		model.addAttribute("str", str);
		model.addAttribute("ordernumber", ordernumber);
		return "/front/order_confirm";
	}
	
	@RequestMapping("/ajax_update_defaultAddress")
	@ResponseBody
	public Boolean ajax_update_defaultAddress(Integer addressId,HttpSession session) {
		User user = (User)session.getAttribute("sessionUser");
		addressService.updateDefaultAddressToZero(user.getId());
		int a = addressService.updateDefaultAddress(addressId);
		if(a==0) {
			return false;
		}else {
			return true;
		}
	}
}
