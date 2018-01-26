package com.xzb.showcase.file.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.file.dao.FileTypeDao;
import com.xzb.showcase.file.entity.FileTypeEntity;

/**
 * 文件类型
 * 
 * @author LauLimXiao
 * 
 */
@Component
@Transactional
@BusinessLog(service = "文件类型管理")
@DataPermission
public class FileTypeService extends BaseService<FileTypeEntity, FileTypeDao> {
	/**
	 * 获取文件类型最大的 sortNumber
	 * @return
	 */
	public Integer findFileTypeSortNumberMax(){
		return dao.findFileTypeSortNumberMax();
	}
}
