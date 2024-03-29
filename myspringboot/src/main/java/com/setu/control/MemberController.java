package com.setu.control;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.setu.service.MemberService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
@CrossOrigin
@ResponseBody
public class MemberController {
    //显示成员信息
    @RequestMapping(value = "/member", method = RequestMethod.POST)
    public JSONObject showMember(@RequestParam("userId") String userId,@RequestParam("associationId") Integer associationId) throws Exception {
        MemberService memberService = new MemberService();
        String member = JSON.toJSONString(memberService.selectMember(userId,associationId));
        JSONArray array= JSONArray.parseArray(member);
        JSONObject result = new JSONObject();
        result.put("member",array);
        return result;
    }

    //显示社团成员
    @RequestMapping(value = "/selectMemberByAssociationsId", method = RequestMethod.POST)
    public JSONObject selectMemberByAssociationsId(@RequestParam("associationId") Integer associationId) throws Exception {
        MemberService memberService = new MemberService();
        String member = JSON.toJSONString(memberService.selectMemberByAssociationsId(associationId));
        JSONArray array= JSONArray.parseArray(member);
        JSONObject result = new JSONObject();
        result.put("member",array);
        return result;
    }
}
