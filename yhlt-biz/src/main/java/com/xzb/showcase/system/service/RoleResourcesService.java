package com.xzb.showcase.system.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.system.dao.RoleResourcesDao;
import com.xzb.showcase.system.entity.RoleResourcesEntity;

@Component
@Transactional
@BusinessLog(service = "用户和资源中间表实体管理")
@DataPermission
public class RoleResourcesService extends BaseService<RoleResourcesEntity,RoleResourcesDao> {
	
}
