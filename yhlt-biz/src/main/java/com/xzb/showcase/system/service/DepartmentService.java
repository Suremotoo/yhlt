package com.xzb.showcase.system.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.system.dao.DepartmentDao;
import com.xzb.showcase.system.entity.DepartmentEntity;

/**
 * 组织机构-部门
 * 
 * @author wj
 * @date 2014年12月25日20:22:24
 */
@Component
@Transactional
@BusinessLog(service = "部门信息管理")
@DataPermission
public class DepartmentService extends BaseService<DepartmentEntity, DepartmentDao> {

}
