package com.xzb.showcase.risk.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.risk.dao.SecurityAssuranceBillDao;
import com.xzb.showcase.risk.entity.SecurityAssuranceBillEntity;

/**
 * 安保专项检查单service
 * 
 * @author LauLimXiao
 * 
 */
@Component
@Transactional
@BusinessLog(service = "安保专项检查单管理")
@DataPermission
public class SecurityAssuranceBillService extends
		BaseService<SecurityAssuranceBillEntity, SecurityAssuranceBillDao> {

}
