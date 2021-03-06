package com.asjy.commerplat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.asjy.commerplat.model.Address;

@Mapper
public interface AddressMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_address
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_address
     *
     * @mbggenerated
     */
    int insert(Address record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_address
     *
     * @mbggenerated
     */
    int insertSelective(Address record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_address
     *
     * @mbggenerated
     */
    Address selectByPrimaryKey(Integer id);

    
    Address selectByaddressid(Integer id);

    
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_address
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(Address record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_address
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(Address record);

	List<Address> selectByUserid(Integer userid);

	Address findDefaultaddressByUserid(Integer userid);

	void updateDefaultAddressToZero(Integer userid);

	int updateDefaultAddress(Integer id);
}