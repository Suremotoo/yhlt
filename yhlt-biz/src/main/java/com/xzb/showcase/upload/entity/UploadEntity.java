package com.xzb.showcase.upload.entity;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.xzb.showcase.base.entity.BaseEntity;

/**
 * 组织机构-公司<br>
 * 删除公司时需要删除下子公司 <br>
 * 删除公司时需要删除公司下部门<br>
 * 
 * 
 * @author wj
 * @date 2014年12月25日20:20:45
 */
@Entity
@Table(name = "tm_file_upload")
public class UploadEntity extends BaseEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 文件名
	 */
	private String fileName;
	/**
	 * 文件存储名
	 */
	private String realName;
	/**
	 * 文件存储路径
	 */
	private String realPath;
	/**
	 * 相对web 系统的访问路径
	 */
	private String sysName;
	/**
	 * 以下参数为断点续传参数 上传文件最后修改时间
	 */
	private Date lastModified;

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getRealPath() {
		return realPath;
	}

	public void setRealPath(String realPath) {
		this.realPath = realPath;
	}

	public String getSysName() {
		return sysName;
	}

	public void setSysName(String sysName) {
		this.sysName = sysName;
	}

	public Date getLastModified() {
		return lastModified;
	}

	public void setLastModified(Date lastModified) {
		this.lastModified = lastModified;
	}
}
