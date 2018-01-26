package com.xzb.showcase.system.service;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.system.dao.ImGroupMessageDao;
import com.xzb.showcase.system.entity.ImGroupMessageEntity;

/**
 * 群
 * @author lls
 *
 */
@Component
@Transactional
@BusinessLog(service = "群信息管理")
@DataPermission
public class ImGroupMessageService extends BaseService<ImGroupMessageEntity, ImGroupMessageDao>{

	public Page<ImGroupMessageEntity> findByGroupId(long tmpGroupId,
			PageRequest pageRequest) {
		return dao.findByGroupId(tmpGroupId, pageRequest);
	}

}
