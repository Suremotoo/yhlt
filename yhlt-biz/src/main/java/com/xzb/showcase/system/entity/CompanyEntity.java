package com.xzb.showcase.system.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.xzb.showcase.base.entity.BaseEntity;

/**
 * 组织机构-公司<br>
 * 删除公司时需要删除下子公司 <br>
 * 删除公司时需要删除公司下部门<br>
 * 
 * 
 * @author wj
 * @date 2014年12月25日20:20:45
 */
@Entity
@Table(name = "tc_system_company")
public class CompanyEntity extends BaseEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3627868618657398768L;
	/**
	 * 名称
	 */
	@NotNull(message = "公司名不能为空")
	@Size(min = 2, max = 20, message = "名称长度限制2-20位")
	private String name;
	/**
	 * 层级
	 */
	private int layer;
	/**
	 * 图标
	 */
	private String icon;
	/**
	 * 排序编码
	 */
	private Long sortNumber = 0L;
	/**
	 * 删除标记（0：正常 1：已删除）
	 */
	private Long deleteFlag = 0L;
	/**
	 * 父公司
	 */
	// @Transient
	private Long parentId = 0L;
	// /**
	// * 父公司
	// */
	// @ManyToOne
	// @JoinColumn(name = "parent_id")
	// @NotFound(action = NotFoundAction.IGNORE)
	// private CompanyEntity parent;
	@Transient
	private String iconCls = "icon2 r14_c19";
	/**
	 * 子集合
	 */
	// @JsonIgnore
	@OneToMany(mappedBy = "parentId", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
	@OrderBy("sortNumber")
	private Set<CompanyEntity> children = new HashSet<CompanyEntity>();

	/**
	 * 子部门
	 */
	@JsonIgnore
	@OneToMany(mappedBy = "companyEntity", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
	@OrderBy("sortNumber")
	private Set<DepartmentEntity> departmentEntities = new HashSet<DepartmentEntity>();
	
	/**
	 * 公司权限左边公司子集合
	 */
	@JsonIgnore
	@OneToMany(mappedBy = "companyPerEntity", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
	private Set<CompanyPermissionEntity> companyPerEntitySet = new HashSet<CompanyPermissionEntity>();
	
	
	/**
	 * 公司权限右边公司子集合
	 */
	@JsonIgnore
	@OneToMany(mappedBy = "companyMappingEntity", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
	private Set<CompanyPermissionEntity> companyMappingEntitySet = new HashSet<CompanyPermissionEntity>();

	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public Long getSortNumber() {
		return sortNumber;
	}

	public void setSortNumber(Long sortNumber) {
		this.sortNumber = sortNumber;
	}

	public Long getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(Long deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

	public Set<CompanyEntity> getChildren() {
		return children;
	}

	public void setChildren(Set<CompanyEntity> children) {
		this.children = children;
	}

	// public CompanyEntity getParent() {
	// return parent;
	// }
	//
	// public void setParent(CompanyEntity parent) {
	// this.parent = parent;
	// }

	public Set<DepartmentEntity> getDepartmentEntities() {
		return departmentEntities;
	}

	public void setDepartmentEntities(Set<DepartmentEntity> departmentEntities) {
		this.departmentEntities = departmentEntities;
	}

	public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}

	public Set<CompanyPermissionEntity> getCompanyPerEntitySet() {
		return companyPerEntitySet;
	}

	public void setCompanyPerEntitySet(
			Set<CompanyPermissionEntity> companyPerEntitySet) {
		this.companyPerEntitySet = companyPerEntitySet;
	}

	public Set<CompanyPermissionEntity> getCompanyMappingEntitySet() {
		return companyMappingEntitySet;
	}

	public void setCompanyMappingEntitySet(
			Set<CompanyPermissionEntity> companyMappingEntitySet) {
		this.companyMappingEntitySet = companyMappingEntitySet;
	}
	
	

}
