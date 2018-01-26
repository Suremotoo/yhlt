package com.xzb.showcase.datapermission.entity;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Formula;

import com.xzb.showcase.base.entity.BaseEntity;
import com.xzb.showcase.system.entity.CompanyEntity;
import com.xzb.showcase.system.entity.DepartmentEntity;
import com.xzb.showcase.system.entity.ResourcesEntity;
import com.xzb.showcase.system.entity.RoleEntity;
import com.xzb.showcase.system.entity.UserEntity;

/**
 * 数据规则引擎-用户关系
 * 
 * @author admin
 * 
 */
@Entity
@Table(name = "tr_system_datapermission_rule_user")
public class DataPermissionRuleUserEntity extends BaseEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5703005067377408274L;

	@ManyToOne
	@JoinColumn(name = "company_id")
	private CompanyEntity companyEntity;

	@ManyToOne
	@JoinColumn(name = "department_id")
	private DepartmentEntity departmentEntity;

	@ManyToOne
	@JoinColumn(name = "role_id")
	private RoleEntity roleEntity;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private UserEntity userEntity;

	@ManyToOne
	@JoinColumn(name = "resource_id")
	private ResourcesEntity resourcesEntity;

	@ManyToOne
	@JoinColumn(name = "rule_id")
	private DataPermissionRuleEntity ruleEntity;

	/**
	 * 排序编码
	 */
	private Long sortNumber = 0L;

	/**
	 * 创建人
	 */
	@Formula("(select u.name from tc_system_user u where u.id=create_by_id)")
	private String createUser;
	@Formula("(select u.name from tc_system_user u where u.id=last_modified_by_id)")
	private String lastModifier;

	public DataPermissionRuleUserEntity() {
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

	public RoleEntity getRoleEntity() {
		return roleEntity;
	}

	public void setRoleEntity(RoleEntity roleEntity) {
		this.roleEntity = roleEntity;
	}

	public UserEntity getUserEntity() {
		return userEntity;
	}

	public void setUserEntity(UserEntity userEntity) {
		this.userEntity = userEntity;
	}

	public ResourcesEntity getResourcesEntity() {
		return resourcesEntity;
	}

	public void setResourcesEntity(ResourcesEntity resourcesEntity) {
		this.resourcesEntity = resourcesEntity;
	}

	public DataPermissionRuleEntity getRuleEntity() {
		return ruleEntity;
	}

	public void setRuleEntity(DataPermissionRuleEntity ruleEntity) {
		this.ruleEntity = ruleEntity;
	}

	public String getCreateUser() {
		return createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public String getLastModifier() {
		return lastModifier;
	}

	public void setLastModifier(String lastModifier) {
		this.lastModifier = lastModifier;
	}

	public Long getSortNumber() {
		return sortNumber;
	}

	public void setSortNumber(Long sortNumber) {
		this.sortNumber = sortNumber;
	}

}
