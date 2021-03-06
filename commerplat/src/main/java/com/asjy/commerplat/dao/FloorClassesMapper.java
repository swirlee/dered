package com.asjy.commerplat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.asjy.commerplat.model.FloorClasses;

@Mapper
public interface FloorClassesMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_floor_classes
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_floor_classes
     *
     * @mbggenerated
     */
    int insert(FloorClasses record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_floor_classes
     *
     * @mbggenerated
     */
    int insertSelective(FloorClasses record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_floor_classes
     *
     * @mbggenerated
     */
    FloorClasses selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_floor_classes
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(FloorClasses record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tb_floor_classes
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(FloorClasses record);

	int deleteByFloord(Integer id);

	int ajaxdeleteByFloorids(List<Integer> ids);

	int insertArrClasses(@Param("arr") Integer[] arr, @Param("id")Integer id);

	List<FloorClassesMapper> findByClasses(Integer classid);
}