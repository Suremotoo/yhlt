package com.xzb.showcase.risk.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.risk.dao.BreakruleUserDao;
import com.xzb.showcase.risk.entity.BreakruleUserEntity;

@Component
@Transactional
@BusinessLog(service = "违规检查单管理")
@DataPermission
public class BreakruleUserService extends
		BaseService<BreakruleUserEntity, BreakruleUserDao> {

}
