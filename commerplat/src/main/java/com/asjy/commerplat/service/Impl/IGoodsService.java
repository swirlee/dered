package com.asjy.commerplat.service.Impl;

import java.util.List;
import java.util.Map;

import com.asjy.commerplat.model.Goods;

public interface IGoodsService {

	List<Goods> findAll();

	Goods findById(Integer id);

	int updateByPrimaryKeySelective(Goods gg);

	int deleteById(Integer id);

	Goods findByGoodsNumber(String goodsnumber);

	int addGoods(Goods goods);

	int updateGoods(Goods goods);

	List<Goods> findByRecommend(Boolean recommend);

	Map<String, Object> findByConditions(Map<String, Object> map);

	List<Goods> findByNewGoods();

	List<Goods> findByinventoryGoods();

}
