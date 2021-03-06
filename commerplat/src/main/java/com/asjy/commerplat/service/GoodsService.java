package com.asjy.commerplat.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.asjy.commerplat.dao.ClassesMapper;
import com.asjy.commerplat.dao.DetailorderMapper;
import com.asjy.commerplat.dao.FloorGoodsMapper;
import com.asjy.commerplat.dao.GoodsMapper;
import com.asjy.commerplat.dao.GoodsSpecMapper;
import com.asjy.commerplat.model.Classes;
import com.asjy.commerplat.model.Detailorder;
import com.asjy.commerplat.model.FloorGoods;
import com.asjy.commerplat.model.Goods;
import com.asjy.commerplat.service.Impl.IGoodsService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;


@Service
public class GoodsService implements IGoodsService {
	
	@Autowired
	GoodsMapper goodsMapper;
	@Autowired
	ClassesMapper classesMapper;
	@Autowired
	DetailorderMapper detailorderMapper;
	@Autowired
	FloorGoodsMapper floorgoodsMapper;
	@Autowired
	GoodsSpecMapper goodsSpecMapper;
	@Override
	public List<Goods> findAll() {
		
		return goodsMapper.findAll();
	}

	@Override
	public Goods findById(Integer id) {
		
		return goodsMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Goods gg) {
		
		return goodsMapper.updateByPrimaryKeySelective(gg);
	}

	@Override
	public int deleteById(Integer id) {
		List<Detailorder> list1 = detailorderMapper.findByGoodsId(id);
		List<FloorGoods> list2 = floorgoodsMapper.findByGoodsId(id);
		if(list1.size() > 0 || list2.size() > 0) {
			return 0;
		}else {
			goodsSpecMapper.deleteByGoodsId(id);
			return goodsMapper.deleteByPrimaryKey(id);
		}
	}

	@Override
	public Goods findByGoodsNumber(String goodsnumber) {
		
		return goodsMapper.findByGoodsNumber(goodsnumber);
	}

	@Override
	public int addGoods(Goods goods) {
		return goodsMapper.insertSelective(goods);
		
	}

	@Override
	public int updateGoods(Goods goods) {
		
		return goodsMapper.updateByPrimaryKeySelective(goods);
	}

	public List<Goods> findByRecommend(Boolean recommend) {
		int i=0;
		if(recommend == true) {
			i=1;
		}
		return goodsMapper.findByRecommend(i);
	}

	@Override
	public Map<String, Object> findByConditions(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		Integer classesid = (Integer)map.get("classesid");
		String goodsname = (String)map.get("goodsname");
		Integer currentPage = (Integer)map.get("currentPage");
		String orderBy = (String)map.get("orderBy");
		String orderType = (String)map.get("orderType");
		Integer area_id = (Integer)map.get("area_id");
		Integer gs_ids = (Integer)map.get("gs_ids");
		Integer brand_ids = (Integer)map.get("brand_ids");
		String properties = (String)map.get("properties");
		String keyword = (String)map.get("keyword");
		String all_property_status = (String)map.get("all_property_status");
		String detail_property_status = (String)map.get("detail_property_status");
		String store_price_begin = (String)map.get("store_price_begin");
		String store_price_end = (String)map.get("store_price_end");
		BigDecimal priceBegin = null;
		BigDecimal priceEnd = null;
		if(store_price_begin != null && store_price_begin != "") {
			priceBegin = new BigDecimal(store_price_begin);
		}
		if(store_price_end != null && store_price_end != "") {
			priceEnd = new BigDecimal(store_price_end);
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
			PageHelper.startPage(currentPage,2);
		}else {
			PageHelper.startPage(1,2);
		}
		List<Goods> blogList = goodsMapper.findByConditions(list_classesid, goodsname, currentPage, orderBy, orderType, area_id, gs_ids ,brand_ids, properties, keyword,all_property_status,detail_property_status,priceEnd,priceBegin);
		PageInfo<Goods> pageInfo = new PageInfo<Goods>(blogList);
		
		List<Goods> list_goods = pageInfo.getList();
		int PageNum = pageInfo.getPageNum();
		int totalPage = pageInfo.getPages();
		
		result.put("list_goods", list_goods);
		result.put("PageNum", PageNum);
		result.put("totalPage", totalPage);
		
		return result;
	}

	@Override
	public List<Goods> findByNewGoods() {
		return goodsMapper.findByNewGoods();
	}

	@Override
	public List<Goods> findByinventoryGoods() {
		return goodsMapper.findByinventoryGoods();
	}

	
	
}
