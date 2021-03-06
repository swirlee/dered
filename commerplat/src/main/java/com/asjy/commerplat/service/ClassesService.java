package com.asjy.commerplat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.asjy.commerplat.dao.ClassesMapper;
import com.asjy.commerplat.dao.FloorClassesMapper;
import com.asjy.commerplat.dao.GoodsMapper;
import com.asjy.commerplat.model.Classes;
import com.asjy.commerplat.service.Impl.IClassesService;

@Service
public class ClassesService implements IClassesService {
	
	@Autowired
	ClassesMapper classesMapper;
	@Autowired
	GoodsMapper goodsMapper;
	@Autowired
	FloorClassesMapper floorClassesMapper;
	
	@Override
	public List<Classes> findbypid(Integer pid) {
		
		return classesMapper.findbypid(pid);
	}

	@Override
	public int updateByPrimaryKeySelective(Classes classes) {
		return classesMapper.updateByPrimaryKeySelective(classes);
	}

	@Override
	public Classes findbyid(Integer id) {
		
		return classesMapper.findById(id);
	}

	@Override
	public List<Classes> selectByPid(Integer pid) {
		
		return classesMapper.selectByPid(pid);
	}

	@Override
	public int addClasses(Classes classes) {
		
		return classesMapper.insert(classes);
	}

	@Override
	public List<Classes> findToGrandSon() {
		
		return classesMapper.findToGrandSon();
	}

	@Override
	public int deleteById(Integer id) {
		List<Classes> list = classesMapper.findbypid(id);
		List<GoodsMapper> list1 = goodsMapper.findByClasses(id);
		List<FloorClassesMapper> list2 = floorClassesMapper.findByClasses(id);
		if(list.size() > 0 ||list1.size() > 0 || list2.size() > 0) {
			return 0;
		}else {
			return classesMapper.deleteByPrimaryKey(id);
		}
	}


}
