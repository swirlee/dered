package com.asjy.commerplat.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.filter.OncePerRequestFilter;

//@WebFilter//如需使用过滤器，需要在app.java中加入@ServletComponentScan注解
public class ueditorFilter extends OncePerRequestFilter{

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		String url = httpRequest.getRequestURI();
		String aString = httpRequest.getContextPath()+"/config";
		if (url.contains(aString)) {
			filterChain.doFilter(request, response);
		}else{
			super.doFilter(request, response, filterChain);
		}
	}



}
