package com.asjy.commerplat.controller.backcontroller;


import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.print.attribute.standard.DateTimeAtCompleted;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.asjy.commerplat.model.Classes;
import com.asjy.commerplat.service.Impl.IClassesService;

@Controller
@RequestMapping("/classes")
public class classescontroller {
	
	@Autowired
	IClassesService classesService;
	
	@RequestMapping("/showclasses")
	public String showclasses(Model model, Integer pid) {
		List<Classes> list_classes = classesService.findbypid(pid);
		model.addAttribute("list_classes", list_classes);
		return "back/class_list";
	}
	

	@ResponseBody
	@RequestMapping("/goods_class_ajax")
	public Map<String, Object> goods_class_ajax_classname(Integer id, String fieldName, String value) {
		Map<String, Object> result = new HashMap<>();
		Classes cc = classesService.findbyid(id);
		if(fieldName.equals("classname")) {
			String classname = value;
			cc.setClassname(classname);
		}
		if(fieldName.equals("seq")) {
			Integer seq = Integer.parseInt(value);
			cc.setSeq(seq);
		}
		if(fieldName.equals("display")) {
			if(cc.getDisplay()==true) {
				cc.setDisplay(false);
			}else
			if(cc.getDisplay()==false){
				cc.setDisplay(true);
			}
		}
		if(fieldName.equals("delete")) {
			int dd = classesService.deleteById(id);
			result.put("dd", dd);
		}
		classesService.updateByPrimaryKeySelective(cc);
		result.put("cc", cc);
		return result;
	}
	
	
	@RequestMapping("/appendSonList")
	public String appendSonList(String id, Model model){
		Classes classes = classesService.findbyid(Integer.parseInt(id));
		List<Classes> classes_Sonlist = classesService.findbypid(Integer.parseInt(id));
		model.addAttribute("classes_Sonlist", classes_Sonlist);
		if (classes.getPid() == 0) {
			return "back/class_list2";
		}else{
			model.addAttribute("pid0", classes.getPid());
			return "back/class_list3";
		}
	}
	
	
	@RequestMapping("/addclasses")
	public String addclasses(Model model, Integer pid) {
		if(pid==null) {
			pid=0;
		}
		model.addAttribute("pid", pid);
		List<Classes> list_classes = classesService.selectByPid(0);
		model.addAttribute("list_classes", list_classes);
		return "back/class_add";
	}
	
	
	@RequestMapping("/saveClasses")
	public String saveClasses(Model model, String classname, Integer pid, String display, Integer seq ) {
		Date addtime = new Date();
		System.out.println(addtime);
		Classes c2 = new Classes();
		c2.setAddtime(addtime);
		c2.setClassname(classname);
		c2.setPid(pid);
		c2.setSeq(seq);
		if(display.equals("true")) {
			c2.setDisplay(true);
		}else {
			c2.setDisplay(false);
		}
		int i = classesService.addClasses(c2);
		return "redirect:showclasses?pid=0";
	}
	
	
	@RequestMapping("/class_update")
	public String class_update(Model model, Integer id) {
		Classes classes = classesService.findbyid(id);
		model.addAttribute("classes1", classes);
		List<Classes> list_classes = classesService.selectByPid(0);
		model.addAttribute("list_classes", list_classes);
		return "back/class_update";
	}
	
	
	@RequestMapping("/updateClasses")
	public String updateClasses(Integer id, String classname, Integer pid, String display, Integer seq) {
		Classes classes = classesService.findbyid(id);
		classes.setPid(pid);
		classes.setClassname(classname);
		if(display.equals("true")) {
			classes.setDisplay(true);
		}else {
			classes.setDisplay(false);
		}
		
		classes.setSeq(seq);
		int i = classesService.updateByPrimaryKeySelective(classes);
		System.out.println(i);
		return "redirect:showclasses?pid=0";
	}
	
}
