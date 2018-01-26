package com.xzb.showcase.file.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.xzb.showcase.base.controller.BaseController;
import com.xzb.showcase.base.security.LoginContextHolder;
import com.xzb.showcase.base.util.Constants;
import com.xzb.showcase.base.util.DateUtil;
import com.xzb.showcase.file.entity.FileInfoEntity;
import com.xzb.showcase.file.service.FileInfoService;

@Controller
@RequestMapping(value = "/file")
public class FileInfoController extends
		BaseController<FileInfoEntity, FileInfoService> {

	@Value("${file.save.path}")
	private String fileSavePath;

	@Override
	public String index(Model model) {
		return "file/file_info_index";
	}

	/**
	 * 附件上传
	 * 
	 * @param file
	 * @param module
	 * @return
	 * @throws Exception
	 * @author LauLimXiao
	 */
	@RequestMapping(value = "/upload")
	@ResponseBody
	public Map<String, Object> upload(@RequestParam("file") MultipartFile file,
			String module, HttpServletRequest request) throws Exception {
		String fileName = file.getOriginalFilename();
		FileInfoEntity fileInfoEntity = new FileInfoEntity();
		String title = request.getParameter("title");
		String typeId = request.getParameter("typeId");
		fileInfoEntity.setTitle(title);
		fileInfoEntity.setTypeId(Integer.valueOf(typeId));
		fileInfoEntity.setModule(module);
		fileInfoEntity.setFileName(fileName);
		fileInfoEntity.setFileSize(file.getSize());
		fileInfoEntity.setConvertFileSize(convertFileSize(file.getSize()));
		fileInfoEntity.setContentType(fileName.substring(fileName
				.lastIndexOf(".") + 1));
		// 获取系统文件
		File newFile = getNewFile(fileName, module);
		fileInfoEntity.setSysFileName(newFile.getName());
		fileInfoEntity.setSysFilePath(newFile.getPath());
		fileInfoEntity.setDeleteFlag(Constants.DELETE_FLAG_FALSE);
		fileInfoEntity.setGmtCreate(new Date());
		fileInfoEntity.setCreateById(LoginContextHolder.get().getUserId());
		// 保存附件
		file.transferTo(newFile);
		// 保存附件信息
		service.save(fileInfoEntity);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", true);
		result.put("obj", fileInfoEntity);
		return result;
	}

	/**
	 * 获取系统文件
	 * 
	 * @param fileName
	 * @param module
	 * @return
	 * @author LauLimXiao
	 */
	private synchronized File getNewFile(String fileName, String module) {
		String number = "00000001";
		// 得到文件扩展名
		String extension = fileName.substring(fileName.lastIndexOf("."));
		// 得到当天日期
		String today = DateUtil.formatDate2Str(new Date(), "yyyyMMdd");
		// 文件路径变量
		StringBuilder path = new StringBuilder(fileSavePath);
		path.append("/").append(module).append("/").append(today).append("/");
		// 文件名变量
		StringBuilder systemName = new StringBuilder(today);
		File file = new File(path.toString());
		// 存在目录判断目录下的文件数量+1，不存在则取1
		if (file.exists()) {
			// 得到目录下的文件数量
			String size = ObjectUtils.toString(file.list().length + 1);
			number = number.substring(0, number.length() - size.length())
					+ size;
		} else {
			file.mkdirs();
		}
		systemName.append(number).append(extension);
		path.append(systemName);
		File newFile = new File(path.toString());
		return newFile;
	}

	/**
	 * 文件大小转化
	 * 
	 * @param filesize
	 * @return
	 * @author LauLimXiao
	 */
	private String convertFileSize(long filesize) {
		String strUnit = "B";
		String strAfterComma = "";
		int intDivisor = 1;
		if (filesize >= 1024 * 1024) {
			strUnit = "MB";
			intDivisor = 1024 * 1024;
		} else if (filesize >= 1024) {
			strUnit = "KB";
			intDivisor = 1024;
		}
		if (intDivisor == 1)
			return filesize + strUnit;
		strAfterComma = "" + 100 * (filesize % intDivisor) / intDivisor;
		if (strAfterComma == "")
			strAfterComma = ".0";
		return filesize / intDivisor + "." + strAfterComma + strUnit;

	}

	public File getNewFile(String module, String fileName,
			HttpServletRequest request) {

		// 获取系统文件
		String number = "00000001";
		// 得到文件扩展名
		String extension = fileName.substring(fileName.lastIndexOf("."));
		// 得到当天日期
		String today = DateUtil.formatDate2Str(new Date(), "yyyyMMdd");
		// 获取web项目所在路径
		String realPath = request.getSession().getServletContext()
				.getRealPath("/");
		// 文件路径变量
		StringBuilder path = new StringBuilder();
		path.append("\\").append(module).append("\\").append(today)
				.append("\\");
		// 文件名变量
		StringBuilder systemName = new StringBuilder(today);
		File localfile = new File(realPath + path.toString());
		// 存在目录判断目录下的文件数量+1，不存在则取1
		if (localfile.exists()) {
			// 得到目录下的文件数量
			String size = ObjectUtils.toString(localfile.list().length + 1);
			number = number.substring(0, number.length() - size.length())
					+ size;
		} else {
			localfile.mkdirs();
		}
		systemName.append(number).append(extension);
		path.append(systemName);
		File newFile = new File(realPath + path.toString());
		return newFile;

	}

	public long getFileSizes(File f) throws Exception {// 取得文件大小
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
	
	/**
	 * 下载
	 * 
	 * @param id
	 * @param request
	 * @param response
	 * @author LauLimXiao
	 */
	@RequestMapping(value = "/download")
	public void download(Long id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		FileInfoEntity fileEntity = service.findOne(id);
		File file = new File(fileEntity.getSysFilePath());
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		if (file.exists()) {
			response.reset();
			String filename = URLEncoder.encode(fileEntity.getFileName(),
					"utf-8");
			response.setHeader("Content-Disposition", "attachment; filename="
					+ filename);
			response.addHeader("Content-Length", "" + file.length());
			response.setContentType("application/octet-stream;charset=UTF-8");
			// 获取输入流
			bis = new BufferedInputStream(new FileInputStream(file));
			// 输出流
			bos = new BufferedOutputStream(response.getOutputStream());
			byte[] buff = new byte[2048];
			int bytesRead;
			while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
				bos.write(buff, 0, bytesRead);
			}
			// 关闭流
			bis.close();
			bos.close();
		}
	}
	
	/**
	 * 验证文件是否存在
	 * 
	 * @param id
	 * @return
	 * @author LauLimXiao
	 */
	@RequestMapping(value = "/check")
	@ResponseBody
	public Map<String, Object> check(Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		FileInfoEntity fileEntity = service.findOne(id);
		File file = new File(fileEntity.getSysFilePath());
		if (file.exists()) {
			result.put("success", true);
		} else {
			result.put("success", false);
		}
		return result;
	}


}
