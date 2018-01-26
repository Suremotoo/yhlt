package com.xzb.showcase.system.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Formula;

import com.xzb.showcase.base.entity.BaseEntity;


@SuppressWarnings("serial")
@Entity
@Table(name = "tc_system_mail")
public class MailEntity extends BaseEntity<Long>{
	
	private String title;
	
	private String content;
	
	private String receiveUser;
	
	@Formula("(select u.name from tc_system_user u where u.id=create_by_id)")
	private String sendName;
	public MailEntity()
	{
		
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getReceiveUser() {
		return receiveUser;
	}

	public void setReceiveUser(String receiveUser) {
		this.receiveUser = receiveUser;
	}

	public String getSendName() {
		return sendName;
	}

	public void setSendName(String sendName) {
		this.sendName = sendName;
	}
	
	
}
