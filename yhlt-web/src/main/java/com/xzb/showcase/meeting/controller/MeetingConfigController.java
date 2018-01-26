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
import com.xzb.showcase.meeting.entity.MeetingConfigEntity;
import com.xzb.showcase.meeting.service.MeetingConfigService;

/**
 * 数据字典
 * 
 * @author lau
 * 
 */
@Controller
@RequestMapping(value = "/meeting")
public class MeetingConfigController extends BaseController<MeetingConfigEntity, MeetingConfigService> {

	@Override
	public String index(Model model) {
		return "meeting/meeting_config_index";
	}

	/**
	 * 根据字典名称及类型判断数据字典项是否重复
	 * 
	 * @param dictName
	 * @param typeName
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/check")
	@ResponseBody
	public Map<String, Object> check(@RequestParam("dictName") String dictName,
			@RequestParam("typeName") String typeName,
			HttpServletRequest request, Model model) {
		Map<String, Object> searchParams = new HashMap<String, Object>();
		searchParams.put("EQ_name", dictName);
		searchParams.put("EQ_type", typeName);
		List<MeetingConfigEntity> entities = service.findByParams(searchParams);

		Map<String, Object> result = new HashMap<String, Object>();
		// flag=true 没有注册，false已被注册
		boolean flag = entities == null || entities.size() == 0;
		result.put("success", flag);
		result.put("msg", flag ? "" : "该标识已被注册");
		return result;
	}

}
