package com.asjy.commerplat.model;

import java.util.Date;

public class Brand {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_brand.id
     *
     * @mbggenerated
     */
    private Integer id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_brand.addtime
     *
     * @mbggenerated
     */
    private Date addtime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_brand.brandname
     *
     * @mbggenerated
     */
    private String brandname;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_brand.path
     *
     * @mbggenerated
     */
    private String path;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_brand.seq
     *
     * @mbggenerated
     */
    private Integer seq;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_brand.recommend
     *
     * @mbggenerated
     */
    private Boolean recommend;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_brand.id
     *
     * @return the value of tb_brand.id
     *
     * @mbggenerated
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_brand.id
     *
     * @param id the value for tb_brand.id
     *
     * @mbggenerated
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_brand.addtime
     *
     * @return the value of tb_brand.addtime
     *
     * @mbggenerated
     */
    public Date getAddtime() {
        return addtime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_brand.addtime
     *
     * @param addtime the value for tb_brand.addtime
     *
     * @mbggenerated
     */
    public void setAddtime(Date addtime) {
        this.addtime = addtime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_brand.brandname
     *
     * @return the value of tb_brand.brandname
     *
     * @mbggenerated
     */
    public String getBrandname() {
        return brandname;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_brand.brandname
     *
     * @param brandname the value for tb_brand.brandname
     *
     * @mbggenerated
     */
    public void setBrandname(String brandname) {
        this.brandname = brandname == null ? null : brandname.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_brand.path
     *
     * @return the value of tb_brand.path
     *
     * @mbggenerated
     */
    public String getPath() {
        return path;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_brand.path
     *
     * @param path the value for tb_brand.path
     *
     * @mbggenerated
     */
    public void setPath(String path) {
        this.path = path == null ? null : path.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_brand.seq
     *
     * @return the value of tb_brand.seq
     *
     * @mbggenerated
     */
    public Integer getSeq() {
        return seq;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_brand.seq
     *
     * @param seq the value for tb_brand.seq
     *
     * @mbggenerated
     */
    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_brand.recommend
     *
     * @return the value of tb_brand.recommend
     *
     * @mbggenerated
     */
    public Boolean getRecommend() {
        return recommend;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_brand.recommend
     *
     * @param recommend the value for tb_brand.recommend
     *
     * @mbggenerated
     */
    public void setRecommend(Boolean recommend) {
        this.recommend = recommend;
    }
}