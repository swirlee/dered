package com.asjy.commerplat.service.Impl;

import java.util.List;

import com.asjy.commerplat.model.Brand;


public interface IBrandService {

	List<Brand> findAll();

	Brand findbyid(Integer id);

	int updateByPrimaryKeySelective(Brand bb);

	int addBrand(Brand b2);

	int deleteById(Integer id);

	List<Brand> findByRecommend(boolean b);

	List<Brand> findByAllRecommend(boolean b);

}
