package com.xzb.showcase.base.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.Map;

import javax.persistence.MappedSuperclass;
import javax.persistence.Transient;

import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * 流程基类Entity
 * 
 * @param <PK>
 * @author wyt
 * @date 2015-2-4 10:26:12
 */
@MappedSuperclass
public class WorkflowBaseEntity<PK extends Serializable> extends BaseEntity<PK> implements Serializable {

	private static final long serialVersionUID = -7176212535133590259L;

	/**
	 * 流程定义
	 */
	@Transient
	private ProcessDefinition pd;
	/**
	 * 流程实例
	 */
	@Transient
	private ProcessInstance pi;
	/**
	 * 流程任务
	 */
	@Transient
	private Task task;
	/**
	 * 流程部署时间
	 */
	@Transient
	private Date deploymentTime;

	@Transient
	@JsonIgnore
	private Map<String, Object> variables;// 流程运行过程中动态生成变量

	public ProcessDefinition getPd() {
		return pd;
	}

	public void setPd(ProcessDefinition pd) {
		this.pd = pd;
	}

	public ProcessInstance getPi() {
		return pi;
	}

	public void setPi(ProcessInstance pi) {
		this.pi = pi;
	}

	public Task getTask() {
		return task;
	}

	public void setTask(Task task) {
		this.task = task;
	}

	public Map<String, Object> getVariables() {
		return variables;
	}

	public void setVariables(Map<String, Object> variables) {
		this.variables = variables;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Date getDeploymentTime() {
		return deploymentTime;
	}

	public void setDeploymentTime(Date deploymentTime) {
		this.deploymentTime = deploymentTime;
	}

}
