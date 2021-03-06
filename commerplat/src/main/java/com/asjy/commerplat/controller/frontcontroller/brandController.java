package com.asjy.commerplat.controller.frontcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asjy.commerplat.model.Brand;
import com.asjy.commerplat.service.Impl.IBrandService;

@Controller
@RequestMapping("/brand")
public class brandController {
	
	@Autowired
	IBrandService brandService;
	
	@RequestMapping("/showBrand")
	public String showBrand(Model model) {
		//查询推荐的品牌
		List<Brand> list_recommendBrand = brandService.findByAllRecommend(true);
		model.addAttribute("list_recommendBrand", list_recommendBrand);
		
		//查询所有品牌
		List<Brand> list_Brand = brandService.findAll();
		model.addAttribute("list_Brand", list_Brand);
		
		return "/front/frbrand";
	}
}
