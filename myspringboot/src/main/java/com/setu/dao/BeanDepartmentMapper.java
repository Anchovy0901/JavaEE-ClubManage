package com.setu.dao;

import com.setu.model.BeanDepartment;

public interface BeanDepartmentMapper {
    int deleteByPrimaryKey(Integer departmentid);

    int insert(BeanDepartment record);

    int insertSelective(BeanDepartment record);

    BeanDepartment selectByPrimaryKey(Integer departmentid);

    int updateByPrimaryKeySelective(BeanDepartment record);

    int updateByPrimaryKey(BeanDepartment record);
}