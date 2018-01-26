/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.xzb.showcase.system.entity;

import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.xzb.showcase.base.entity.BaseEntity;

@Entity
@Table(name = "tc_system_user")
public class UserEntity extends BaseEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@NotNull(message = "用户名不能为空")
	@Size(min = 3, max = 20, message = "用户名长度限制3-20位")
	private String loginName;
	// 不显示在Restful接口的属性.
	@NotNull(message = "密码不能为空")
	@Size(min = 3, max = 32, message = "密码长度限制3-32位")
	@JsonIgnore
	private String password;
	@NotNull(message = "真实姓名不能为空")
	@Size(min = 2, max = 10, message = "真实姓名长度限制2-10位")
	private String name;
	// @NotNull(message = "性别不能为空")
	private Integer sex;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birthday;
	private String telephone;
	private String mobile;
	private String email;
	private String companyAddress;
	private String homeAddress;
	private Integer jobId;
	private Integer managerId;
	private Integer statusId;
	private String pinyinName;
	private String workcode;
	private Integer secLevel;
	private String headImgUrl;

	/**
	 * 第一学历
	 */
	private String education1;
	/**
	 * 第二学历
	 */
	private String education2;
	/**
	 * 身份证
	 */
	@Size(max = 18, message = "身份证最大长度限制18位")
	private String idCard;
	/**
	 * 员工卡号
	 */
	private String cardNo;

	/**
	 * 第一资质证书
	 */
	private Integer qualification;
	/**
	 * 第二资质证书
	 */
	private Integer qualification2;

	// 排序
	private int sortNumber;
	// 0-不显示,1-显示
	private int display;

	/**
	 * 公司
	 */
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "company_id")
	@Fetch(FetchMode.JOIN)
	private CompanyEntity companyEntity;

	/**
	 * 部门
	 */
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "dep_id")
	@Fetch(FetchMode.JOIN)
	private DepartmentEntity departmentEntity;

	/**
	 * 职位
	 */
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "pos_id")
	@Fetch(FetchMode.JOIN)
	private PositionEntity positionEntity;

	/**
	 * 人员角色
	 */
	@JsonIgnore
	@OneToMany(mappedBy = "user", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
	private Set<RoleUserEntity> roleUsers;
	/**
	 * 用户系统设置
	 */
	@JsonIgnore
	@OneToMany(mappedBy = "user", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
	private List<UserSettingEntity> userSettingEntities;

	public Set<RoleUserEntity> getRoleUsers() {
		return roleUsers;
	}

	public void setRoleUsers(Set<RoleUserEntity> roleUsers) {
		this.roleUsers = roleUsers;
	}

	public UserEntity() {
	}

	public UserEntity(Long id) {
		this.id = id;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCompanyAddress() {
		return companyAddress;
	}

	public void setCompanyAddress(String companyAddress) {
		this.companyAddress = companyAddress;
	}

	public String getHomeAddress() {
		return homeAddress;
	}

	public void setHomeAddress(String homeAddress) {
		this.homeAddress = homeAddress;
	}

	public Integer getJobId() {
		return jobId;
	}

	public void setJobId(Integer jobId) {
		this.jobId = jobId;
	}

	public CompanyEntity getCompanyEntity() {
		return companyEntity;
	}

	public void setCompanyEntity(CompanyEntity companyEntity) {
		this.companyEntity = companyEntity;
	}

	public DepartmentEntity getDepartmentEntity() {
		return departmentEntity;
	}

	public void setDepartmentEntity(DepartmentEntity departmentEntity) {
		this.departmentEntity = departmentEntity;
	}

	public Integer getManagerId() {
		return managerId;
	}

	public void setManagerId(Integer managerId) {
		this.managerId = managerId;
	}

	public Integer getStatusId() {
		return statusId;
	}

	public void setStatusId(Integer statusId) {
		this.statusId = statusId;
	}

	public String getPinyinName() {
		return pinyinName;
	}

	public void setPinyinName(String pinyinName) {
		this.pinyinName = pinyinName;
	}

	public String getWorkcode() {
		return workcode;
	}

	public void setWorkcode(String workcode) {
		this.workcode = workcode;
	}

	public Integer getSecLevel() {
		return secLevel;
	}

	public void setSecLevel(Integer secLevel) {
		this.secLevel = secLevel;
	}

	public List<UserSettingEntity> getUserSettingEntities() {
		return userSettingEntities;
	}

	public void setUserSettingEntities(
			List<UserSettingEntity> userSettingEntities) {
		this.userSettingEntities = userSettingEntities;
	}

	public String getHeadImgUrl() {
		return headImgUrl;
	}

	public void setHeadImgUrl(String headImgUrl) {
		this.headImgUrl = headImgUrl;
	}

	public PositionEntity getPositionEntity() {
		return positionEntity;
	}

	public void setPositionEntity(PositionEntity positionEntity) {
		this.positionEntity = positionEntity;
	}

	public int getSortNumber() {
		return sortNumber;
	}

	public void setSortNumber(int sortNumber) {
		this.sortNumber = sortNumber;
	}

	public int getDisplay() {
		return display;
	}

	public void setDisplay(int display) {
		this.display = display;
	}

	public String getEducation1() {
		return education1;
	}

	public void setEducation1(String education1) {
		this.education1 = education1;
	}

	public String getEducation2() {
		return education2;
	}

	public void setEducation2(String education2) {
		this.education2 = education2;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public Integer getQualification() {
		return qualification;
	}

	public void setQualification(Integer qualification) {
		this.qualification = qualification;
	}

	public Integer getQualification2() {
		return qualification2;
	}

	public void setQualification2(Integer qualification2) {
		this.qualification2 = qualification2;
	}

}