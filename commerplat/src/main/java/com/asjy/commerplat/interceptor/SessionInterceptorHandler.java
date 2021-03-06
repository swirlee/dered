package com.asjy.commerplat.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.asjy.commerplat.model.User;

@Component
public class SessionInterceptorHandler implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		User sessionUser = (User)session.getAttribute("sessionUser");
		if(sessionUser == null) {
			//response.sendRedirect("/front/frlogin");
			String url=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/front/frlogin";
			PrintWriter out = response.getWriter();
			out.println("<html>"); 
			out.println("<script>");
			out.println("window.open ('"+url+"','_parent')"); //作为父窗口打开
			out.println("</script>"); 
			out.println("</html>"); 
		    return false;
		}
		//return HandlerInterceptor.super.preHandle(request, response, handler);
		return true;
	}

	
}
