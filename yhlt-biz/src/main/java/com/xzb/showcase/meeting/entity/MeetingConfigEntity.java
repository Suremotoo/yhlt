package com.xzb.showcase.meeting.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import com.xzb.showcase.base.entity.BaseEntity;

/**
 * 会议配置
 * @author LauLimXiao
 *
 */
@Entity
@Table(name="tc_system_dict")
public class MeetingConfigEntity extends BaseEntity<Long>{

	

	/**
	 * 
	 */
	private static final long serialVersionUID = 4390736663071347725L;
	/**
	 * 字典名
	 */
	@NotNull(message = "名称不能为空")
	@Size(min = 1, max = 20, message = "名称长度限制1-20位")
	private String name;
	/**
	 * 字典项类型
	 */
	@NotNull(message = "类型不能为空")
	@Size(min = 1, max = 20, message = "类型长度限制1-20位")
	private String type;
	/**
	 * 字典项值
	 */
	@Size(min = 0, max = 20, message = "数值长度限制20位")
	private String value;
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
	
	
}
