package com.xzb.showcase.datapermission.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.datapermission.dao.DataPermissionRuleUserDao;
import com.xzb.showcase.datapermission.entity.DataPermissionRuleUserEntity;

/**
 * 数据规则引擎-规则-用户关系管理Service
 * 
 */
@Component
@Transactional
@BusinessLog(service = "数据规则引擎用户管理")
public class DataPermissionRuleUserService extends
		BaseService<DataPermissionRuleUserEntity, DataPermissionRuleUserDao> {

}
