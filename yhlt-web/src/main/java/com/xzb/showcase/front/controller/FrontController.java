package com.xzb.showcase.front.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.domain.Sort.Order;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xzb.showcase.base.util.ConstantsUtils;
import com.xzb.showcase.base.util.Servlets;
import com.xzb.showcase.system.entity.DepartmentEntity;
import com.xzb.showcase.system.service.DepartmentService;
import com.xzb.showcase.system.service.UserService;

/**
 * 门户网站
 * 
 * @author admin
 * 
 */
@Controller
@RequestMapping(value = "/front")
public class FrontController {
	@Autowired
	private DepartmentService departmentService;

	@Autowired
	private UserService userService;

	@RequestMapping()
	public String index(HttpServletRequest request, Model model) {
		Order o = new Order(Direction.ASC, "sortNumber");
		Map<String, Object> searchParams = new HashMap<String, Object>();
		List<DepartmentEntity> departmentEntities = departmentService
				.findByParams(searchParams, new Sort(o));
		request.setAttribute("department", departmentEntities);
		return "front/user_index";
	}

	@RequestMapping(value = "showList")
	public String showlist(Model model) {
		return "front/list_index";
	}

	@RequestMapping(value = "showDetail")
	public String showDetail(Model model) {
		return "front/detail_index";
	}

	/**
	 * @author hbj
	 * @Description: 根据分类id获取中标/废标 公告列表
	 * @param：
	 * @return
	 */
	@RequestMapping(value = "/getUserInfos")
	@ResponseBody
	public Map<String, Object> getUserInfos(
			@RequestParam(value = "page", defaultValue = "1") Integer pageNum,
			@RequestParam(value = "rows", defaultValue = "10") Integer pageRows,
			@RequestParam(value = "sort", defaultValue = "sortNumber") String sort,
			@RequestParam(value = "order", defaultValue = "asc") String order,
			Model model, HttpServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_", true);
		searchParams.put("EQ_display", ConstantsUtils.USER_DISPALY);
		Order o = new Order("desc".equals(order) ? Direction.DESC
				: Direction.ASC, sort);
		Map<String, Object> result = userService.findByParamsMap(searchParams,
				new PageRequest(pageNum, pageRows, new Sort(o)));
		return result;
	}

	/**
	 * @author hbj
	 * @Description: 跳转到中心公告首页
	 * @param：
	 * @return
	 */
	@RequestMapping(value = "/searchUserInfo")
	public String toNoticeIndexPage(Model model, HttpServletRequest request) {
		Order o = new Order(Direction.ASC, "sortNumber");
		Map<String, Object> searchParams = new HashMap<String, Object>();
		List<DepartmentEntity> departmentEntities = departmentService
				.findByParams(searchParams, new Sort(o));
		request.setAttribute("department", departmentEntities);

		request.setAttribute("name", request.getParameter("name"));
		return "front/user_index";
	}
}
