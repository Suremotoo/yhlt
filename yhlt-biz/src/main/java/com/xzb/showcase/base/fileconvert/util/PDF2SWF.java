package com.xzb.showcase.base.fileconvert.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.xzb.showcase.base.util.Env;

/**
 * PDF 转 swf工具
 * 
 * @author wj
 * 
 */
public class PDF2SWF {
	private static Logger logger = Logger.getLogger(PDF2SWF.class);
	/**
	 * SWTOOLS的安装路径,我的SWFTools安装目录为:"C:/Program Files (x86)/SWFTools"
	 */
	public static final String SWFTOOLS_PATH;
	static {
		SWFTOOLS_PATH = Env.getProperty(Env.SWFTOOLS_PATH);
	}
	/**
	 * pdf文件后缀名
	 */
	public static final String FILE_NAME_OF_PDF = "pdf";
	/**
	 * swf文件后缀名
	 */
	public static final String FILE_NAME_OF_SWF = "swf";

	/**
	 * 获得文件的路径
	 * 
	 * @param file
	 *            文件的路径 ,如："c:/test/test.swf"
	 * @return 文件的路径
	 */
	public static String getFilePath(String file) {
		int endIndex = file.lastIndexOf("/") > 0 ? file.lastIndexOf("/") : file
				.lastIndexOf("\\");
		String result = file.substring(0, endIndex);
		if (file.substring(2, 3) == "/") {
			result = file.substring(0, file.lastIndexOf("/"));
		} else if (file.substring(2, 3) == "\\") {
			result = file.substring(0, file.lastIndexOf("\\"));
		}
		return result;
	}

	/**
	 * 新建一个目录
	 * 
	 * @param folderPath
	 *            新建目录的路径 如："c:\\newFolder"
	 */
	public static void newFolder(String folderPath) {
		try {
			File myFolderPath = new File(folderPath.toString());
			if (!myFolderPath.exists()) {
				myFolderPath.mkdir();
			}
		} catch (Exception e) {
			System.out.println("新建目录操作出错");
			e.printStackTrace();
		}
	}

	/**
	 * the exit value of the subprocess represented by this Process object. By
	 * convention, the value 0 indicates normal termination.
	 * 
	 * @param sourcePath
	 *            pdf文件路径 ，如："c:/hello.pdf"
	 * @param destPath
	 *            swf文件路径,如："c:/test/test.swf"
	 * @return 正常情况下返回：0，失败情况返回：1
	 * @throws IOException
	 * @throws InterruptedException
	 */
	public static int convertPDF2SWF(List<String> sourcePath,
			List<String> destPath) throws IOException, InterruptedException {
		// 如果目标文件的路径是新的，则新建路径
		int status = 0;
		for (int i = 0; i < sourcePath.size(); i++) {
			newFolder(getFilePath(destPath.get(i)));

			// 源文件不存在则返回
			File source = new File(sourcePath.get(i));
			if (!source.exists()) {
				return 0;
			}
			File dest = new File(destPath.get(i));
			if (dest.exists()) {
				System.out.println("文件已经存在，不用转换了");
				return 0;
			}
			// 调用pdf2swf命令进行转换
			String command = SWFTOOLS_PATH
					+ "/pdf2swf.exe  -t \""
					+ sourcePath.get(i)
					+ "\" -o  \""
					+ destPath.get(i)
					+ "\" -s flashversion=9 -s languagedir=D:\\xpdf\\xpdf-chinese-simplified ";
			System.out.println("命令操作:" + command + "\n开始转换...");
			// 调用外部程序
			Thread.sleep(500);
			Process process = Runtime.getRuntime().exec(command);
			final InputStream is1 = process.getInputStream();
			new Thread(new Runnable() {
				public void run() {
					BufferedReader br = new BufferedReader(
							new InputStreamReader(is1));
					try {
						while (br.readLine() != null)
							;
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}).start(); // 启动单独的线程来清空process.getInputStream()的缓冲区
			InputStream is2 = process.getErrorStream();
			BufferedReader br2 = new BufferedReader(new InputStreamReader(is2));
			// 保存输出结果流
			StringBuilder buf = new StringBuilder();
			String line = null;
			while ((line = br2.readLine()) != null)
				// 循环等待ffmpeg进程结束
				buf.append(line);
			while (br2.readLine() != null)
				;
			try {
				process.waitFor();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			System.out.println("转换结束...");
			status = process.exitValue();
			source.delete();
		}

		return status;
	}

	/**
	 * Pdf 转换 swf,并且swf自动分页
	 * 
	 * @param sourcePath pdf源路径
	 * @param destPath swf目标路径
	 * @param flag 转换后删除文件
	 * @return
	 * @throws IOException
	 * @throws InterruptedException
	 */
	public static int convertPDF2SWF(List<String> sourcePath,
			List<String> destPath, boolean flag) throws IOException,
			InterruptedException {
		logger.info("convertPDF2SWF转换开始");
		// 如果目标文件的路径是新的，则新建路径
		int status = 0;
		for (int i = 0; i < sourcePath.size(); i++) {
			newFolder(getFilePath(destPath.get(i)));

			// 源文件不存在则返回
			File source = new File(sourcePath.get(i));
			if (!source.exists()) {
				return 0;
			}
			File dest = new File(destPath.get(i));
			if (dest.exists()) {
				dest.delete();
				return 0;
			}
			// 调用pdf2swf命令进行转换
			String command = SWFTOOLS_PATH
					+ "/pdf2swf.exe \""
					+ sourcePath.get(i)
					+ "\" -o \""
					+ destPath.get(i)
					+ "\" -f -T 9 -t -s languagedir=D:\\xpdf\\xpdf-chinese-simplified ";
			// C:\SWFTools\pdf2swf.exe Paper.pdf -o Paper%.swf -f -T 9 -t -s
			// storeallcharacters
			logger.info("命令操作:" + command + " 开始转换");
			// 调用外部程序
			Thread.sleep(500);
			Process process = Runtime.getRuntime().exec(command);
			final InputStream is1 = process.getInputStream();
			new Thread(new Runnable() {
				public void run() {
					BufferedReader br = new BufferedReader(
							new InputStreamReader(is1));
					try {
						while (br.readLine() != null)
							;
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}).start(); // 启动单独的线程来清空process.getInputStream()的缓冲区
			InputStream is2 = process.getErrorStream();
			BufferedReader br2 = new BufferedReader(new InputStreamReader(is2));
			// 保存输出结果流
			StringBuilder buf = new StringBuilder();
			String line = null;
			while ((line = br2.readLine()) != null)
				// 循环等待ffmpeg进程结束
				buf.append(line);
			while (br2.readLine() != null)
				;
			try {
				process.waitFor();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			logger.info("convertPDF2SWF转换结束");
			status = process.exitValue();
			if (flag) {
				source.delete();
			}
		}
		return status;
	}

	/**
	 * pdf文件转换为swf文件操作
	 * 
	 * @param sourcePath
	 *            pdf文件路径 ，如："c:/hello.pdf"
	 * @param destPath
	 *            swf文件路径,如："c:/test/test.swf"
	 */
	public static void pdf2swf(List<String> sourcePath, List<String> destPath,
			boolean flag) {
		long begin_time = new Date().getTime();
		try {
			PDF2SWF.convertPDF2SWF(sourcePath, destPath, flag);
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("转换过程失败！！");
		}
		long end_time = new Date().getTime();
		System.out.println("转换共耗时 :[" + (end_time - begin_time) + "]ms");
		System.out.println("转换文件成功！！");
	}

	public static void main(String[] args) throws IOException {
		// String sourcePath = "f:/struts." + FILE_NAME_OF_PDF;
		// String destPath = "e:/struts" + "." + FILE_NAME_OF_SWF;
		// pdf2swf(sourcePath, destPath);
	}
}
