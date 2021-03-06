package com.asjy.commerplat.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.asjy.commerplat.dao.ClassesMapper;
import com.asjy.commerplat.dao.FloorClassesMapper;
import com.asjy.commerplat.dao.FloorGoodsMapper;
import com.asjy.commerplat.dao.FloorMapper;
import com.asjy.commerplat.dao.GoodsMapper;
import com.asjy.commerplat.model.Classes;
import com.asjy.commerplat.model.Floor;
import com.asjy.commerplat.model.Goods;
import com.asjy.commerplat.service.Impl.IFloorService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mysql.jdbc.StringUtils;

@Service
public class FloorService implements IFloorService {
	
	@Autowired
	FloorMapper floorMapper;
	@Autowired
	FloorGoodsMapper floorGoodsMapper;
	@Autowired
	FloorClassesMapper floorClassesMapper;
	@Autowired
	GoodsMapper goodsMapper;
	@Autowired
	ClassesMapper classesMapper;
	@Autowired
	ClassesService classesService;
	
	/**
	 * 后台-楼层-显示
	 */
	@Override
	public List<Floor> findByPid(Integer pid) {
		return floorMapper.findByPid(pid);
	}
	
	/**
	 * 后台-楼层-显示下级
	 */
	@Override
	public List<Floor> findById(Map<String, Object> map) {
		Integer pid = Integer.parseInt((String)map.get("id"));
		List<Floor> list_floor = floorMapper.findByPid(pid);
		return list_floor;
	}

	/**
	 * 后台-楼层-执行新增
	 */
	@Override
	public int addFloor(Floor floor) {
		return floorMapper.insertSelective(floor);
	}
	
	/**
	 * 后台-楼层-根据楼层id查找楼层
	 */
	@Override
	public Floor selectById(Integer id) {
		return floorMapper.selectByPrimaryKey(id);
	}

	/**
	 * 后台-楼层-修改楼层信息
	 */
	@Override
	public int updateFloor(Floor cc) {
		return floorMapper.updateByPrimaryKeySelective(cc);
	}

	/**
	 * 后台-楼层-执行修改
	 */
	@Override
	public int editFloor(Floor floor) {
		return floorMapper.updateByPrimaryKeySelective(floor);
	}

	/**
	 * 后台-楼层-执行删除
	 */
	@Override
	public int delFloor(Integer id) {
		List<Floor> list = floorMapper.findByPid(id);
		if(list.size()>0) {
			//删除主楼层下子楼层中关联的商品以及子楼层
			for (Floor floor : list) {
				floorGoodsMapper.deleteByFloord(floor.getId());
				floorMapper.deleteByPrimaryKey(floor.getId());
			}
		}
		//删除主楼层下关联的分类、商品以及主楼层本身
		floorGoodsMapper.deleteByFloord(id);
		floorClassesMapper.deleteByFloord(id);
		return floorMapper.deleteByPrimaryKey(id);
	}

	/**
	 * 后台-楼层-执行ajax删除
	 */
	@Override
	public Map<String, Object> ajaxdelete(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		String a =  (String) map.get("ids");
		String[] b = a.split(",");
		List<Integer> ids = new ArrayList<Integer>();
		for (int i = 0; i < b.length; i++) {
			ids.add(Integer.parseInt(b[i]));
		}
		floorGoodsMapper.ajaxdeleteByFloorids(ids);
		floorClassesMapper.ajaxdeleteByFloorids(ids);
		floorMapper.ajaxdeleteids(ids);
		return result;
	}

	/**
	 * 后台-楼层-模版编辑显示
	 */
	@Override
	public Floor FloorSelectById(Integer id) {
		return floorMapper.FloorSelectById(id);
	}
	
	/**
	 * 后台-楼层-分类浮窗-执行修改
	 */
	@Override
	public int addFloorClasses(Map<String, Object> map) {
		Integer[] arr = (Integer[]) map.get("arr");
		Integer id = (Integer) map.get("id");
		String floorname = (String) map.get("floorname");
		//改楼层名
		Floor floor = floorMapper.selectByPrimaryKey(id);
		floor.setFloorname(floorname);
		floorMapper.updateByPrimaryKeySelective(floor);
		//改楼层分类
		floorClassesMapper.deleteByFloord(id);
		if(arr.length>0) {
			return floorClassesMapper.insertArrClasses(arr, id);
		}else {
			return 0;
		}
		
	}

	
	/**
	 * 后台-楼层-模版编辑-楼层商品-查询楼层商品
	 */
	@Override
	public Map<String, Object> selectGoodsByClassidAndGoodsname(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		String goodsname = (String)map.get("goodsname");
		Integer currentPage = (Integer)map.get("currentPage");
		String a = (String)map.get("classesid");
		Integer classesid = null; 
		if(!StringUtils.isNullOrEmpty(a)) {
			classesid = Integer.parseInt(a);
		}
		
		//查询出某分类下所有子分类、子子分类的id
		List<Integer> list_classesid  = null;
		if(classesid != null) {
			list_classesid = new ArrayList<>();
			list_classesid.add(classesid);
			List<Classes> list = classesMapper.find2sonbypid(classesid);
			if(list.size() > 0) {
				for (Classes classes2 : list) {
					list_classesid.add(classes2.getId());
					if(classes2.getList_sonclasses().size() > 0) {
						for (Classes classes3 : classes2.getList_sonclasses()) {
							list_classesid.add(classes3.getId());
						}
					}
				}
			}
		}
		
		if(currentPage != null) {
			PageHelper.startPage(currentPage,5);
		}else {
			PageHelper.startPage(1,5);
		}
		List<Goods> blogList = goodsMapper.selectGoodsByClassidAndGoodsname(goodsname, list_classesid);
		PageInfo<Goods> pageInfo = new PageInfo<Goods>(blogList);
		
		List<Goods> list_goods = pageInfo.getList();
		int PageNum = pageInfo.getPageNum();
		int totalPage = pageInfo.getPages();
		
		result.put("list_goods", list_goods);
		result.put("PageNum", PageNum);
		result.put("totalPage", totalPage);
		return result;		
	}

	
	/**
	 * 后台-楼层-楼层商品浮窗-执行修改
	 */
	@Override
	public int addFloorGoods(Map<String, Object> map) {
		Integer[] arr = (Integer[]) map.get("arr");
		Integer id = (Integer) map.get("id");
		String floorname = (String) map.get("floorname");
		//改楼层名
		Floor floor = floorMapper.selectByPrimaryKey(id);
		floor.setFloorname(floorname);
		floorMapper.updateByPrimaryKeySelective(floor);
		//改楼层商品
		floorGoodsMapper.deleteByFloord(id);
		if(arr.length>0) {
		floorGoodsMapper.insertArrGoods(arr, id);
		}
		return  0;
	}

	@Override
	public List<Floor> FloorSelectAll() {
		return floorMapper.FloorSelectAll();
	}
	
	@Override
	public List<Floor> FloorSelectByDisplay() {
		return floorMapper.FloorSelectByDisplay();
	}
		
}
