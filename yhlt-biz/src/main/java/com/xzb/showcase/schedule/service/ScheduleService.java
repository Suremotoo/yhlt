package com.xzb.showcase.schedule.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.schedule.dao.ScheduleDao;
import com.xzb.showcase.schedule.entity.ScheduleEntity;

@Component
@Transactional
@BusinessLog(service="日程")
@DataPermission
public class ScheduleService extends BaseService<ScheduleEntity, ScheduleDao>{

	
}
