/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.xzb.showcase.system.entity;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.xzb.showcase.base.entity.BaseEntity;

/**
 * 
 * @author wyt 电子签名
 * 
 */
@Entity
@Table(name = "tr_system_user_signature")
public class UserSignatureEntity extends BaseEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = -528830373892101512L;
	/**
	 * 用户
	 */
	@ManyToOne
	@JoinColumn(name = "user_id")
	private UserEntity user;
	/**
	 * 文件
	 */
	@ManyToOne
	@JoinColumn(name = "file_id")
	private FileEntity file;
	@NotNull(message = "密码不能为空")
	@Size(min = 6, max = 32, message = "密码长度限制6-32位")
	@JsonIgnore
	private String password;

	public UserEntity getUser() {
		return user;
	}

	public void setUser(UserEntity user) {
		this.user = user;
	}

	public FileEntity getFile() {
		return file;
	}

	public void setFile(FileEntity file) {
		this.file = file;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}