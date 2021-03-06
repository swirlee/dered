package com.asjy.commerplat.model;

import java.math.BigDecimal;

public class Detailorder {
    
    private Integer id;

    private Integer goodsid;

    private Integer orderid;

    private BigDecimal price;

    private Integer count;

    private BigDecimal subtotal;

   private Goods goods; 
   
    public Goods getGoods() {
	return goods;
}

public void setGoods(Goods goods) {
	this.goods = goods;
}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getGoodsid() {
        return goodsid;
    }

    public void setGoodsid(Integer goodsid) {
        this.goodsid = goodsid;
    }

    public Integer getOrderid() {
        return orderid;
    }

    public void setOrderid(Integer orderid) {
        this.orderid = orderid;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }
}