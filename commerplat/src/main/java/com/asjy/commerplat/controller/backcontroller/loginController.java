package com.asjy.commerplat.controller.backcontroller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.table.TableStringConverter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.asjy.commerplat.model.User;
import com.asjy.commerplat.service.Impl.IUserService;
import com.asjy.commerplat.util.RandomValidateCode;




@Controller
@RequestMapping("/fronttoback")
public class loginController {
	
	
	@Autowired
	IUserService userservice;
	
	@RequestMapping("/login")
	public String login(HttpSession session) {
		User sessionUser = (User)session.getAttribute("sessionUser");
		if(sessionUser!=null && sessionUser.getAuthority()==true) {
			return "back/home";
		}else {
			return "back/login";
		}
	}
	
	
	@RequestMapping("/random")
	public void random(HttpServletRequest request, HttpServletResponse response){
		
		response.setContentType("image/jpeg");//设置相应类型,告诉浏览器输出的内容为图片
		response.setHeader("Pragma", "No-cache");//设置响应头信息，告诉浏览器不要缓存此内容
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expire", 0);
		RandomValidateCode randomValidateCode = new RandomValidateCode();
		try {
			randomValidateCode.getRandcode(request, response);//输出图片方法
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	

	@RequestMapping("/denglu")
	public String denglu(Model model, String username, String password ,HttpSession session, String randomcode) {
		String code = (String)session.getAttribute(RandomValidateCode.RANDOMCODEKEY);
		StringBuffer msg = new StringBuffer();
		if(username==null || username.equals("")) {
			msg.append("请输入账户名！");
			model.addAttribute("msg", msg);
			return "back/login";
		}
		
		if(password==null || password.equals("")) {
			msg.append("请输入密码！");
			model.addAttribute("msg", msg);
			return "back/login";
		}
		
		if(!code.equalsIgnoreCase(randomcode)) {
			msg.append("验证码输入的值错误，请重新输入！");
			model.addAttribute("msg", msg);
			return "back/login";
		}
		
		User finduser = userservice.findbyusernameandpassword(username, password);
		
		if(finduser==null) {
			msg.append("用户名或密码输入错误，请重新输入！");
			model.addAttribute("msg", msg);
			return "back/login";
		}
		session.setAttribute("sessionUser", finduser);
		return "back/home";
	}
	
	
	@RequestMapping("/tuichu")
	public String tuichu(HttpSession session) {
		session.removeAttribute("sessionUser");
			return "back/login";
		
	}
	
}
