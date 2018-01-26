package com.xzb.showcase.system.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.system.dao.RoleTreeDao;
import com.xzb.showcase.system.entity.RoleTreeEntity;

@Component
@Transactional
@BusinessLog(service = "角色树管理")
@DataPermission
public class RoleTreeService extends BaseService<RoleTreeEntity, RoleTreeDao> {

}
