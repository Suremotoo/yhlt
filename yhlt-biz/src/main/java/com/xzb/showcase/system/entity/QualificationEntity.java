package com.xzb.showcase.system.entity;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.xzb.showcase.base.entity.BaseEntity;

/**
 * 资质证书
 * 
 * @author LauLimXiao
 * 
 */
@Entity
@Table(name = "tm_system_qualification")
public class QualificationEntity extends BaseEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5608026178290186501L;
	/**
	 * 唯一标识
	 */
	/*@NotNull(message = "uuid不能为空")
	@Size(min = 1, max = 20, message = "uuid长度限制1-20位")*/
	private String uuid;
	/**
	 * 资质证书备注
	 */
	private String remark;

	/**
	 * 证书名
	 */
	@NotNull(message = "证书名不能为空")
	private String name;

	/**
	 * 父级证书id
	 */
	private Integer parentId;

	/**
	 * 子集证书集合
	 */
	@OneToMany(mappedBy = "parentId", fetch = FetchType.LAZY, cascade = {
			CascadeType.REMOVE, CascadeType.MERGE })
	private Set<QualificationEntity> children = new HashSet<QualificationEntity>();
	/**
	 * 证书检查日期
	 */
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date checkPeriod;
	/**
	 * 证书有效期
	 */
	@NotNull(message = "证书有效期不能为空")
	private Integer validDate;

	/**
	 * 节点图标
	 */
	@Transient
	private String iconCls = "icon2 r22_c5";

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public Date getCheckPeriod() {
		return checkPeriod;
	}

	public void setCheckPeriod(Date checkPeriod) {
		this.checkPeriod = checkPeriod;
	}

	public Integer getValidDate() {
		return validDate;
	}

	public void setValidDate(Integer validDate) {
		this.validDate = validDate;
	}

	public Set<QualificationEntity> getChildren() {
		return children;
	}

	public void setChildren(Set<QualificationEntity> children) {
		this.children = children;
	}

	public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}

}
