package com.xzb.showcase.risk.dao;

import org.springframework.data.jpa.repository.Query;

import com.xzb.showcase.base.dao.BaseDao;
import com.xzb.showcase.risk.entity.SecurityAssuranceEntity;

/**
 * 安保专项类型Dao
 * @author LauLimXiao
 *
 */
public interface SecurityAssuranceDao extends BaseDao<SecurityAssuranceEntity>{
	/**
	 * 获取安保专项类型最大 sortNumber
	 * @return
	 */
	@Query("select max(sortNumber) from SecurityAssuranceEntity")
	public Integer findSecurityAssuranceSortNumberMax();
}
