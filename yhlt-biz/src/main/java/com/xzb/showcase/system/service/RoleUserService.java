package com.xzb.showcase.system.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.system.dao.RoleUserDao;
import com.xzb.showcase.system.entity.RoleUserEntity;

@Component
@Transactional
@BusinessLog(service = "角色用户管理")
@DataPermission
public class RoleUserService extends BaseService<RoleUserEntity,RoleUserDao> {
	
}
