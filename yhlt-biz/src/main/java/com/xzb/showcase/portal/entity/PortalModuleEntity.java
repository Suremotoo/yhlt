package com.xzb.showcase.portal.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import com.xzb.showcase.base.entity.BaseEntity;

/**
 * PORTAL模块
 * 
 * 
 * @author wj
 * @date 2015年1月29日21:59:28
 */
@Entity
@Table(name = "tc_system_protalmodule")
public class PortalModuleEntity extends BaseEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6669540488938735184L;
	/**
	 * 模块名称
	 */
	@NotNull(message = "名称不能为空")
	@Size(min = 1, max = 20, message = "名称长度限制1-20位")
	private String name;
	/**
	 * 容器Div-ID名称
	 */
	@NotNull(message = "容器ID不能为空")
	@Size(min = 1, max = 20, message = "名称长度限制1-20位")
	private String container;
	/**
	 * JS内容
	 */
	@NotNull(message = "脚本内容不能为空")
	@Size(min = 1, max = 4000, message = "脚本内容长度限制1-4000位")
	private String content;
	/**
	 * JS内容
	 */
	private String icon;
	/**
	 * 类型<br>
	 * 饼状图、柱状图、折线图
	 */
	private int type;

	public PortalModuleEntity() {
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getContainer() {
		return container;
	}

	public void setContainer(String container) {
		this.container = container;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

}
