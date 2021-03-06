package com.asjy.commerplat.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.asjy.commerplat.dao.GoodsSpecMapper;
import com.asjy.commerplat.dao.SpecMapper;
import com.asjy.commerplat.dao.SpecvMapper;
import com.asjy.commerplat.model.Detailorder;
import com.asjy.commerplat.model.FloorGoods;
import com.asjy.commerplat.model.GoodsSpec;
import com.asjy.commerplat.model.Spec;
import com.asjy.commerplat.model.Specv;
import com.asjy.commerplat.service.Impl.ISpecService;

@Service
public class SpecService implements ISpecService {

	@Autowired
	SpecMapper specMapper;
	@Autowired
	SpecvMapper specvMapper;
	@Autowired
	GoodsSpecMapper goodsspecvMapper;
	@Override
	public List<Spec> findAll() {
		
		return specMapper.findAll();
	}

	@Override
	public Map<String, Object> addSpecAndSpecv(Map<String,Object> map) {
		Spec spec = (Spec)map.get("spec");
		 specMapper.insert(spec);
		 String[] specvnames = (String[])map.get("specvnames");
		 Integer[] specvseqs = (Integer[])map.get("specvseqs");
		 Integer pid = (Integer)map.get("pid");
		 
		if(specvnames != null && specvnames.length >0){
			int i = 0;
				for(String name : specvnames){
					if(name!=null && !"".equals(name)){
						Specv specv = new Specv();
						specv.setSpecid(spec.getId());
						specv.setSpecvname(name);
						specv.setAddtime(new Date());
						if(specvseqs != null && specvseqs.length > 0){
							Integer seq = specvseqs[i];
							specv.setSeq(seq);
						}else{
							specv.setSeq(0);
						}
						specvMapper.insert(specv);
					}
					i++;
			}
		}
		
		return null;
	}

	@Override
	public Spec findById(Integer id) {
		
		return specMapper.selectByPrimaryKey(id);
	}

	@Override
	public void editSpecAndSpecv(Map<String, Object> map) {
		Integer specid = (Integer)map.get("specid");
		String specname = (String)map.get("specname");
		Integer seq = (Integer)map.get("seq");
		String delids = (String)map.get("delids");
		Integer[] arr_specvid = (Integer[])map.get("specvid");
		String[] arr_oldspecvname = (String[])map.get("oldspecvname");
		Integer[] arr_oldspecvseq = (Integer[])map.get("oldspecvseq");
		String[] arr_specvname = (String[])map.get("specvname");
		Integer[] arr_specvseq = (Integer[])map.get("specvseq");
		
		//修改规格
		Spec update_spec = specMapper.selectByPrimaryKey(specid);
		update_spec.setSpecname(specname);
		update_spec.setSeq(seq);
		specMapper.updateByPrimaryKeySelective(update_spec);
		
		
		//第一步：删除规格值
		String[] arr_delids = delids.split(",");
		System.out.println(arr_delids[0]);
		System.out.println(arr_delids.length);
		if(!arr_delids[0].equals("") && arr_delids.length>0) {
			List<Integer> list_delids = new ArrayList<Integer>();
			for (int i=0;i<arr_delids.length;i++) {
				list_delids.add(Integer.parseInt(arr_delids[i]));
				
			}
			if(list_delids != null && list_delids.size() > 0) {
				specvMapper.deleteByList(list_delids);
			}
		}
		
		
		//第二步：编辑规格值
		if(arr_specvid!=null && arr_specvid.length>0) {
			int i = 0;
			for (Integer specvid : arr_specvid) {
				Specv update_specv = specvMapper.selectByPrimaryKey(specvid);
				if(arr_oldspecvname!=null && arr_oldspecvname.length>0) {
					update_specv.setSpecvname(arr_oldspecvname[i]);
				}
				if(arr_oldspecvseq!=null && arr_oldspecvseq.length>0) {
					update_specv.setSeq(arr_oldspecvseq[i]);
				}
				specvMapper.updateByPrimaryKeySelective(update_specv);
				i++;
			}
		}
		
		
		//第三步：加入后续添加的规格值
		if(arr_specvname != null && arr_specvname.length >0){
			int i = 0;
				for(String name : arr_specvname){
					if(name!=null && !"".equals(name)){
						Specv specv = new Specv();
						specv.setSpecid(specid);
						specv.setSpecvname(name);
						specv.setAddtime(new Date());
						if(arr_specvseq != null && arr_specvseq.length > 0){
							specv.setSeq(arr_specvseq[i]);
						}else{
							specv.setSeq(0);
						}
						specvMapper.insert(specv);
					}
					i++;
			}
		}
		
	}

	@Override
	public List<Spec> findByGoodsNumber(String goodsnumber) {
		
		return specMapper.findByGoodsNumber(goodsnumber);
	}

	@Override
	public List<Spec> findByGoodsId(Integer id) {
		return specMapper.findByGoodsId(id);
	}

	@Override
	public Spec selectedById(Integer id) {
		return specMapper.selectedById(id);
	}

	@Override
	public int deleteById(Integer id) {
		
		List<GoodsSpec> list1 = goodsspecvMapper.findBySpecId(id);
		if(list1.size() > 0) {
			return 0;
		}else {
			specvMapper.deleteByspecid(id);
			return specMapper.deleteByPrimaryKey(id);
		}
		
		
	}

	@Override
	public int updateByPrimaryKey(Spec gg) {
		
		return specMapper.updateByPrimaryKeySelective(gg);
	}

	@Override
	public int delOrnotById(Integer id) {
		List<GoodsSpec> list1 = goodsspecvMapper.findBySpecId(id);
		if(list1.size() > 0) {
			return 0;
		}else {
			return 1;
		}
	}

	
}
	
