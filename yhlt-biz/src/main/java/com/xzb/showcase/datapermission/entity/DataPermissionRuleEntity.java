package com.xzb.showcase.datapermission.entity;

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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.annotations.Formula;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.xzb.showcase.base.entity.BaseEntity;
import com.xzb.showcase.system.entity.ResourcesEntity;

/**
 * 数据规则引擎-规则
 * 
 * @author admin
 * 
 */
@Entity
@Table(name = "tc_system_datapermission_rule")
public class DataPermissionRuleEntity extends BaseEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5703005067377408274L;

	@ManyToOne
	@JoinColumn(name = "resource_id")
	private ResourcesEntity resourcesEntity;

	@NotNull(message = "规则名称不能为空")
	@Size(min = 2, max = 20, message = "规则名称长度限制2-20位")
	private String name;

	private int enable;

	private String remark;
	/**
	 * 规则明细
	 */
	@JsonIgnore
	@OneToMany(mappedBy = "ruleEntity", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
	@OrderBy("sortNumber")
	private Set<DataPermissionRuleDetailEntity> ruleDetailEntities = new HashSet<DataPermissionRuleDetailEntity>();
	/**
	 * 规则关联用户
	 */
	@JsonIgnore
	@OneToMany(mappedBy = "ruleEntity", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
	@OrderBy("sortNumber")
	private Set<DataPermissionRuleUserEntity> ruleUserEntities = new HashSet<DataPermissionRuleUserEntity>();
	/**
	 * 创建人
	 */
	@Formula("(select u.name from tc_system_user u where u.id=create_by_id)")
	private String createUser;
	@Formula("(select u.name from tc_system_user u where u.id=last_modified_by_id)")
	private String lastModifier;

	public DataPermissionRuleEntity() {
	}

	public ResourcesEntity getResourcesEntity() {
		return resourcesEntity;
	}

	public void setResourcesEntity(ResourcesEntity resourcesEntity) {
		this.resourcesEntity = resourcesEntity;
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

	public Set<DataPermissionRuleDetailEntity> getRuleDetailEntities() {
		return ruleDetailEntities;
	}

	public void setRuleDetailEntities(
			Set<DataPermissionRuleDetailEntity> ruleDetailEntities) {
		this.ruleDetailEntities = ruleDetailEntities;
	}

	public Set<DataPermissionRuleUserEntity> getRuleUserEntities() {
		return ruleUserEntities;
	}

	public void setRuleUserEntities(
			Set<DataPermissionRuleUserEntity> ruleUserEntities) {
		this.ruleUserEntities = ruleUserEntities;
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

	public int getEnable() {
		return enable;
	}

	public void setEnable(int enable) {
		this.enable = enable;
	}

}
