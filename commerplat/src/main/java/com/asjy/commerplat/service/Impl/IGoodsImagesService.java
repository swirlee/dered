package com.asjy.commerplat.service.Impl;

import java.util.List;

import com.asjy.commerplat.model.GoodsImages;


public interface IGoodsImagesService {

	
	int updateByPrimaryKeySelective(GoodsImages gI);

	int addGoodsImages(GoodsImages goodsImages);

	List<GoodsImages> findByGoodsId(Integer goodsid);

	GoodsImages findBYId(Integer imagesPaths);

	int updateGoodsImages(GoodsImages goodsImages1);

	int deleteByid(Integer imagesPaths);


}
