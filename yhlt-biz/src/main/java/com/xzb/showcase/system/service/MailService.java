package com.xzb.showcase.system.service;

import javax.transaction.Transactional;
import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.system.dao.MailDao;
import com.xzb.showcase.system.entity.MailEntity;

@Component
@Transactional
@BusinessLog(service = "邮件管理")
@DataPermission
public class MailService extends BaseService<MailEntity, MailDao> {

}
