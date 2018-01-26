/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.xzb.showcase.system.entity;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.xzb.showcase.base.entity.BaseEntity;

/**
 * 用户自定义设置
 * 
 * @author admin
 * 
 */
@Entity
@Table(name = "tc_system_user_setting")
public class UserSettingEntity extends BaseEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 用户
	 */
	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	private UserEntity user;
	/**
	 * 用户Portal设置
	 */
	private String portalContent;
	/**
	 * 用户主题
	 */
	private String theme;
	/**
	 * 组件主题
	 */
	private String modeThemes;
	/**
	 * 组件主题
	 */
	private String componentThemes;

	public UserSettingEntity() {
	}

	public UserEntity getUser() {
		return user;
	}

	public void setUser(UserEntity user) {
		this.user = user;
	}

	public String getPortalContent() {
		return portalContent;
	}

	public void setPortalContent(String portalContent) {
		this.portalContent = portalContent;
	}

	public String getTheme() {
		return theme;
	}

	public void setTheme(String theme) {
		this.theme = theme;
	}

	public String getModeThemes() {
		return modeThemes;
	}

	public void setModeThemes(String modeThemes) {
		this.modeThemes = modeThemes;
	}

	public String getComponentThemes() {
		return componentThemes;
	}

	public void setComponentThemes(String componentThemes) {
		this.componentThemes = componentThemes;
	}

}