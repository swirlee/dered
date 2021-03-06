package com.asjy.commerplat.service.Impl;

import java.util.List;

import com.asjy.commerplat.model.Ad;


public interface IAdService {

	List<Ad> findAll();

	Ad findbyid(Integer id);

	int updateByPrimaryKeySelective(Ad bb);

	int addAd(Ad b2);

	int deleteById(Integer id);

	List<Ad> findRandomFiveAd();

}
