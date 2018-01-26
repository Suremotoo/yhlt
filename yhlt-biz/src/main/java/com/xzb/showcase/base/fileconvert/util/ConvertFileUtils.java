package com.xzb.showcase.base.fileconvert.util;

import java.io.File;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

import org.apache.log4j.Logger;

import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.ComThread;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;

/**
 * 队列任务工具类
 * 
 * @author wj
 * 
 */
public class ConvertFileUtils {
	private static Logger logger = Logger.getLogger(ConvertFileUtils.class
			.getName());
	// 线程安全队列
	private static BlockingQueue<FileConvertDto> FILE_BLOCK_QUEUE = new LinkedBlockingQueue<FileConvertDto>();
	public static Object WORD_LOCK = null;

	/**
	 * 当前word转换锁定
	 * 
	 * @return
	 */
	public static boolean isLock() {
		return WORD_LOCK != null;
	}

	/**
	 * 新增转换文件队列信息
	 * 
	 * @param convertDto
	 */
	public static void addFile(FileConvertDto convertDto) {
		FILE_BLOCK_QUEUE.add(convertDto);
	}

	/**
	 * 当前转换队列长度
	 * 
	 * @return
	 */
	public static int queueSize() {
		return FILE_BLOCK_QUEUE.size();
	}

	/**
	 * 移除并返回队列头部的元素 如果队列为空，则阻塞
	 * 
	 * @return
	 * @throws InterruptedException
	 */
	public static FileConvertDto takeFile() throws InterruptedException {
		return FILE_BLOCK_QUEUE.take();
	}

	/**
	 * 返回队列头部的元素 如果队列为空，则返回null
	 * 
	 * @return
	 */
	public static FileConvertDto peekFile() {
		return FILE_BLOCK_QUEUE.peek();
	}

	/**
	 * 移除并返回队列头部的元素 如果队列为空，则抛出一个NoSuchElementException异常
	 */
	public static void remove() {
		try {
			FILE_BLOCK_QUEUE.remove();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 判断是否存在
	 * @param obj
	 * @return
	 */
	public static boolean contains(Object obj){
		return FILE_BLOCK_QUEUE.contains(obj);
	}
	
	/**
	 * PowerPoint转成HTML
	 * 
	 * @param pptPath
	 *            PowerPoint文件全路径
	 * @param htmlfile
	 *            转换后HTML存放路径
	 */
	public static synchronized void pptToHtml(String pptPath, String htmlPath) {
		ActiveXComponent offCom = new ActiveXComponent("PowerPoint.Application");
		try {
			offCom.setProperty("Visible", new Variant(true));
			Dispatch excels = offCom.getProperty("Presentations").toDispatch();
			Dispatch excel = Dispatch.invoke(
					excels,
					"Open",
					Dispatch.Method,
					new Object[] { pptPath, new Variant(false),
							new Variant(false) }, new int[1]).toDispatch();
			Dispatch.invoke(excel, "SaveAs", Dispatch.Method, new Object[] {
					htmlPath, new Variant(12) }, new int[1]);
			// Variant f = new Variant(false);
			Dispatch.call(excel, "Close");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			offCom.invoke("Quit", new Variant[] {});
			ComThread.Release();
		}
	}

	/**
	 * WORD转成PDF
	 * 
	 * @param wordPath
	 *            WORD文件全路径
	 * @param htmlPath
	 *            生成的HTML存放路径
	 */
	public static synchronized void wordToPdf(String wordPath, String pdfPath) {
		logger.info("Word转换Pdf" + wordPath);
		ActiveXComponent offCom = new ActiveXComponent("Word.Application");
		WORD_LOCK = new Object();
		try {
			offCom.setProperty("Visible", new Variant(false));
			Dispatch wordDis = offCom.getProperty("Documents").toDispatch();
			Dispatch doc = Dispatch.invoke(
					wordDis,
					"Open",
					Dispatch.Method,
					new Object[] { wordPath, new Variant(false),
							new Variant(true) }, new int[1]).toDispatch();
			Dispatch.invoke(doc, "SaveAs", Dispatch.Method, new Object[] {
					pdfPath, new Variant(17) }, new int[1]);
			Variant f = new Variant(false);
			Dispatch.call(doc, "Close", f);
		} catch (Exception e) {
			System.out.println();
			logger.error("Word转换Pdf失败" + wordPath, e);
			e.printStackTrace();
		} finally {
			offCom.invoke("Quit", new Variant[] {});
			WORD_LOCK = null;
		}
		logger.info("Word转换Pdf成功" + pdfPath);
	}

	/**
	 * WORD转成HTML
	 * 
	 * @param wordPath
	 *            WORD文件全路径
	 * @param htmlPath
	 *            生成的HTML存放路径
	 */
	public static synchronized void wordToHtml(String wordPath, String htmlPath) {
		ActiveXComponent offCom = new ActiveXComponent("Word.Application");
		WORD_LOCK = new Object();
		try {
			offCom.setProperty("Visible", new Variant(false));
			Dispatch wordDis = offCom.getProperty("Documents").toDispatch();
			Dispatch doc = Dispatch.invoke(
					wordDis,
					"Open",
					Dispatch.Method,
					new Object[] { wordPath, new Variant(false),
							new Variant(true) }, new int[1]).toDispatch();
			Dispatch.invoke(doc, "SaveAs", Dispatch.Method, new Object[] {
					htmlPath, new Variant(8) }, new int[1]);
			Variant f = new Variant(false);
			Dispatch.call(doc, "Close", f);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			offCom.invoke("Quit", new Variant[] {});
			WORD_LOCK = null;
		}
	}

	/**
	 * EXCEL转成HTML
	 * 
	 * @param xlsfile
	 *            EXCEL文件全路径
	 * @param htmlfile
	 *            转换后HTML存放路径
	 */
	public static synchronized void excelToHtml(String excelPath,
			String htmlPath) {
		ActiveXComponent offCom = new ActiveXComponent("Excel.Application");
		try {
			offCom.setProperty("Visible", new Variant(false));
			Dispatch excels = offCom.getProperty("Workbooks").toDispatch();
			Dispatch excel = Dispatch.invoke(
					excels,
					"Open",
					Dispatch.Method,
					new Object[] { excelPath, new Variant(false),
							new Variant(true) }, new int[1]).toDispatch();
			Dispatch.invoke(excel, "SaveAs", Dispatch.Method, new Object[] {
					htmlPath, new Variant(44) }, new int[1]);
			Variant f = new Variant(false);
			Dispatch.call(excel, "Close", f);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			offCom.invoke("Quit", new Variant[] {});
			ComThread.Release();
		}
	}
	
	/**
	 * docx转doc
	 * @author mxp
	 * @param docxPath	docx的绝对路径
	 * @param docPath	doc 的存放路径 
	 */
	public static synchronized boolean docxTodoc(String docxPath,String docPath){
		try {
			//指定被转换文件的完整路径。 我这里的意图是把pdf转为txt   
	        String path = docxPath;
	        //根据路径创建文件对象   
	        File docFile=new File(path);  
	        //获取文件名（包含扩展名）   
	        String filename=docFile.getName();  
	        //过滤掉文件名中的扩展名   
	        int dotposition=filename.indexOf(".");  
	        filename=filename.substring(0,dotposition);  
	          
	        //设置输出路径，一定要包含输出文件名（不含输出文件的扩展名）   
	        String savepath = docPath;
	          
	        //启动Word程序   
	        ActiveXComponent app = new ActiveXComponent("Word.Application");          
	        //接收输入文件和输出文件的路径   
	        String inFile = path;  
	        String tpFile = savepath;  
	        //设置word不可见   
	        app.setProperty("Visible", new Variant(false));  
	        //这句不懂   
	        Object docs = app.getProperty("Documents").toDispatch();  
	        //打开输入的doc文档   
	        Object doc = Dispatch.invoke((Dispatch) docs,"Open", Dispatch.Method, new Object[]{inFile,new Variant(true), new Variant(true)}, new int[1]).toDispatch();  
	          
	        //另存文件, 其中Variant(n)参数指定另存为的文件类型，详见代码结束后的文字   
	        Dispatch.invoke((Dispatch) doc,"SaveAs", Dispatch.Method, new Object[]{tpFile,new Variant(0)}, new int[1]);  
	        //这句也不懂   
	        Variant f = new Variant(false);  
	        //关闭并退出   
	        Dispatch.call((Dispatch) doc, "Close", f);  
	        app.invoke("Quit", new Variant[] {});  
	        logger.info("docx=>doc 转换完成");
	        return true;
		} catch (Exception e) {
			logger.info("docx=>doc 转换失败");
			return false;
		}
	}
}
