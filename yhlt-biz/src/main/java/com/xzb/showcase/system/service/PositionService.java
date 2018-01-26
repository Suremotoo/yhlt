package com.xzb.showcase.system.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.system.dao.PositionDao;
import com.xzb.showcase.system.entity.PositionEntity;

/**
 * 职位管理
 * @author hubaojie
 *
 */
@Component
@Transactional
@BusinessLog(service = "职位管理")
@DataPermission
public class PositionService extends BaseService<PositionEntity, PositionDao>{
	
	public synchronized Long getMaxSortNumber() {
		return dao.getMaxSortNumber();
	}
}
