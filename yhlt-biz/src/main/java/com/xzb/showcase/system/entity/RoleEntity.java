/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.xzb.showcase.system.entity;

import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.apache.commons.lang3.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.xzb.showcase.base.entity.BaseEntity;

@Entity
@Table(name = "tc_system_role")
public class RoleEntity extends BaseEntity<Long> {

	private static final long serialVersionUID = 1L;
	@NotNull(message = "名称不能为空")
	@Size(min = 2, max = 10, message = "名称长度限制2-10位")
	private String name;
	private String remark;
	private int sort_number;
	private int delete_flag;
	@NotNull(message = "公司不能为空")
	private Long companyId;

	/**
	 * 角色人员集合
	 */
	@JsonIgnore
	@OneToMany(mappedBy = "role", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
	private List<RoleUserEntity> roleUsers;

	/**
	 * 角色资源集合
	 */
	@JsonIgnore
	@OneToMany(mappedBy = "role", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
	private Set<RoleResourcesEntity> roleResourcess;

	public Set<RoleResourcesEntity> getRoleResourcess() {
		return roleResourcess;
	}

	public void setRoleResourcess(Set<RoleResourcesEntity> roleResourcess) {
		this.roleResourcess = roleResourcess;
	}

	public List<RoleUserEntity> getRoleUsers() {
		return roleUsers;
	}

	public void setRoleUsers(List<RoleUserEntity> roleUsers) {
		this.roleUsers = roleUsers;
	}

	public Long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public int getSort_number() {
		return sort_number;
	}

	public void setSort_number(int sort_number) {
		this.sort_number = sort_number;
	}

	public int getDelete_flag() {
		return delete_flag;
	}

	public void setDelete_flag(int delete_flag) {
		this.delete_flag = delete_flag;
	}

}