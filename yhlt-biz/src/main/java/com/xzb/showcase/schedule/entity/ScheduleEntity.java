package com.xzb.showcase.schedule.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.xzb.showcase.base.entity.BaseEntity;

/**
 * 日程
 * @author lls
 *
 */
@Entity
@Table(name="tc_system_schedule")
public class ScheduleEntity extends BaseEntity<Long>{

	/**
	 * 
	 */
	private static final long serialVersionUID = -2410165641370293675L;

	@NotNull(message="标题不能为空")
	@Size(min=1,max=20,message="标题长度限制1-20位")
	private String title;
	
	@Size(min=0,max=100,message="描述长度限制100位")
	private String content;
	
	/**
	 * 是否是全天
	 */
	@Column(name="all_day")
	private int allDay;
	
	/**
	 * 该日程开始时间
	 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")  
	@Column(insertable = true, updatable = true)
	private Date start;
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")  
	@Column(insertable = true, updatable = true)
	private Date end;
	
	private String url;
	
	/**
	 * 日程节点颜色
	 */
	private String color;
	/**
	 * 文本颜色
	 */
	@Column(name="text_color")
	private String textColor;
	
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
	
	
	public Date getStart() {
		return start;
	}
	public void setStart(Date start) {
		this.start = start;
	}
	public Date getEnd() {
		return end;
	}
	public void setEnd(Date end) {
		this.end = end;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public int getAllDay() {
		return allDay;
	}
	public void setAllDay(int allDay) {
		this.allDay = allDay;
	}
	public String getTextColor() {
		return textColor;
	}
	public void setTextColor(String textColor) {
		this.textColor = textColor;
	}
	
	
	
}
