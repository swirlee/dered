package com.asjy.commerplat.controller.backcontroller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.asjy.commerplat.model.Classes;
import com.asjy.commerplat.model.Floor;
import com.asjy.commerplat.service.Impl.IClassesService;
import com.asjy.commerplat.service.Impl.IFloorService;

@Controller
@RequestMapping("/floor")
public class backFloorController {
	
	@Autowired
	IFloorService floorService;
	@Autowired
	IClassesService classesService;
	
	/**
	 * 后台-楼层-页面显示
	 * @param model
	 * @return
	 */
	@RequestMapping("/goods_floor_list")
	public String goods_floor_list(Model model) {
		List<Floor> list_floor = floorService.findByPid(0);
		model.addAttribute("list_floor", list_floor);
		return "back/goods_floor_list";
	}
	
	
	/**
	 * 后台-楼层-新增页面显示
	 * @param model
	 * @return
	 */
	@RequestMapping("/floor_add")
	public String floor_add(Model model, Integer pid) {
		//判断是否为新增下级的新增
		if(pid != null) {
			model.addAttribute("pid", pid);
		}else {
			model.addAttribute("pid", 0);
		}
		//下拉框里的内容
		List<Floor> list_floor = floorService.findByPid(0);
		model.addAttribute("list_floor", list_floor);
		return "back/floor_add";
	}
	
	
	/**
	 * 后台-楼层-ajax查看下级
	 * @return
	 */
	@RequestMapping("/appendSonList")
	public String appendSonList(@RequestParam Map<String, Object> map,Model model){
		List<Floor> list_floor = floorService.findById(map);
		model.addAttribute("list_floor",list_floor);
		return "back/floor_list2";
	}
	
	
	
	/**
	 * 后台-楼层-执行新增
	 */
	@RequestMapping("/floor_save")
	public String floor_save(String floor_name, Integer pid, String floor_display ,Integer floor_seq){
		Floor floor = new Floor();
		floor.setAddtime(new Date());
		floor.setDisplay(floor_display.equals("true")? true : false);
		floor.setFloorname(floor_name);
		floor.setPid(pid);
		floor.setSeq(floor_seq);
		floorService.addFloor(floor);
		return "redirect:/floor/goods_floor_list";
	}
	
	
	/**
	 * 后台-楼层页面-Ajax修改
	 * @param id
	 * @param fieldName
	 * @param value
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/floor_ajax_update")
	public Map<String, Object> floor_ajax_update(Integer id, String fieldName, String value) {
		Floor cc = floorService.selectById(id);
		if(fieldName.equals("floor_name")) {
			String floorname = value;
			cc.setFloorname(floorname);
		}
		if(fieldName.equals("floor_seq")) {
			if(value==""||value==null) {
				value="0";
			}
			Integer seq = Integer.parseInt(value);
			cc.setSeq(seq);
		}
		if(fieldName.equals("floor_display")) {
			if(cc.getDisplay()==true) {
				cc.setDisplay(false);
			}else
			if(cc.getDisplay()==false){
				cc.setDisplay(true);
			}
		}
		floorService.updateFloor(cc);
		Map<String, Object> result = new HashMap<>();
		result.put("cc", cc);
		return result;
	}
	
	
	/**
	 * 后台-楼层页面-查看一级楼层下有几个子楼层
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/countOfSonFloor")
	public Map<String, Object> countOfSonFloor(Integer id) {
		//查询父类楼层下有几个子楼层
		List<Floor> list = floorService.findByPid(id);
		int aaa = list.size();
		Map<String, Object> result = new HashMap<>();
		result.put("aaa", aaa);
		return result;
	}
	
	
	/**
	 * 后台-楼层-修改页面显示
	 * @param model
	 * @return
	 */
	@RequestMapping("/floor_edit")
	public String floor_edit(Model model, Integer id) {
		Floor floor = floorService.selectById(id);
		model.addAttribute("floor", floor);
		//下拉框里的内容
		List<Floor> list_floor = floorService.findByPid(0);
		model.addAttribute("list_floor", list_floor);
		return "back/floor_edit";
	}
	
	/**
	 * 后台-楼层-执行修改
	 */
	@RequestMapping("/floor_doupdate")
	public String floor_doupdate(String floor_name, Integer pid, String floor_display ,Integer floor_seq, Integer id){
		Floor floor = floorService.selectById(id);
		floor.setDisplay(floor_display.equals("true") ? true : false);
		floor.setFloorname(floor_name);
		floor.setPid(pid);
		floor.setSeq(floor_seq);
		floorService.editFloor(floor);
		return "redirect:/floor/goods_floor_list";
	}
	
	
	/**
	 * 后台-楼层-执行修改
	 */
	@RequestMapping("/floor_del")
	public String floor_del(Integer id){
		floorService.delFloor(id);
		return "redirect:/floor/goods_floor_list";
	}
	
	
	/**
	 * 后台-楼层-执行ajax删除
	 */
	@RequestMapping("/ajaxdel")
	@ResponseBody
	public Map<String, Object> ajaxdel(@RequestParam Map<String, Object> map){
		Map<String, Object> result = floorService.ajaxdelete(map);
		return result;
	}
	
	
	/**
	 * 后台-楼层-模版编辑显示
	 * @param model
	 * @return
	 */
	@RequestMapping("/floor_model_edit")
	public String floor_model_edit(Model model, @ModelAttribute("id") Integer id) {
		Floor floor = floorService.FloorSelectById(id);
		model.addAttribute("floor", floor);
		return "back/floor_model_edit";
	}
	
	
	
	/**
	 * 后台-楼层-模版编辑-分类编辑浮窗显示
	 * @param model
	 * @return
	 */
	@RequestMapping("/floor_classes_edit")
	public String floor_classes_edit(Model model, Integer id) {
		Floor floor = floorService.FloorSelectById(id);
		model.addAttribute("floor", floor);
		List<Classes> list_classes = classesService.selectByPid(0);
		model.addAttribute("list_classes", list_classes);
		return "back/floor_classes_edit";
	}
	
	
	
	/**
	 * 后台-楼层页面-模版编辑-分类编辑浮窗-分类修改
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/ajax_edit_classes")
	public Map<String, Object> ajax_edit_classes(Integer id) {
		Classes classes = classesService.findbyid(id);
		Map<String, Object> result = new HashMap<>();
		result.put("classes", classes);
		return result;
	}
	
	
	/**
	 * 后台-楼层-分类浮窗-执行修改
	 */
	@RequestMapping("/floor_classes_doedit")
	public String floor_classes_doedit(Integer[] arr, Integer id, String gf_name, RedirectAttributes redirectAttributes){
		redirectAttributes.addAttribute("id", id);
		Map<String, Object> map = new HashMap<>();
		map.put("arr", arr);
		map.put("id", id);
		map.put("floorname", gf_name);
		floorService.addFloorClasses(map);
		return "redirect:/floor/floor_model_edit";
	}
	
	
	/**
	 * 后台-楼层-模版编辑-楼层商品-编辑浮窗显示
	 * @param model
	 * @return
	 */
	@RequestMapping("/floor_floor_edit")
	public String floor_floor_edit(Model model, Integer id) {
		Floor floor = floorService.FloorSelectById(id);
		model.addAttribute("floor", floor);
		List<Classes> list_classes = classesService.selectByPid(0);
		model.addAttribute("list_classes", list_classes);
		return "back/floor_floor_edit";
	}
	
	
	
	/**
	 * 后台-楼层-模版编辑-楼层商品-查询楼层商品
	 */
	@RequestMapping("/floor_floor_select_goods")
	@ResponseBody
	public Map<String, Object> floor_floor_select_goods(@RequestBody Map<String, Object> map){
		Map<String, Object> result = floorService.selectGoodsByClassidAndGoodsname(map);
		return result;
	}
	
	
	/**
	 * 后台-楼层-楼层商品浮窗-执行修改
	 */
	@RequestMapping("/floor_floor_doedit")
	public String floor_floor_doedit(Integer[] arr, Integer id,Integer pid, String gf_name, RedirectAttributes redirectAttributes){
		redirectAttributes.addAttribute("id", pid);
		Map<String, Object> map = new HashMap<>();
		map.put("arr", arr);
		map.put("id", id);
		map.put("floorname", gf_name);
		floorService.addFloorGoods(map);
		return "redirect:/floor/floor_model_edit";
	}
	
	
	
	
	/**
	 * 后台-楼层-模版编辑-右边商品-编辑浮窗显示
	 * @param model
	 * @return
	 */
	@RequestMapping("/floor_goods_edit")
	public String floor_goods_edit(Model model, Integer id) {
		Floor floor = floorService.FloorSelectById(id);
		model.addAttribute("floor", floor);
		List<Classes> list_classes = classesService.selectByPid(0);
		model.addAttribute("list_classes", list_classes);
		return "back/floor_goods_edit";
	}
	
	
	/**
	 * 后台-楼层-右边商品浮窗-执行修改
	 */
	@RequestMapping("/floor_goods_doedit")
	public String floor_goods_doedit(Integer[] arr, Integer id,String gf_name, RedirectAttributes redirectAttributes){
		redirectAttributes.addAttribute("id", id);
		Map<String, Object> map = new HashMap<>();
		map.put("arr", arr);
		map.put("id", id);
		map.put("floorname", gf_name);
		floorService.addFloorGoods(map);
		return "redirect:/floor/floor_model_edit";
	}
}
