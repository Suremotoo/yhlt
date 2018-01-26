package com.xzb.showcase.system.dto;

import java.io.Serializable;
/**
 * 饼状图数据
 * @author xunxun
 * @date 2015-1-31 下午3:34:57
 */
public class PieChartDataDto implements Serializable{

	private static final long serialVersionUID = 1L;
	/**
	 * 名称
	 */
	private String name;
	/**
	 * 值
	 */
	private Double y;
	/**
	 * 是否切片
	 */
	private boolean sliced; 
	/**
	 * 是否选中
	 */
	private boolean selected;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Double getY() {
		return y;
	}
	public void setY(Double y) {
		this.y = y;
	}
	public boolean isSliced() {
		return sliced;
	}
	public void setSliced(boolean sliced) {
		this.sliced = sliced;
	}
	public boolean isSelected() {
		return selected;
	}
	public void setSelected(boolean selected) {
		this.selected = selected;
	}
}
