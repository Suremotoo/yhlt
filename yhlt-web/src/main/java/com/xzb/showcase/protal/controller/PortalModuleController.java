package com.xzb.showcase.protal.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xzb.showcase.base.controller.BaseController;
import com.xzb.showcase.portal.entity.PortalModuleEntity;
import com.xzb.showcase.portal.service.PortalModuleService;

/**
 * Portal 组件
 * 
 * @author admin
 * 
 */
@Controller
@RequestMapping(value = "/portalModule")
public class PortalModuleController extends
		BaseController<PortalModuleEntity, PortalModuleService> {

	@Override
	public String index(Model model) {
		return "portal/portalmodule_index";
	}

	@RequestMapping(value = "/module")
	public String module(@RequestParam("id") long id, Model model,
			HttpServletRequest request, HttpServletResponse response) {
		PortalModuleEntity portalModuleEntity = service.findOne(id);
		model.addAttribute("module", portalModuleEntity);
		return "portal/portalmodule_detail";
	}

	@RequestMapping(value = "/combo")
	@ResponseBody
	public List<PortalModuleEntity> combo(Model model,
			HttpServletRequest request, HttpServletResponse response) {
		return service.findByParams(new HashMap<String, Object>());
	}
}
