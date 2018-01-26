package com.xzb.showcase.risk.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Formula;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.xzb.showcase.base.entity.BaseEntity;
import com.xzb.showcase.system.entity.CompanyEntity;
import com.xzb.showcase.system.entity.DepartmentEntity;

/**
 * 安保专项检查单
 * 
 * @author LauLimXiao
 * 
 */
@Entity
@Table(name = "tm_sms_security_assurance_bill")
public class SecurityAssuranceBillEntity extends BaseEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2020716372551986738L;

	/**
	 * uuid
	 */
	private String uuid;

	/**
	 * 检查单日期
	 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@Column(insertable = true, updatable = true)
	private Date billDate;
	/**
	 * 公司
	 */
	@ManyToOne
	@JoinColumn(name = "company_id")
	private CompanyEntity companyEntity;
	/**
	 * 部门
	 */
	@ManyToOne
	@JoinColumn(name = "department_id")
	private DepartmentEntity departmentEntity;
	/**
	 * 被检查人签名1
	 */
	private String signatureImage;
	/**
	 * 被检查人签名2
	 */
	private String signatureImage2;
	/**
	 * 备注
	 */
	private String remark;

	/**
	 * 状态 0未完成，1检查完成
	 */
	private Integer status;
	/**
	 * 状态0未完成，1检查完成
	 */
	@SuppressWarnings("unused")
	@Transient
	private String statusWrapper;
	/**
	 * 流程id
	 */
	private Long processId;

	@Formula(value = "(select t.name  from  tc_system_user t where  t.id=create_by_id)")
	private String createName;

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public Date getBillDate() {
		return billDate;
	}

	public void setBillDate(Date billDate) {
		this.billDate = billDate;
	}

	public CompanyEntity getCompanyEntity() {
		return companyEntity;
	}

	public void setCompanyEntity(CompanyEntity companyEntity) {
		this.companyEntity = companyEntity;
	}

	public DepartmentEntity getDepartmentEntity() {
		return departmentEntity;
	}

	public void setDepartmentEntity(DepartmentEntity departmentEntity) {
		this.departmentEntity = departmentEntity;
	}

	public String getSignatureImage() {
		return signatureImage;
	}

	public void setSignatureImage(String signatureImage) {
		this.signatureImage = signatureImage;
	}

	public String getSignatureImage2() {
		return signatureImage2;
	}

	public void setSignatureImage2(String signatureImage2) {
		this.signatureImage2 = signatureImage2;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Long getProcessId() {
		return processId;
	}

	public void setProcessId(Long processId) {
		this.processId = processId;
	}

	public String getCreateName() {
		return createName;
	}

	public void setCreateName(String createName) {
		this.createName = createName;
	}

	public String getStatusWrapper() {
		if(status==0){
			return "检查中";
		}
		return "检查完成";
	}

	public void setStatusWrapper(String statusWrapper) {
		this.statusWrapper = statusWrapper;
	}
	

}
