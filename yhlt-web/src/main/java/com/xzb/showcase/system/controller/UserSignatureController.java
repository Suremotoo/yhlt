package com.xzb.showcase.system.controller;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;

import net.coobird.thumbnailator.Thumbnails;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.xzb.showcase.base.controller.BaseController;
import com.xzb.showcase.base.security.AccessRequired;
import com.xzb.showcase.base.security.LoginContextHolder;
import com.xzb.showcase.base.util.Constants;
import com.xzb.showcase.base.util.Env;
import com.xzb.showcase.base.util.FileUtil;
import com.xzb.showcase.base.util.MD5Util;
import com.xzb.showcase.system.entity.FileEntity;
import com.xzb.showcase.system.entity.UserEntity;
import com.xzb.showcase.system.entity.UserSignatureEntity;
import com.xzb.showcase.system.service.FileService;
import com.xzb.showcase.system.service.UserSignatureService;

/**
 * 电子签名管理
 * 
 * @author wyt
 * 
 */
@Controller
@RequestMapping(value = "/system/user/signature")
@AccessRequired("电子签名管理")
public class UserSignatureController extends BaseController<UserSignatureEntity, UserSignatureService> {

	@Autowired
	private FileService fileService;

	@Override
	public String index(Model model) {
		return "";
	}

	@AccessRequired("管理员")
	@RequestMapping("upload")
	@ResponseBody
	public Map<String, Object> upload(@RequestParam("file") MultipartFile multipartFile, Long userId, HttpServletRequest request, HttpServletResponse response) throws Exception {
		UserSignatureEntity entity = new UserSignatureEntity();
		String password = Env.getProperty(Env.KEY_DEFAULT_PASSWORD);
		String fileName = multipartFile.getOriginalFilename();
		List<Object> list = FileUtil.getNewFile(fileName, "signature", request);
		File file = (File) list.get(0);

		FileEntity fileEntity = new FileEntity();
		fileEntity.setModule("signature");
		fileEntity.setFileName(fileName);
		fileEntity.setFileSize(multipartFile.getSize());
		fileEntity.setContentType(fileName.substring(fileName.indexOf(".")));

		fileEntity.setSysFileName(file.getName());
		fileEntity.setSysFilePath(list.get(1).toString());
		fileEntity.setDownloadUrl(file.getPath());
		fileEntity.setDeleteFlag(Constants.DELETE_FLAG_FALSE);
		fileEntity.setGmtCreate(new Date());
		fileEntity.setCreateById(LoginContextHolder.get().getUserId());
		// 保存到服务器:大于10kb压缩
		if (fileEntity.getFileSize() > 10 * 1024) {
			Thumbnails.of(multipartFile.getInputStream()).size(120, 60).outputFormat("jpg").toFile(file);
			fileEntity.setConvertFileSize(FileUtil.convertFileSize(FileUtil.getFileSizes(file)));
		} else {
			multipartFile.transferTo(file);
			fileEntity.setConvertFileSize(FileUtil.convertFileSize(multipartFile.getSize()));
		}
		fileService.save(fileEntity);

		entity.setPassword(MD5Util.MD5(password));
		// 验证实体类
		Set<ConstraintViolation<UserSignatureEntity>> constraintViolations = validator.getValidator().validate(entity);
		// 如果大于0，说明有验证未通过信息
		if (constraintViolations.size() > 0) {
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("success", false);
			result.put("msg", constraintViolations.iterator().next().getMessage());
			return result;
		}

		Map<String, Object> searchParams = new HashMap<String, Object>();
		searchParams.put("EQ_user.id", userId);
		UserSignatureEntity temp = service.findOneByParams(searchParams);

		if (temp != null) {
			entity.setId(temp.getId());
			entity.setGmtModified(new Date());
			entity.setLastModifiedById(LoginContextHolder.get().getUserId());
		} else {
			entity.setGmtCreate(new Date());
			entity.setCreateById(LoginContextHolder.get().getUserId());
		}
		entity.setFile(fileEntity);
		entity.setUser(new UserEntity(userId));

		Map<String, Object> result = service.saveMap(entity);
		result.put("success", true);
		result.put("msg", "保存成功！");
		return result;
	}

	@RequestMapping("ajax")
	@ResponseBody
	public Map<String, Object> ajax(Long id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> searchParams = new HashMap<String, Object>();
		searchParams.put("EQ_user.id", id);
		UserSignatureEntity entity = service.findOneByParams(searchParams);

		if (entity != null) {
			result.put("success", true);
			result.put("path", entity.getFile().getSysFilePath());
		} else {
			result.put("success", false);
		}
		return result;
	}

	/**
	 * 校验旧密码
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/checkOldPwd")
	@ResponseBody
	public Map<String, Object> checkOldPwd(String oldPwd, HttpServletRequest request, Model model) {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> searchParams = new HashMap<String, Object>();
		searchParams.put("EQ_user.id", LoginContextHolder.get().getUserId());
		List<UserSignatureEntity> entities = service.findByParams(searchParams);
		UserSignatureEntity entity = new UserSignatureEntity();
		if (entities != null && entities.size() > 0) {
			entity = entities.get(0);
			result.put("flag", true);
			if (StringUtils.isBlank(oldPwd) || (entity != null && !entity.getPassword().equals(MD5Util.MD5(oldPwd)))) {
				result.put("msg", "旧密码输入有误");
				result.put("flag", false);
			}
		} else {
			result.put("msg", "您没有电子签名功能，请先上传电子签名！");
			result.put("flag", false);
		}
		return result;
	}

	/**
	 * 保存密码
	 * 
	 * @param request
	 * @param model
	 * @param oldPwd
	 *            原密码
	 * @param password
	 *            新密码
	 * @param newPassword
	 *            确认新密码
	 * @return
	 */
	@RequestMapping(value = "/savePwd")
	@ResponseBody
	public Map<String, Object> savePwd(HttpServletRequest request, Model model, String oldPwd, String password, String newPassword) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", false);
		Map<String, Object> searchParams = new HashMap<String, Object>();
		searchParams.put("EQ_user.id", LoginContextHolder.get().getUserId());
		List<UserSignatureEntity> entities = service.findByParams(searchParams);
		UserSignatureEntity entity = new UserSignatureEntity();
		if (entities != null && entities.size() > 0) {
			entity = entities.get(0);
		} else {
			result.put("msg", "您没有电子签名功能，请先上传电子签名！");
			return result;
		}

		// 校验密码-->>
		if (StringUtils.isBlank(oldPwd)) {
			result.put("msg", "请输入旧密码");
			return result;
		} else if (entity != null && !entity.getPassword().equals(MD5Util.MD5(oldPwd))) {
			result.put("msg", "旧密码输入有误");
			return result;
		} else if (StringUtils.isBlank(password) || StringUtils.isBlank(newPassword) || !password.equals(newPassword)) {
			result.put("msg", "两次输入密码不一样");
			return result;
		}
		// 校验密码--<<
		// 修改密码
		entity.setPassword(MD5Util.MD5(password));
		service.save(entity);
		result.put("success", true);
		result.put("msg", "密码修改成功！");
		return result;
	}
}
