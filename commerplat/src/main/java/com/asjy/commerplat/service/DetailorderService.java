package com.asjy.commerplat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.asjy.commerplat.dao.DetailorderMapper;
import com.asjy.commerplat.dao.GoodsMapper;
import com.asjy.commerplat.model.Detailorder;
import com.asjy.commerplat.model.Goods;
import com.asjy.commerplat.service.Impl.IDetailorderService;

@Service
public class DetailorderService implements IDetailorderService{
	
	@Autowired
	DetailorderMapper detailorderMapper;
	@Autowired
	GoodsMapper goodsMapper;
	
	@Override
	public int add(Detailorder detailorder) {
		
		return detailorderMapper.insertSelective(detailorder);
	}

	@Override
	public List<Detailorder> findByOrderid(Integer orderid) {
		 List<Detailorder> list_detailorder = detailorderMapper.findByOrderid(orderid);
		 for (Detailorder detailorder : list_detailorder) {
			 Goods goods = goodsMapper.selectByPrimaryKey(detailorder.getGoodsid());
			 goods.setInventory(goods.getInventory()+detailorder.getCount());
			 goodsMapper.updateByPrimaryKeySelective(goods);
		}
		return null;
	}

}
