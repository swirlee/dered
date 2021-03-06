package com.asjy.commerplat.controller.backcontroller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/back")
public class backindexcontroller {
	
	
	@RequestMapping("/home")
	public String home() {
		
		return"back/home";
	}
	
	@RequestMapping("/welcome")
	public String welcome() {
		
		return"back/welcome";
	}
}
