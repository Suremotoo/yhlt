package com.xzb.showcase.system.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.base.util.Constants;
import com.xzb.showcase.system.dao.UserRoleResourceDao;
import com.xzb.showcase.system.dto.SystemMenuDto;
import com.xzb.showcase.system.entity.UserRoleResourceEntity;

@Component
@Transactional
@BusinessLog(service = "用户资源信息查询")
@DataPermission
public class UserRoleResourceService extends
		BaseService<UserRoleResourceEntity, UserRoleResourceDao> {

	/**
	 * 根据ID查找
	 * 
	 * @param id
	 * @return T
	 */
	public List<SystemMenuDto> findSystemMenuByUserId(long userId, Long parentId) {
		Map<String, Object> searchParams = new HashMap<String, Object>();
		searchParams.put("EQ_deleteFlag", Constants.DELETE_FLAG_FALSE);
		searchParams.put("EQ_userId", userId);
		searchParams.put("EQ_type", Constants.RESOURCE_TYPE_MENU);
//		if (parentId != null)
//			searchParams.put("EQ_parentId", parentId);
		List<UserRoleResourceEntity> list = findByParams(searchParams);
		// sortnumber排序
		Collections.sort(list, new Comparator<UserRoleResourceEntity>() {

			@Override
			public int compare(UserRoleResourceEntity o1,
					UserRoleResourceEntity o2) {
				return o1.getSortNumber().compareTo(o2.getSortNumber());
			}
		});
		List<SystemMenuDto> root = new ArrayList<SystemMenuDto>();
		for (UserRoleResourceEntity resourceEntity : list) {
			if (parentId == null && resourceEntity.getParentId().equals(0L)) {
				root.add(getChildRenList(resourceEntity, list));
			} else if (resourceEntity.getParentId().equals(parentId)) {
				root.add(getChildRenList(resourceEntity, list));
			}
		}
		return root;
	}

	/**
	 * 递归菜单
	 * 
	 * @param resourceEntity
	 * @param list
	 * @return
	 */
	private SystemMenuDto getChildRenList(
			UserRoleResourceEntity resourceEntity,
			List<UserRoleResourceEntity> list) {
		SystemMenuDto systemMenuDto = new SystemMenuDto(resourceEntity.getId(),
				resourceEntity.getName(), resourceEntity.getDescription(),
				resourceEntity.getIcon(), resourceEntity.getUrl());
		for (UserRoleResourceEntity userRoleResourceEntity : list) {
			if (resourceEntity.getId().equals(
					userRoleResourceEntity.getParentId())) {
				systemMenuDto.getChildren().add(
						getChildRenList(userRoleResourceEntity, list));
			}
		}
		return systemMenuDto;
	}

}
