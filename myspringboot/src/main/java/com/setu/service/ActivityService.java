package com.setu.service;

import com.setu.model.BeanActivity;
import com.alibaba.fastjson.JSONObject;
import com.setu.Tool.JsonUtil;
import org.apache.ibatis.session.SqlSession;
import com.setu.Tool.MybatiesSession;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ActivityService{
    // 创建活动
    public JSONObject createActivity(String range, String name, String introduction, Date startTime, Date endTime, Date deadLine, int palaceid, int associationid, int departmentid) throws Exception{
        JSONObject jsonObject = null;

        System.out.println(startTime);
        SqlSession session = MybatiesSession.getSession();
        Date now = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        if(startTime.after(endTime)){
            jsonObject = JsonUtil.errorResult(401, "结束时间不得早于开始时间");
        } else if(startTime.before(now)){
            jsonObject = JsonUtil.errorResult(401, "开始时间不得早于当前时间");
        } else if(deadLine.after(startTime)){
            jsonObject = JsonUtil.errorResult(401, "报名截止时间不得晚于开始时间");
        } else if (!placeAvailability(palaceid,startTime,endTime)){
            jsonObject = JsonUtil.errorResult(401, "场地已被占用");
        }
        else {
            BeanActivity activity = new BeanActivity();
            activity.setActivityrange(range);
            activity.setActivityname(name);
            activity.setActivityintroduction(introduction);
            activity.setActivitystarttime(startTime);
            activity.setActivityendtime(endTime);
            activity.setActivityreleasetime(now);
            activity.setActivitydeadline(deadLine);
            activity.setActivitypalce(palaceid);
            activity.setAssociationsid(associationid);
            if(!range.equals("部门"))
                activity.setDepartmentid(999999);
            else
                activity.setDepartmentid(departmentid);
            activity.setActivitiesapplicationtime(now);
            if(range.equals("全校"))
                activity.setActivitiesapplicationstate("等待审核");
            else
                activity.setActivitiesapplicationstate("审核通过");

            session.insert("insertActivity",activity);
            jsonObject = JsonUtil.ActivityResult(200, activity);
        }

        session.commit();
        return jsonObject;
    }

    // 审核活动
    public JSONObject changeState(int activityid, Boolean answer) throws Exception {
        BeanActivity activity = new BeanActivity();
        JSONObject jsonObject = null;

        SqlSession session = MybatiesSession.getSession();
        Date now = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式

        activity = session.selectOne("selectActivity",activityid);
        if(activity == null){
            jsonObject = JsonUtil.errorResult(401,"活动不存在");
        }
        else if (answer == true && !placeAvailability(activity.getActivitypalce(),activity.getActivitystarttime(),activity.getActivityendtime())){
            jsonObject = JsonUtil.errorResult(401, "场地已被占用");
        }
        else {
            if(answer == true){
                activity.setActivityreleasetime(now);
                activity.setActivitiesapplicationstate("审核通过");
            } else{
                activity.setActivitiesapplicationstate("审核拒绝");
            }

            session.update("updateActivity", activity);
            jsonObject = JsonUtil.ActivityResult(200, activity);
        }

        session.commit();
        return jsonObject;
    }

    // 管理员显示活动（等待审核-1、审核记录-2）
    public List<JSONObject> loadActivity(int type) throws Exception {
        List<BeanActivity> activityList = null;
        JSONObject jsonObject = null;
        List<JSONObject> list = new ArrayList<JSONObject>();

        SqlSession session = MybatiesSession.getSession();
        activityList = session.selectList("selectAllActivity");

        for(int i=0;i<activityList.size();i++) {
            if(type == 1 && activityList.get(i).getActivitiesapplicationstate().equals("等待审核")) {
                jsonObject = JsonUtil.ActivityResult(200, activityList.get(i));
                list.add(jsonObject);
            }
            else if(type == 2 && !activityList.get(i).getActivitiesapplicationstate().equals("等待审核")){
                jsonObject = JsonUtil.ActivityResult(200, activityList.get(i));
                list.add(jsonObject);
            }
        }

        session.commit();
        return list;
    }

    //显示全校活动
    public List<JSONObject> loadActivityBySchool() throws Exception {
        List<BeanActivity> activityList;
        JSONObject jsonObject;
        List<JSONObject> list = new ArrayList<JSONObject>();
        Date now = new Date();

        SqlSession session = MybatiesSession.getSession();
        activityList = session.selectList("selectActivityByState","审核通过");
        for(int i=0;i<activityList.size();i++) {
            if(activityList.get(i).getActivityrange().equals("全校") && activityList.get(i).getActivityendtime().after(now)) {
                jsonObject = JsonUtil.ActivityResult(200, activityList.get(i));
                list.add(jsonObject);
            }
        }

        session.commit();
        return list;
    }

    // 显示社团活动
    public List<JSONObject> loadActivityByAssociation(int associationId) throws Exception {
        List<BeanActivity> activityList = null;
        JSONObject jsonObject = null;
        List<JSONObject> list = new ArrayList<JSONObject>();
        Date now = new Date();

        SqlSession session = MybatiesSession.getSession();
        activityList = session.selectList("selectActivityByAssociation",associationId);

        for(int i=0;i<activityList.size();i++) {
//            if (post.equals("社长")) {
//                if (!activityList.get(i).getActivityrange().equals("全校") && activityList.get(i).getActivityendtime().after(now)) {
//                    jsonObject = JsonUtil.ActivityResult(200, activityList.get(i));
//                    list.add(jsonObject);
//                }
//            }
//            else {
                if (activityList.get(i).getActivityrange().equals("社团")) {
                    if (activityList.get(i).getActivityendtime().after(now)) {
                        jsonObject = JsonUtil.ActivityResult(200, activityList.get(i));
                        list.add(jsonObject);
                    }
                }
//            }
        }

        session.commit();
        return list;
    }

    // 模糊查询活动
    public List<JSONObject> searchActivity(String keyword) throws Exception {
        List<BeanActivity> activityList;
        JSONObject jsonObject;
        List<JSONObject> list = new ArrayList<JSONObject>();
        Date now = new Date();

        SqlSession session = MybatiesSession.getSession();
        activityList = session.selectList("selectActivityByState","审核通过");
        for(int i=0;i<activityList.size();i++) {
            if(activityList.get(i).getActivityrange().equals("全校") && activityList.get(i).getActivityendtime().after(now)) {
                if (activityList.get(i).getActivityname().contains(keyword)) {
                    jsonObject = JsonUtil.ActivityResult(200, activityList.get(i));
                    list.add(jsonObject);
                }
            }
        }

        session.commit();
        return list;
    }

    // 判断场地是否可用
    public Boolean placeAvailability(int placeId, Date startTime, Date endTime) throws Exception {
        List<BeanActivity> activityList = null;
        List<BeanActivity> activityList1 = new ArrayList <BeanActivity>();
        BeanActivity activity = null;
        Date now = new Date();

        SqlSession session = MybatiesSession.getSession();
        activityList = session.selectList("selectActivityByPlace",placeId);

        int sum = 0;
        for(int i=0;i<activityList.size();i++) {
            activity = activityList.get(i);
            if (activity.getActivitiesapplicationstate().equals("审核通过")) {
                activityList1.add(activity);
            }
        }

        for(int i=0;i<activityList1.size();i++) {
            activity = activityList1.get(i);
            if (activity.getActivitystarttime().after(endTime) || activity.getActivityendtime().before(startTime)) {
                sum = sum + 1;
            }
        }

        if(sum == activityList1.size())
            return true;
        else
            return false;
    }

    public static void main(String[] args) throws Exception {
        ActivityService a = new ActivityService();
        Date date = new Date();
//        JSONObject zs = a.createActivity("全校","football","222",date ,date ,date ,date ,1,2,2);
//        JSONObject zs = a.register("311","22","1233","1233","nan","yixue","1702","13429590334");
//        JSONObject zs = a.changeState(2,true);
//        JSONObject zs = (JSONObject) a.loadActivityBySchool();
//        System.out.println(zs);
    }
}
