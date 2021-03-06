package com.asjy.commerplat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.asjy.commerplat.dao.GoodsImagesMapper;
import com.asjy.commerplat.model.GoodsImages;
import com.asjy.commerplat.service.Impl.IGoodsImagesService;
import com.asjy.commerplat.service.Impl.IGoodsService;

@Service
public class GoodsImagesService implements IGoodsImagesService {
	
	@Autowired
	GoodsImagesMapper goodsimagesmapper;
	
	
	

	@Override
	public int updateByPrimaryKeySelective(GoodsImages gI) {
		return goodsimagesmapper.updateByPrimaryKeySelective(gI);
	}




	@Override
	public int addGoodsImages(GoodsImages goodsImages) {
		return goodsimagesmapper.insertSelective(goodsImages);
	}




	@Override
	public List<GoodsImages> findByGoodsId(Integer goodsid) {
		
		return goodsimagesmapper.findByGoodsId(goodsid);
	}




	@Override
	public GoodsImages findBYId(Integer imagesPaths) {
		
		return goodsimagesmapper.findBYId(imagesPaths);
	}




	@Override
	public int updateGoodsImages(GoodsImages goodsImages1) {
		
		return goodsimagesmapper.updateByPrimaryKeySelective(goodsImages1);
	}




	@Override
	public int deleteByid(Integer id) {
		
		return goodsimagesmapper.deleteByPrimaryKey(id);
	}

	
	
}
