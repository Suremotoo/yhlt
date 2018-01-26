package com.xzb.showcase.system.dao;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.xzb.showcase.base.dao.BaseDao;
import com.xzb.showcase.system.entity.ImMessageEntity;

//WebIm聊天记录
public interface ImMessageDao extends BaseDao<ImMessageEntity> {

	@Modifying
	@Query("update ImMessageEntity i set i.status=0 where i.receiveId = ?1 and i.status=1")
	void setMessageReaded(Long currentUserId);

	
	
	
}
