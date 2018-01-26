package com.xzb.showcase.system.dto;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 甘特图_任务
 * 
 * @author yutianyu
 */
public class GanttTaskDto implements Serializable {

	private static final long serialVersionUID = 73934832149676097L;
	
	@JsonProperty("Id")
	private Long id;
	/**
	 * 父任务Id
	 */
	@JsonProperty("ParentId")
	private Long parentId;
	/**
	 * 任务名
	 */
	@JsonProperty("Name")
	private String name;
	/**
	 * 任务开始时间
	 */
	@JsonProperty("StartDate")
	private String startDate;
	/**
	 * 任务结束时间
	 */
	@JsonProperty("EndDate")
	private String endDate;
	/**
	 * 是否可以折叠
	 */
	@JsonProperty("IsLeaf")
	private boolean isLeaf;
	@JsonProperty("Responsible")
	private String responsible;
	@JsonProperty("Duration")
	private String duration = "";

	/**
	 * 完成情况
	 */
	@JsonProperty("PercentDone")
	private int percentDone;
	
	public int getPercentDone() {
		return percentDone;
	}

	public void setPercentDone(int percentDone) {
		this.percentDone = percentDone;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public boolean isLeaf() {
		return isLeaf;
	}

	public void setLeaf(boolean isLeaf) {
		this.isLeaf = isLeaf;
	}

	public String getResponsible() {
		return responsible;
	}

	public void setResponsible(String responsible) {
		this.responsible = responsible;
	}

	public String getDuration() {
		return duration;
	}

	public void setDuration(String duration) {
		this.duration = duration;
	}

}
