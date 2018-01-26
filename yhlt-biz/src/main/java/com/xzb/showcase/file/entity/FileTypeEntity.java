package com.xzb.showcase.file.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Formula;

import com.xzb.showcase.base.entity.BaseEntity;

/**
 * 文件类型
 * 
 * @author LauLimXiao
 * 
 */
@Entity
@Table(name = "tm_sms_file_type")
public class FileTypeEntity extends BaseEntity<Long> {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6988682157606987984L;
	/**
	 * uuid 唯一标识
	 */
	private String uuid;
	/**
	 * 类型名
	 */
	private String name;
	/**
	 * 类型父节点
	 */
	private Integer parentId;
	@OneToMany(mappedBy = "parentId", fetch = FetchType.LAZY, cascade = {
			CascadeType.REMOVE, CascadeType.MERGE })
	@OrderBy("sortNumber")
	private Set<FileTypeEntity> children = new HashSet<FileTypeEntity>();
	/**
	 * 说明
	 */
	private String remark;
	/**
	 * 类型
	 */
	private String type;
	/**
	 * 排序号
	 */
	private Integer sortNumber;
	/**
	 * 创建人名字
	 */
	@Formula(value = "(select t.name  from  tc_system_user t where  t.id=create_by_id)")
	private String gmtCreateUserName;

	@Transient
	private String iconCls = "icon2 r4_c4";

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getSortNumber() {
		return sortNumber;
	}

	public void setSortNumber(Integer sortNumber) {
		this.sortNumber = sortNumber;
	}

	public Set<FileTypeEntity> getChildren() {
		return children;
	}

	public void setChildren(Set<FileTypeEntity> children) {
		this.children = children;
	}

	public String getGmtCreateUserName() {
		return gmtCreateUserName;
	}

	public void setGmtCreateUserName(String gmtCreateUserName) {
		this.gmtCreateUserName = gmtCreateUserName;
	}

	public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}

}
