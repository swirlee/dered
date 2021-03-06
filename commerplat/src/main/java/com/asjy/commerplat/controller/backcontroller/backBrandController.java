package com.asjy.commerplat.controller.backcontroller;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.asjy.commerplat.model.Brand;
import com.asjy.commerplat.service.Impl.IBrandService;

@Controller
@RequestMapping("/brand")
public class backBrandController {
	
	@Autowired
	IBrandService brandService;
	
	@RequestMapping("/showbrand")
	public String showbrand(Model model) {
		List<Brand> list_brand = brandService.findAll();
		model.addAttribute("list_brand", list_brand);
		return  "back/brand_list";
	}
	
	
	@ResponseBody
	@RequestMapping("/updatebrand_ajax")
	public Map<String, Object> updatebrand_ajax(Integer id, String fieldName, String value) {
		Brand bb = brandService.findbyid(id);
		if(fieldName.equals("brandname")) {
			String brandname = value;
			bb.setBrandname(brandname);
		}
		if(fieldName.equals("seq")) {
			Integer seq = Integer.parseInt(value);
			bb.setSeq(seq);
		}
		if(fieldName.equals("recommend")) {
			
				if(bb.getRecommend()!=null && bb.getRecommend()==true) {
					bb.setRecommend(false);
				}else
				if(bb.getRecommend()==null || bb.getRecommend()==false){
					bb.setRecommend(true);
				}
				
				
		}
		int hh = brandService.updateByPrimaryKeySelective(bb);
		System.out.println(hh);
		Map<String, Object> result = new HashMap<>();
		result.put("bb", bb);
		System.out.println(bb);
		System.out.println(bb.getRecommend());
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping("/goods_brand_del_ajax")
	public Map<String, Object> ajaxDeleteBrand(Integer id) {
		int a = brandService.deleteById(id);
		Map<String, Object> result = new HashMap<>();
		result.put("a", a);
		return result;
	}
	
	
	@RequestMapping("/addbrand")
	public String addbrand(Model model) {
		
		return  "back/brand_add";
	}
	
	
	
	@RequestMapping(value="/doaddbrand",method=RequestMethod.POST)
	public String doaddbrand(HttpServletRequest req, String brandname, String recommend, Integer seq) throws Exception{
		/**
		 *此方法用来执行添加品牌的操作，重点是包含了“图片的上传”！！！
		 */
		//图片文件的上传
		//将请求变成多部分请求
	    MultipartHttpServletRequest mreq = (MultipartHttpServletRequest)req;
	    //通过文件名，返回一个文件，取名为file
	    MultipartFile file = mreq.getFile("brandLogo");
	    //获取该文件的上传前的名字
	    String fileName = file.getOriginalFilename();
	    //得到文件的扩展名(后缀，比如png,jpg)
	    String lastName = fileName.substring(fileName.lastIndexOf('.'));
	    //声明一个指定日期格式的变量currentTime，并为其赋值
	    SimpleDateFormat currentTime = new SimpleDateFormat("yyyyMMddHHmmss");
	    String ct = currentTime.format(new Date());
	    //将文件存在指定的虚拟路径下
	    FileOutputStream fos = new FileOutputStream("D:/uploadFiles/"+ct+lastName);
	    fos.write(file.getBytes());
	    fos.flush();//刷新缓冲区
	    fos.close();//关闭资源
	    
	    
	    Date addtime = new Date();
		System.out.println(addtime);
		Brand b2 = new Brand();
		b2.setAddtime(addtime);
		b2.setBrandname(brandname);
		b2.setSeq(seq);
		b2.setPath("/asjy/file/"+ct+lastName);
		if(recommend.equals("true")) {
			b2.setRecommend(true);
		}else {
			b2.setRecommend(false);
		}
		int i = brandService.addBrand(b2);
	     
	    return "redirect:/brand/showbrand";
	}
	
	@RequestMapping("/updatebrand")
	public String brandEdit(Model model, Integer id) {
		Brand brand = brandService.findbyid(id);
		model.addAttribute("brand", brand);
		return "back/brand_update";
	}
	@RequestMapping(value="/back_goods_brand_doupdate",method=RequestMethod.POST)
	public String doBrandEdit(Model model, Integer id, HttpServletRequest req, String brandname, String recommend, Integer seq) throws IOException {
		
		Brand b2 = brandService.findbyid(id);
		//将请求变成多部分请求
	    MultipartHttpServletRequest mreq = (MultipartHttpServletRequest)req;
	    //通过文件名，返回一个文件，取名为file
	    MultipartFile file = mreq.getFile("brandLogo");
	    //获取该文件的上传前的名字
	    String fileName = file.getOriginalFilename();
	    if(!fileName.equals("")) {
		    //得到文件的扩展名(后缀，比如png,jpg)
		    String lastName = fileName.substring(fileName.lastIndexOf('.'));
		    //声明一个指定日期格式的变量currentTime，并为其赋值
		    SimpleDateFormat currentTime = new SimpleDateFormat("yyyyMMddHHmmss");
		    String ct = currentTime.format(new Date());
		    //将文件存在指定的虚拟路径下
		    FileOutputStream fos = new FileOutputStream("D:/uploadFiles/"+ct+lastName);
		    fos.write(file.getBytes());
		    fos.flush();//刷新缓冲区
		    fos.close();//关闭资源
		    b2.setPath("/asjy/file/"+ct+lastName);
	    }
	    
		b2.setAddtime(new Date());
		b2.setBrandname(brandname);
		b2.setSeq(seq);
		
		if(recommend.equals("true")) {
			b2.setRecommend(true);
		}else {
			b2.setRecommend(false);
		}
		
		int i = brandService.updateByPrimaryKeySelective(b2);
	    
	    
		return "redirect:/brand/showbrand";
	}
	
}
