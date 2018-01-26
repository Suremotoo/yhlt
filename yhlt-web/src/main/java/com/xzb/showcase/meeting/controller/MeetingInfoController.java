package com.xzb.showcase.meeting.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xzb.showcase.base.controller.BaseController;
import com.xzb.showcase.meeting.entity.MeetingInfoEntity;
import com.xzb.showcase.meeting.service.MeetingInfoService;

/**
 * 会议管理
 * 
 * @author lau
 * 
 */
@Controller
@RequestMapping(value = "/meeting/info")
public class MeetingInfoController extends BaseController<MeetingInfoEntity,MeetingInfoService> {

	@Override
	public String index(Model model) {
		return "meeting/meeting_info_index";
	}

	/**
	 * 根据会议uuid号判断会议是否重复
	 * 
	 * @param uuid
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/check")
	@ResponseBody
	public Map<String, Object> check(@RequestParam("uuid") String uuid,
			HttpServletRequest request, Model model) {
		Map<String, Object> searchParams = new HashMap<String, Object>();
		searchParams.put("EQ_uuid", uuid);
		List<MeetingInfoEntity> entities = service.findByParams(searchParams);

		Map<String, Object> result = new HashMap<String, Object>();
		// flag=true 没有注册，false已被注册
		boolean flag = entities == null || entities.size() == 0;
		result.put("success", flag);
		result.put("msg", flag ? "" : "该标识已被注册");
		return result;
	}

}
