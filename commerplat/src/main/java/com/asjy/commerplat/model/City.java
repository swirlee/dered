package com.asjy.commerplat.model;

public class City {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_city.id
     *
     * @mbggenerated
     */
    private Integer id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_city.cityname
     *
     * @mbggenerated
     */
    private String cityname;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_city.pid
     *
     * @mbggenerated
     */
    private Integer pid;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_city.id
     *
     * @return the value of tb_city.id
     *
     * @mbggenerated
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_city.id
     *
     * @param id the value for tb_city.id
     *
     * @mbggenerated
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_city.cityname
     *
     * @return the value of tb_city.cityname
     *
     * @mbggenerated
     */
    public String getCityname() {
        return cityname;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_city.cityname
     *
     * @param cityname the value for tb_city.cityname
     *
     * @mbggenerated
     */
    public void setCityname(String cityname) {
        this.cityname = cityname == null ? null : cityname.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_city.pid
     *
     * @return the value of tb_city.pid
     *
     * @mbggenerated
     */
    public Integer getPid() {
        return pid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_city.pid
     *
     * @param pid the value for tb_city.pid
     *
     * @mbggenerated
     */
    public void setPid(Integer pid) {
        this.pid = pid;
    }
}