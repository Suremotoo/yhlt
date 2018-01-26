package com.xzb.showcase.datapermission.entity;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.annotations.Formula;

import com.xzb.showcase.base.entity.BaseEntity;

/**
 * 数据规则引擎-规则明细
 * 
 * @author admin
 * 
 */
@Entity
@Table(name = "tc_system_datapermission_rule_detail")
public class DataPermissionRuleDetailEntity extends BaseEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5703005067377408274L;

	@ManyToOne
	@JoinColumn(name = "rule_id")
	private DataPermissionRuleEntity ruleEntity;

	@ManyToOne
	@JoinColumn(name = "property_id")
	private DataPermissionPropertyEntity propertyEntity;
	// 查询类属性
	private String propertyName;
	// 操作符
	private String operator;
	// checkbox,input
	private String type;
	// 选定内容名称
	private String name;

	@NotNull(message = "规则明细值不能为空")
	@Size(min = 1, max = 500, message = "值长度限制1-500位")
	private String value;

	private int isAll;
	/**
	 * 排序编码
	 */
	private Long sortNumber = 0L;
	/**
	 * 条件分组KEY
	 */
	private String conditionGroup;
	/**
	 * 创建人
	 */
	@Formula("(select u.name from tc_system_user u where u.id=create_by_id)")
	private String createUser;
	@Formula("(select u.name from tc_system_user u where u.id=last_modified_by_id)")
	private String lastModifier;

	public DataPermissionRuleDetailEntity() {
	}

	public DataPermissionRuleEntity getRuleEntity() {
		return ruleEntity;
	}

	public void setRuleEntity(DataPermissionRuleEntity ruleEntity) {
		this.ruleEntity = ruleEntity;
	}

	public DataPermissionPropertyEntity getPropertyEntity() {
		return propertyEntity;
	}

	public void setPropertyEntity(DataPermissionPropertyEntity propertyEntity) {
		this.propertyEntity = propertyEntity;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPropertyName() {
		return propertyName;
	}

	public void setPropertyName(String propertyName) {
		this.propertyName = propertyName;
	}

	public int getIsAll() {
		return isAll;
	}

	public void setIsAll(int isAll) {
		this.isAll = isAll;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public String getConditionGroup() {
		return conditionGroup;
	}

	public void setConditionGroup(String conditionGroup) {
		this.conditionGroup = conditionGroup;
	}

}
