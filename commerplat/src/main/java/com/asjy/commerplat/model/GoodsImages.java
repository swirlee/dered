package com.asjy.commerplat.model;

public class GoodsImages {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_goods_images.id
     *
     * @mbggenerated
     */
    private Integer id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_goods_images.goodsid
     *
     * @mbggenerated
     */
    private Integer goodsid;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_goods_images.path
     *
     * @mbggenerated
     */
    private String path;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_goods_images.id
     *
     * @return the value of tb_goods_images.id
     *
     * @mbggenerated
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_goods_images.id
     *
     * @param id the value for tb_goods_images.id
     *
     * @mbggenerated
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_goods_images.goodsid
     *
     * @return the value of tb_goods_images.goodsid
     *
     * @mbggenerated
     */
    public Integer getGoodsid() {
        return goodsid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_goods_images.goodsid
     *
     * @param goodsid the value for tb_goods_images.goodsid
     *
     * @mbggenerated
     */
    public void setGoodsid(Integer goodsid) {
        this.goodsid = goodsid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_goods_images.path
     *
     * @return the value of tb_goods_images.path
     *
     * @mbggenerated
     */
    public String getPath() {
        return path;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_goods_images.path
     *
     * @param path the value for tb_goods_images.path
     *
     * @mbggenerated
     */
    public void setPath(String path) {
        this.path = path == null ? null : path.trim();
    }
}