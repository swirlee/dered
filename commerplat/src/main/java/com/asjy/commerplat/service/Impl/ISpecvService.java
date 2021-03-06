package com.asjy.commerplat.service.Impl;

import java.util.List;

import com.asjy.commerplat.model.Specv;

public interface ISpecvService {

	
	List<Specv> findByPid(Integer pid);

	int deleteByspecid(Integer specid);

}
