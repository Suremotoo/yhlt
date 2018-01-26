package com.xzb.showcase.system.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.xzb.showcase.base.excel.CommonDataGridExport;
import com.xzb.showcase.base.excel.DataGridDto;
import com.xzb.showcase.base.security.AccessRequired;

@Controller
@RequestMapping(value = "/system/export")
@AccessRequired("导出数据管理")
public class ExportController {

	/**
	 * 查询公司树
	 * 
	 * @return
	 * @author wj
	 * @date 2014-11-19 下午3:02:15
	 */
	@RequestMapping(value = "/exportDataGrid")
	public void exportDataGrid(@RequestParam(value = "data") String data,
			HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObj = JSONObject.fromObject(data);
		DataGridDto dataGridDto = new DataGridDto();
		dataGridDto.setHeader((JSONArray) jsonObj.get("header"));
		dataGridDto.setRows((List<JSONArray>) jsonObj.get("rows"));
		System.out.println(dataGridDto);
		try {
			response.reset();
			String fileName = URLEncoder.encode("数据导出.xls", "utf-8");
			response.setHeader("Content-Disposition", "attachment; filename="
					+ fileName);
			response.setContentType("application/octet-stream;charset=UTF-8");
			new CommonDataGridExport(dataGridDto).doExport(response.getOutputStream(),
					null);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
