package com.asjy.commerplat.model;

import java.util.Date;

public class Address {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_address.id
     *
     * @mbggenerated
     */
    private Integer id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_address.addtime
     *
     * @mbggenerated
     */
    private Date addtime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_address.userid
     *
     * @mbggenerated
     */
    private Integer userid;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_address.provinceid
     *
     * @mbggenerated
     */
    private Integer provinceid;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_address.cityid
     *
     * @mbggenerated
     */
    private Integer cityid;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_address.areaid
     *
     * @mbggenerated
     */
    private Integer areaid;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_address.address
     *
     * @mbggenerated
     */
    private String address;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_address.zipcode
     *
     * @mbggenerated
     */
    private String zipcode;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_address.receiver
     *
     * @mbggenerated
     */
    private String receiver;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_address.tel
     *
     * @mbggenerated
     */
    private String tel;
    


	private City province;
    private City city;
    private City area;

    
    public City getProvince() {
		return province;
	}

	public void setProvince(City province) {
		this.province = province;
	}

	public City getCity() {
		return city;
	}

	public void setCity(City city) {
		this.city = city;
	}

	public City getArea() {
		return area;
	}

	public void setArea(City area) {
		this.area = area;
	}
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_address.defaultaddress
     *
     * @mbggenerated
     */
    private Boolean defaultaddress;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_address.id
     *
     * @return the value of tb_address.id
     *
     * @mbggenerated
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_address.id
     *
     * @param id the value for tb_address.id
     *
     * @mbggenerated
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_address.addtime
     *
     * @return the value of tb_address.addtime
     *
     * @mbggenerated
     */
    public Date getAddtime() {
        return addtime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_address.addtime
     *
     * @param addtime the value for tb_address.addtime
     *
     * @mbggenerated
     */
    public void setAddtime(Date addtime) {
        this.addtime = addtime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_address.userid
     *
     * @return the value of tb_address.userid
     *
     * @mbggenerated
     */
    public Integer getUserid() {
        return userid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_address.userid
     *
     * @param userid the value for tb_address.userid
     *
     * @mbggenerated
     */
    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_address.provinceid
     *
     * @return the value of tb_address.provinceid
     *
     * @mbggenerated
     */
    public Integer getProvinceid() {
        return provinceid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_address.provinceid
     *
     * @param provinceid the value for tb_address.provinceid
     *
     * @mbggenerated
     */
    public void setProvinceid(Integer provinceid) {
        this.provinceid = provinceid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_address.cityid
     *
     * @return the value of tb_address.cityid
     *
     * @mbggenerated
     */
    public Integer getCityid() {
        return cityid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_address.cityid
     *
     * @param cityid the value for tb_address.cityid
     *
     * @mbggenerated
     */
    public void setCityid(Integer cityid) {
        this.cityid = cityid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_address.areaid
     *
     * @return the value of tb_address.areaid
     *
     * @mbggenerated
     */
    public Integer getAreaid() {
        return areaid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_address.areaid
     *
     * @param areaid the value for tb_address.areaid
     *
     * @mbggenerated
     */
    public void setAreaid(Integer areaid) {
        this.areaid = areaid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_address.address
     *
     * @return the value of tb_address.address
     *
     * @mbggenerated
     */
    public String getAddress() {
        return address;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_address.address
     *
     * @param address the value for tb_address.address
     *
     * @mbggenerated
     */
    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_address.zipcode
     *
     * @return the value of tb_address.zipcode
     *
     * @mbggenerated
     */
    public String getZipcode() {
        return zipcode;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_address.zipcode
     *
     * @param zipcode the value for tb_address.zipcode
     *
     * @mbggenerated
     */
    public void setZipcode(String zipcode) {
        this.zipcode = zipcode == null ? null : zipcode.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_address.receiver
     *
     * @return the value of tb_address.receiver
     *
     * @mbggenerated
     */
    public String getReceiver() {
        return receiver;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_address.receiver
     *
     * @param receiver the value for tb_address.receiver
     *
     * @mbggenerated
     */
    public void setReceiver(String receiver) {
        this.receiver = receiver == null ? null : receiver.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_address.tel
     *
     * @return the value of tb_address.tel
     *
     * @mbggenerated
     */
    public String getTel() {
        return tel;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_address.tel
     *
     * @param tel the value for tb_address.tel
     *
     * @mbggenerated
     */
    public void setTel(String tel) {
        this.tel = tel == null ? null : tel.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_address.defaultaddress
     *
     * @return the value of tb_address.defaultaddress
     *
     * @mbggenerated
     */
    public Boolean getDefaultaddress() {
        return defaultaddress;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_address.defaultaddress
     *
     * @param defaultaddress the value for tb_address.defaultaddress
     *
     * @mbggenerated
     */
    public void setDefaultaddress(Boolean defaultaddress) {
        this.defaultaddress = defaultaddress;
    }
}