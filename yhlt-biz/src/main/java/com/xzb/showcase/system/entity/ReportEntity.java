package com.xzb.showcase.system.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.annotations.Formula;

import com.xzb.showcase.base.entity.BaseEntity;

/**
 * 系统报表
 * @author xunxun
 * @date 2015-1-30 上午9:40:58
 */
@Entity
@Table(name = "tc_system_report")
public class ReportEntity extends BaseEntity<Long>{

	/** 
	 * @Fields serialVersionUID
	 */
	private static final long serialVersionUID = -8919889486619796488L;
	
	/**
	 * 名称
	 */
	@NotNull(message = "名称不能为空")
	@Size(min = 1, max = 50, message = "名称长度限制1-50位")
	private String name;
	/**
	 * 面板显示内容
	 */
	@NotNull(message = "面板显示内容不能为空")
	@Size(min = 1, max = 1000, message = "面板显示内容长度限制1-1000位")
	private String content;
	/**
	 * 脚本内容
	 */
	@NotNull(message = "脚本内容不能为空")
	@Size(min = 1, max = 4000, message = "脚本内容长度限制1-4000位")
	private String jsContent;
	
	/**
	 * 类型
	 */
	private String type;
	/**
	 * 模块
	 */
	private String module;
	
	/**
	 * 排序编码
	 */
	private Long sortNumber;
	
	@Formula("(select d.name from tc_system_dict d where d.type='REPORT_MODULE' and d.value= module)")
	private String moduleName;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getJsContent() {
		return jsContent;
	}
	public void setJsContent(String jsContent) {
		this.jsContent = jsContent;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getModule() {
		return module;
	}
	public void setModule(String module) {
		this.module = module;
	}
	public Long getSortNumber() {
		return sortNumber;
	}
	public void setSortNumber(Long sortNumber) {
		this.sortNumber = sortNumber;
	}
	
	public String getModuleName() {
		return moduleName;
	}
	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}
}
