package com.xzb.showcase.system.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.system.dao.ResourcesDao;
import com.xzb.showcase.system.entity.ResourcesEntity;

/**
 * 系统资源
 * @author xunxun
 * @date 2014-11-15 下午2:46:12
 */
@Component
@Transactional
@BusinessLog(service = "资源信息管理")
@DataPermission
public class ResourcesService extends BaseService<ResourcesEntity, ResourcesDao>{
	
}
