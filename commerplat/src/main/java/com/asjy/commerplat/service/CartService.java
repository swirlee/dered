package com.asjy.commerplat.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.asjy.commerplat.dao.CartMapper;
import com.asjy.commerplat.dao.GoodsMapper;
import com.asjy.commerplat.model.Cart;
import com.asjy.commerplat.model.Goods;
import com.asjy.commerplat.model.User;
import com.asjy.commerplat.service.Impl.ICartService;


@Service
public class CartService implements ICartService {
	
	@Autowired
	CartMapper cartMapper;
	@Autowired
	GoodsMapper goodsMapper;
	
	/**
	 * 添加购物车
	 */
	@Override
	public Map<String, Object> addInCart(Map<String, Object> map) {
		Integer goodsid = (Integer)map.get("goodsid");
		Integer count0 = (Integer)map.get("count");
		Integer userid = (Integer)map.get("userid");
		Cart cart = new Cart();
		cart.setGoodsid(goodsid);
		cart.setUserid(userid);
		cart.setAddtime(new Date());
		Cart cc = cartMapper.findCartidByUseridAndGoodsid(userid,goodsid);
		Goods goods = goodsMapper.selectByPrimaryKey(goodsid);
		if(cc == null) {
			if (goods.getInventory()<count0) {
				cart.setCount(goods.getInventory());
			}else {
			cart.setCount(count0);
			}
			cartMapper.insertSelective(cart);
		}else {
			if (goods.getInventory()<count0+cc.getCount()) {
				cart.setCount(goods.getInventory());
			}else {
				cart.setCount(count0+cc.getCount());
			}
			cart.setId(cc.getId());
			cartMapper.updateByPrimaryKeySelective(cart);
		}
		
		List<Cart> list_cart = cartMapper.findByUserid(userid);
		Integer count=0;
		Long total_price=(long) 0;
		for (Cart cart2 : list_cart) {
			count+=cart2.getCount();
			total_price+=cart2.getGoods().getSellprice()*cart2.getCount();
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("count", count);
		result.put("total_price", total_price);
		return result;
	}
	
	/**
	 * 通过用户ID查询购物车
	 */
	@Override
	public Map<String, Object> findCartByUserid(Integer userid) {
		Long total_price=(long) 0;
		List<Cart> list_cart = cartMapper.findByUserid(userid);
		Map<String, Object> result = new HashMap<>();
		for (Cart cart : list_cart) {
			total_price+=cart.getGoods().getSellprice()*cart.getCount();
		}
		result.put("total_price", total_price);
		result.put("list_cart", list_cart);
		return result;
	}
	
	/**
	 * 购物车商品数量调整
	 */
	@Override
	public Map<String, Object> adjustCount(Map<String, Object> map1) {
		Map<String, Object> result = new HashMap<>();
		Integer id = (Integer)map1.get("cartid");
		Integer count0 = (Integer)map1.get("count");
		User user = (User)map1.get("user");
		Cart cart = cartMapper.selectByPrimaryKey(id);
		if(cart.getGoods().getInventory()<count0) {
			cart.setCount(cart.getGoods().getInventory());
			result.put("msg", "数量超出库存~");
		}
		if(cart.getGoods().getInventory()<1) {
			cart.setCount(1);
			result.put("msg", "东西刚被其他用户买走，您暂时不能购买！");
		}
		if(cart.getGoods().getInventory()>=count0) {
			cart.setCount(count0);
			result.put("msg", "success");
		}
		cartMapper.updateByPrimaryKey(cart);
		result.put("cart", cart);
		return result;
	}

	@Override
	public int deleteById(Integer id) {
		return cartMapper.deleteByPrimaryKey(id);
	}

	@Override
	public List<Cart> findCartById(String[] cartids) {
		
		return cartMapper.findCartById(cartids);
	}
	
}
