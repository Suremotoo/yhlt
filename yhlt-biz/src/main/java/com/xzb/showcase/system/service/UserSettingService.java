package com.xzb.showcase.system.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.system.dao.UserSettingDao;
import com.xzb.showcase.system.entity.UserSettingEntity;

/**
 * 用户系统设置
 * 
 * @author admin
 * 
 */
@Component
@Transactional
@BusinessLog(service = "用户系统设置管理")
@DataPermission
public class UserSettingService extends
		BaseService<UserSettingEntity, UserSettingDao> {
}
