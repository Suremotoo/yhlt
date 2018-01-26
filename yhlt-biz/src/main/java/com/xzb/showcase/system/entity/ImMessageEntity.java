package com.xzb.showcase.system.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.hibernate.annotations.Formula;

import com.xzb.showcase.base.entity.BaseEntity;

/**
 * webim message
 * @author admin
 *
 */
@Entity
@Table(name="tc_system_message")
public class ImMessageEntity extends BaseEntity<Long> {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8311234870293455741L;
	/**
	 * 发送人UserId
	 */
	private Long sendId;
	/**
	 * 发送人名称
	 */
	@Size(min = 0, max = 20, message = "发送人名称限制20位")
	private String sendName;
	/**
	 * 接收人UserId
	 */
	private Long receiveId;
	/**
	 * 接收人名称
	 */
	@Size(min = 2, max = 20, message = "接收人名称限制2-20位")
	private String receiveName;
	/**
	 * 消息内容
	 */
	@Size(min = 1, max = 200, message = "内容长度限制1-200位")
	private String content;
	/**
	 * 消息状态0未读，1已读
	 */
	private int status;
	
	@Formula("(select u.name from tc_system_user u where u.id=create_by_id)")
	private String sendUserName;
	
	
	public String getSendUserName() {
		return sendUserName;
	}

	public void setSendUserName(String sendUserName) {
		this.sendUserName = sendUserName;
	}

	public ImMessageEntity() {
	}

	public Long getSendId() {
		return sendId;
	}

	public void setSendId(Long sendId) {
		this.sendId = sendId;
	}

	public String getSendName() {
		return sendName;
	}

	public void setSendName(String sendName) {
		this.sendName = sendName;
	}

	public Long getReceiveId() {
		return receiveId;
	}

	public void setReceiveId(Long receiveId) {
		this.receiveId = receiveId;
	}

	public String getReceiveName() {
		return receiveName;
	}

	public void setReceiveName(String receiveName) {
		this.receiveName = receiveName;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String toString() {
		return "ImMessageEntity [sendId=" + sendId + ", sendName=" + sendName
				+ ", receiveId=" + receiveId + ", receiveName=" + receiveName
				+ ", content=" + content + ", status=" + status + "]";
	}

	
}
