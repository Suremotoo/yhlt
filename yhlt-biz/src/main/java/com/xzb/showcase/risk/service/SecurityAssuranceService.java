package com.xzb.showcase.risk.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.risk.dao.SecurityAssuranceDao;
import com.xzb.showcase.risk.entity.SecurityAssuranceEntity;

/**
 * 安保专项类型service
 * @author LauLimXiao
 *
 */
@Component
@Transactional
@BusinessLog(service = "安保专项类型管理")
@DataPermission
public class SecurityAssuranceService extends BaseService<SecurityAssuranceEntity, SecurityAssuranceDao>{
	/**
	 * 获取安保专项类型最大 sortNumber
	 * @return
	 */
	public Integer findSecurityAssuranceSortNumberMax(){
		return dao.findSecurityAssuranceSortNumberMax();
	}
}
