package com.xzb.showcase.system.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 图形报表
 * @author xunxun
 * @date 2015-1-30 下午4:46:10
 */
public class ChartReportDto implements Serializable{

	private static final long serialVersionUID = -2193050431620532756L;
	
	/**
	 * 基本属性
	 */
	private Map<String, Object> chart=new HashMap<String, Object>();
	
	/**
	 * 标题
	 */
	private Map<String, Object> title=new HashMap<String, Object>();
	/**
	 * 子标题
	 */
	private Map<String, Object> subTitle=new HashMap<String, Object>();
	
	/**
	 * xAxis
	 */
	private Map<String, Object> xAxis=new HashMap<String, Object>();
	
	/**
	 * yAxis
	 */
	private Map<String, Object> yAxis=new HashMap<String, Object>();
	
	/**
	 * 数据  series
	 */
	private List<Map<String, Object>> series=new ArrayList<Map<String,Object>>();
	
	/**
	 * 工具提示
	 */
	private Map<String, Object> tooltip=new HashMap<String, Object>();
	

	public Map<String, Object> getChart() {
		return chart;
	}

	public void setChart(Map<String, Object> chart) {
		this.chart = chart;
	}

	public Map<String, Object> getTitle() {
		return title;
	}

	public void setTitle(Map<String, Object> title) {
		this.title = title;
	}

	public Map<String, Object> getSubTitle() {
		return subTitle;
	}

	public void setSubTitle(Map<String, Object> subTitle) {
		this.subTitle = subTitle;
	}

	public Map<String, Object> getxAxis() {
		return xAxis;
	}

	public void setxAxis(Map<String, Object> xAxis) {
		this.xAxis = xAxis;
	}

	public Map<String, Object> getyAxis() {
		return yAxis;
	}

	public void setyAxis(Map<String, Object> yAxis) {
		this.yAxis = yAxis;
	}

	public List<Map<String, Object>> getSeries() {
		return series;
	}

	public void setSeries(List<Map<String, Object>> series) {
		this.series = series;
	}

	public Map<String, Object> getTooltip() {
		return tooltip;
	}

	public void setTooltip(Map<String, Object> tooltip) {
		this.tooltip = tooltip;
	}
}
