package com.xzb.showcase.system.entity;

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
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.Formula;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.xzb.showcase.base.entity.BaseEntity;

/**
 * 组织机构-部门 <br>
 * 删除部门时，删除部门下人员<br>
 * 
 * @author wj
 * @date 2014年12月25日20:20:45
 */
/**
 * @author hubaojie
 *
 */
/**
 * @author hubaojie
 * 
 */
@Entity
@Table(name = "tc_system_department")
public class DepartmentEntity extends BaseEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7782317696821552723L;
	/**
	 * 名称
	 */
	@NotNull(message = "部门名不能为空")
	@Size(min = 2, max = 20, message = "名称长度限制2-20位")
	private String name;
	/**
	 * 层级
	 */
	private Integer layer;
	/**
	 * 排序编码
	 */
	private Long sortNumber = 0L;
	/**
	 * 删除标记（0：正常 1：已删除）
	 */
	private Long deleteFlag = 0L;

	/**
	 * 公司
	 */
	@ManyToOne
	@JoinColumn(name = "company_id")
	private CompanyEntity companyEntity;
	/**
	 * 父菜单
	 */
	private long parentId;

	/**
	 * 子集合
	 */
	@OneToMany(mappedBy = "parentId", fetch = FetchType.LAZY, cascade = {
			CascadeType.REMOVE, CascadeType.MERGE })
	@OrderBy("sortNumber")
	private Set<DepartmentEntity> children = new HashSet<DepartmentEntity>();

	/**
	 * 子集合
	 */
	@JsonIgnore
	@OneToMany(mappedBy = "departmentEntity")
	@Fetch(FetchMode.JOIN)
	private Set<UserEntity> userEntities = new HashSet<UserEntity>();

	@Transient
	private int userCount;

	@Transient
	private String iconCls = "icon2 r22_c5";

	/**
	 * 部门负责人
	 */
	private Long headId;
	@Formula(value = "(select t.name  from  tc_system_user t where  t.id=head_id)")
	private String deptHeadName;

	/**
	 * 部门领导
	 */
	private Long leaderId;
	@Formula(value = "(select t.name  from  tc_system_user t where  t.id=leader_id)")
	private String deptLeaderName;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public long getParentId() {
		return parentId;
	}

	public void setParentId(long parentId) {
		this.parentId = parentId;
	}

	public Set<DepartmentEntity> getChildren() {
		return children;
	}

	public void setChildren(Set<DepartmentEntity> children) {
		this.children = children;
	}

	public CompanyEntity getCompanyEntity() {
		return companyEntity;
	}

	public void setCompanyEntity(CompanyEntity companyEntity) {
		this.companyEntity = companyEntity;
	}

	public Set<UserEntity> getUserEntities() {
		return userEntities;
	}

	public void setUserEntities(Set<UserEntity> userEntities) {
		this.userEntities = userEntities;
	}

	public int getUserCount() {
		return this.userCount;
	}

	public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}

	public String getDeptHeadName() {
		return deptHeadName;
	}

	public void setDeptHeadName(String deptHeadName) {
		this.deptHeadName = deptHeadName;
	}

	public String getDeptLeaderName() {
		return deptLeaderName;
	}

	public void setDeptLeaderName(String deptLeaderName) {
		this.deptLeaderName = deptLeaderName;
	}

	public Long getHeadId() {
		return headId;
	}

	public void setHeadId(Long headId) {
		this.headId = headId;
	}

	public Long getLeaderId() {
		return leaderId;
	}

	public void setLeaderId(Long leaderId) {
		this.leaderId = leaderId;
	}


	public void setUserCount(int userCount) {
		this.userCount = userCount;
	}

	public Integer getLayer() {
		return layer;
	}

	public void setLayer(Integer layer) {
		this.layer = layer;
	}
	

}
