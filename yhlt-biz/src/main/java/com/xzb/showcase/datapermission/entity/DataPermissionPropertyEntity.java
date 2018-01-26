package com.xzb.showcase.datapermission.entity;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import com.xzb.showcase.base.entity.BaseEntity;
import com.xzb.showcase.system.entity.DictEntity;
import com.xzb.showcase.system.entity.ResourcesEntity;

/**
 * 数据规则引擎属性
 * 
 * @author admin
 * 
 */
@Entity
@Table(name = "tc_system_datapermission_property")
public class DataPermissionPropertyEntity extends BaseEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5703005067377408274L;

	@ManyToOne
	@JoinColumn(name = "resource_id")
	private ResourcesEntity resourcesEntity;

	@NotNull(message = "中文名称不能为空")
	@Size(min = 2, max = 10, message = "名称长度限制2-10位")
	private String propertyCnname;

	@NotNull(message = "属性名称不能为空")
	@Size(min = 2, max = 20, message = "名称长度限制2-20位")
	private String propertyName;

	@ManyToOne
	@JoinColumn(name = "type_id")
	private DictEntity typeEntity;

	/**
	 * 排序编码
	 */
	private Long sortNumber = 0L;

	@Size(min = 0, max = 200, message = "URL长度限制200位")
	private String url;

	@Size(min = 0, max = 50, message = "多选名称字段长度限制50位")
	private String inputName;

	@Size(min = 0, max = 50, message = "多选值字段长度限制50位")
	private String inputValue;

	public ResourcesEntity getResourcesEntity() {
		return resourcesEntity;
	}

	public void setResourcesEntity(ResourcesEntity resourcesEntity) {
		this.resourcesEntity = resourcesEntity;
	}

	public String getPropertyCnname() {
		return propertyCnname;
	}

	public void setPropertyCnname(String propertyCnname) {
		this.propertyCnname = propertyCnname;
	}

	public String getPropertyName() {
		return propertyName;
	}

	public void setPropertyName(String propertyName) {
		this.propertyName = propertyName;
	}

	public DictEntity getTypeEntity() {
		return typeEntity;
	}

	public void setTypeEntity(DictEntity typeEntity) {
		this.typeEntity = typeEntity;
	}

	public Long getSortNumber() {
		return sortNumber;
	}

	public void setSortNumber(Long sortNumber) {
		this.sortNumber = sortNumber;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getInputName() {
		return inputName;
	}

	public void setInputName(String inputName) {
		this.inputName = inputName;
	}

	public String getInputValue() {
		return inputValue;
	}

	public void setInputValue(String inputValue) {
		this.inputValue = inputValue;
	}

}
