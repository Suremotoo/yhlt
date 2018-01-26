package com.xzb.showcase.file.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.file.dao.FileInfoDao;
import com.xzb.showcase.file.entity.FileInfoEntity;

/**
 * 文件信息
 * 
 * @author LauLimXiao
 * 
 */
@Component
@Transactional
@BusinessLog(service = "文件信息管理")
@DataPermission
public class FileInfoService extends BaseService<FileInfoEntity, FileInfoDao> {

}
