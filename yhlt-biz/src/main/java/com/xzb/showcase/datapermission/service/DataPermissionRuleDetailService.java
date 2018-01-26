package com.xzb.showcase.datapermission.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.datapermission.dao.DataPermissionRuleDetailDao;
import com.xzb.showcase.datapermission.entity.DataPermissionRuleDetailEntity;

/**
 * 数据规则引擎-规则明细管理Service
 * 
 */
@Component
@Transactional
@BusinessLog(service = "数据规则引擎明细管理")
public class DataPermissionRuleDetailService
		extends
		BaseService<DataPermissionRuleDetailEntity, DataPermissionRuleDetailDao> {

}
