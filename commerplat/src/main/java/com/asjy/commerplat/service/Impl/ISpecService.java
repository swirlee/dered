package com.asjy.commerplat.service.Impl;

import java.util.List;
import java.util.Map;

import com.asjy.commerplat.model.Spec;


public interface ISpecService {

	List<Spec> findAll();
	
	public Map<String, Object> addSpecAndSpecv(Map<String,Object> map);

	Spec findById(Integer id);

	void editSpecAndSpecv(Map<String, Object> map);

	List<Spec> findByGoodsNumber(String goodsnumber);

	List<Spec> findByGoodsId(Integer id);

	Spec selectedById(Integer id);

	int deleteById(Integer id);

	int updateByPrimaryKey(Spec gg);

	int delOrnotById(Integer id);

	

}
