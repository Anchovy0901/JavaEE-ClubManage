package com.setu.dao;

import com.setu.model.BeanLog;

public interface BeanLogMapper {
    int deleteByPrimaryKey(Integer logid);

    int insert(BeanLog record);

    int insertSelective(BeanLog record);

    BeanLog selectByPrimaryKey(Integer logid);

    int updateByPrimaryKeySelective(BeanLog record);

    int updateByPrimaryKey(BeanLog record);
}