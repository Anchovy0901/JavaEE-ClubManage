package com.setu.service;

import com.alibaba.fastjson.JSONObject;
import com.setu.Tool.JsonUtil;
import com.setu.Tool.MybatiesSession;
import com.setu.model.BeanActivity;
import com.setu.model.BeanDepartment;
import com.setu.model.BeanMember;
import com.setu.model.BeanNotice;
import org.apache.ibatis.session.SqlSession;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class NoticeService {
    //创建管理员公告
    public JSONObject createadminNotice(String noticerange, String noticename, String noticecontent) throws Exception {
        JSONObject jsonObject = null;
        SqlSession session = MybatiesSession.getSession();
        Date now = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        if (noticename==null) {
            jsonObject = JsonUtil.errorResult(401, "公告名字不得为空");
        } else if (noticecontent==null) {
            jsonObject = JsonUtil.errorResult(401, "公告内容不得为空");
        } else if (noticerange==null) {
            jsonObject = JsonUtil.errorResult(401, "请选择公告范围");
        } else {
            BeanNotice notice = new BeanNotice();
            notice.setNoticerange(noticerange);
            notice.setNoticename(noticename);
            notice.setNoticecontent(noticecontent);
            notice.setNoticetime(now);
            notice.setAssociationsid(0);
            notice.setDepartmentid(0);
            notice.setNoticestate("审核通过");
            session.insert("insertNotice", notice);
            jsonObject = JsonUtil.NoticeResult(200, notice);
        }

        session.commit();
        return jsonObject;

    }
    //创建部门公告
    public JSONObject createDepartmentNotice( String noticename, String noticecontent, String userid,int associationid) throws Exception {
        JSONObject jsonObject = null;
        SqlSession session = MybatiesSession.getSession();
        Date now = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        BeanMember member =new BeanMember();
        member.setUserid(userid);
        member.setAssociationsid(associationid);
        BeanDepartment department =session.selectOne("selectdepartmentid",member);
        if (noticename==null) {
            jsonObject = JsonUtil.errorResult(401, "公告名字不得为空");
        } else if (noticecontent==null) {
            jsonObject = JsonUtil.errorResult(401, "公告内容不得为空");}
        else if(department==null){
            jsonObject = JsonUtil.errorResult(401, "部门不存在");
        }
        else {
            BeanNotice notice = new BeanNotice();
            notice.setNoticerange("部门");
            notice.setNoticename(noticename);
            notice.setNoticecontent(noticecontent);
            notice.setNoticetime(now);
            notice.setAssociationsid(associationid);
            notice.setDepartmentid(department.getDepartmentid());
            notice.setNoticestate("审核通过");
            session.insert("insertNotice", notice);
            jsonObject = JsonUtil.NoticeResult(200, notice);
        }
        session.commit();
        return jsonObject;
//     return null;
    }

    // 社长创建社团公告
    public JSONObject createNotice(String noticerange, String noticename, String noticecontent, int associationid) throws Exception {
        JSONObject jsonObject = null;
        SqlSession session = MybatiesSession.getSession();
        Date now = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        if (noticename==null) {
            jsonObject = JsonUtil.errorResult(401, "公告名字不得为空");
        } else if (noticecontent==null) {
            jsonObject = JsonUtil.errorResult(401, "公告内容不得为空");
        } else if (noticerange==null) {
            jsonObject = JsonUtil.errorResult(401, "请选择公告范围");
        } else {
            BeanNotice notice = new BeanNotice();
            notice.setNoticerange(noticerange);
            notice.setNoticename(noticename);
            notice.setNoticecontent(noticecontent);
            notice.setNoticetime(now);
            notice.setAssociationsid(associationid);
            notice.setDepartmentid(999999);
            if(noticerange.equals("全校"))
                notice.setNoticestate("等待审核");
            else
                notice.setNoticestate("审核通过");
            session.insert("insertNotice", notice);
            jsonObject = JsonUtil.NoticeResult(200, notice);
        }

        session.commit();
        return jsonObject;
    }

    // 管理员创建全校公告
    public JSONObject createManagerNotice(String noticename, String noticecontent) throws Exception {
        JSONObject jsonObject = null;
        SqlSession session = MybatiesSession.getSession();
        Date now = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        if (noticename==null) {
            jsonObject = JsonUtil.errorResult(401, "公告名字不得为空");
        } else if (noticecontent==null) {
            jsonObject = JsonUtil.errorResult(401, "公告内容不得为空");
        } else {
            BeanNotice notice = new BeanNotice();
            notice.setNoticerange("全校");
            notice.setNoticename(noticename);
            notice.setNoticecontent(noticecontent);
            notice.setNoticetime(now);
            notice.setAssociationsid(0);
            notice.setDepartmentid(999999);
            notice.setNoticestate("审核通过");
            session.insert("insertNotice", notice);
            jsonObject = JsonUtil.NoticeResult(200, notice);
        }

        session.commit();
        return jsonObject;
    }

    //审核公告
    public JSONObject changeNoticeState(int noticeid, Boolean answer) throws Exception {
        BeanNotice notice = new BeanNotice();
        JSONObject jsonObject = null;

        SqlSession session = MybatiesSession.getSession();

        notice = session.selectOne("selectNotice",noticeid);
        if(notice == null){
            jsonObject = JsonUtil.errorResult(401,"公告不存在");
        }
        else {
            if(answer == true){
                notice.setNoticestate("审核通过");
            } else{
                notice.setNoticestate("审核拒绝");
            }
            session.update("updateNotice", notice);
            jsonObject = JsonUtil.NoticeResult(200, notice);
        }

        session.commit();
        return jsonObject;
    }
    // 显示所有公告
    public List<JSONObject> loadNotice() throws Exception {
        List<BeanNotice> noticeList = null;
        JSONObject jsonObject = null;
        List<JSONObject> list = new ArrayList<JSONObject>();

        SqlSession session = MybatiesSession.getSession();
        noticeList = session.selectList("selectAllNotice");

        for(int i=0;i<noticeList.size();i++) {
            jsonObject = JsonUtil.NoticeResult(200, noticeList.get(i));
            list.add(jsonObject);
        }

        session.commit();
        return list;
    }
    //显示全校公告
    public List<JSONObject> loadNoticeBySchool() throws Exception {
        List<BeanNotice> noticeList ;
        JSONObject jsonObject;
        List<JSONObject> list = new ArrayList<JSONObject>();
        Date now = new Date();

        SqlSession session = MybatiesSession.getSession();
        noticeList = session.selectList("selectNoticeBySchool");
        System.out.println(noticeList);
//        System.out.println("11");
        for(int i=0;i<noticeList.size();i++) {
            jsonObject = JsonUtil.NoticeResult(200, noticeList.get(i));
//            System.out.println("22");
            list.add(jsonObject);
//            System.out.println("55");
        }
//        System.out.println("33");
        session.commit();
//        System.out.println("44");
        return list;

    }
    // 显示社团公告
    public List<JSONObject> loadNoticeByAssociation(Integer associationId) throws Exception {
        List<BeanNotice> noticeList;
        JSONObject jsonObject;
        List<JSONObject> list = new ArrayList<JSONObject>();

        SqlSession session = MybatiesSession.getSession();
        noticeList = session.selectList("selectNoticeByAssociationId",associationId);

        for(int i=0;i<noticeList.size();i++) {
            if(noticeList.get(i).getNoticestate().equals("审核通过")) {
                jsonObject = JsonUtil.NoticeResult(200, noticeList.get(i));
                list.add(jsonObject);
            }
        }

        session.commit();
        return list;
    }
    // 显示部门公告
    public List<JSONObject> loadNoticeByDepartment(String userid, int associationid) throws Exception {
        List<BeanNotice> noticeList = null;
        JSONObject jsonObject = null;
        List<JSONObject> list = new ArrayList<JSONObject>();
        SqlSession session = MybatiesSession.getSession();
        BeanMember member =new BeanMember();
        member.setUserid(userid);
        member.setAssociationsid(associationid);
        BeanDepartment department =session.selectOne("selectdepartmentid",member);
        noticeList = session.selectList("selectNoticeByDepartment",department.getDepartmentid());

        for(int i=0;i<noticeList.size();i++) {
            jsonObject = JsonUtil.NoticeResult(200, noticeList.get(i));
            list.add(jsonObject);
        }

        session.commit();
        return list;
    }


}
