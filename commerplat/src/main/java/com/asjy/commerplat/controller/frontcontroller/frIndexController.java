package com.asjy.commerplat.controller.frontcontroller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.asjy.commerplat.model.Ad;
import com.asjy.commerplat.model.Brand;
import com.asjy.commerplat.model.Classes;
import com.asjy.commerplat.model.Floor;
import com.asjy.commerplat.model.Goods;
import com.asjy.commerplat.model.User;
import com.asjy.commerplat.service.Impl.IAdService;
import com.asjy.commerplat.service.Impl.IBrandService;
import com.asjy.commerplat.service.Impl.IClassesService;
import com.asjy.commerplat.service.Impl.IFloorService;
import com.asjy.commerplat.service.Impl.IGoodsService;
import com.asjy.commerplat.service.Impl.IUserService;
import com.asjy.commerplat.util.RandomValidateCode;



@Controller
@RequestMapping("/front")
public class frIndexController {

	@Autowired
	IUserService userservice;
	@Autowired
	IGoodsService goodsService;
	@Autowired
	IFloorService floorService;
	@Autowired
	IClassesService classesService;
	@Autowired
	IAdService adService;
	@Autowired
	IBrandService brandService;
	@Autowired
	RandomValidateCode randomValidateCode;
	
	@RequestMapping("/index")
	public String index(Model model, HttpSession session, String s) {
		//点击退出，用户信息清除
		if("0".equals(s) && session.getAttribute("sessionUser") != null) {
			session.removeAttribute("sessionUser");
		}
		//查询推荐的商品
		List<Goods> list_recommendGoods = goodsService.findByRecommend(true);
		model.addAttribute("list_recommendGoods", list_recommendGoods);
		//查询新上架商品
		List<Goods> list_newGoods = goodsService.findByNewGoods();
		model.addAttribute("list_newGoods", list_newGoods);
		//查询销量多的商品
		List<Goods> list_inventoryGoods = goodsService.findByinventoryGoods();
		model.addAttribute("list_inventoryGoods", list_inventoryGoods);
		//查询推荐的品牌
		List<Brand> list_recommendBrand = brandService.findByRecommend(true);
		model.addAttribute("list_recommendBrand", list_recommendBrand);
		//查询楼层
		List<Floor> list_floor = floorService.FloorSelectByDisplay();
		model.addAttribute("list_floor", list_floor);
		//查询轮播图
		List<Ad> list_BigAd = adService.findRandomFiveAd();
		model.addAttribute("list_BigAd", list_BigAd);
		//分类显示
		List<Classes> list_classes = classesService.findToGrandSon();
		model.addAttribute("list_classes", list_classes);
		return "/front/frindex";		
	}		
				
	@RequestMapping("/random")
	public void random(HttpServletRequest request, HttpServletResponse response){
		response.setContentType("image/jpeg");//设置相应类型,告诉浏览器输出的内容为图片
		response.setHeader("Pragma", "No-cache");//设置响应头信息，告诉浏览器不要缓存此内容
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expire", 0);
		//验证码类的实例化过程交给spring框架了，在RandomValidateCode类上加了@Component注解，在框架中注册了一个bean
		//RandomValidateCode randomValidateCode = new RandomValidateCode();
		try {
			randomValidateCode.getRandcode(request, response);//输出图片方法
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/frzhuce")
	public String frzhuce(Model model) {
		return "front/frzhuce";
	}
	
	@RequestMapping("/frlogin")
	public String frlogin(Model model, Integer goodsid) {
		model.addAttribute("goodsid", goodsid);
		return "front/frlogin";
	}
	
	@RequestMapping("/frdologin")
	public String frdologin(Model model, String username, String password ,HttpSession session, String code, Integer goodsid, RedirectAttributes redirectAttributes) {
		String Truecode = (String)session.getAttribute(RandomValidateCode.RANDOMCODEKEY);
		if(!Truecode.equalsIgnoreCase(code)) {
			model.addAttribute("msg1","验证码错误！！！" );
			if(goodsid!=null) {
				model.addAttribute("goodsid",goodsid);
			}			
			return "front/frlogin";
		}
		User sessionUser = userservice.findbyusernameandpassword(username, password);
		if(sessionUser!=null && goodsid==null) {
			session.setAttribute("sessionUser", sessionUser);
			return "redirect:index";
		}else if(sessionUser!=null && goodsid!=null){
			session.setAttribute("sessionUser", sessionUser);
			redirectAttributes.addAttribute("id", goodsid);
			return "redirect:/frontGoods/goodsDetails";
		}
		else{
			model.addAttribute("msg","用户不存在或密码错误！！！" );
			if(goodsid!=null) {
				model.addAttribute("goodsid",goodsid);
			}	
			return "front/frlogin";
		}
	}
	
	@RequestMapping("/shoppingDologin")
	public String shoppingDologin(Model model, String username, String password ,HttpSession session, Integer detailsgoodsid) {
		User sessionUser = userservice.findbyusernameandpassword(username, password);
		session.setAttribute("sessionUser", sessionUser);
		return "redirect:/frontGoods/goodsDetails?id="+detailsgoodsid;
	}
	
	@RequestMapping("/frdozhuce")
	public String frdozhuce(Model model ,String username, String password, String phone, String email, String realname) {
		Boolean authority = false;
		String sex = "男";
		Date addtime = new Date();
		userservice.adduser(username, password, phone, email, realname, sex, authority, addtime);
		return "front/frlogin";
	}
	
}
