package com.xzb.showcase.base.fileconvert.util;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.xzb.showcase.base.entity.BaseEntity;


/**
 * 文档转换dto
 * 
 * 1464089174931.doc;C:/work/workspace-eclipse/bid/bid-web/src/main/webapp/
 * notice -file/ZB/20160525/2640/tbf/101028/master;/notice-file/ZB/20160525/2640
 * /tbf/101028/master;C:/work/workspace-eclipse/bid/bid-web/src/main/webapp/
 * notice-file/ZB/20160525/2640/tbf/101028/master;12905
 * 
 * @author admin
 * 
 */
@Entity
@Table(name="tm_notice_file_convert_queue")
public class FileConvertDto extends BaseEntity<Long>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3617613298558420132L;
	/**
	 * NoticeFile-Id
	 */
	private Long fileId;
	/**
	 * 文件名,1464089174931.doc
	 */
	private String fileName;
	/**
	 * 原文件目录,C:/work/workspace-eclipse/bid/bid-web/src/main/webapp/ notice
	 * -file/ZB/20160525/2640/tbf/101028/master
	 */
	private String orgDictionaryDirectory;
	/**
	 * 导出pdf目录,C:/work/workspace-eclipse/bid/bid-web/src/main/webapp/ notice
	 * -file/ZB/20160525/2640/tbf/101028/master
	 */
	private String exportPdfFileDirectory;
	/**
	 * 导出swf目录,C:/work/workspace-eclipse/bid/bid-web/src/main/webapp/ notice
	 * -file/ZB/20160525/2640/tbf/101028/master
	 */
	private String exportSwfFileDirectory;
	/**
	 * 保存相对路径,/notice-file/ZB/20160525/2640 /tbf/101028/master
	 */
	private String relativePath;
	/**
	 * 备用
	 */
	private String content;

	public FileConvertDto() {
	}

	public FileConvertDto(Long fileId, String fileName,
			String orgDictionaryDirectory, String exportPdfFileDirectory,
			String exportSwfFileDirectory, String relativePath, String content) {
		super();
		this.fileId = fileId;
		this.fileName = fileName;
		this.orgDictionaryDirectory = orgDictionaryDirectory;
		this.exportPdfFileDirectory = exportPdfFileDirectory;
		this.exportSwfFileDirectory = exportSwfFileDirectory;
		this.relativePath = relativePath;
		this.content = content;
	}

	public Long getFileId() {
		return fileId;
	}

	public void setFileId(Long fileId) {
		this.fileId = fileId;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getOrgDictionaryDirectory() {
		return orgDictionaryDirectory;
	}

	public void setOrgDictionaryDirectory(String orgDictionaryDirectory) {
		this.orgDictionaryDirectory = orgDictionaryDirectory;
	}

	public String getExportPdfFileDirectory() {
		return exportPdfFileDirectory;
	}

	public void setExportPdfFileDirectory(String exportPdfFileDirectory) {
		this.exportPdfFileDirectory = exportPdfFileDirectory;
	}

	public String getExportSwfFileDirectory() {
		return exportSwfFileDirectory;
	}

	public void setExportSwfFileDirectory(String exportSwfFileDirectory) {
		this.exportSwfFileDirectory = exportSwfFileDirectory;
	}

	public String getRelativePath() {
		return relativePath;
	}

	public void setRelativePath(String relativePath) {
		this.relativePath = relativePath;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return this.fileName;
	}
	//	public static void main(String[] args) {
//		FileConvertDto convertDto = new FileConvertDto(
//				1L,
//				"1111.doc",
//				"C:/work/workspace-eclipse/bid/bid-web/src/main/webapp/ notice-file/ZB/20160525/2640/tbf/101028/master",
//				"C:/work/workspace-eclipse/bid/bid-web/src/main/webapp/ notice-file/ZB/20160525/2640/tbf/101028/master",
//				"C:/work/workspace-eclipse/bid/bid-web/src/main/webapp/ notice-file/ZB/20160525/2640/tbf/101028/master",
//				"test", null);
//		System.out.println(new JsonMapper().toJson(convertDto));
//	}
}