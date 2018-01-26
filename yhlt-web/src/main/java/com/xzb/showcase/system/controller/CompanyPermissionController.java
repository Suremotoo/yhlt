package com.xzb.showcase.system.controller;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xzb.showcase.base.controller.BaseController;
import com.xzb.showcase.base.security.AccessRequired;
import com.xzb.showcase.base.security.SessionSecurityConstants;
import com.xzb.showcase.system.entity.CompanyEntity;
import com.xzb.showcase.system.entity.CompanyPermissionEntity;
import com.xzb.showcase.system.entity.UserEntity;
import com.xzb.showcase.system.service.CompanyPermissionService;
import com.xzb.showcase.system.service.CompanyService;

/**
 * @author hubaojie 公司数据权限
 */
@Controller
@RequestMapping(value = "/system/company/permission")
@AccessRequired("公司管理")
public class CompanyPermissionController extends BaseController<CompanyPermissionEntity, CompanyPermissionService> {

	@Override
	public String index(Model model) {
		return "system/company/company_permission";
	}
	
	@Autowired
	private CompanyService companyService;

	/**
	 * 查询公司树
	 * 
	 * @return
	 * @author hubaojie
	 */
	@RequestMapping(value = "/tree")
	@ResponseBody
	public Set<Long> tree(HttpServletRequest request, @RequestParam("companyId") String companyId, @RequestParam("typeId") String typeId) {
		return permissionCompanyList(typeId, companyId); // by mxp
	}

	/**
	 * 公司数据权限公共
	 * 
	 * @author mxp
	 * @param typeId
	 * @param companyId
	 * @return
	 */
	private Set<Long> permissionCompanyList(String typeId, String companyId) {
		Map<String, Object> searchParams = new HashMap<String, Object>();
		searchParams.put("EQ_typeId", typeId);
		searchParams.put("EQ_companyPerEntity.id", companyId);
		List<CompanyPermissionEntity> list = service.findByParams(searchParams);
		Set<Long> ids = new HashSet<Long>();
		if (list != null && list.size() != 0) {
			for (CompanyPermissionEntity entity : list) {
				Long pid = entity.getCompanyMappingEntity().getId();
				ids.add(pid);
			}
		}
		return ids;
	}

	/**
	 * 打印有权限查看公司 
	 * @author mxp
	 * @param request
	 * @param response
	 * @param typeId 供应商类型：物资、工程
	 * @return json 
	 */
	@ResponseBody
	@RequestMapping("/companyPermission")
	public List<CompanyEntity> permissionEntity(HttpServletRequest request, HttpServletResponse response,String typeId) {
		Map<String, Object> searchParams = new HashMap<String, Object>();
		Long companyId = ((UserEntity)request.getSession().getAttribute(SessionSecurityConstants.KEY_USER)).getCompanyEntity().getId();
		Set<Long> ids =  permissionCompanyList(typeId,companyId.toString());
		if(ids.size()==0){
			ids.add(-1L);
		}
		searchParams.put("IN_id",ids);
		return companyService.findByParams(searchParams);
	}

	/**
	 * 保存公司权限修改
	 * 
	 * @param roleId
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	/* @AccessRequired("管理员") */
	@RequestMapping(value = "/editPermission", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> editResources(@RequestParam("companyIdsRight") Long[] companyIdsRight, @RequestParam("companyIdLeft") String companyIdLeft, @RequestParam("typeId") Long typeId, Model model, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		if (!StringUtils.isBlank(companyIdLeft)) {
			Map<String, Object> searchParams = new HashMap<String, Object>();
			searchParams.put("EQ_typeId", typeId);
			searchParams.put("EQ_companyPerEntity.id", companyIdLeft);
			List<CompanyPermissionEntity> companyPermissionlist = service.findByParams(searchParams);
			if (companyPermissionlist != null) {
				service.savePermissionEntity(companyPermissionlist, companyIdsRight, Long.parseLong(companyIdLeft), typeId);
			}
			result.put("success", true);
		} else {
			result.put("success", false);
		}
		return result;
	}

}
