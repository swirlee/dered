package com.asjy.commerplat.service.Impl;

import java.util.List;
import java.util.Map;


import com.asjy.commerplat.model.Floor;

public interface IFloorService {

	List<Floor> findByPid(Integer pid);

	List<Floor> findById(Map<String, Object> map);

	int addFloor(Floor floor);

	Floor selectById(Integer id);

	int updateFloor(Floor cc);

	int editFloor(Floor floor);

	int delFloor(Integer id);

	Map<String, Object> ajaxdelete(Map<String, Object> map);

	Floor FloorSelectById(Integer id);

	int addFloorClasses(Map<String, Object> map);

	Map<String, Object> selectGoodsByClassidAndGoodsname(Map<String, Object> map);

	int addFloorGoods(Map<String, Object> map);

	List<Floor> FloorSelectAll();

	List<Floor> FloorSelectByDisplay();

}
