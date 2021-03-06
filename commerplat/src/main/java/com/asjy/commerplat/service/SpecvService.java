package com.asjy.commerplat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.asjy.commerplat.dao.SpecvMapper;
import com.asjy.commerplat.model.Specv;
import com.asjy.commerplat.service.Impl.ISpecvService;

@Service
public class SpecvService implements ISpecvService {

	@Autowired
	SpecvMapper specvmapper;
	
	@Override
	public List<Specv> findByPid(Integer pid) {
		
		return specvmapper.findByPid(pid);
	}

	@Override
	public int deleteByspecid(Integer specid) {
		return specvmapper.deleteByspecid(specid);
	}

}
