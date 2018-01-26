package com.xzb.showcase.system.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.system.dao.FileDao;
import com.xzb.showcase.system.entity.FileEntity;

/**
 * 附件
 * 
 * @author xunxun
 * @date 2015-1-20 下午1:57:11
 */
@Component
@Transactional
@BusinessLog(service = "上传文件管理")
@DataPermission
public class FileService extends BaseService<FileEntity, FileDao> {
}
