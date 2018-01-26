package com.xzb.showcase.datapermission.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.datapermission.dao.DataPermissionPropertyDao;
import com.xzb.showcase.datapermission.entity.DataPermissionPropertyEntity;

/**
 * 数据规则引擎-属性管理Service
 * 
 */
@Component
@Transactional
@BusinessLog(service = "数据规则引擎属性管理")
public class DataPermissionPropertyService extends
		BaseService<DataPermissionPropertyEntity, DataPermissionPropertyDao> {

}
