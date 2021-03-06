package com.asjy.commerplat.controller.frontcontroller;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.asjy.commerplat.model.User;
import com.asjy.commerplat.service.Impl.IUserService;



@Controller
@RequestMapping("/frzhuce")
public class frZhuceController {
	
	@Autowired
	IUserService userService;
	
	
	@RequestMapping("/validate")
	@ResponseBody
	public Boolean validate(String validate,String ziduan){
		Boolean boo = userService.findByValidate(validate, ziduan);
		return boo;
	}
	
	
	@RequestMapping("/dozhuce")
	public String dozhuce(String username, String password, String mobile, String email){
		User user = new User();
		user.setAddtime(new Date());
		user.setAuthority(false);
		user.setEmail(email);
		user.setPassword(password);
		user.setPhone(mobile);
		user.setUsername(username);
		userService.addNewUser(user);
		return "redirect:/front/frlogin";
	}
	
}
