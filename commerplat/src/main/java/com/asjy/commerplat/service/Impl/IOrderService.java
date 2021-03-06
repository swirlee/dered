package com.asjy.commerplat.service.Impl;

import java.util.List;
import java.util.Map;

import com.asjy.commerplat.model.Order;

public interface IOrderService {

	int addOrer(Order order);

	Order findByOrdernumber(String ordernumber);

	List<Order> findByUserid(Integer id, String ordernumber, String begintime, String endtime, String orderstate);

	int deleteOrderById(Integer orderid);

	int updateOrderState(Integer orderid, String orderstate);

	int  deleteHavePayOrderById(Integer id);

	List<Order> findAll();

	Boolean deleteOrderById_back(Map<String, Object> map);

	Boolean sendGoods(Map<String, Object> map);

	Order findByOrderid(Integer orderid);

	Map<String, Object> getMonth();

	List<Order> findByconditions_back(String ordernumber, String begintime, String endtime, String orderstate);

	int updateOrderState_delete(Integer orderid, String orderstate);


	

}
