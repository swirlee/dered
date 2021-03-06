package com.asjy.commerplat.service.Impl;

import java.util.List;
import java.util.Map;

import com.asjy.commerplat.model.GoodsSpec;

public interface IGoodsSpecService {

	int addGoodsSpec(GoodsSpec goodsSpec1);

	Map<String, Object> findByGoodsnumberAndSpecvid(String goodsnumber, String specvids);

	List<GoodsSpec> findByGoodsId(Integer goodsid);

	int updateGoodsSpec(GoodsSpec goodsSpec);

	int deleteById(Integer id);



}
