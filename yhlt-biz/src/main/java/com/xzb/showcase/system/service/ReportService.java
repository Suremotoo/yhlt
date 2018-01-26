package com.xzb.showcase.system.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.system.dao.ReportDao;
import com.xzb.showcase.system.entity.ReportEntity;

@Component
@Transactional
@BusinessLog(service = "系统报表管理")
@DataPermission
public class ReportService extends BaseService<ReportEntity, ReportDao>{

}
