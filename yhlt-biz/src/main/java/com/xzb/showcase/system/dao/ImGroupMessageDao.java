package com.xzb.showcase.system.dao;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.xzb.showcase.base.dao.BaseDao;
import com.xzb.showcase.system.entity.ImGroupMessageEntity;

public interface ImGroupMessageDao extends BaseDao<ImGroupMessageEntity> {

	Page<ImGroupMessageEntity> findByGroupId(long tmpGroupId, Pageable pageRequest);
}
