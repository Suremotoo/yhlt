package com.xzb.showcase.base.excel;

import net.sf.json.JSONArray;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;

import com.alibaba.fastjson.JSONObject;

public class CommonDataGridExport extends
		AbstractExcelExportTemplate<JSONObject> {

	private DataGridDto dataGridDto;

	public CommonDataGridExport(DataGridDto dataGridDto) {
		this.dataGridDto = dataGridDto;
	}

	@Override
	public String[] getSheetNames() {
		return new String[] { "数据导出" };
	}

	@Override
	public String[][] getTitles() {

		String[][] title = new String[1][dataGridDto.getHeader().size()];
		int index = 0;
		for (int i = 0; i < dataGridDto.getHeader().size(); i++) {
			title[0][index++] = dataGridDto.getHeader().getString(i);
		}
		return title;
	}

	@Override
	protected void buildTitle(int sheetIndex) {
		if (this.titles.length < sheetIndex + 1) {
			return;
		}
		String[] ts = this.titles[sheetIndex];
		if (ts == null) {
			return;
		}
		Sheet sheet = this.getSheet(sheetIndex);
		int titleStartIndex = this.getTitleStartIndex(sheetIndex);
		Row rowTitle = sheet.createRow(titleStartIndex);
		for (int i = 0; i < ts.length; i++) {
			// 找出数据最大列宽，动态设置列宽
			int cellLength = 1;
			for (JSONArray row : dataGridDto.getRows()) {
				if (row.get(i) != null) {
					int lenght = row.get(i).toString().getBytes().length;
					cellLength = cellLength > lenght ? cellLength : lenght;
				}
			}
			// 最大列宽不会超过默认列宽
			cellLength = cellLength < columnWidth ? cellLength : columnWidth;
			sheet.setColumnWidth(i, cellLength * 256);
			createStyledCell(rowTitle, i, ts[i], this.titleRowStyle);
		}
	}

	@Override
	protected void buildBody(int sheetIndex) {
		HSSFSheet sheetsv = (HSSFSheet) getSheet(sheetIndex);
		int startIndex = this.getBodyStartIndex(sheetIndex);
		for (int i = 0; i < dataGridDto.getRows().size(); i++) {
			int index = 0;
			// 按序写入
			HSSFRow rowsd = sheetsv.createRow(i + startIndex);
			JSONArray row = dataGridDto.getRows().get(i);
			for (Object object : row) {
				createStyledCell(rowsd, index++, object.toString(),
						this.bodyRowStyle);// 规划号
			}
		}
	}

}
