package com.xzb.showcase.risk.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.risk.dao.SecurityAssuranceBillDetailDao;
import com.xzb.showcase.risk.entity.SecurityAssuranceBillDetailEntity;

/**
 * 安保专项检查单详情service
 * 
 * @author LauLimXiao
 * 
 */
@Component
@Transactional
@BusinessLog(service = "安保专项检查单详情")
@DataPermission
public class SecurityAssuranceBillDetailService
		extends
		BaseService<SecurityAssuranceBillDetailEntity, SecurityAssuranceBillDetailDao> {

}
