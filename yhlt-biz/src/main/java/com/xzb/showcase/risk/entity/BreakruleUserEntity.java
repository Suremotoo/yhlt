package com.xzb.showcase.risk.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Formula;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.xzb.showcase.base.entity.BaseEntity;

/**
 * 违规检查单
 * 
 * @author LauLimXiao
 * 
 */
@Entity
@Table(name = "tm_sms_breakrule_user")
public class BreakruleUserEntity extends BaseEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = -565076289116634753L;

	/**
	 * uuid 唯一标识
	 */
	private String uuid;
	/**
	 * 通行证编号
	 */
	private String code;
	/**
	 * 公司名
	 */
	private String companyName;
	/**
	 * 部门名
	 */
	private String departmentName;
	/**
	 * 违规用户id
	 */
	private Integer userId;
	/**
	 * 违规用户名
	 */
	private String userName;
	/**
	 * 有无后果，0无，1有
	 */
	private Integer riskStatus;
	@SuppressWarnings("unused")
	@Transient
	private String riskStatusWrapper;
	/**
	 * 创建人名字
	 */
	@Formula(value = "(select t.name  from  tc_system_user t where  t.id=create_by_id)")
	private String gmtCreateUserName;
	/**
	 * 违规日期
	 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date breakruleDatetime;
	/**
	 * 违规地点
	 */
	private String location;
	/**
	 * 违规扣分
	 */
	private Double breakruleScore;
	/**
	 * 违规扣分依据
	 */
	private String breakruleInfo;
	/**
	 * 违规信息描述
	 */
	private String remark;
	/**
	 * 违规人签字
	 */
	private String userSignature;
	/**
	 * 督查人签字
	 */
	private String superviseSignature;

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Integer getRiskStatus() {
		return riskStatus;
	}

	public void setRiskStatus(Integer riskStatus) {
		this.riskStatus = riskStatus;
	}

	public Date getBreakruleDatetime() {
		return breakruleDatetime;
	}

	public void setBreakruleDatetime(Date breakruleDatetime) {
		this.breakruleDatetime = breakruleDatetime;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public Double getBreakruleScore() {
		return breakruleScore;
	}

	public void setBreakruleScore(Double breakruleScore) {
		this.breakruleScore = breakruleScore;
	}

	public String getBreakruleInfo() {
		return breakruleInfo;
	}

	public void setBreakruleInfo(String breakruleInfo) {
		this.breakruleInfo = breakruleInfo;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getUserSignature() {
		return userSignature;
	}

	public void setUserSignature(String userSignature) {
		this.userSignature = userSignature;
	}

	public String getSuperviseSignature() {
		return superviseSignature;
	}

	public void setSuperviseSignature(String superviseSignature) {
		this.superviseSignature = superviseSignature;
	}

	public String getRiskStatusWrapper() {
		if (riskStatus == 0) {
			return "无";
		}
		return "有";
	}

	public void setRiskStatusWrapper(String riskStatusWrapper) {
		this.riskStatusWrapper = riskStatusWrapper;
	}

	public String getGmtCreateUserName() {
		return gmtCreateUserName;
	}

	public void setGmtCreateUserName(String gmtCreateUserName) {
		this.gmtCreateUserName = gmtCreateUserName;
	}

}
