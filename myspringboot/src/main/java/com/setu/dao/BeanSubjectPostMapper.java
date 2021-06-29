package com.setu.dao;

import com.setu.model.BeanSubjectPost;

public interface BeanSubjectPostMapper {
    int deleteByPrimaryKey(Integer subjectpostid);

    int insert(BeanSubjectPost record);

    int insertSelective(BeanSubjectPost record);

    BeanSubjectPost selectByPrimaryKey(Integer subjectpostid);

    int updateByPrimaryKeySelective(BeanSubjectPost record);

    int updateByPrimaryKey(BeanSubjectPost record);
}