package com.setu.dao;

import com.setu.model.BeanActivitySign;

public interface BeanActivitySignMapper {
    int deleteByPrimaryKey(Integer activitysignid);

    int insert(BeanActivitySign record);

    int insertSelective(BeanActivitySign record);

    BeanActivitySign selectByPrimaryKey(Integer activitysignid);

    int updateByPrimaryKeySelective(BeanActivitySign record);

    int updateByPrimaryKey(BeanActivitySign record);
}