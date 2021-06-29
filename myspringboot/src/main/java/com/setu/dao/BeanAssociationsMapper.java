package com.setu.dao;

import com.setu.model.BeanAssociations;

public interface BeanAssociationsMapper {
    int deleteByPrimaryKey(Integer associationsid);

    int insert(BeanAssociations record);

    int insertSelective(BeanAssociations record);

    BeanAssociations selectByPrimaryKey(Integer associationsid);

    int updateByPrimaryKeySelective(BeanAssociations record);

    int updateByPrimaryKey(BeanAssociations record);

    BeanAssociations insertAssociation(String name, String type, String introduction,  String leader);
}
