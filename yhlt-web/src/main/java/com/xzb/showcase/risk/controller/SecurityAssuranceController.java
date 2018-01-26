package com.xzb.showcase.risk.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
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
import com.xzb.showcase.base.security.LoginContextHolder;
import com.xzb.showcase.base.util.Constants;
import com.xzb.showcase.base.util.CopyPropertiesUtil;
import com.xzb.showcase.base.util.Servlets;
import com.xzb.showcase.risk.entity.SecurityAssuranceEntity;
import com.xzb.showcase.risk.service.SecurityAssuranceService;

/**
 * 安保专项类型
 * 
 * @author LauLimXiao
 * 
 */
@Controller
@RequestMapping(value = "/risk/securityAssurance")
public class SecurityAssuranceController extends
		BaseController<SecurityAssuranceEntity, SecurityAssuranceService> {

	@Autowired
	private SecurityAssuranceService securityAssuranceService;

	@Override
	public String index(Model model) {
		return "/risk/securityAssurance/security_assurance_index";
	}

	/**
	 * 进入安保专项管理界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/manage")
	public String manage(Model model) {
		return "/risk/securityAssurance/security_assurance_manage";
	}

	/**
	 * 查询类型树
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @author LauLimXiao
	 */
	@RequestMapping(value = "/combotree")
	@ResponseBody
	public List<SecurityAssuranceEntity> tree(HttpServletRequest request,
			Model model) {
		List<SecurityAssuranceEntity> list = new ArrayList<SecurityAssuranceEntity>();
		SecurityAssuranceEntity resource = new SecurityAssuranceEntity();
		resource.setId(0L);
		resource.setName("全部");
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_", true);
		resource.setChildren(new HashSet<SecurityAssuranceEntity>(service
				.findByParams(searchParams)));
		list.add(resource);
		return list;
	}

	/**
	 * 检查 名字是否已存在
	 * 
	 * @param securityName
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/check")
	@ResponseBody
	public Map<String, Object> check(
			@RequestParam("securityName") String securityName,
			HttpServletRequest request, Model model) {
		Map<String, Object> searchParams = new HashMap<String, Object>();
		searchParams.put("EQ_name", securityName);
		List<SecurityAssuranceEntity> entities = service
				.findByParams(searchParams);
		Map<String, Object> result = new HashMap<String, Object>();
		// flag=true 没有注册，false已被注册
		boolean flag = entities == null || entities.size() == 0;
		result.put("success", flag);
		result.put("msg", flag ? "" : "该标识已被注册");
		return result;
	}

	/**
	 * 安保项目列排序
	 * 
	 * @param sortType
	 *            0-升，1-降
	 * @param userId
	 * @param request
	 * @param model
	 * @return
	 */
	@AccessRequired("管理员")
	@RequestMapping(value = "/securityAssuranceSort")
	@ResponseBody
	public Map<String, Object> userSort(@RequestParam int sortType,
			@RequestParam long securityAssuranceId, HttpServletRequest request,
			Model model) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			SecurityAssuranceEntity entity = service
					.findOne(securityAssuranceId);
			int currentSortNumber = entity.getSortNumber();

			Page<SecurityAssuranceEntity> securityAssuranceEntityList = null;
			// 升
			if (sortType == 0) {
				Map<String, Object> searchParams = new HashMap<String, Object>();
				searchParams.put("LT_sortNumber", currentSortNumber);
				securityAssuranceEntityList = service.findByParams(
						searchParams, new PageRequest(0, 1, new Sort(new Order(
								Direction.DESC, "sortNumber"))));
			} else {
				// 降
				Map<String, Object> searchParams = new HashMap<String, Object>();
				searchParams.put("GT_sortNumber", currentSortNumber);
				securityAssuranceEntityList = service.findByParams(
						searchParams, new PageRequest(0, 1, new Sort(new Order(
								Direction.ASC, "sortNumber"))));
			}
			if (securityAssuranceEntityList != null
					&& securityAssuranceEntityList.getSize() > 0) {
				SecurityAssuranceEntity entityTemp = securityAssuranceEntityList
						.getContent().get(0);
				entity.setSortNumber(entityTemp.getSortNumber());
				entityTemp.setSortNumber(currentSortNumber);
				service.save(entity);
				service.save(entityTemp);
			}
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
		}
		return result;
	}

	/**
	 * 查询treegrid，用于安保菜单展示
	 * 
	 * @return
	 * @author LauLImxiao
	 */
	@RequestMapping(value = "/treegrid")
	@ResponseBody
	public List<SecurityAssuranceEntity> treegrid(
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
		List<SecurityAssuranceEntity> result = new ArrayList<SecurityAssuranceEntity>();
		if (theId == null || theId == Constants.ZERO)
			result = service.findByParams(searchParams, new Sort(o));
		else {
			Map<String, Object> searchParams2 = new HashMap<String, Object>();
			searchParams2.put("EQ_id", theId);
			SecurityAssuranceEntity newsTypeEntity = securityAssuranceService
					.findOneByParams(searchParams2);
			Set<Long> ids = new HashSet<Long>();
			fillChildIds(newsTypeEntity, ids);
			searchParams.put("IN_parentId", ids);
			result = service.findByParams(searchParams, new Sort(o));
		}
		return result;
	}

	// 递归子节点
	private void fillChildIds(SecurityAssuranceEntity entity, Set<Long> ids) {
		ids.add(entity.getId());
		if (entity.getChildren().size() > 0) {
			for (SecurityAssuranceEntity children : entity.getChildren()) {
				ids.add(children.getId());
				fillChildIds(children, ids);
			}
		}
	}

	/**
	 * 添加 安保检查依据
	 * 
	 * @param t
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author LauLimXiao
	 */
	@RequestMapping(value = "/saveBasis")
	@ResponseBody
	public Map<String, Object> saveBasis(SecurityAssuranceEntity t,
			Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		if (t.getId() != null) {
			SecurityAssuranceEntity temp = service.findOne(t.getId());
			CopyPropertiesUtil.copyPropertiesIgnoreNull(t, temp);
			temp.setGmtModified(new Date());
			temp.setLastModifiedById(LoginContextHolder.get().getUserId());
			t = temp;
			service.save(t);
		} else {
			t.setGmtCreate(new Date());
			t.setCreateById(LoginContextHolder.get().getUserId());
			t.setType(2);
			t.setSortNumber(service.findSecurityAssuranceSortNumberMax() + 1);
			t.setUuid(UUID.randomUUID().toString());
			service.save(t);
		}

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", true);
		return result;
	}

	/**
	 * 添加安保检查 标准
	 * 
	 * @param t
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author LauLimXiao
	 */
	@RequestMapping(value = "/saveStandard")
	@ResponseBody
	public Map<String, Object> saveStandard(SecurityAssuranceEntity t,
			Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		if (t.getId() != null) {
			SecurityAssuranceEntity temp = service.findOne(t.getId());
			CopyPropertiesUtil.copyPropertiesIgnoreNull(t, temp);
			temp.setGmtModified(new Date());
			temp.setLastModifiedById(LoginContextHolder.get().getUserId());
			t = temp;
			service.save(t);
		} else {
			t.setGmtCreate(new Date());
			t.setCreateById(LoginContextHolder.get().getUserId());
			t.setType(3);
			t.setSortNumber(service.findSecurityAssuranceSortNumberMax() + 1);
			t.setUuid(UUID.randomUUID().toString());
			service.save(t);
		}

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", true);
		return result;
	}

	/**
	 * 添加安保检查类型
	 * 
	 * @param t
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author LauLimXiao
	 */
	@RequestMapping(value = "/saveType")
	@ResponseBody
	public Map<String, Object> saveType(SecurityAssuranceEntity t, Model model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		t.setType(0); // 类型 0
		if (t.getId() != null) {
			SecurityAssuranceEntity temp = service.findOne(t.getId());
			CopyPropertiesUtil.copyPropertiesIgnoreNull(t, temp);
			temp.setGmtModified(new Date());
			temp.setLastModifiedById(LoginContextHolder.get().getUserId());
			t = temp;
			service.save(t);
		} else {
			t.setGmtCreate(new Date());
			t.setCreateById(LoginContextHolder.get().getUserId());
			t.setSortNumber(service.findSecurityAssuranceSortNumberMax() + 1);
			t.setUuid(UUID.randomUUID().toString());
			service.save(t);
		}

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", true);
		return result;
	}

	/**
	 * 查询依据下面有没有标准
	 * 
	 * @param id
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/checkNext")
	@ResponseBody
	public Map<String, Object> checkChild(@RequestParam("id") String id,
			HttpServletRequest request, Model model) {
		Map<String, Object> searchParams = new HashMap<String, Object>();
		searchParams.put("EQ_parentId", id);
		List<SecurityAssuranceEntity> entities = service
				.findByParams(searchParams);

		Map<String, Object> result = new HashMap<String, Object>();
		// flag=true 没有子级标准，false有子级标准
		boolean flag = entities == null || entities.size() == 0;
		result.put("success", flag);
		return result;
	}

}
