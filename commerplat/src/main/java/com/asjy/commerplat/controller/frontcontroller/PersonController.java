package com.asjy.commerplat.controller.frontcontroller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.aliyun.oss.OSSClient;
import com.asjy.commerplat.model.City;
import com.asjy.commerplat.model.User;
import com.asjy.commerplat.oss.OSSConfig;
import com.asjy.commerplat.oss.OSSUtil;
import com.asjy.commerplat.service.Impl.ICityService;
import com.asjy.commerplat.service.Impl.IUserService;



@Controller
@RequestMapping("/person")
public class PersonController {
	
	@Autowired
	IUserService userService;
	@Autowired
	ICityService cityService;
	
	@RequestMapping("/enterPersonCenter")
	public String validate(HttpSession session, Model model){
		User sessionUser = (User)session.getAttribute("sessionUser");
		Integer userid = sessionUser.getId();
		User user = userService.findbyid(userid);
		model.addAttribute("user",user);
		List<City> list_city = cityService.findBypid(0);
		model.addAttribute("list_city",list_city);
		return"/front/admin_detail";
	}
	
	@RequestMapping("/ajax_update_password")
	@ResponseBody
	public Boolean ajax_update_password(@RequestParam Map<String,Object> map, HttpSession session){
		return userService.updatePassword(map,session);
	}
	
	@RequestMapping("/validate")
	@ResponseBody
	public Boolean validate(String validate,String ziduan, HttpSession session){
		Boolean boo = userService.findByUserAndValidate(validate, ziduan, session);
		return boo;
	}
	
	
	@RequestMapping("/ajax_update_email")
	@ResponseBody
	public Boolean ajax_update_email(@RequestParam Map<String,Object> map, HttpSession session){
		
		return userService.updateemail(map,session);
	}
	
	/**
	 * ????????????????????????
	 * @param map
	 * @param session
	 * @return
	 */
	@RequestMapping("/ajax_update_detail")
	@ResponseBody
	public Boolean ajax_update_detail(@RequestParam Map<String,Object> map, HttpSession session){
		
		return userService.updatedetail(map,session);
	}
	
	
	/**
	 *ajax??????????????????
	 * @throws IOException 
	 */
	@RequestMapping("/ajax_upload_userImg")
	@ResponseBody
	public Map<String, Object> ajax_upload_userImg(HttpServletRequest req, MultipartFile imgFile) throws IOException{
		User sessionUser = (User)req.getSession().getAttribute("sessionUser");
		Integer userid = sessionUser.getId();
		User user = userService.findbyid(userid);
		Map<String, Object> map = new HashMap<String, Object>();
		//????????????????????????????????????
	    String fileName = imgFile.getOriginalFilename();
	    //????????????????????????
	    String lastName = fileName.substring(fileName.lastIndexOf('.'));
	    //???????????????????????????????????????
	    SimpleDateFormat currentTime = new SimpleDateFormat("yyyyMMddHHmmss");
	    String currenttime = currentTime.format(new Date());
	    //???????????????????????????????????????????????????
	    //???????????????????????????????????????
	    //FileOutputStream fos = new FileOutputStream("D:/uploadFiles/"+currenttime+lastName);
	    //fos.write(imgFile.getBytes());
	    //???????????????
	    //fos.flush();
	    //????????????
	    //fos.close();
	    //???????????????????????????????????????
	    //user.setHeadimagepath("/asjy/file/"+currenttime+lastName);
	    
	    //???????????????aliyunoss????????????
	    String newFileName = currenttime + lastName;
	    File newFile = new File(newFileName);
        FileOutputStream os = new FileOutputStream(newFile);
        os.write(imgFile.getBytes());
        os.close();
        imgFile.transferTo(newFile);
        //?????????OSS
        String uploadUrl = OSSUtil.upload(newFile);
        //??????OSS??????????????????
        if(null != user.getHeadimagepath()) {
        	String[] str = user.getHeadimagepath().split("\\.com\\/");
	        OSSClient ossClient = new OSSClient(OSSConfig.END_POINT, OSSConfig.ACCESS_KEY_ID, OSSConfig.ACCESS_KEY_SECRET);
	        ossClient.deleteObject(OSSConfig.BUCKET_NAME, str[str.length-1]);
	        ossClient.shutdown();
        }
        //????????????????????????????????????
	    user.setHeadimagepath("http://yeti-shopping.oss-cn-beijing.aliyuncs.com/"+uploadUrl);
	    userService.updateUser(user);
	    map.put("user", user);
	    return map;
	}
}
