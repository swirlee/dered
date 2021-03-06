package com.asjy.commerplat.service.Impl;

import java.util.List;
import java.util.Map;

import com.asjy.commerplat.model.Cart;

public interface ICartService {

	Map<String, Object> addInCart(Map<String, Object> map);

	Map<String, Object> findCartByUserid(Integer userid);

	Map<String, Object> adjustCount(Map<String, Object> map1);

	int deleteById(Integer id);

	List<Cart> findCartById(String[] cartids);

}
