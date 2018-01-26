package com.xzb.showcase.risk.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Where;

import com.xzb.showcase.base.entity.BaseEntity;

/**
 * 安保专项类型
 * 
 * @author LauLimXiao
 * 
 */
@Entity
@Table(name = "tm_sms_security_assurance")
public class SecurityAssuranceEntity extends BaseEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3632471742133768685L;

	/**
	 * 类型名
	 */
	private String name;
	/**
	 * 说明
	 */
	private String remark;
	/**
	 * 0：分类，1：检查项，2：检查依据，3：检查依据明细
	 */
	private Integer type;
	/**
	 * 排序
	 */
	private Integer sortNumber;
 
	/**
	 * 父级id
	 */
	private Long parentId = 0L;

	@OneToMany(mappedBy = "parentId", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
	@OrderBy("sortNumber")
	@Where(clause = "type=0")
	private Set<SecurityAssuranceEntity> children = new HashSet<SecurityAssuranceEntity>();
	
	/**
	 * uuid
	 */
	private String uuid;
	
	@Transient
	private String iconCls = "icon2 r4_c4";

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

	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getSortNumber() {
		return sortNumber;
	}

	public void setSortNumber(Integer sortNumber) {
		this.sortNumber = sortNumber;
	}

	public Set<SecurityAssuranceEntity> getChildren() {
		return children;
	}

	public void setChildren(Set<SecurityAssuranceEntity> children) {
		this.children = children;
	}

	public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}


}
