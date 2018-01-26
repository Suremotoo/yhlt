package com.xzb.showcase.system.entity;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.xzb.showcase.base.util.Constants;

/**
 * 会议房间
 * 
 * @author admin
 * 
 */
public class TalkyRoom implements Serializable {
	/**
		 * 
		 */
	private static final long serialVersionUID = 1L;

	private String name;
	@JsonIgnore
	private String password;

	private boolean needPassword;
	private int connectionNum = 0;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	private Date gmtModified = new Date();
	// 剩余分钟
	private long remainTime;

	public TalkyRoom() {
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getConnectionNum() {
		return connectionNum;
	}

	public void setConnectionNum(int connectionNum) {
		this.connectionNum = connectionNum;
	}

	public Date getGmtModified() {
		return gmtModified;
	}

	public void setGmtModified(Date gmtModified) {
		this.gmtModified = gmtModified;
	}

	public boolean isNeedPassword() {
		needPassword = !StringUtils.isBlank(password);
		return needPassword;
	}

	public long getRemainTime() {
		remainTime = DateUtils
				.addHours(gmtModified, Constants.TALKY_ROOM_HOURS).getTime()
				- new Date().getTime();
		remainTime = remainTime / 1000 / 60;
		return remainTime;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj instanceof TalkyRoom) {
			TalkyRoom temp = (TalkyRoom) obj;
			if (this.getName().equals(temp.getName())) {
				return true;
			} else {
				return false;
			}
		} else
			return false;
	}

}