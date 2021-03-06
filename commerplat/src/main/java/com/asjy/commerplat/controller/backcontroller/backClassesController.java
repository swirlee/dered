package com.asjy.commerplat.controller.backcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asjy.commerplat.model.Classes;
import com.asjy.commerplat.service.Impl.IClassesService;


@Controller
public class backClassesController {
	
	@Autowired
	IClassesService classesService;
	
	/**
	 * 跳转后台商品分类页(展示所有一级分类集合)
	 */
	@RequestMapping("/back_goods_classes_list")
	public String goodsList(Model model) {
		List<Classes> listPid0 = classesService.findbypid(0);
		model.addAttribute("listPid0", listPid0);
		return "back/back_goods_classes_list";
	}
	/**
	 * 分级显示(点击+获得当前分类下的集合)
	 */
	@RequestMapping("/back_goods_classes_list2or3")
	public String classesShow(String id, Model model){
		Classes classes = classesService.findbyid(Integer.parseInt(id));
		List<Classes> selectByPid = classesService.findbypid(Integer.parseInt(id));
		model.addAttribute("listPidNo0", selectByPid);
		if (classes.getPid() == 0) {
			return "back/back_goods_classes_list2";
		}else{
			model.addAttribute("pid0", classes.getPid());
			return "back/back_goods_classes_list3";
		}
	}
	/**
	 * 分类编辑
	 */
	@RequestMapping("/back_goods_classes_list_updatebyid")
	public String goodsUpdateById(Model model) {
		
		return "back/back_goods_classes_list_updatebyid";
	}
}
