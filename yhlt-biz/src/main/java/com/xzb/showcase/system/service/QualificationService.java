package com.xzb.showcase.system.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.system.dao.QualificationDao;
import com.xzb.showcase.system.entity.QualificationEntity;


/**
 * 资质证书
 * @author lau
 *
 */
@Component
@Transactional
@BusinessLog(service = "资质证书管理")
@DataPermission
public class QualificationService extends BaseService<QualificationEntity, QualificationDao>{

}
