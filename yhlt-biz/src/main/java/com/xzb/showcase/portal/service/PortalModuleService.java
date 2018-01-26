package com.xzb.showcase.portal.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.portal.dao.PortalModuleDao;
import com.xzb.showcase.portal.entity.PortalModuleEntity;

/**
 * Portal组件Service
 * @author wj
 *
 */
@Component
@Transactional
@BusinessLog(service="PORTAL组件管理")
@DataPermission
public class PortalModuleService extends BaseService<PortalModuleEntity, PortalModuleDao>{

}
