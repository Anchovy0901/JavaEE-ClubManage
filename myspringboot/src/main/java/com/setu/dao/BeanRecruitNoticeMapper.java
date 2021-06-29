package com.setu.dao;

import com.setu.model.BeanRecruitNotice;

public interface BeanRecruitNoticeMapper {
    int deleteByPrimaryKey(Integer recruitnoticeid);

    int insert(BeanRecruitNotice record);

    int insertSelective(BeanRecruitNotice record);

    BeanRecruitNotice selectByPrimaryKey(Integer recruitnoticeid);

    int updateByPrimaryKeySelective(BeanRecruitNotice record);

    int updateByPrimaryKey(BeanRecruitNotice record);
}