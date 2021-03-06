package com.asjy.commerplat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.asjy.commerplat.dao.BrandMapper;
import com.asjy.commerplat.dao.FloorClassesMapper;
import com.asjy.commerplat.dao.GoodsMapper;
import com.asjy.commerplat.model.Brand;
import com.asjy.commerplat.model.Classes;
import com.asjy.commerplat.service.Impl.IBrandService;

@Service
public class BrandService implements IBrandService {
	
	@Autowired
	BrandMapper brandmapper;
	@Autowired
	GoodsMapper goodsMapper;
	
	@Override
	public List<Brand> findAll() {
		
		return brandmapper.findAll();
	}

	@Override
	public Brand findbyid(Integer id) {
		
		return brandmapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Brand bb) {
		
		return brandmapper.updateByPrimaryKey(bb);
	}

	@Override
	public int addBrand(Brand b2) {
		
		return brandmapper.insertSelective(b2);
	}

	@Override
	public int deleteById(Integer id) {
		List<GoodsMapper> list1 = goodsMapper.findByBrand(id);
		if(list1.size() > 0) {
			return 0;
		}else {
			return brandmapper.deleteByPrimaryKey(id);
		}
	}

	@Override
	public List<Brand> findByRecommend(boolean recommend) {
		int i=0;
		if(recommend == true) {
			i=1;
		}
		return brandmapper.findByRecommend(i);
		
	}

	@Override
	public List<Brand> findByAllRecommend(boolean recommend) {
		int i=0;
		if(recommend == true) {
			i=1;
		}
		return brandmapper.findByAllRecommend(i);
	}
	
}
