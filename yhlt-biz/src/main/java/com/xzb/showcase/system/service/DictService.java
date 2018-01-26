package com.xzb.showcase.system.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.system.dao.DictDao;
import com.xzb.showcase.system.entity.DictEntity;

/**
 * 数据字典
 * @author lls
 *
 */
@Component
@Transactional
@BusinessLog(service = "字典信息管理")
@DataPermission
public class DictService extends BaseService<DictEntity, DictDao>{

}
