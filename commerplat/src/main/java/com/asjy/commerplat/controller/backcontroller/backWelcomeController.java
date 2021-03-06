package com.asjy.commerplat.controller.backcontroller;

import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.asjy.commerplat.service.Impl.IOrderService;

@Controller
@RequestMapping("/welcome")
public class backWelcomeController {
	
	@Autowired
	IOrderService orderService;
	
	@ResponseBody
	@RequestMapping("/showWelcome")
	public Map<String, Object> showWelcome() {
		Map<String, Object> result = orderService.getMonth();
		System.out.println(result);
		return result;
	}
	
	
}
