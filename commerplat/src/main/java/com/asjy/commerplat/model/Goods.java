package com.asjy.commerplat.model;

import java.util.Date;
import java.util.List;

public class Goods {
    
    private Integer id;
    private Date addtime;
    private String goodsname;
    private Integer classid;
    private Integer brandid;
    private Long sellprice;
    private Long originalprice;
    private Integer inventory;
    private Integer salevolume;
    private Integer clicks;
    private String state;
    private String path;
    private Long volume;
    private Long weight;
    private String goodsnumber;
    private Boolean recommend;
    private String details;
	private List<Goods> list_goods;
	private String classname;
	private String brandname;
	private List<String> paths;

    public List<String> getPaths() {
		return paths;
	}

	public void setPaths(List<String> paths) {
		this.paths = paths;
	}

	public String getClassname() {
		return classname;
	}

	public void setClassname(String classname) {
		this.classname = classname;
	}

	public String getBrandname() {
		return brandname;
	}

	public void setBrandname(String brandname) {
		this.brandname = brandname;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getAddtime() {
        return addtime;
    }

    public void setAddtime(Date addtime) {
        this.addtime = addtime;
    }

    public String getGoodsname() {
        return goodsname;
    }

    public void setGoodsname(String goodsname) {
        this.goodsname = goodsname == null ? null : goodsname.trim();
    }

    
    public Integer getClassid() {
        return classid;
    }

    
    public void setClassid(Integer classid) {
        this.classid = classid;
    }

    public Integer getBrandid() {
        return brandid;
    }

    public void setBrandid(Integer brandid) {
        this.brandid = brandid;
    }

    public Long getSellprice() {
        return sellprice;
    }

  
    public void setSellprice(Long sellprice) {
        this.sellprice = sellprice;
    }

    public Long getOriginalprice() {
        return originalprice;
    }

    public void setOriginalprice(Long originalprice) {
        this.originalprice = originalprice;
    }

    public Integer getInventory() {
        return inventory;
    }

    public void setInventory(Integer inventory) {
        this.inventory = inventory;
    }

    public Integer getSalevolume() {
        return salevolume;
    }

    public void setSalevolume(Integer salevolume) {
        this.salevolume = salevolume;
    }

    public Integer getClicks() {
        return clicks;
    }

    public void setClicks(Integer clicks) {
        this.clicks = clicks;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path == null ? null : path.trim();
    }

    public Long getVolume() {
        return volume;
    }

    public void setVolume(Long volume) {
        this.volume = volume;
    }

    public Long getWeight() {
        return weight;
    }

    public void setWeight(Long weight) {
        this.weight = weight;
    }

    public String getGoodsnumber() {
        return goodsnumber;
    }

   
    public void setGoodsnumber(String goodsnumber) {
        this.goodsnumber = goodsnumber == null ? null : goodsnumber.trim();
    }

  
    public Boolean getRecommend() {
        return recommend;
    }

    public void setRecommend(Boolean recommend) {
        this.recommend = recommend;
    }

   
    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details == null ? null : details.trim();
    }
    
    public List<Goods> getList_goods() {
		return list_goods;
	}

	public void setList_goods(List<Goods> list_goods) {
		this.list_goods = list_goods;
	}

	
}