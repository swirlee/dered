package com.asjy.commerplat.service.Impl;

import java.util.List;

import com.asjy.commerplat.model.Classes;
import com.asjy.commerplat.model.Goods;

public interface IClassesService {

	List<Classes> findbypid(Integer pid);

	int updateByPrimaryKeySelective(Classes classes);

	Classes findbyid(Integer id);

	List<Classes> selectByPid(Integer pid);

	int addClasses(Classes classes);

	List<Classes> findToGrandSon();

	int deleteById(Integer id);
	

}
