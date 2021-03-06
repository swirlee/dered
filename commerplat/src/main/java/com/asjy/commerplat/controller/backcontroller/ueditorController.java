package com.asjy.commerplat.controller.backcontroller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.util.ClassUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.baidu.ueditor.ActionEnter;

@Controller
public class ueditorController {
	
	//@RequestMapping("/config")
    public void config0(HttpServletRequest request, HttpServletResponse response) throws IOException{
		response.setContentType("application/json");
		//rootPath就是配置文件(config.json)所在的目录
		String rootPath =ClassUtils.getDefaultClassLoader().getResource("").getPath()+"static/ueditor";
		//创建一个通用的多部分解析器  
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(); 
        if(multipartResolver.isMultipart(request)){  
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;//转换成多部分request
	        
            PrintWriter writer = response.getWriter();
	        writer.write(new ActionEnter( multiRequest, rootPath ).exec());
	        writer.flush();
	        writer.close();
	    }else {
	    	PrintWriter writer = response.getWriter();
	        writer.write(new ActionEnter( request, rootPath ).exec());
	        writer.flush();
	        writer.close();
	    }
    }
	
	
	 /**
	  * ueditor执行文件上传
	  * @param request
	  * @param response
	  */
	 @RequestMapping(value="/config")  
	    public void config(HttpServletRequest request, HttpServletResponse response) {
	        response.setContentType("application/json");
//	        String rootPath = request.getSession().getServletContext().getRealPath("/");  
	        try {
	            String exec = new ActionEnter(request, "D:/uploadFiles/").exec();  
	            PrintWriter writer = response.getWriter();  
	            writer.write(exec);
	            writer.flush();  
	            writer.close();  
	        } catch (IOException e) {  
	            e.printStackTrace();  
	        }  
	    }
}
