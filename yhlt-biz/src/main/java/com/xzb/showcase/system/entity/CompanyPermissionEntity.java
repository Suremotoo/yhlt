package com.xzb.showcase.system.entity;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.LazyToOne;
import org.hibernate.annotations.LazyToOneOption;

import com.xzb.showcase.base.entity.BaseEntity;

/**
 * 公司数据权限Entity
 * @author hubaojie
 *
 */
@Entity
@Table(name="tr_system_company_permission")
@SuppressWarnings("serial")
public class CompanyPermissionEntity extends BaseEntity<Long> {

	@ManyToOne
	@JoinColumn(name="company_id")
	@Fetch(FetchMode.SELECT)
	@LazyToOne(LazyToOneOption.FALSE)
	private CompanyEntity companyPerEntity;
	
	@ManyToOne(optional=true)
	@JoinColumn(name="company_data_id")
	@Fetch(FetchMode.SELECT)
	@LazyToOne(LazyToOneOption.FALSE)
	private CompanyEntity companyMappingEntity;
	
	private Long typeId;
	

	public CompanyEntity getCompanyMappingEntity() {
		return companyMappingEntity;
	}

	public void setCompanyMappingEntity(CompanyEntity companyMappingEntity) {
		this.companyMappingEntity = companyMappingEntity;
	}

	public Long getTypeId() {
		return typeId;
	}

	public void setTypeId(Long typeId) {
		this.typeId = typeId;
	}

	public CompanyEntity getCompanyPerEntity() {
		return companyPerEntity;
	}

	public void setCompanyPerEntity(CompanyEntity companyPerEntity) {
		this.companyPerEntity = companyPerEntity;
	}
	
	
}
