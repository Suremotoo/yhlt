package com.xzb.showcase.base.util;

import java.io.File;
import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

public class FileUtil {

	/**
	 * 获取附件，最后一个参数可以不传，使用时可不传，也可传任意数量的String类型参数，将追加到  模块/年月日/之后
	 * 
	 * @param fileName
	 * @return
	 */
	public static synchronized List<Object> getNewFile(String fileName, String module, HttpServletRequest request, String... subModule) {
		List<Object> list = new ArrayList<Object>();
		// 得到文件扩展名
		String extension = fileName.substring(fileName.lastIndexOf("."));
		// 得到当天日期
		Date date = new Date();
		// 取四位年两位月两位天
		SimpleDateFormat today = new SimpleDateFormat("yyyyMMdd");
		// 文件路径变量
		StringBuffer filePath = new StringBuffer(request.getSession().getServletContext().getRealPath(""));
		filePath.append("/");
		StringBuffer sysPath = new StringBuffer(Env.getProperty(Env.KEY_FILE_SAVE_PATH));
		// 转换为字符串
		String dateFormat = today.format(date);
		sysPath.append("/").append(module).append("/").append(dateFormat).append("/");
		for (String sub : subModule) {
			sysPath.append(sub).append("/");
		}
		// 文件名变量
		StringBuilder systemName = new StringBuilder(System.currentTimeMillis() + extension);
		File file = new File(filePath.toString() + sysPath.toString());
		if (!file.exists()) {
			file.mkdirs();
		}
		File newFile = new File(file.getPath() + "/" + systemName.toString());
		sysPath.append(systemName);
		list.add(newFile);
		list.add(sysPath);
		return list;
	}

	/**
	 * 文件大小转化
	 * 
	 * @param fileSize
	 * @return
	 */
	public static String convertFileSize(long fileSize) {
		String strUnit = "B";
		String strAfterComma = "";
		int intDivisor = 1;
		if (fileSize >= 1024 * 1024) {
			strUnit = "MB";
			intDivisor = 1024 * 1024;
		} else if (fileSize >= 1024) {
			strUnit = "KB";
			intDivisor = 1024;
		}
		if (intDivisor == 1)
			return fileSize + strUnit;
		strAfterComma = "" + 100 * (fileSize % intDivisor) / intDivisor;
		if (strAfterComma == "")
			strAfterComma = ".0";
		return fileSize / intDivisor + "." + strAfterComma + strUnit;

	}

	/**
	 * 获取文件大小
	 * 
	 * @param fileSize
	 * @return
	 */
	public static long getFileSizes(File f) throws Exception {
		long s = 0;
		if (f.exists()) {
			FileInputStream fis = null;
			fis = new FileInputStream(f);
			s = fis.available();
		} else {
			f.createNewFile();
			System.out.println("文件不存在");
		}
		return s;
	}

}
