package com.xzb.showcase.meeting.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.annotations.Formula;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.xzb.showcase.base.entity.BaseEntity;

/**
 * 会议管理信息
 * 
 * @author LauLimXiao
 * 
 */
@Entity
@Table(name = "tm_sms_meeting_info")
public class MeetingInfoEntity extends BaseEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3937459956938387857L;
	/**
	 * 唯一标识
	 */
	@NotNull(message = "uuid不能为空")
	@Size(min = 1, max = 20, message = "uuid长度限制1-20位")
	private String uuid;

	/**
	 * 编码
	 */
	private String code;
	/**
	 * 会议标题
	 */
	@NotNull(message = "名称不能为空")
	@Size(min = 0, max = 20, message = "数值长度限制20位")
	private String title;

	/**
	 * 会议备注
	 */
	private String remark;

	/**
	 * 会议开始时间
	 */
	@NotNull(message = "开始时间不能为空")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date startDate;

	/**
	 * 会议结束时间
	 */
	@NotNull(message = "结束时间不能为空")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date endDate;

	/**
	 * 会议房间
	 */
	@NotNull(message = "会议房间不能为空")
	private String meetingRoom;

	/**
	 * 会议类型 (0:邀请会议 ,1:自主会议)
	 */
	@NotNull(message = "会议类型不能为空")
	private Integer type;
	/**
	 * 会议类型对应的名称
	 */
	@SuppressWarnings("unused")
	@Transient
	private String typeWrapper;

	/**
	 * 会议状态(0:草稿,1:发布)
	 */
	@NotNull(message = "会议状态不能为空")
	private Integer status;
	/**
	 * 会议状态对应的名称
	 */
	@SuppressWarnings("unused")
	@Transient
	private String statusWrapper;
	/**
	 * 会议发起人
	 */
	private Long userId;
	@Formula(value = "(select t.name  from  tc_system_user t where  t.id=user_id)")
	private String recordUserName;

	public String getTypeWrapper() {
		if (type == 0) {
			return "邀请会议";
		}
		return "自主会议";
	}

	public void setTypeWrapper(String typeWrapper) {
		this.typeWrapper = typeWrapper;
	}

	public String getStatusWrapper() {
		if (status == 0) {
			return "草稿";
		}
		return "发布";
	}

	public void setStatusWrapper(String statusWrapper) {
		this.statusWrapper = statusWrapper;
	}

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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getMeetingRoom() {
		return meetingRoom;
	}

	public void setMeetingRoom(String meetingRoom) {
		this.meetingRoom = meetingRoom;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getRecordUserName() {
		return recordUserName;
	}

	public void setRecordUserName(String recordUserName) {
		this.recordUserName = recordUserName;
	}
	
}
