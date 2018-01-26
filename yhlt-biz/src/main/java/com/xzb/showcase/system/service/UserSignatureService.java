package com.xzb.showcase.system.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.system.dao.UserSignatureDao;
import com.xzb.showcase.system.entity.UserSignatureEntity;

@Component
@Transactional
@BusinessLog(service = "电子签名管理")
@DataPermission
public class UserSignatureService extends BaseService<UserSignatureEntity, UserSignatureDao> {
}
