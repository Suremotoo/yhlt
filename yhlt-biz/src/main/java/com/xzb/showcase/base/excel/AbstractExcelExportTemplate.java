package com.xzb.showcase.base.excel;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.Validate;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;

/**
 * @param <T>
 * @author xunxun
 * @date 2015-1-14 下午4:34:19
 */
public abstract class AbstractExcelExportTemplate<T> implements ExcelExportTemplate<T> {
	/**
	 * 默认表格宽度
	 */
	private static final int DEFAULT_COLUMN_WIDTH = 7000;
	/**
	 * excel文件对象
	 */
	protected Workbook  workbook;
	/**
	 * excel sheet列表
	 */
	protected List<Sheet> sheets = new ArrayList<Sheet>();
	/**
	 * 标题栏
	 */
	protected String[][] titles;
	protected CellStyle captionRowSytle;
	/**
	 * 默认标题行样式
	 */
	protected CellStyle titleRowStyle;
	/**
	 * 默认内容行样式
	 */
	protected CellStyle bodyRowStyle;
	/**
	 * 各个sheet是否包含抬头,key:sheet坐标，value:包含true,否则false
	 */
	protected Map<Integer, Boolean> hasCaptionMap = new HashMap<Integer, Boolean>();
	/**
	 * 默认单元格宽度
	 */
	protected int columnWidth = DEFAULT_COLUMN_WIDTH;
	/**
	 * 参数列表
	 */
	protected T parameters;

	/* (non-Javadoc)
	 * @see com.haier.openplatform.excel.ExcelExportService#doExport(java.io.OutputStream)
	 */
	@Override
	public void doExport(OutputStream outputStream,T parameters) throws IOException {
		String[] sheetNames = this.getSheetNames();
		Validate.notEmpty(sheetNames);
		Validate.notNull(outputStream);
		this.parameters = parameters;
//		this.workbook = new SXSSFWorkbook(getRowAccessWindowSize());
		this.workbook = new HSSFWorkbook();
		this.titles = this.getTitles();
		this.captionRowSytle = crateCaptionCellStyle();
		this.titleRowStyle = crateTitleCellStyle();
		this.bodyRowStyle = crateBodyCellStyle();
		this.afterCreateWorkBook();
		
		for (int i = 0; i < sheetNames.length; i++) {
			Sheet sheet = workbook.createSheet(sheetNames[i]);
			this.sheets.add(sheet);
			afterBuildSheet(i);
			buildCaption(i);
			buildTitle(i);
			afterBuildTitle(i);
			buildBody(i);
			afterBuildBody(i);
		}
		this.workbook.write(outputStream);
	}

	/**
	 * 创建单元格
	 * @param row
	 * @param index
	 * @param cellValue
	 * @param cellStyle
	 */
	protected void createStyledCell(Row row,int index,String cellValue,CellStyle cellStyle){
		Cell cell = row.createCell(index);
		cell.setCellValue(cellValue);
		cell.setCellStyle(cellStyle);
	}
	
	/**
	 * 在创建完毕HSSFWorkBook对象和样式对象后作的处理操作，通常用来对默认的样式进行重新定义
	 */
	protected void afterCreateWorkBook(){
	}
	/**
	 * 获取excel抬头样式
	 * @return
	 */
	protected CellStyle crateCaptionCellStyle() {
		Font font = workbook.createFont();
		font.setColor(Font.COLOR_NORMAL);
		CellStyle cellStyle = workbook.createCellStyle();
		cellStyle.setWrapText(false);
		font.setFontHeight((short)250);
		cellStyle.setFont(font);
		cellStyle.setFillForegroundColor(IndexedColors.BLUE_GREY.index);
		cellStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
		cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
		return cellStyle;
	}
	
	/**
	 * 获取excel表头样式
	 * @return
	 */
	protected CellStyle crateTitleCellStyle() {
		Font font = workbook.createFont();
		font.setColor(Font.COLOR_NORMAL);
		CellStyle cellStyle = workbook.createCellStyle();
		cellStyle.setWrapText(false);
		font.setFontHeight((short)250);
		cellStyle.setFont(font);
		cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		cellStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
		short border = 1;
		setCellBorder(cellStyle,border,border,border,border);
		cellStyle.setAlignment(CellStyle.ALIGN_LEFT);
		return cellStyle;
	}
	
	/**
	 * 设置单元格的border
	 * @param cellStyle
	 * @param top
	 * @param bottom
	 * @param left
	 * @param right
	 */
	protected void setCellBorder(CellStyle cellStyle,short top,short bottom,short left,short right){
		cellStyle.setBorderBottom(bottom);
		cellStyle.setBorderLeft(left);
		cellStyle.setBorderRight(right);
		cellStyle.setBorderTop(top);
	}
	
	/**
	 * 获取excel内容样式
	 * @return
	 */
	protected CellStyle crateBodyCellStyle() {
		Font font = workbook.createFont();
		//font.setColor(HSSFColor.BLUE_GREY.index);
		CellStyle cellStyle = workbook.createCellStyle();
		cellStyle.setWrapText(false);
		cellStyle.setFont(font);
		cellStyle.setFillForegroundColor(HSSFColor.WHITE.index);
		cellStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
		cellStyle.setAlignment(CellStyle.ALIGN_LEFT);
		short border = 1;
		setCellBorder(cellStyle,border,border,border,border);
		return cellStyle;
	}

	/**
	 * 获取第n个excel sheet
	 * @param sheetIndex
	 * @return
	 */
	protected Sheet getSheet(int sheetIndex) {
		return this.sheets.get(sheetIndex);
	}

	/**
	 * 创建sheet完毕后做的操作
	 * @param sheetIndex
	 */
	protected void afterBuildSheet(int sheetIndex) {
	}
	
	/**
	 * 在sheet的第一行插入标题
	 * @param sheetIndex
	 */
	protected void buildCaption(int sheetIndex){
		Sheet sheet = getSheet(sheetIndex);
		String[] captions = this.getCaptions(); 
		hasCaptionMap.put(sheetIndex, false);
		if(captions != null && captions.length >=sheetIndex +1){
			String caption = captions[sheetIndex];
			if(StringUtils.isNotBlank(caption)){
				Row row = sheet.createRow(0);
				int lastColumn = calculateLastColumn(sheetIndex);
				CellRangeAddress cellRangeAddress = new CellRangeAddress(0, 0, 0, lastColumn);
				sheet.addMergedRegion(cellRangeAddress);
				createStyledCell(row, 0, caption, this.captionRowSytle);
				hasCaptionMap.put(sheetIndex, true);
			}
		}
	}
	
	/**
	 * 计算最后一列数据数据的
	 * @param sheetIndex
	 * @return
	 */
	protected int calculateLastColumn(int sheetIndex){
		if(this.titles != null && sheetIndex <= this.titles.length -1 && this.titles[sheetIndex] != null){
			return this.titles[sheetIndex].length - 1;
		}else{
			return 1;
		}
	}

	/**
	 * 创建sheet中数据的标题
	 * @param sheetIndex
	 */
	protected void buildTitle(int sheetIndex){
		if(this.titles.length < sheetIndex + 1){
			return;
		}
		String[] ts = this.titles[sheetIndex];
		if(ts == null){
			return;
		}
		Sheet sheet = this.getSheet(sheetIndex);
		int titleStartIndex = this.getTitleStartIndex(sheetIndex);
		Row rowTitle = sheet.createRow(titleStartIndex); 
		for(int i = 0; i < ts.length; i++){
			sheet.setColumnWidth(i, columnWidth);
			createStyledCell(rowTitle, i, ts[i], this.titleRowStyle);
		}
	}
	
	/**
	 * 获取各个sheet内容部分起始行index,默认为从第一行开始
	 * @param sheetIndex sheet的index
	 * @return
	 */
	protected int getBodyStartIndex(int sheetIndex){
		int captionRow = getTitleStartIndex(sheetIndex);;
		int titleRow = 0;
		if(this.titles != null && this.titles.length >= sheetIndex + 1){
			if(titles[sheetIndex] != null && titles[sheetIndex].length >0){
				titleRow = 1;
			}
		}
		return captionRow + titleRow;
	}

	protected int getTitleStartIndex(int sheetIndex){
		return this.hasCaptionMap.get(sheetIndex) ? 1 : 0;
	}
	/**
	 * 创建sheet中数据的标题之后做的操作
	 * @param sheetIndex
	 */
	protected void afterBuildTitle(int sheetIndex) {
	}

	/**
	 * 创建sheet中数据的内容
	 * @param sheetIndex
	 */
	protected abstract void buildBody(int sheetIndex);

	/**
	 * 创建sheet中数据的内容之后做的操作
	 * @param sheetIndex
	 */
	protected void afterBuildBody(int sheetIndex) {
	}

	@Override
	public String[] getCaptions() {
		return new String[]{};
	}

	@Override
	public int getRowAccessWindowSize() {
		return 200;
	}
}
