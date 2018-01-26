package com.xzb.showcase.base.util.poi;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STMerge;

/**
 * @ClassName tobm-web  ExcelUtil
 * @Description poi 帮助类
 * @author mxp  work_mxp@foxmail.com
 * @date 2016-4-12 下午3:14:21
 */
public class PoiUtil{
	/**
	 * @param request
	 * @param response
	 * @param workbook
	 * @param fileName
	 * @throws Exception
	 */
	public  static  void downExcel(HttpServletRequest request,HttpServletResponse response,Workbook workbook,String fileName) throws Exception{ 
		String codedFileName = fileName;
		response.reset();    
	if (workbook instanceof HSSFWorkbook) {
            codedFileName += ".xls";
        } else {
            codedFileName += ".xlsx";
        }
        if (RequestView.isIE(request)) {
            codedFileName = java.net.URLEncoder.encode(codedFileName, "UTF8");
        } else {
            codedFileName = new String(codedFileName.getBytes("UTF-8"), "ISO-8859-1");
        }
        response.setHeader("content-disposition", "attachment;filename=" + codedFileName);
        ServletOutputStream out = response.getOutputStream();
        workbook.write(out);
        out.flush();
	}
	
	/**
	 * office 2007 word 下载
	 * @author mxp
	 * @param request
	 * @param response
	 * @param xwpfdocument
	 * @param fileName
	 * @throws Exception
	 */
	public static void downWord(HttpServletRequest request,HttpServletResponse response,XWPFDocument xwpfdocument,String fileName) throws Exception{
		String codedFileName = fileName;
		codedFileName +=".docx";
		if (RequestView.isIE(request)) {
            codedFileName = java.net.URLEncoder.encode(codedFileName, "UTF8");
        } else {
            codedFileName = new String(codedFileName.getBytes("UTF-8"), "ISO-8859-1");
        }
		response.reset();
		response.setHeader("content-disposition", "attachment;filename=" + codedFileName);
        ServletOutputStream out = response.getOutputStream();
        xwpfdocument.write(out);
        out.flush();
	}
	 /** 
     * @Description: 跨列合并  word
     */  
    public static void mergeCellsHorizontal(XWPFTable table, int row, int fromCell, int toCell) {  
        for (int cellIndex = fromCell; cellIndex <= toCell; cellIndex++) {  
            XWPFTableCell cell = table.getRow(row).getCell(cellIndex);  
            if ( cellIndex == fromCell ) {  
                // The first merged cell is set with RESTART merge value  
                cell.getCTTc().addNewTcPr().addNewHMerge().setVal(STMerge.RESTART);  
            } else {  
                // Cells which join (merge) the first one, are set with CONTINUE  
                cell.getCTTc().addNewTcPr().addNewHMerge().setVal(STMerge.CONTINUE);  
            }
        }  
    }  
      
    /** 
     * @Description: 跨行合并 word
     */  
    public static void mergeCellsVertically(XWPFTable table, int col, int fromRow, int toRow) {  
        for (int rowIndex = fromRow; rowIndex <= toRow; rowIndex++) {  
            XWPFTableCell cell = table.getRow(rowIndex).getCell(col);  
            if ( rowIndex == fromRow ) {  
                // The first merged cell is set with RESTART merge value  
                cell.getCTTc().addNewTcPr().addNewVMerge().setVal(STMerge.RESTART);  
            } else {  
                // Cells which join (merge) the first one, are set with CONTINUE  
                cell.getCTTc().addNewTcPr().addNewVMerge().setVal(STMerge.CONTINUE);  
            }  
        }  
    }  
}
