package com.xzb.showcase.base.fileconvert.util.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.fileconvert.util.ConvertFileUtils;
import com.xzb.showcase.base.fileconvert.util.FileConvertDto;
import com.xzb.showcase.base.fileconvert.util.dao.FileConvertDao;
import com.xzb.showcase.base.service.BaseService;

@Component
@Transactional
public class FileConvertService extends BaseService<FileConvertDto,FileConvertDao>{
	
	/**
	 *
	 * @param convertDto
	 */
	public void addConver(FileConvertDto convertDto){
		this.save(convertDto);
		ConvertFileUtils.addFile(convertDto);
	}
}
