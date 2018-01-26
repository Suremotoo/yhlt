package com.xzb.showcase.system.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.system.dao.DictLauDao;
import com.xzb.showcase.system.entity.DictLauEntity;

/**
 * 数据字典
 * @author lau
 *
 */
@Component
@Transactional
@BusinessLog(service = "字典信息管理")
@DataPermission
public class DictLauService extends BaseService<DictLauEntity, DictLauDao>{

}
