package com.asjy.commerplat.controller.backcontroller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.asjy.commerplat.model.Spec;
import com.asjy.commerplat.model.Specv;
import com.asjy.commerplat.service.Impl.ISpecService;
import com.asjy.commerplat.service.Impl.ISpecvService;

@RequestMapping("/spec")
@Controller
public class backSpecController {
	
	@Autowired
	ISpecService specService;
	
	@Autowired
	ISpecvService specvService;
	
	@RequestMapping("/showspec")
	public String showspec(Model model) {
		
		List<Spec> list_spec = specService.findAll();
		model.addAttribute("list_spec", list_spec);
		return "back/spec_list";
	}
	
	@RequestMapping("/addspec")
	public String addspec(Model model) {
		
		return "back/spec_add";
	}
	
	@RequestMapping("/doaddspec")
	public String doaddapec(Model model, String specname, Integer seq, String[] specvname, Integer[] specvseq) {
		Spec spec = new Spec();
		spec.setSpecname(specname);
		spec.setSeq(seq);
		Date addtime = new Date();
		spec.setAddtime(addtime);
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("spec", spec);
		map.put("specvnames", specvname);
		map.put("specvseqs", specvseq);
		Integer pid = spec.getId();
		map.put("pid",pid);
		
		specService.addSpecAndSpecv(map);
		return "redirect:/spec/showspec";
	}
	
	
	@RequestMapping("/spec_edit")
	public String editspec(Model model, Integer id) {
		Spec spec = specService.findById(id);
		model.addAttribute("spec", spec);
		List<Specv> list_specv = specvService.findByPid(id);
		model.addAttribute("list_specv", list_specv);
		
		System.out.println(spec.getSpecname());
		return "back/spec_edit";
	}
	
	
	
	@RequestMapping("/doeditspec")
	public String doeditapec(Integer specid, String specname, Integer seq, String delids, Integer[] specvid, String[] oldspecvname, Integer[] oldspecvseq, String[] specvname, Integer[] specvseq) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("specid", specid);
		map.put("specname", specname);
		map.put("seq", seq);
		map.put("delids", delids);
		map.put("specvid", specvid);
		map.put("oldspecvname", oldspecvname);
		map.put("oldspecvseq", oldspecvseq);
		map.put("specvname", specvname);
		map.put("specvseq", specvseq);
		specService.editSpecAndSpecv(map);
		return "redirect:/spec/showspec";
	}
	
	@RequestMapping("/spec_del")
	public String spec_del(Integer id) {
		specService.deleteById(id);
		specvService.deleteByspecid(id);
		return "redirect:/spec/showspec";
	}
	
	@ResponseBody
	@RequestMapping("/ajax_update")
	public Map<String, Object> ajax_update(Integer id, String fieldName, String value) {
		
		Map<String, Object> result = new HashMap<>();
		
		Spec gg = specService.findById(id);
		if(fieldName.equals("seq")) {
			Integer seq = Integer.parseInt(value);
			gg.setSeq(seq);
		}
		if(fieldName.equals("specname")) {
			gg.setSpecname(value);
		}
		if(fieldName.equals("delete")) {
			int dd = specService.deleteById(id);
			result.put("dd", dd);
		}
		
		specService.updateByPrimaryKey(gg);
		result.put("gg", gg);
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping("/ajax_edit_del")
	public Map<String, Object> ajax_edit_del(Integer id, String fieldName) {
		
		Map<String, Object> result = new HashMap<>();
		if(fieldName.equals("delete")) {
			int dd = specService.delOrnotById(id);
			result.put("dd", dd);
		}
		return result;
	}
	
}
