package com.xzb.showcase.datapermission.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xzb.showcase.base.controller.BaseController;
import com.xzb.showcase.base.security.AccessRequired;
import com.xzb.showcase.base.util.Servlets;
import com.xzb.showcase.datapermission.entity.DataPermissionPropertyEntity;
import com.xzb.showcase.datapermission.service.DataPermissionPropertyService;

/**
 * 数据规则引擎-属性管理
 * 
 * @author admin
 * 
 */
@Controller
@RequestMapping(value = "/datapermissionProperty")
@AccessRequired("数据规则引擎-属性管理")
public class DataPermissionPropertyController
		extends
		BaseController<DataPermissionPropertyEntity, DataPermissionPropertyService> {

	@Override
	public String index(Model model) {
		return "/datapermission/datapermissionProperty_index";
	}

	/**
	 * 查询属性列表
	 * 
	 * @return
	 * @author wj
	 * @date 2014-11-19 下午3:02:15
	 */
	@RequestMapping(value = "/combotree")
	@ResponseBody
	public List<DataPermissionPropertyEntity> tree(HttpServletRequest request,
			Model model) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_",true);
		return service.findByParams(searchParams);
	}
}
