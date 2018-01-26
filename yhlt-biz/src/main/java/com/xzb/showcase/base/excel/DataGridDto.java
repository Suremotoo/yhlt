package com.xzb.showcase.base.excel;

import java.io.Serializable;
import java.util.List;

import net.sf.json.JSONArray;


/**
 * 表格导出DTO
 * 
 * @author admin
 * 
 */
public class DataGridDto implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6852056026355001499L;
	// {"header":["","","设备分类","位置","维修单位","维修负责人","故障描述","经办人","创建时间","状态","修复时间","修复描述"],"rows":[["1","","综保部-电维修","1","1","1","111","admin","2015-06-15 18:32:47","已修复","",""],["2","","综保部-电维修","121","12","12","121212121212121,,,,","admin","2015-06-15 17:56:42","未修复","","sadsd"],["3","","点烟器","办公室","设备科","张三","短路,,短路,","admin","2015-06-11 22:23:13","已修复","",""]],"objRows":[{"_index":"1","id":"","type.name":"综保部-电维修","location":"1","maintainUnit":"1","maintainPrincipal":"1","remark":"111","publisher":"admin","gmtCreate":"2015-06-15 18:32:47","statusEntity.name":"已修复","finishTime":"","repairRemark":""},{"_index":"2","id":"","type.name":"综保部-电维修","location":"121","maintainUnit":"12","maintainPrincipal":"12","remark":"121212121212121,,,,","publisher":"admin","gmtCreate":"2015-06-15 17:56:42","statusEntity.name":"未修复","finishTime":"","repairRemark":"sadsd"},{"_index":"3","id":"","type.name":"点烟器","location":"办公室","maintainUnit":"设备科","maintainPrincipal":"张三","remark":"短路,,短路,","publisher":"admin","gmtCreate":"2015-06-11 22:23:13","statusEntity.name":"已修复","finishTime":"","repairRemark":""}],"fields":["_index","id","type.name","location","maintainUnit","maintainPrincipal","remark","publisher","gmtCreate","statusEntity.name","finishTime","repairRemark"],"footer":[],"objFooter":[],"footerCount":[],"total":3,"title":"新坐标showcase"}
	private JSONArray header;
	private List<JSONArray> rows;
	private JSONArray[] objRows;
	private JSONArray[] fields;
	private JSONArray footer;
	private JSONArray objFooter;
	private JSONArray footerCount;
	private int total;
	private String title;

	public DataGridDto() {
	}

	public JSONArray getHeader() {
		return header;
	}

	public void setHeader(JSONArray header) {
		this.header = header;
	}

	public List<JSONArray> getRows() {
		return rows;
	}

	public void setRows(List<JSONArray> rows) {
		this.rows = rows;
	}

	public JSONArray[] getObjRows() {
		return objRows;
	}

	public void setObjRows(JSONArray[] objRows) {
		this.objRows = objRows;
	}

	public JSONArray[] getFields() {
		return fields;
	}

	public void setFields(JSONArray[] fields) {
		this.fields = fields;
	}

	public JSONArray getFooter() {
		return footer;
	}

	public void setFooter(JSONArray footer) {
		this.footer = footer;
	}

	public JSONArray getObjFooter() {
		return objFooter;
	}

	public void setObjFooter(JSONArray objFooter) {
		this.objFooter = objFooter;
	}

	public JSONArray getFooterCount() {
		return footerCount;
	}

	public void setFooterCount(JSONArray footerCount) {
		this.footerCount = footerCount;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}
