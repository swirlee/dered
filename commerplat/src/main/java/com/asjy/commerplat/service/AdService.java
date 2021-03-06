package com.asjy.commerplat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.asjy.commerplat.dao.AdMapper;
import com.asjy.commerplat.model.Ad;
import com.asjy.commerplat.service.Impl.IAdService;

@Service
public class AdService implements IAdService {
	
	@Autowired
	AdMapper admapper;
	
	@Override
	public List<Ad> findAll() {
		
		return admapper.findAll();
	}

	@Override
	public Ad findbyid(Integer id) {
		
		return admapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Ad bb) {
		
		return admapper.updateByPrimaryKey(bb);
	}

	@Override
	public int addAd(Ad b2) {
		
		return admapper.insertSelective(b2);
	}

	@Override
	public int deleteById(Integer id) {
		
		return admapper.deleteByPrimaryKey(id);
	}

	@Override
	public List<Ad> findRandomFiveAd() {
		return admapper.findRandomFiveAd();
	}
	
}
