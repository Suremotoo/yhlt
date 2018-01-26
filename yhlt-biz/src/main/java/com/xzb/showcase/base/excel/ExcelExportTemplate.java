package com.xzb.showcase.base.excel;

import java.io.OutputStream;

/**
 * 将数据导出到excel接口定义
 * @param <T>
 * @author xunxun
 * @date 2015-1-14 下午4:33:46
 */
public interface ExcelExportTemplate<T> {
	/**
	 * 将数据导出为excel
	 * @param outputStream 文件输出流
	 * @param parameters 参数
	 */
	public void doExport(OutputStream outputStream,T parameters)throws Exception;
	/**
	 * 要创建的excel文件的sheet名称
	 * @return
	 */
	public String[] getSheetNames();
	
	/**
	 * 要创建的excel表格中的表头内容.
	 * list中存放的是多个sheet的表头内容
	 * @return
	 */
	public String[][] getTitles();
	
	/**
	 * 要创建的excel表格的每个sheet的表头
	 * @return
	 */
	public String[] getCaptions();
	
	/**
	 * 控制文件在内存中最多占用多少条
	 * @return
	 */
	public int getRowAccessWindowSize();
}
