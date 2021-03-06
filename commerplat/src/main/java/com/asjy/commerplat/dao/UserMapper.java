package com.asjy.commerplat.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.asjy.commerplat.model.User;

@Mapper
public interface UserMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_user
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_user
     *
     * @mbggenerated
     */
    int insert(User record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_user
     *
     * @mbggenerated
     */
    int insertSelective(User record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_user
     *
     * @mbggenerated
     */
    User selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_user
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(User record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_user
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(User record);

	int insert(@Param("username")String username, @Param("password")String password, @Param("phone")String phone, @Param("email")String email, @Param("realname")String realname, @Param("sex")String sex,
			@Param("authority")Boolean authority,@Param("addtime")Date addtime);

	List<User> findAll();

	User findbyid(int id);

	User findbyusernameandpassword(@Param("username")String username, @Param("password")String password);

	User findByValidate(@Param("validate")String validate,@Param("ziduan")String ziduan);
}