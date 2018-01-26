package com.xzb.showcase.system.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import com.xzb.showcase.base.entity.BaseEntity;


@SuppressWarnings("serial")
@Entity
@Table(name = "tc_system_group_message")
public class ImGroupMessageEntity extends BaseEntity<Long>{
	
	//发送人Id
	private Long sendId;
	
	//发送人名称
	@Size(min = 0, max = 200, message = "消息内容限制20位")
	private String sendName;
	
	//群组ID
	private Long groupId;
	
	//群名称
	@Size(min = 0, max = 200, message = "消息内容限制20位")
	private String groupName;
	
	//群消息内容
	@Size(min = 0, max = 200, message = "消息内容限制200位")
	private String content;
	
	public ImGroupMessageEntity()
	{
		
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

	public Long getGroupId() {
		return groupId;
	}

	public void setGroupId(Long groupId) {
		this.groupId = groupId;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	

}
