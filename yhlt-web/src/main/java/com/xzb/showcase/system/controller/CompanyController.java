package com.xzb.showcase.system.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xzb.showcase.base.controller.BaseController;
import com.xzb.showcase.base.security.AccessRequired;
import com.xzb.showcase.base.util.Servlets;
import com.xzb.showcase.system.entity.CompanyEntity;
import com.xzb.showcase.system.service.CompanyService;

/**
 * 组织机构-公司
 * 
 * @author wj
 * @date 2014年12月25日20:23:27
 */
@Controller
@RequestMapping(value = "/system/company")
@AccessRequired("公司管理")
public class CompanyController extends
		BaseController<CompanyEntity, CompanyService> {

	@Override
	public String index(Model model) {
		return "system/company/company_index";
	}

	/**
	 * 查询公司树
	 * 
	 * @return
	 * @author wj
	 * @date 2014-11-19 下午3:02:15
	 */
	@RequestMapping(value = "/combotree")
	@ResponseBody
	public List<CompanyEntity> tree(HttpServletRequest request, Model model) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		return service.findByParams(searchParams);
	}

	@AccessRequired("管理员")
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Map<String, Object> delete(@RequestParam("ids") long id,
			Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		CompanyEntity entity = service.findOne(id);
		if (entity.getChildren().isEmpty()
				&& entity.getDepartmentEntities().isEmpty())
			return super.delete(id, model, request, response);
		return null;
	}
}
