package com.xzb.showcase.system.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.xzb.showcase.base.entity.BaseEntity;

/**
 * 职位管理
 * @author lls
 *
 */
@Entity
@Table(name="tc_system_position")
public class PositionEntity extends BaseEntity<Long>{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7186651772219188691L;

	/**
	 * 职位名称
	 */
	@NotNull(message = "名称不能为空")
	@Size(min = 1, max = 20, message = "名称长度限制1-20位")
	private String name;
	/**
	 * 备注
	 */
	private String remark;
	/**
	 * 排序编码
	 */
	private Long sortNumber = 0L;
	
	
	/**
	 * 子集合
	 */
	@JsonIgnore
	@OneToMany(mappedBy = "positionEntity")
	@Fetch(FetchMode.JOIN)
	private Set<UserEntity> userEntities = new HashSet<UserEntity>();
	
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
	public Long getSortNumber() {
		return sortNumber;
	}
	public void setSortNumber(Long sortNumber) {
		this.sortNumber = sortNumber;
	}
	public Set<UserEntity> getUserEntities() {
		return userEntities;
	}
	public void setUserEntities(Set<UserEntity> userEntities) {
		this.userEntities = userEntities;
	}
	
	
	
	
}
