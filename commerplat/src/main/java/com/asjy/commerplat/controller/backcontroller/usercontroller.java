package com.asjy.commerplat.controller.backcontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.asjy.commerplat.model.User;
import com.asjy.commerplat.service.UserService;

@Controller
@RequestMapping("/user")
public class usercontroller {
	
	@Autowired 
	UserService userservice;
	
	
	@RequestMapping("/userManage")
	public String userManage(Model model) {
		List<User> list_user = userservice.findAll();
		model.addAttribute("list_user", list_user);
		return"back/user_list";
	}
	
	@RequestMapping("/showuser")
	public String showuser(Model model, Integer id) {
		User uu = userservice.findbyid(id);
		model.addAttribute("uu", uu);
		return"back/user_show";
	}
	
}
