package com.asjy.commerplat.controller.backcontroller;

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

import com.asjy.commerplat.model.Ad;
import com.asjy.commerplat.service.Impl.IAdService;

@Controller
@RequestMapping("/ad")
public class backAdController {
	
	@Autowired
	IAdService adService;
	
	@RequestMapping("/showAd")
	public String showad(Model model) {
		List<Ad> list_ad = adService.findAll();
		model.addAttribute("list_ad", list_ad);
		return  "back/ad_list";
	}
	
	
	@ResponseBody
	@RequestMapping("/updatead_ajax")
	public Map<String, Object> updatead_ajax(Integer id, String fieldName, String value) {
		Ad bb = adService.findbyid(id);
		if(fieldName.equals("titlename")) {
			String titlename = value;
			bb.setTitlename(titlename);
		}
		if(fieldName.equals("seq")) {
			Integer seq = Integer.parseInt(value);
			bb.setSeq(seq);
		}
		if(fieldName.equals("display")) {
			
				if(bb.getDisplay()!=null && bb.getDisplay()==true) {
					bb.setDisplay(false);
				}else
				if(bb.getDisplay()==null || bb.getDisplay()==false){
					bb.setDisplay(true);
				}
				
				
		}
		int hh = adService.updateByPrimaryKeySelective(bb);
		System.out.println(hh);
		Map<String, Object> result = new HashMap<>();
		result.put("bb", bb);
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping("/goods_ad_del_ajax")
	public Map<String, Object> ajaxDeleteAd(Integer id) {
		int a = adService.deleteById(id);
		Map<String, Object> result = new HashMap<>();
		result.put("a", a);
		return result;
	}
	
	
	@RequestMapping("/addad")
	public String addad(Model model) {
		
		return  "back/ad_add";
	}
	
	
	
	@RequestMapping(value="/doaddad",method=RequestMethod.POST)
	public String doaddad(HttpServletRequest req, String titlename, String display, Integer seq, String url) throws Exception{
		/**
		 *此方法用来执行添加品牌的操作，重点是包含了“图片的上传”！！！
		 */
		//图片文件的上传
		//将请求变成多部分请求
	    MultipartHttpServletRequest mreq = (MultipartHttpServletRequest)req;
	    //通过文件名，返回一个文件，取名为file
	    MultipartFile file = mreq.getFile("adLogo");
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
		Ad b2 = new Ad();
		b2.setAddtime(addtime);
		b2.setTitlename(titlename);
		b2.setSeq(seq);
		b2.setPath("/asjy/file/"+ct+lastName);
		if(display.equals("true")) {
			b2.setDisplay(true);
		}else {
			b2.setDisplay(false);
		}
		adService.addAd(b2);
	     
	    return "redirect:/ad/showAd";
	}
	
	@RequestMapping("/updatead")
	public String adEdit(Model model, Integer id) {
		Ad ad = adService.findbyid(id);
		model.addAttribute("ad", ad);
		return "back/ad_update";
	}
	@RequestMapping(value="/back_goods_ad_doupdate",method=RequestMethod.POST)
	public String doAdEdit(Model model, Integer id, HttpServletRequest req, String titlename, String display, Integer seq, String url) throws IOException {
		
		Ad b2 = adService.findbyid(id);
		//将请求变成多部分请求
	    MultipartHttpServletRequest mreq = (MultipartHttpServletRequest)req;
	    //通过文件名，返回一个文件，取名为file
	    MultipartFile file = mreq.getFile("adLogo");
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
		b2.setTitlename(titlename);
		b2.setSeq(seq);
		
		if(display.equals("true")) {
			b2.setDisplay(true);
		}else {
			b2.setDisplay(false);
		}
		
		adService.updateByPrimaryKeySelective(b2);
	    
	    
		return "redirect:/ad/showAd";
	}
	
}
