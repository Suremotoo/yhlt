package com.xzb.showcase.system.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xzb.showcase.base.controller.BaseController;
import com.xzb.showcase.system.entity.DictLauEntity;
import com.xzb.showcase.system.service.DictLauService;

/**
 * 数据字典
 * 
 * @author lau
 * 
 */
@Controller
@RequestMapping(value = "/system/dictLau")
public class DictLauController extends BaseController<DictLauEntity, DictLauService> {

	@Override
	public String index(Model model) {
		return "system/dictLau/dict_Lau_index";
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
		List<DictLauEntity> dictEntities = service.findByParams(searchParams);

		Map<String, Object> result = new HashMap<String, Object>();
		// flag=true 没有注册，false已被注册
		boolean flag = dictEntities == null || dictEntities.size() == 0;
		result.put("success", flag);
		result.put("msg", flag ? "" : "该标识已被注册");
		return result;
	}

	/**
	 * 根据模块查询 供下拉框用
	 * 
	 * @param typeName
	 * @return
	 * @author xunxun
	 * @date 2015-1-30 下午2:54:51
	 */
	@RequestMapping(value = "/combobox")
	@ResponseBody
	public List<DictLauEntity> combobox(String type) {
		Map<String, Object> searchParams = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(type)) {
			searchParams.put("EQ_type", type);
		}
		return service.findByParams(searchParams);
	}

	@RequestMapping(value = "/getID")
	@ResponseBody
	public DictLauEntity getId(String type, String value) {
		Map<String, Object> searchParams = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(type)) {
			searchParams.put("EQ_type", type);
			searchParams.put("EQ_value", value);
		}
		return service.findOneByParams(searchParams);
	}
}
