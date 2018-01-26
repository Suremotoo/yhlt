package com.xzb.showcase.file.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Formula;

import com.xzb.showcase.base.entity.BaseEntity;

/**
 * 文件类型
 * 
 * @author LauLimXiao
 * 
 */
@Entity
@Table(name = "tm_sms_file_info")
public class FileInfoEntity extends BaseEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2693391171315521477L;
	/**
	 * uuid 唯一标识
	 */
	private String uuid;
	/**
	 * 文件名
	 */
	private String fileName;
	/**
	 * 系统文件名
	 */
	private String sysFileName;
	/**
	 * 系统存放路径
	 */
	private String sysFilePath;

	/**
	 * 文件大小 单位B
	 */
	private Long fileSize;
	/**
	 * 系统模块
	 */
	private String module;
	/**
	 * 文件标题
	 */
	private String title;
	/**
	 * 文件类型id
	 */
	@NotNull
	private Integer typeId;
	@Formula(value = "(select t.name  from  tm_sms_file_type t where  t.id=type_id)")
	private String typeName;
	/**
	 * 转换后文件大小带单位
	 */
	private String convertFileSize;
	/**
	 * 文件类型
	 */
	private String contentType;
	/**
	 * 下载路径
	 */
	private String downloadUrl;
	/**
	 * pdf文件路径
	 */
	private String pdfPath;
	/**
	 * swf文件路径
	 */
	private String swfPath;
	/**
	 * 总页数
	 */
	private Integer totalPages;
	/**
	 * 删除标记
	 */
	private Long deleteFlag;
	/**
	 * 创建人名字
	 */
	@Formula(value = "(select t.name  from  tc_system_user t where  t.id=create_by_id)")
	private String gmtCreateUserName;

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getSysFileName() {
		return sysFileName;
	}

	public void setSysFileName(String sysFileName) {
		this.sysFileName = sysFileName;
	}

	public String getSysFilePath() {
		return sysFilePath;
	}

	public void setSysFilePath(String sysFilePath) {
		this.sysFilePath = sysFilePath;
	}

	public Long getFileSize() {
		return fileSize;
	}

	public void setFileSize(Long fileSize) {
		this.fileSize = fileSize;
	}

	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getTypeId() {
		return typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

	public String getConvertFileSize() {
		return convertFileSize;
	}

	public void setConvertFileSize(String convertFileSize) {
		this.convertFileSize = convertFileSize;
	}

	public String getContentType() {
		return contentType;
	}

	public void setContentType(String contentType) {
		this.contentType = contentType;
	}

	public String getDownloadUrl() {
		return downloadUrl;
	}

	public void setDownloadUrl(String downloadUrl) {
		this.downloadUrl = downloadUrl;
	}

	public String getPdfPath() {
		return pdfPath;
	}

	public void setPdfPath(String pdfPath) {
		this.pdfPath = pdfPath;
	}

	public String getSwfPath() {
		return swfPath;
	}

	public void setSwfPath(String swfPath) {
		this.swfPath = swfPath;
	}

	public Integer getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(Integer totalPages) {
		this.totalPages = totalPages;
	}

	public Long getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(Long deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public String getGmtCreateUserName() {
		return gmtCreateUserName;
	}

	public void setGmtCreateUserName(String gmtCreateUserName) {
		this.gmtCreateUserName = gmtCreateUserName;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

}
