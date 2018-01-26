package com.xzb.showcase.system.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 图形报表基类
 * @author xunxun
 * @date 2015-1-31 下午2:14:53
 */
public class BaseChartDto implements Serializable{

	private static final long serialVersionUID = 73934832149676097L;

	/**
	 * 标题
	 */
	protected String title;
	
	/**
	 * 子标题
	 */
	protected String subTitle;
	
	/**
	 * xAxis 类别
	 */
	protected String [] categories;
	
	/**
	 * yAxis 最小颗粒
	 */
	protected Long min;
	
	/**
	 * yAxis 标题
	 */
	protected String text;
	
	/**
	 * 工具提示  后缀
	 */
	protected String valueSuffix;
	
	/**
	 * 数据
	 */
	protected List<ChartSeriesDto> series=new ArrayList<ChartSeriesDto>();

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSubTitle() {
		return subTitle;
	}

	public void setSubTitle(String subTitle) {
		this.subTitle = subTitle;
	}

	public String[] getCategories() {
		return categories;
	}

	public void setCategories(String[] categories) {
		this.categories = categories;
	}

	public Long getMin() {
		return min;
	}

	public void setMin(Long min) {
		this.min = min;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}
	
	public String getValueSuffix() {
		return valueSuffix;
	}

	public void setValueSuffix(String valueSuffix) {
		this.valueSuffix = valueSuffix;
	}

	public List<ChartSeriesDto> getSeries() {
		return series;
	}

	public void setSeries(List<ChartSeriesDto> series) {
		this.series = series;
	}
}
