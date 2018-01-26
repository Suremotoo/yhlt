package com.xzb.showcase.system.dao;

import org.springframework.data.jpa.repository.Query;

import com.xzb.showcase.base.dao.BaseDao;
import com.xzb.showcase.system.entity.PositionEntity;
/**
 * 职位管理
 * @author hubaojie
 *
 */
public interface PositionDao extends BaseDao<PositionEntity>{
	
	@Query("select max(p.sortNumber) from PositionEntity p")
	Long getMaxSortNumber();
}
