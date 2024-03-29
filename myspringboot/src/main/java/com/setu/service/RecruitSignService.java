package com.setu.service;

import com.alibaba.fastjson.JSONObject;
import com.setu.Tool.JsonUtil;
import com.setu.Tool.MybatiesSession;
import com.setu.model.BeanAssociations;
import com.setu.model.BeanMember;
import com.setu.model.BeanRecruitSign;
import org.apache.ibatis.session.SqlSession;

import java.text.ParseException;
import java.util.*;
import java.text.SimpleDateFormat;

public class RecruitSignService {
    //创建招新申请表(招新报名)
    public JSONObject insertrecruit(String userid, int associationsId,String content,String recruitNoticeStartTime) throws ParseException {
        JSONObject jsonObject = null;
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        Date startTime = df.parse(recruitNoticeStartTime);
        SqlSession session = MybatiesSession.getSession();
        Date now = new Date();

        List<BeanMember> memberList;
        memberList = session.selectList("selectMemberByUid",userid);
        int sum = 0;
        for(int i=0;i<memberList.size();i++){
            if(memberList.get(i).getAssociationsid() == associationsId){
                sum++;
            }
        }

        BeanAssociations association = new BeanAssociations();
        association = session.selectOne("selectAssociations",associationsId);
        List<BeanRecruitSign> sign1 = null;
        sign1 = session.selectList("selectResult",userid);
        for(int i = 0; i < sign1.size(); i++){
            BeanRecruitSign sign2 = null;
            sign2 = sign1.get(i);
            if(sign2.getAssociationsid().equals(associationsId) && sign2.getRecruitSignApplicationState().equals("等待审核")){
                jsonObject = JsonUtil.errorResult(401,"您已提交过招新表");
                return jsonObject;
            }
        }
        if("".equals(associationsId)){
            jsonObject = JsonUtil.errorResult(401,"请选择社团");
        }else if(content == null|| content.equals("")){
            jsonObject = JsonUtil.errorResult(401,"个人介绍不能为空");
        }else if(sum > 0){
            jsonObject = JsonUtil.errorResult(401,"您已经是该社社员");
        }else if(now.before(startTime)) {
            jsonObject = JsonUtil.errorResult(401, "招新尚未开始");
        }else if(association == null) {
            jsonObject = JsonUtil.errorResult(401, "社团不存在");
        }
        else{
            BeanRecruitSign recruitSign = new BeanRecruitSign();
            recruitSign.setRecruitsigntime(now);
            recruitSign.setUserid(userid);
            recruitSign.setAssociationsid(associationsId);
            recruitSign.setRecruitSignContent(content);
            recruitSign.setRecruitSignApplicationState("等待审核");

            session.insert("insertRecruit",recruitSign);
            jsonObject = JsonUtil.RecruitSignResult(200, recruitSign);
        }
        session.commit();
        return jsonObject;
    }

    //审核招新申请表
    public JSONObject changeState(int recruitSignId, String recruitSignApplicationState) throws Exception {
        BeanRecruitSign recruitSign = new BeanRecruitSign();
        JSONObject jsonObject = null;

        SqlSession session = MybatiesSession.getSession();

        BeanRecruitSign member = null;
        member = session.selectOne("selectMemberBySignid",recruitSignId);
        recruitSign = session.selectOne("selectRecruitSignBySignid",recruitSignId);
        if(member != null){
            jsonObject = JsonUtil.errorResult(401,"该用户已是本社社员");
        }else if(recruitSign == null){
            jsonObject = JsonUtil.errorResult(401,"招新申请表不存在");
        }else if(!recruitSign.getRecruitSignApplicationState().equals("等待审核")){
            jsonObject = JsonUtil.errorResult(401,"已审核");
        }
        else {
            if(recruitSignApplicationState.equals("审核通过")){
                //审核通过后，将用户插入社员member表中
                //社团人员number++
                recruitSign = session.selectOne("selectRecruitSignBySignid",recruitSignId);
                recruitSign.setRecruitSignApplicationState("审核通过");
                BeanMember newMember = new BeanMember();
                newMember.setMemberpost("社员");
                newMember.setMembertime(new Date());
                newMember.setMemberintroduction(recruitSign.getRecruitSignContent());
                newMember.setUserid(recruitSign.getUserid());
                newMember.setAssociationsid(recruitSign.getAssociationsid());
                newMember.setDepartmentid(999999);

                session.insert("insertMember",newMember);

                BeanAssociations associations = new BeanAssociations();
                associations = session.selectOne("selectAssociations",recruitSign.getAssociationsid());
                associations.setAssociationsnumber(associations.getAssociationsnumber()+1);
                session.update("updateByAssociationsId",associations);
                jsonObject = JsonUtil.MemberResult(200, newMember);
                session.commit();
            } else{
                recruitSign.setRecruitSignApplicationState("审核拒绝");
            }
            session.update("updateRecruitSign", recruitSign);
            jsonObject = JsonUtil.RecruitSignResult(200, recruitSign);
        }
        session.commit();
        return jsonObject;
    }

    //社长分配部门
    public JSONObject changeDepartment(int memberid,int departmentId) throws Exception {
        JSONObject jsonObject = null;

        SqlSession session = MybatiesSession.getSession();
        BeanMember oldMember = null;
        oldMember = session.selectOne("selectMemberByMid",memberid);
        if("".equals(departmentId)){
            jsonObject = JsonUtil.errorResult(401,"请选择部门");
            return jsonObject;
        }else if(oldMember.getDepartmentid().equals(departmentId)){
            jsonObject = JsonUtil.errorResult(401,"该社员已在该部门");
            return jsonObject;
        }
        oldMember.setDepartmentid(departmentId);

        session.update("updateMemberDepartment",oldMember);
        jsonObject = JsonUtil.MemberResult(200, oldMember);

        session.commit();
        return jsonObject;
    }

    //显示所有招新申请表
    public List<JSONObject> loadAllRecruitSign() throws Exception {
        List<BeanRecruitSign> recruitSignList = null;
        JSONObject jsonObject = null;
        List<JSONObject> list = new ArrayList<JSONObject>();

        SqlSession session = MybatiesSession.getSession();
        recruitSignList = session.selectList("selectAllRecruitSign");

        for(int i = 0; i < recruitSignList.size(); i++){
            jsonObject = JsonUtil.RecruitSignResult(200, recruitSignList.get(i));
            list.add(jsonObject);
        }
        session.commit();
        return list;
    }

    //显示该社团的所有申请表(社长查询
    public List<JSONObject> loadAllRecruitSignByAssociationsId(Integer associationsId) throws Exception {
        List<BeanRecruitSign> recruitSignList = null;
        JSONObject jsonObject = new JSONObject();
        List<JSONObject> list = new ArrayList<JSONObject>();

        SqlSession session = MybatiesSession.getSession();
        recruitSignList = session.selectList("selectRecruitSignByAssociationsId",associationsId);
        if(recruitSignList == null){
            jsonObject = JsonUtil.errorResult(401,"无招新申请表");
        }
        else {
            for (int i = 0; i < recruitSignList.size(); i++) {
                if(recruitSignList.get(i).getRecruitSignApplicationState().equals("等待审核")) {
                    jsonObject = JsonUtil.RecruitSignResult(200, recruitSignList.get(i));
                    list.add(jsonObject);
                }
            }
        }
        session.commit();
        return list;
    }

    public static void main(String[] args) throws Exception {
        RecruitSignService a = new RecruitSignService();
//        JSONObject zs = a.insertrecruit("5",1,"ugyuih");
//        System.out.println(zs);
//      List<JSONObject> test1 = a.loadAllRecruitSignByAssociation("2");
//        List<JSONObject> test2 = a.loadAllRecruitSign();
//        System.out.println(test1);
//        System.out.println(test2);
        JSONObject test3 = a.changeState(8,"审核通过");
        System.out.println(test3);
//        JSONObject test4 = a.changeDepartment(14,1);
//        System.out.println(test4);

    }
}
