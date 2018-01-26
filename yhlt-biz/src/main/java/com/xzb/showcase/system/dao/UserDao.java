package com.xzb.showcase.system.dao;

import org.springframework.data.jpa.repository.Query;

import com.xzb.showcase.base.dao.BaseDao;
import com.xzb.showcase.system.entity.UserEntity;

public interface UserDao extends BaseDao<UserEntity> {

	@Query("select max(sortNumber) from UserEntity")
	public int findUserSortNumberMax();
}
