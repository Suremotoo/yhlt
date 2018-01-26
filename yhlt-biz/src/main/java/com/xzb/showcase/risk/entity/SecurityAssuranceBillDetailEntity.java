package com.xzb.showcase.risk.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.xzb.showcase.base.entity.BaseEntity;

/**
 * 安保专项检查单详情
 * 
 * @author LauLimXiao
 * 
 */
@Entity
@Table(name = "tm_sms_security_assurance_bill_detail")
public class SecurityAssuranceBillDetailEntity extends BaseEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5765347203726796293L;
	/**
	 * uuid
	 */
	private String uuid;
	/**
	 * 检查单id
	 */
	private Integer billId;
	/**
	 * 公司id
	 */
	private Integer companyId;
	/**
	 * 部门id
	 */
	private Integer departmentId;

	/**
	 * 大分类id
	 */
	private Integer securityAssuranceTypeOneId;
	/**
	 * 大分类名称
	 */
	private String securityAssuranceTypeOneName;
	/**
	 * 小分类id
	 */
	private Integer securityAssuranceTypeTwoId;
	/**
	 * 小分类名称
	 */
	private String securityAssuranceTypeTwoName;
	/**
	 * 检查依据id
	 */
	private Integer securityAssuranceGistId;
	/**
	 * 检查依据名称
	 */
	private String securityAssuranceGistName;
	/**
	 * 检查标准id
	 */
	private Integer securityAssuranceStandardId;
	/**
	 * 检查标准名称
	 */
	private String securityAssuranceStandardName;

	/**
	 * 检查状态 0符合,1不符合,2未检查,3不适用
	 */
	private Integer status;
	/**
	 * 检查状态 0符合,1不符合,2未检查,3不适用
	 */
	@SuppressWarnings("unused")
	@Transient
	private String statusWrapper;

	/**
	 * 备注
	 */
	private String remark;
	/**
	 * 流程id
	 */
	private Long processId;

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public Integer getBillId() {
		return billId;
	}

	public void setBillId(Integer billId) {
		this.billId = billId;
	}

	public Integer getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}

	public Integer getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(Integer departmentId) {
		this.departmentId = departmentId;
	}

	public Integer getSecurityAssuranceTypeOneId() {
		return securityAssuranceTypeOneId;
	}

	public void setSecurityAssuranceTypeOneId(Integer securityAssuranceTypeOneId) {
		this.securityAssuranceTypeOneId = securityAssuranceTypeOneId;
	}

	public String getSecurityAssuranceTypeOneName() {
		return securityAssuranceTypeOneName;
	}

	public void setSecurityAssuranceTypeOneName(
			String securityAssuranceTypeOneName) {
		this.securityAssuranceTypeOneName = securityAssuranceTypeOneName;
	}

	public Integer getSecurityAssuranceTypeTwoId() {
		return securityAssuranceTypeTwoId;
	}

	public void setSecurityAssuranceTypeTwoId(Integer securityAssuranceTypeTwoId) {
		this.securityAssuranceTypeTwoId = securityAssuranceTypeTwoId;
	}

	public String getSecurityAssuranceTypeTwoName() {
		return securityAssuranceTypeTwoName;
	}

	public void setSecurityAssuranceTypeTwoName(
			String securityAssuranceTypeTwoName) {
		this.securityAssuranceTypeTwoName = securityAssuranceTypeTwoName;
	}

	public Integer getSecurityAssuranceGistId() {
		return securityAssuranceGistId;
	}

	public void setSecurityAssuranceGistId(Integer securityAssuranceGistId) {
		this.securityAssuranceGistId = securityAssuranceGistId;
	}

	public String getSecurityAssuranceGistName() {
		return securityAssuranceGistName;
	}

	public void setSecurityAssuranceGistName(String securityAssuranceGistName) {
		this.securityAssuranceGistName = securityAssuranceGistName;
	}

	public Integer getSecurityAssuranceStandardId() {
		return securityAssuranceStandardId;
	}

	public void setSecurityAssuranceStandardId(
			Integer securityAssuranceStandardId) {
		this.securityAssuranceStandardId = securityAssuranceStandardId;
	}

	public String getSecurityAssuranceStandardName() {
		return securityAssuranceStandardName;
	}

	public void setSecurityAssuranceStandardName(
			String securityAssuranceStandardName) {
		this.securityAssuranceStandardName = securityAssuranceStandardName;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getStatusWrapper() {
		if (status == 0) {
			return "符合";
		} else if (status == 1) {
			return "不符合";
		} else if (status == 2) {
			return "未检查";
		} else {
			return "不适用";
		}
	}

	public void setStatusWrapper(String statusWrapper) {
		this.statusWrapper = statusWrapper;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Long getProcessId() {
		return processId;
	}

	public void setProcessId(Long processId) {
		this.processId = processId;
	}

}
