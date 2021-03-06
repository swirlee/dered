package com.asjy.commerplat.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class SessionInterceptorConfig implements WebMvcConfigurer{

	@Autowired
	SessionInterceptorHandler sessionInterceptorHandler;

//	@Override
//	public void addInterceptors(InterceptorRegistry registry) {
//		registry.addInterceptor(sessionInterceptorHandler)
//				.addPathPatterns("/order/**","/person/**")
//				.excludePathPatterns("/address_add","/ajax_city_select","/showaddress");
//	}


	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(sessionInterceptorHandler)
				.addPathPatterns()
				.excludePathPatterns();
	}
}
