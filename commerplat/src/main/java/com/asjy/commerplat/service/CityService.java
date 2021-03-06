package com.asjy.commerplat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.asjy.commerplat.dao.CityMapper;
import com.asjy.commerplat.model.City;
import com.asjy.commerplat.service.Impl.ICityService;

@Service
public class CityService implements ICityService {
	
	@Autowired
	CityMapper cityMapper;

	@Override
	public List<City> findBypid(Integer pid) {
		
		return cityMapper.findBypid(pid);
	}
	
}
