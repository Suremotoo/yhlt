package com.xzb.showcase.datapermission.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.datapermission.dao.DataPermissionRuleDao;
import com.xzb.showcase.datapermission.entity.DataPermissionRuleEntity;

/**
 * 数据规则引擎-规则管理Service
 * 
 */
@Component
@Transactional
@BusinessLog(service = "数据规则引擎管理")
public class DataPermissionRuleService extends
		BaseService<DataPermissionRuleEntity, DataPermissionRuleDao> {

}
