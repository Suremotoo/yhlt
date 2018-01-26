package com.xzb.showcase.system.entity;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.xzb.showcase.base.entity.BaseEntity;

/**
 * 业务日志表
 * 
 * @author wj
 * 
 */
@Entity
@Table(name = "tc_system_log")
public class SystemLog extends BaseEntity<Long> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "createById", insertable = false, updatable = false)
	private UserEntity userInfo;
	// 业务表主键ID
	private String entityId;
	// 后台业务类
	private String service;
	// 操作前内容
	private String content;
	// 后台业务方法
	private String operation;
	// 返回结果
	private String result;
	// 类名称
	private String className;

	public SystemLog() {
	}

	public UserEntity getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(UserEntity userInfo) {
		this.userInfo = userInfo;
	}

	public String getEntityId() {
		return entityId;
	}

	public void setEntityId(String entityId) {
		this.entityId = entityId;
	}

	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getOperation() {
		return operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

}
