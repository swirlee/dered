package com.asjy.commerplat.controller.frontcontroller;

import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.asjy.commerplat.exception.SystemException;
import com.asjy.commerplat.model.Address;
import com.asjy.commerplat.model.Cart;
import com.asjy.commerplat.model.City;
import com.asjy.commerplat.model.Classes;
import com.asjy.commerplat.model.Detailorder;
import com.asjy.commerplat.model.Goods;
import com.asjy.commerplat.model.Order;
import com.asjy.commerplat.model.User;
import com.asjy.commerplat.service.OrderService;
import com.asjy.commerplat.service.Impl.IAddressService;
import com.asjy.commerplat.service.Impl.ICartService;
import com.asjy.commerplat.service.Impl.ICityService;
import com.asjy.commerplat.service.Impl.IDetailorderService;
import com.asjy.commerplat.service.Impl.IGoodsImagesService;
import com.asjy.commerplat.service.Impl.IGoodsService;
import com.asjy.commerplat.service.Impl.IGoodsSpecService;
import com.asjy.commerplat.service.Impl.IOrderService;
import com.asjy.commerplat.service.Impl.ISpecService;
import com.asjy.commerplat.service.Impl.IUserService;
import com.asjy.commerplat.util.ExcelUtil;
import com.mysql.jdbc.StringUtils;

@Controller
@RequestMapping("/order")
public class orderController {

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
	IUserService userService;
	@Autowired
	IAddressService addressService;
	@Autowired
	IOrderService orderService;
	@Autowired
	IDetailorderService detailOrderService;
	
	
	@RequestMapping("/address_add")
	public String address_add(Model model, HttpSession session,String str) {
		User sessionUser = (User)session.getAttribute("sessionUser");
		Integer userid = sessionUser.getId();
		List<City> list_city = cityService.findBypid(0);
		model.addAttribute("list_city", list_city);
		model.addAttribute("str", str);
		return "front/addAddress";
	}
	
	@RequestMapping("/ajax_city_select")
	@ResponseBody
	public Map<String, Object> ajax_city_select(String pid) {
		Map<String, Object> result = new HashMap<>();
		List<City> list_city = cityService.findBypid(Integer.parseInt(pid));
		result.put("list_city", list_city);
		return result;
	}
	
	/**
	 * ?????????????????????
	 * @return
	 */
	@RequestMapping("/showaddress")
	public String showaddress(Model model, HttpSession session) {
		User sessionUser = (User)session.getAttribute("sessionUser");
		Integer userid = sessionUser.getId();
		User user = userService.findbyid(userid);
		model.addAttribute("user",user);
		List<Address> list_address = addressService.findAddressByUserid(userid);
		model.addAttribute("list_address", list_address);
		return "front/address_show";
	}
	/**
	 * ????????????
	 * @return
	 */
	@RequestMapping("/submit_order")
	@Transactional
	public String submit_order(Model model, HttpSession session, Long totalprice, String cityaddress, String detailaddress, String receiver, String tel, String zipcode,String ordernumber,String str) {
		Order order1 = orderService.findByOrdernumber(ordernumber);
		//???????????????????????????
		if(order1 == null) {
			User sessionUser = (User)session.getAttribute("sessionUser");
			
			//?????????????????????Long??????Bigdecimal
			BigDecimal totalPrice = new BigDecimal(totalprice);
			
			String orderstate = "?????????";
			Order order = new Order();
			order.setAddtime(new Date());
			order.setUserid(sessionUser.getId());
			order.setOrdernumber(ordernumber);
			order.setCityaddress(cityaddress);
			order.setDetailaddress(detailaddress);
			order.setReceiver(receiver);
			order.setTel(tel);
			order.setZipcode(zipcode);
			order.setOrderstate(orderstate);
			order.setTotalprice(totalPrice);
			orderService.addOrer(order);
			model.addAttribute("orderid",order.getId());
			
			//???????????? ??????
			String[] cartids = str.split(",");
			List<Cart> list_cart = cartService.findCartById(cartids);
			for (Cart cart : list_cart) {
				Detailorder detailorder = new Detailorder();
				detailorder.setGoodsid(cart.getGoodsid());
				detailorder.setCount(cart.getCount());
				detailorder.setOrderid(order.getId());
				detailorder.setPrice(new BigDecimal(cart.getGoods().getSellprice()));
				detailorder.setSubtotal(new BigDecimal(cart.getGoods().getSellprice()).multiply(new BigDecimal(cart.getCount())));
				detailOrderService.add(detailorder);
				//???????????????
				cartService.deleteById(cart.getId());
				//?????????
				if(cart.getGoods().getInventory()-cart.getCount()<0) {
					throw new SystemException("????????????????????????????????????????????????????????????????????????????????????????????????????????????");
				}else {
					Goods goodss = goodsService.findById(cart.getGoodsid());
					goodss.setInventory(cart.getGoods().getInventory()-cart.getCount());
					goodsService.updateByPrimaryKeySelective(goodss);
				}
			}
			
		}else {
			model.addAttribute("orderid",order1.getId());
		}
		model.addAttribute("totalprice", totalprice);
		model.addAttribute("ordernumber", ordernumber);
		return "front/order_pay";
	}
	
	/**
	 * ????????????????????????
	 * @param model
	 * @param session
	 * @param ordernumber
	 * @param begintime
	 * @param endtime
	 * @param orderstate
	 * @return
	 */
	@RequestMapping("/myorder")
	public String myorder(Model model, HttpSession session, @ModelAttribute("ordernumber")String ordernumber, String begintime, String endtime, String orderstate) {
		User sessionUser = (User)session.getAttribute("sessionUser");
		List<Order> list_order = orderService.findByUserid(sessionUser.getId(), ordernumber, begintime, endtime, orderstate);
		model.addAttribute("list_order", list_order);
		model.addAttribute("user", sessionUser);
		model.addAttribute("ordernumber", ordernumber);
		model.addAttribute("begintime", begintime);
		model.addAttribute("endtime", endtime);
		model.addAttribute("orderstate", orderstate);
		return "/front/myorder";
	}
	
	/**
	 * ??????????????????????????????
	 * @param model
	 * @return
	 */
	@RequestMapping("/cancel_order")
	public String cancel_order(Model model, Integer id, String ordernumber) {
		model.addAttribute("id", id);
		model.addAttribute("ordernumber", ordernumber);
		return "/front/cancel_order";
	}
	
	/**
	 * ??????????????????????????????
	 * @param model
	 * @param id
	 * @param ordernumber
	 * @return
	 */
	@RequestMapping("/order_cancel_save")
	public String order_cancel_save(RedirectAttributes  redirectattr, Integer orderid, String ordernumber,String orderstate) {
		redirectattr.addFlashAttribute("ordernumber", ordernumber);
		orderService.updateOrderState_delete(orderid,orderstate);
		return "redirect:/order/myorder";
	}
	
	/**
	 * ????????????????????????
	 * @param id
	 * @return
	 */
	@RequestMapping("/deleteNoPayOrder")
	public String deleteNoPayOrder(Integer id) {
		detailOrderService.findByOrderid(id);
		orderService.deleteOrderById(id);
		return "redirect:/order/myorder";
	}
	
	/**
	 * ???????????????????????????
	 * @param id
	 * @return
	 */
	@RequestMapping("/deletePayOrder")
	public String deletePayOrder(Integer id) {
		detailOrderService.findByOrderid(id);
		orderService.deleteHavePayOrderById(id);
		return "redirect:/order/myorder";
	}
	
	
	/**
	 * ????????????????????????
	*/
	@RequestMapping("/receiveGoods")
	public String receiveGoods(Integer id) {
		String orderstate = "?????????";
		orderService.updateOrderState(id, orderstate);
		return "redirect:/order/myorder";
	}
	
	/**
	 * ???????????????????????????????????????
	*/
	@RequestMapping("/order_pay_view")
	public String order_pay_view(Integer id) {
		String orderstate = "?????????";
		orderService.updateOrderState(id, orderstate);
		return "redirect:/order/myorder";
	}
	
	
	/**
	 * ??????????????????????????????
	*/
	@RequestMapping("/front_order_pay")
	@ResponseBody
	public Map<String, Object> front_order_pay(Integer orderid) {
		Map<String, Object> map = new HashMap<>();
		String orderstate = "?????????";
		orderService.updateOrderState(orderid, orderstate);
		String STATUS = "SUCCESS";
		map.put("STATUS", STATUS);
		return map;
	}
	
	
	/**
	 * ??????????????????????????????
	 * @param model
	 * @return
	 */
	@RequestMapping("/order_list")
	public String order_list(Model model,String ordernumber, String begintime, String endtime, String orderstate) {
		if(StringUtils.isNullOrEmpty(ordernumber) &&StringUtils.isNullOrEmpty(begintime)&&StringUtils.isNullOrEmpty(endtime)&&StringUtils.isNullOrEmpty(orderstate)) {
			List<Order> list_order = orderService.findAll();
			model.addAttribute("list_order", list_order);
		}else {
			List<Order> list_order = orderService.findByconditions_back(ordernumber,begintime,endtime,orderstate);
			model.addAttribute("list_order", list_order);
		}
		model.addAttribute("ordernumber", ordernumber);
		model.addAttribute("begintime", begintime);
		model.addAttribute("endtime", endtime);
		model.addAttribute("orderstate", orderstate);
		return "back/order_list";
	}
	
	
	/**
	 * ??????-????????????-??????
	 */
	@RequestMapping("/backorderdelete")
	@ResponseBody
	public Boolean backorderdelete(@RequestParam Map<String,Object> map){
		Boolean msg = orderService.deleteOrderById_back(map);
		return msg;
	}
	
	
	
	/**
	 * ??????-????????????-????????????
	 */
	@RequestMapping("/sendGoods")
	@ResponseBody
	public Boolean sendGoods(@RequestParam Map<String,Object> map){
		Boolean msg = orderService.sendGoods(map);
		return msg;
	}
	
	
	/**
	 * ??????-????????????-??????????????????
	 * @param model
	 * @return
	 */
	@RequestMapping("/order_view")
	public String order_view(Model model, Integer orderid) {
		Order order = orderService.findByOrderid(orderid);
		model.addAttribute("order", order);
		return "back/order_detail";
	}
	
	
	/**
	 * ??????-????????????-Excel?????????
	 * @param model
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("/downloadExcel")
	public void downloadExcel(HttpServletResponse resp,String ordernumber, String begintime, String endtime, String orderstate) throws IOException {
		List<Order> list_order = orderService.findByconditions_back(ordernumber,begintime,endtime,orderstate);
		
		//??????ExcelUtil???????????????????????????excel??????
		XSSFWorkbook wb = ExcelUtil.exportExcelForOrder(list_order);
		//???????????????
		String filename = "?????????.xlsx";
		//????????????????????????Excel????????????
		resp.setContentType("application/vnd.ms-excel"); 
		
		resp.setCharacterEncoding("UTF-8");
		//resp.setHeader("Content-disposition", "attachment;filename=" + filename); 
		resp.setHeader("Content-disposition", "attachment;filename=" + new String(filename.getBytes("UTF-8"),"ISO8859-1"));
		
		
		OutputStream ouputStream = resp.getOutputStream();  
		wb.write(ouputStream);
		ouputStream.flush();    
		ouputStream.close();    
		
	}

}
