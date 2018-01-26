package com.xzb.showcase.file.dao;

import org.springframework.data.jpa.repository.Query;

import com.xzb.showcase.base.dao.BaseDao;
import com.xzb.showcase.file.entity.FileTypeEntity;

/**
 * 文件类型
 * @author LauLimXiao
 *
 */
public interface FileTypeDao extends BaseDao<FileTypeEntity>{
	/**
	 * 获取文件类型最大 sortNumber
	 * @return
	 */
	@Query("select max(sortNumber) from FileTypeEntity")
	public Integer findFileTypeSortNumberMax();
}
