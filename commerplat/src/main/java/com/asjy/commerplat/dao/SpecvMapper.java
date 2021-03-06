package com.asjy.commerplat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.asjy.commerplat.model.Specv;
@Mapper
public interface SpecvMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_specv
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_specv
     *
     * @mbggenerated
     */
    int insert(Specv record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_specv
     *
     * @mbggenerated
     */
    int insertSelective(Specv record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_specv
     *
     * @mbggenerated
     */
    Specv selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_specv
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(Specv record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_specv
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(Specv record);

	List<Specv> findByPid(Integer pid);

	void deleteByList(List<Integer> list_delids);

	int deleteByspecid(Integer specid);
}