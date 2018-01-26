package com.xzb.showcase.system.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.system.dao.UserDao;
import com.xzb.showcase.system.entity.UserEntity;

@Component
@Transactional
@BusinessLog(service = "用户信息管理")
@DataPermission
public class UserService extends BaseService<UserEntity, UserDao> {
	
	public int findUserSortNumberMax() {
		return dao.findUserSortNumberMax();
	}
}
