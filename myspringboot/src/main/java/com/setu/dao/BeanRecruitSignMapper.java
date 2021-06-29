package com.setu.dao;

import com.setu.model.BeanRecruitSign;

public interface BeanRecruitSignMapper {
    int deleteByPrimaryKey(Integer recruitsignid);

    int insert(BeanRecruitSign record);

    int insertSelective(BeanRecruitSign record);

    BeanRecruitSign selectByPrimaryKey(Integer recruitsignid);

    int updateByPrimaryKeySelective(BeanRecruitSign record);

    int updateByPrimaryKey(BeanRecruitSign record);
}