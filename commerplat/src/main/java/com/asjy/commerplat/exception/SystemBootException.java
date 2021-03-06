package com.asjy.commerplat.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

/**
 *@author lee
 *处理异常类
 */

@ControllerAdvice
//功能类似于@controller 不用再在studentcontroller中写方法了
public class SystemBootException {
	
	/**	返回到页面上的是json类型的数据，前端有ajax技术时使用如下注释代码！！！
	*/
	//	@ExceptionHandler(SystemException.class)
	//	public ResponseEntity<Map<String, Object>> exceptionHandlerJson(SystemException systemException, Model model, WebRequest req){
	//		Map<String, Object> result = new HashMap<String, Object>();
	//		result.put("status", "fail");
	//		result.put("message", systemException.getMessage());
	//	    return ResponseEntity.ok(result);
	//	}
	
	/**	返回一个页面，提示用户页面丢失、系统崩溃、信息提交错误等等！！！
	*/
	@ExceptionHandler(SystemException.class)
	public String exceptionHandlerJson(SystemException systemException, Model model, WebRequest req){
		model.addAttribute("status", "fail");
		model.addAttribute("message", systemException.getMessage());
		return "front/error1";
	}
	
}
