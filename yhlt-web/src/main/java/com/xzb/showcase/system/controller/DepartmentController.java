package com.xzb.showcase.system.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.domain.Sort.Order;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xzb.showcase.base.controller.BaseController;
import com.xzb.showcase.base.security.AccessRequired;
import com.xzb.showcase.base.util.Constants;
import com.xzb.showcase.base.util.Servlets;
import com.xzb.showcase.system.entity.CompanyEntity;
import com.xzb.showcase.system.entity.DepartmentEntity;
import com.xzb.showcase.system.service.CompanyService;
import com.xzb.showcase.system.service.DepartmentService;

/**
 * 组织机构-部门
 * 
 * @author wj
 * @date 2014年12月25日20:23:27
 */
@Controller
@RequestMapping(value = "/system/department")
@AccessRequired("部门管理")
public class DepartmentController extends
		BaseController<DepartmentEntity, DepartmentService> {

	@Autowired
	private CompanyService companyService;

	@Override
	public String index(Model model) {
		return "system/department/department_index";
	}

	/**
	 * 查询combotree，用于树形选择
	 * 
	 * @return
	 * @author xunxun
	 * @date 2014-11-19 下午3:02:15
	 */
	@RequestMapping(value = "/combotree")
	@ResponseBody
	public List<DepartmentEntity> combotree(HttpServletRequest request,
			Model model) {
		List<DepartmentEntity> list = new ArrayList<DepartmentEntity>();
		DepartmentEntity resource = new DepartmentEntity();
		resource.setId(0L);
		resource.setName("无父节点");
		list.add(resource);
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_", true);
		list.addAll(service.findByParams(searchParams));
		return list;
	}

	/**
	 * 查询treegrid，用于部门展示
	 * 
	 * @return
	 * @author wj
	 * @date 2015年3月25日10:34:46
	 */
	@RequestMapping(value = "/treegrid")
	@ResponseBody
	public List<DepartmentEntity> treegrid(
			@RequestParam(value = "companyId", required = false) Long companyId,
			@RequestParam(value = "sort", defaultValue = "sortNumber", required = false) String sort,
			@RequestParam(value = "order", defaultValue = "asc", required = false) String order,
			HttpServletRequest request, Model model) {
		Long theId = null;
		if (companyId != null && !"".equals(companyId))
			theId = Long.valueOf(companyId.toString());
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_", true);
		Order o = new Order("desc".equals(order) ? Direction.DESC
				: Direction.ASC, sort);
		// 递归循环子集记录
		List<DepartmentEntity> result = new ArrayList<DepartmentEntity>();
		if (theId == null || theId == Constants.ZERO)
			result = service.findByParams(searchParams, new Sort(o));
		else {
			Map<String, Object> searchParams2 = new HashMap<String, Object>();
			searchParams2.put("EQ_id", theId);
			CompanyEntity newsTypeEntity = companyService
					.findOneByParams(searchParams2);
			Set<Long> ids = new HashSet<Long>();
			fillChildIds(newsTypeEntity, ids);
			searchParams.put("IN_companyEntity.id", ids);
			result = service.findByParams(searchParams, new Sort(o));
		}
		return result;
	}

	@AccessRequired("管理员")
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Map<String, Object> delete(@RequestParam("ids") long id,
			Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		DepartmentEntity departmentEntity = service.findOne(id);
		if (departmentEntity.getUserEntities().isEmpty())
			return super.delete(id, model, request, response);
		return null;
	}

	private void fillChildIds(CompanyEntity entity, Set<Long> ids) {
		ids.add(entity.getId());
		if (entity.getChildren().size() > 0) {
			for (CompanyEntity children : entity.getChildren()) {
				ids.add(children.getId());
				fillChildIds(children, ids);
			}
		}
	}
}
