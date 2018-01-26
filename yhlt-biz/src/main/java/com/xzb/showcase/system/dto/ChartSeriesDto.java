package com.xzb.showcase.system.dto;

import java.io.Serializable;

/**
 * 图形报表 数据
 * @author xunxun
 * @date 2015-1-31 下午2:23:27
 */
public class ChartSeriesDto implements Serializable{

	/** 
	 * @Fields serialVersionUID  TODO
	 */
	private static final long serialVersionUID = -3280149129675871846L;

	/**
	 * 类型
	 */
	private String type;
	
	/**
	 * 名称
	 */
	private String name;
	
	/**
	 * 数据
	 */
	private Object data;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}
}
