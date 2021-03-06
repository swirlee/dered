package com.asjy.commerplat.model;

import java.util.Date;
import java.util.List;

public class Floor {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_floor.id
     *
     * @mbggenerated
     */
    private Integer id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_floor.addtime
     *
     * @mbggenerated
     */
    private Date addtime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_floor.floorname
     *
     * @mbggenerated
     */
    private String floorname;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_floor.pid
     *
     * @mbggenerated
     */
    private Integer pid;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_floor.seq
     *
     * @mbggenerated
     */
    private Integer seq;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_floor.display
     *
     * @mbggenerated
     */
    private Boolean display;

    private List<Floor> list_floor;
    private List<Goods> list_goods;
    private List<Classes> list_classes;
    private List<Goods> list_goods2;
    
    
    
    
    
    
    public List<Goods> getList_goods2() {
		return list_goods2;
	}

	public void setList_goods2(List<Goods> list_goods2) {
		this.list_goods2 = list_goods2;
	}

	public List<Goods> getList_goods() {
		return list_goods;
	}

	public void setList_goods(List<Goods> list_goods) {
		this.list_goods = list_goods;
	}

	public List<Classes> getList_classes() {
		return list_classes;
	}

	public void setList_classes(List<Classes> list_classes) {
		this.list_classes = list_classes;
	}

	public List<Floor> getList_floor() {
		return list_floor;
	}

	public void setList_floor(List<Floor> list_floor) {
		this.list_floor = list_floor;
	}

	public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_floor.id
     *
     * @param id the value for tb_floor.id
     *
     * @mbggenerated
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_floor.addtime
     *
     * @return the value of tb_floor.addtime
     *
     * @mbggenerated
     */
    public Date getAddtime() {
        return addtime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_floor.addtime
     *
     * @param addtime the value for tb_floor.addtime
     *
     * @mbggenerated
     */
    public void setAddtime(Date addtime) {
        this.addtime = addtime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_floor.floorname
     *
     * @return the value of tb_floor.floorname
     *
     * @mbggenerated
     */
    public String getFloorname() {
        return floorname;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_floor.floorname
     *
     * @param floorname the value for tb_floor.floorname
     *
     * @mbggenerated
     */
    public void setFloorname(String floorname) {
        this.floorname = floorname == null ? null : floorname.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_floor.pid
     *
     * @return the value of tb_floor.pid
     *
     * @mbggenerated
     */
    public Integer getPid() {
        return pid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_floor.pid
     *
     * @param pid the value for tb_floor.pid
     *
     * @mbggenerated
     */
    public void setPid(Integer pid) {
        this.pid = pid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_floor.seq
     *
     * @return the value of tb_floor.seq
     *
     * @mbggenerated
     */
    public Integer getSeq() {
        return seq;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_floor.seq
     *
     * @param seq the value for tb_floor.seq
     *
     * @mbggenerated
     */
    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_floor.display
     *
     * @return the value of tb_floor.display
     *
     * @mbggenerated
     */
    public Boolean getDisplay() {
        return display;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_floor.display
     *
     * @param display the value for tb_floor.display
     *
     * @mbggenerated
     */
    public void setDisplay(Boolean display) {
        this.display = display;
    }
}