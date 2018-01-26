package com.xzb.showcase.datapermission.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xzb.showcase.base.controller.BaseController;
import com.xzb.showcase.base.security.AccessRequired;
import com.xzb.showcase.base.security.LoginContextHolder;
import com.xzb.showcase.datapermission.entity.DataPermissionRuleEntity;
import com.xzb.showcase.datapermission.entity.DataPermissionRuleUserEntity;
import com.xzb.showcase.datapermission.service.DataPermissionRuleUserService;
import com.xzb.showcase.system.entity.CompanyEntity;
import com.xzb.showcase.system.entity.DepartmentEntity;
import com.xzb.showcase.system.entity.ResourcesEntity;
import com.xzb.showcase.system.entity.RoleEntity;
import com.xzb.showcase.system.entity.UserEntity;

/**
 * 数据规则引擎-规则-用户管理controller
 * 
 * @author admin
 * 
 */
@Controller
@RequestMapping(value = "/datapermissionRuleUser")
@AccessRequired("数据规则引擎-规则管理")
public class DataPermissionRuleUserController
		extends
		BaseController<DataPermissionRuleUserEntity, DataPermissionRuleUserService> {

	@Override
	public String index(Model model) {
		return "/datapermission/datapermissionRule_index";
	}

	@RequestMapping(value = "/save1", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> save1(@RequestParam(value = "data") String data,
			Model model, @RequestParam(value = "ids") Long[] ids,
			@RequestParam(value = "type") String type,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		JSONObject jsonObject = new JSONObject(data);
		Long ruleId = jsonObject.getLong("ruleId");
		Long resourceId = jsonObject.getLong("resourceId");
		List<DataPermissionRuleUserEntity> temp = new ArrayList<DataPermissionRuleUserEntity>();
		Map<Long, Object> existed = existed(type, resourceId, ruleId);
		for (Long id : ids) {
			if (!existed.containsKey(id)) {
				ResourcesEntity resourcesEntity = new ResourcesEntity();
				resourcesEntity.setId(resourceId);
				DataPermissionRuleEntity dataPermissionRuleEntity = new DataPermissionRuleEntity();
				dataPermissionRuleEntity.setId(ruleId);
				DataPermissionRuleUserEntity entity = new DataPermissionRuleUserEntity();
				if ("company".equals(type)) {
					CompanyEntity companyEntity = new CompanyEntity();
					companyEntity.setId(id);
					entity.setCompanyEntity(companyEntity);
				} else if ("department".equals(type)) {
					DepartmentEntity departmentEntity = new DepartmentEntity();
					departmentEntity.setId(id);
					entity.setDepartmentEntity(departmentEntity);
				} else if ("role".equals(type)) {
					RoleEntity roleEntity = new RoleEntity();
					roleEntity.setId(id);
					entity.setRoleEntity(roleEntity);
				} else if ("user".equals(type)) {
					UserEntity userEntity = new UserEntity();
					userEntity.setId(id);
					entity.setUserEntity(userEntity);
				}
				entity.setResourcesEntity(resourcesEntity);
				entity.setRuleEntity(dataPermissionRuleEntity);
				entity.setGmtCreate(new Date());
				entity.setCreateById(LoginContextHolder.get().getUserId());
				temp.add(entity);
			}
		}
		return service.save(temp);
	}
	/**
	 * 查询现有集合
	 * @param type
	 * @param resourceId
	 * @param ruleId
	 * @return
	 */
	private Map<Long, Object> existed(String type, Long resourceId, Long ruleId) {
		Map<String, Object> searchParams = new HashMap<String, Object>();
		if ("company".equals(type)) {
			searchParams.put("GT_companyEntity.id", 0L);
		} else if ("department".equals(type)) {
			searchParams.put("GT_departmentEntity.id", 0L);
		} else if ("role".equals(type)) {
			searchParams.put("GT_roleEntity.id", 0L);
		} else if ("user".equals(type)) {
			searchParams.put("GT_userEntity.id", 0L);
		}
		searchParams.put("EQ_resourcesEntity.id", resourceId);
		searchParams.put("EQ_ruleEntity.id", ruleId);
		List<DataPermissionRuleUserEntity> r = service
				.findByParams(searchParams);
		Map<Long, Object> map = new HashMap<Long, Object>();
		if ("company".equals(type)) {
			for (DataPermissionRuleUserEntity dataPermissionRuleUserEntity : r) {
				CompanyEntity companyEntity = dataPermissionRuleUserEntity
						.getCompanyEntity();
				if (companyEntity != null) {
					map.put(companyEntity.getId(), null);
				}
			}
		} else if ("department".equals(type)) {
			for (DataPermissionRuleUserEntity dataPermissionRuleUserEntity : r) {
				DepartmentEntity departmentEntity = dataPermissionRuleUserEntity
						.getDepartmentEntity();
				if (departmentEntity != null) {
					map.put(departmentEntity.getId(), null);
				}
			}
		} else if ("role".equals(type)) {
			for (DataPermissionRuleUserEntity dataPermissionRuleUserEntity : r) {
				RoleEntity roleEntity = dataPermissionRuleUserEntity
						.getRoleEntity();
				if (roleEntity != null) {
					map.put(roleEntity.getId(), null);
				}
			}
		} else if ("user".equals(type)) {
			for (DataPermissionRuleUserEntity dataPermissionRuleUserEntity : r) {
				UserEntity userEntity = dataPermissionRuleUserEntity
						.getUserEntity();
				if (userEntity != null) {
					map.put(userEntity.getId(), null);
				}
			}
		}
		return map;
	}
}
