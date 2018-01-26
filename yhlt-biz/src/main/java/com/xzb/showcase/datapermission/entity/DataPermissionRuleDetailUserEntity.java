package com.xzb.showcase.datapermission.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.xzb.showcase.base.entity.IdEntity;

/**
 * 数据规则引擎-用户-属性-资源关系视图
 * 
 * @author admin
 * 
 */
@Entity
@Table(name = "v_system_datapermission")
public class DataPermissionRuleDetailUserEntity extends IdEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3059388674427330968L;
	private Long resourceId;
	private String name;
	private String remark;
	private Long propertyId;
	private String propertyName;
	private String type;
	private String operator;
	private String value;
	private String conditionGroup;
	private Long sortNumber = 0L;
	private Long companyId;
	private Long departmentId;
	private Long roleId;
	private Long userId;
	private String code;
	private String description;
	private String url;
	private int isAll;

	public DataPermissionRuleDetailUserEntity() {
	}

	public Long getResourceId() {
		return resourceId;
	}

	public void setResourceId(Long resourceId) {
		this.resourceId = resourceId;
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

	public Long getPropertyId() {
		return propertyId;
	}

	public void setPropertyId(Long propertyId) {
		this.propertyId = propertyId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public Long getSortNumber() {
		return sortNumber;
	}

	public void setSortNumber(Long sortNumber) {
		this.sortNumber = sortNumber;
	}

	public Long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}

	public Long getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(Long departmentId) {
		this.departmentId = departmentId;
	}

	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
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
