package com.xzb.showcase.datapermission.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.xzb.showcase.base.controller.BaseController;
import com.xzb.showcase.base.security.AccessRequired;
import com.xzb.showcase.datapermission.entity.DataPermissionRuleEntity;
import com.xzb.showcase.datapermission.service.DataPermissionRuleService;

/**
 * 数据规则引擎-规则管理controller
 * 
 * @author admin
 * 
 */
@Controller
@RequestMapping(value = "/datapermissionRule")
@AccessRequired("数据规则引擎-规则管理")
public class DataPermissionRuleController extends
		BaseController<DataPermissionRuleEntity, DataPermissionRuleService> {

	@Override
	public String index(Model model) {
		return "/datapermission/datapermissionRule_index";
	}

	@RequestMapping(value = "/selection", method = RequestMethod.POST)
	public String selection(@RequestParam(value = "data") String data,
			Model model, HttpServletRequest request) {
		request.setAttribute("data", data);
		return "/common/organizationSelection";
	}

	@RequestMapping(value = "/companySelection", method = RequestMethod.POST)
	public String companySelection(Model model,
			@RequestParam(value = "data") String data,
			HttpServletRequest request) {
		request.setAttribute("data", data);
		return "/common/companySelection";
	}

	@RequestMapping(value = "/departmentSelection", method = RequestMethod.POST)
	public String departmentSelection(Model model,
			@RequestParam(value = "data") String data,
			HttpServletRequest request) {
		request.setAttribute("data", data);
		return "/common/deparmentSelection";
	}

	@RequestMapping(value = "/roleSelection", method = RequestMethod.POST)
	public String roleSelection(Model model,
			@RequestParam(value = "data") String data,
			HttpServletRequest request) {
		request.setAttribute("data", data);
		return "/common/roleSelection";
	}
	
	@RequestMapping(value = "/userSelection", method = RequestMethod.POST)
	public String userSelection(Model model,
			@RequestParam(value = "data") String data,
			HttpServletRequest request) {
		request.setAttribute("data", data);
		return "/common/userSelection";
	}
}
