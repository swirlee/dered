package com.asjy.commerplat.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.asjy.commerplat.dao.DetailorderMapper;
import com.asjy.commerplat.dao.GoodsMapper;
import com.asjy.commerplat.dao.OrderMapper;
import com.asjy.commerplat.model.Detailorder;
import com.asjy.commerplat.model.Goods;
import com.asjy.commerplat.model.Order;
import com.asjy.commerplat.service.Impl.IOrderService;

@Service
public class OrderService implements IOrderService {
	
	@Autowired
	OrderMapper orderMapper;
	@Autowired
	DetailorderMapper detailorderMapper;
	@Autowired
	GoodsMapper goodsMapper;
	
	@Override
	public int addOrer(Order order) {
		return orderMapper.insertSelective(order);
	}

	@Override
	public Order findByOrdernumber(String ordernumber) {
		
		return orderMapper.selectByOrdernumber(ordernumber);
	}

	@Override
	public List<Order> findByUserid(Integer id, String ordernumber, String begintime, String endtime, String orderstate) {
		
		return orderMapper.selectByUserid(id, ordernumber, begintime, endtime ,orderstate);
	}

	@Override
	public int deleteOrderById(Integer orderid) {
		detailorderMapper.deleteByOrderId(orderid);
		return orderMapper.deleteByPrimaryKey(orderid);
	}
	
	@Override
	public int updateOrderState(Integer orderid, String orderstate) {
		//查询订单
		Order order = orderMapper.selectByPrimaryKey(orderid);
		//修改订单状态
		order.setOrderstate(orderstate);
		return orderMapper.updateByPrimaryKeySelective(order);
	}
	
	/**
	 * 订单删除，还商品库存
	 */
	@Override
	public int updateOrderState_delete(Integer orderid, String orderstate) {
		//查询订单
		Order order = orderMapper.selectByPrimaryKey(orderid);
		//修改订单状态
		order.setOrderstate(orderstate);
		//还商品库存
		List<Detailorder> list = detailorderMapper.findByOrderid(orderid);
		for (Detailorder detailorder : list) {
			Goods goods = goodsMapper.selectByPrimaryKey(detailorder.getGoodsid());
			goods.setInventory(goods.getInventory()+detailorder.getCount());
			goodsMapper.updateByPrimaryKeySelective(goods);
		}
		return orderMapper.updateByPrimaryKeySelective(order);
	}

	@Override
	public int deleteHavePayOrderById(Integer id) {
		
		return orderMapper.deleteHavePayOrderById(id);
	}
	
	/**
	 * 后台订单管理页面显示
	 */
	@Override
	public List<Order> findAll() {
		
		return orderMapper.findAll();
	}
	
	
	/**
	 * 后台-订单管理-删除订单
	 */
	@Override
	public Boolean deleteOrderById_back(Map<String, Object> map) {
		Integer deleteid = Integer.parseInt((String)map.get("deleteid"));
		Boolean msg = orderMapper.deleteOrderById_back(deleteid);
		return msg;
	}
	
	/**
	 * 后台-订单管理-一键发货
	 */
	@Override
	public Boolean sendGoods(Map<String, Object> map) {
		Integer orderid = Integer.parseInt((String)map.get("orderid"));
		Order order = orderMapper.selectByPrimaryKey_back(orderid);
		order.setOrderstate("已发货");
		int msg = orderMapper.updateByPrimaryKeySelective(order);
		if(msg==1) {
			return true;
		}else {
			return false;
		}
		
	}
	
	/**
	 * 后台-订单管理-根据订单id找订单
	 */
	@Override
	public Order findByOrderid(Integer orderid) {
		
		return orderMapper.selectByPrimaryKey_back(orderid);
	}

	@Override
	public Map<String, Object> getMonth() {
		
		return orderMapper.getMonth();
	}

	@Override
	public List<Order> findByconditions_back(String ordernumber, String begintime, String endtime, String orderstate) {
		return orderMapper.findByconditions_back(ordernumber, begintime, endtime ,orderstate);
	}

	

	

}
