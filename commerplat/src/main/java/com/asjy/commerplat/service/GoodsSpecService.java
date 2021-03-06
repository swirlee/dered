package com.asjy.commerplat.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.asjy.commerplat.dao.GoodsImagesMapper;
import com.asjy.commerplat.dao.GoodsSpecMapper;
import com.asjy.commerplat.model.GoodsImages;
import com.asjy.commerplat.model.GoodsSpec;
import com.asjy.commerplat.service.Impl.IGoodsSpecService;
import com.github.pagehelper.StringUtil;

@Service
public class GoodsSpecService implements IGoodsSpecService {
	
	@Autowired
	GoodsSpecMapper goodsSpecMapper;
	@Autowired
	GoodsImagesMapper goodsImagesMapper;

	@Override
	public int addGoodsSpec(GoodsSpec goodsSpec) {
		
		return goodsSpecMapper.insertSelective(goodsSpec);
	}

	@Override
	public Map<String, Object> findByGoodsnumberAndSpecvid(String goodsnumber,String specvids) {
		Map<String, Object> result = new HashMap<String, Object>();
		String[] arr_specvid = specvids.split(",");
		Integer specvid1 = Integer.parseInt(arr_specvid[0]);
		Integer specvid2 = Integer.parseInt(arr_specvid[1]);
		GoodsSpec goodsSpec = goodsSpecMapper.findByGoodsnumberAndSpecvid(specvid1,specvid2,goodsnumber);
		if(goodsSpec!=null) {
			List<GoodsImages> list_images = goodsImagesMapper.findByGoodsId(goodsSpec.getGoods().getId());
			result.put("goodsSpec", goodsSpec);
			result.put("list_images", list_images);
			return result;
		}
		return null;
		
	}

	@Override
	public List<GoodsSpec> findByGoodsId(Integer goodsid) {
		
		return goodsSpecMapper.findByGoodsId(goodsid);
	}

	@Override
	public int updateGoodsSpec(GoodsSpec goodsSpec) {
		return goodsSpecMapper.updateByPrimaryKeySelective(goodsSpec);
	}

	@Override
	public int deleteById(Integer id) {
		return goodsImagesMapper.deleteByPrimaryKey(id);
	}
	
	
}
