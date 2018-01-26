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
import org.springframework.beans.BeanUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.domain.Sort.Order;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.xzb.showcase.base.controller.BaseController;
import com.xzb.showcase.base.security.AccessRequired;
import com.xzb.showcase.base.security.LoginContextHolder;
import com.xzb.showcase.base.util.CopyPropertiesUtil;
import com.xzb.showcase.base.util.Env;
import com.xzb.showcase.base.util.FileUtil;
import com.xzb.showcase.base.util.MD5Util;
import com.xzb.showcase.system.entity.UserEntity;
import com.xzb.showcase.system.service.UserService;

/**
 * 用户信息管理
 * 
 * @author admin
 * 
 */
@Controller
@RequestMapping(value = "/system/user")
@AccessRequired("用户管理")
public class UserController extends BaseController<UserEntity, UserService> {

	@Override
	public String index(Model model) {
		return "system/user/user_index";
	}

	@AccessRequired("管理员")
	@Override
	public Map<String, Object> save(UserEntity t, Model model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		boolean isNotExists = true;
		// 新用户注册
		if (t.getId() == null) {
			// 检查用户注册情况
			if (!checkUser(t.getLoginName())) {
				Map<String, Object> result = new HashMap<String, Object>();
				isNotExists = false;
				result.put("success", isNotExists);
				result.put("msg", isNotExists ? "" : "用户名已被注册");
				return result;
			}
			if (StringUtils.isBlank(t.getPassword())) {
				t.setPassword(Env.getProperty(Env.KEY_DEFAULT_PASSWORD));
			}
		}
		// 验证实体类
		Set<ConstraintViolation<UserEntity>> constraintViolations = validator
				.getValidator().validate(t);
		// 如果大于0，说明有验证未通过信息
		if (constraintViolations.size() > 0) {
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("success", false);
			result.put("msg", constraintViolations.iterator().next()
					.getMessage());
			return result;
		}

		if (t.getId() != null) {
			UserEntity temp = service.findOne(t.getId());
			BeanUtils.copyProperties(t, temp);
			temp.setGmtModified(new Date());
			temp.setLastModifiedById(LoginContextHolder.get().getUserId());
			t = temp;
		} else {
			t.setGmtCreate(new Date());
			t.setCreateById(LoginContextHolder.get().getUserId());
			t.setPassword(MD5Util.MD5(t.getPassword()));
			t.setSortNumber(service.findUserSortNumberMax() + 1);
		}
		Map<String, Object> result = service.saveMap(t);
		UserEntity user = (UserEntity) result.get("obj");
		result.put("success", true);
		result.put("msg", "保存成功！");
		result.put("userId", user.getId());
		result.put("password", user.getPassword());
		return result;
	}

	/**
	 * 查询用户名注册
	 * 
	 * @return
	 * @author wj
	 * @date 2015年1月7日16:26:02
	 */
	@RequestMapping(value = "/check")
	@ResponseBody
	public Map<String, Object> check(
			@RequestParam("loginName") String loginName,
			HttpServletRequest request, Model model) {
		boolean flag = checkUser(loginName);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", flag);
		result.put("msg", flag ? "" : "用户名已被注册");
		return result;
	}

	/**
	 * 检查用户名重复情况
	 * 
	 * @param loginName
	 * @return
	 */
	private boolean checkUser(String loginName) {
		Map<String, Object> searchParams = new HashMap<String, Object>();
		searchParams.put("EQ_loginName", loginName);
		List<UserEntity> userEntities = service.findByParams(searchParams);

		// flag=true 没有注册，false已被注册
		boolean flag = userEntities == null || userEntities.size() == 0;
		return flag;
	}

	@RequestMapping(value = "/toEdit")
	public String edit(HttpServletRequest request, Model model) {
		UserEntity user = service.findOne(LoginContextHolder.get().getUserId());
		model.addAttribute("entity", user);
		return "system/user/edit_info";
	}

	/**
	 * 人员信息查询
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toSearch")
	public String toSearch(HttpServletRequest request, Model model) {
		return "system/user/user_search_index";
	}

	/**
	 * 保存个人信息
	 * 
	 * @param entity
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveInfo")
	@ResponseBody
	public Map<String, Object> saveInfo(UserEntity entity, Model model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 置空敏感字段，防止被恶意修改
		entity.setPassword(null);
		entity.setWorkcode(null);
		entity.setCompanyEntity(null);
		entity.setDepartmentEntity(null);
		entity.setLoginName(null);
		if (entity.getId() != null) {
			UserEntity temp = service.findOne(entity.getId());
			CopyPropertiesUtil.copyPropertiesIgnoreNull(entity, temp);
			temp.setGmtModified(new Date());
			temp.setLastModifiedById(LoginContextHolder.get().getUserId());
			entity = temp;
		}
		// 验证实体类
		Set<ConstraintViolation<UserEntity>> constraintViolations = validator
				.getValidator().validate(entity);
		// 如果大于0，说明有验证未通过信息
		if (constraintViolations.size() > 0) {
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("success", false);
			result.put("msg", constraintViolations.iterator().next()
					.getMessage());
			return result;
		}
		Map<String, Object> result = service.saveMap(entity);
		result.put("success", true);
		result.put("msg", "保存成功！");
		return result;
	}

	/**
	 * 跳转修改密码
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toEditPwd")
	public String toEditPwd(HttpServletRequest request, Model model) {
		return "system/user/edit_pwd";
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
	public Map<String, Object> savePwd(HttpServletRequest request, Model model,
			String oldPwd, String password, String newPassword) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", false);
		UserEntity user = service.findOne(LoginContextHolder.get().getUserId());
		// 校验密码-->>
		if (StringUtils.isBlank(oldPwd)) {
			result.put("msg", "请输入旧密码");
			return result;
		} else if (user != null
				&& !user.getPassword().equals(MD5Util.MD5(oldPwd))) {
			result.put("msg", "旧密码输入有误");
			return result;
		} else if (StringUtils.isBlank(password)
				|| StringUtils.isBlank(newPassword)
				|| !password.equals(newPassword)) {
			result.put("msg", "两次输入密码不一样");
			return result;
		}
		// 校验密码--<<
		// 修改密码
		user.setPassword(MD5Util.MD5(password));
		service.save(user);
		result.put("success", true);
		result.put("msg", "密码修改成功！");
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
	public Map<String, Object> checkOldPwd(String oldPwd,
			HttpServletRequest request, Model model) {
		Map<String, Object> result = new HashMap<String, Object>();
		UserEntity user = service.findOne(LoginContextHolder.get().getUserId());
		result.put("flag", true);
		if (StringUtils.isBlank(oldPwd)
				|| (user != null && !user.getPassword().equals(
						MD5Util.MD5(oldPwd)))) {
			result.put("msg", "旧密码输入有误");
			result.put("flag", false);
		}
		return result;
	}

	/**
	 * 跳转到用户新增页面
	 * 
	 * @param request
	 * @param model
	 * @return hubaojie
	 */
	@RequestMapping(value = "/toAddPage")
	public String toAddPage(HttpServletRequest request, Model model) {
		/*
		 * String id = request.getParameter("id"); if(id != null){ UserEntity
		 * user = service.findOne(Long.parseLong(id));
		 * model.addAttribute("entity",user); }
		 */
		return "system/user/user_add";
	}

	/**
	 * 跳转到用户修改页面
	 * 
	 * @param request
	 * @param model
	 * @return hubaojie
	 */
	@RequestMapping(value = "/toEditPage")
	public String toEditPage(HttpServletRequest request, Model model) {
		String id = request.getParameter("id");
		if (id != null) {
			UserEntity user = service.findOne(Long.parseLong(id));
			model.addAttribute("entity", user);
		}
		return "system/user/user_edit";
	}

	/**
	 * 获取当前用户
	 * 
	 * @param request
	 * @param model
	 * @return hubaojie
	 */
	@ResponseBody
	@RequestMapping(value = "/getCurrUser")
	public Map<String, Object> getCurrUser(HttpServletRequest request,
			Model model) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			UserEntity user = service.findOne(LoginContextHolder.get()
					.getUserId());
			result.put("flag", true);
			result.put("user", user);
		} catch (Exception e) {
			result.put("flag", false);
		}
		return result;
	}

	/**
	 * 重置密码
	 * 
	 * @param request
	 * @param model
	 * @return hubaojie
	 */
	@AccessRequired("管理员")
	@RequestMapping(value = "/resetPwd")
	@ResponseBody
	public Map<String, Object> resetPwd(HttpServletRequest request, Model model) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			String id = request.getParameter("id");
			UserEntity user = service.findOne(Long.parseLong(id));
			user.setPassword(MD5Util.MD5(Env
					.getProperty(Env.KEY_DEFAULT_PASSWORD)));//
			service.save(user);
			result.put("flag", true);
			result.put("msg", "重置成功！");
		} catch (Exception e) {
			result.put("flag", false);
			result.put("msg", "重置失败！");
		}
		return result;
	}

	/** 
	 * 用户头像上传
	 * @param file
	 * @param request
	 * @param response
	 * @param flag : (0:admin新增用户，1：用户个人修改)
	 * @return
	 *  hubaojie 
	 */
	@ResponseBody
	@RequestMapping(value = "/uploadHeadImg")
	public Map<String, Object> uploadHeadImg(@RequestParam(required = false) MultipartFile file,@RequestParam Long userId,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			response.setCharacterEncoding("UTF-8");
			
			// 格式处理
			String OriFileName = file.getOriginalFilename();
			String type = OriFileName.substring(OriFileName.lastIndexOf(".") + 1);
			if (!(type.equalsIgnoreCase("jpg") || type.equalsIgnoreCase("gif") || 
					type.equalsIgnoreCase("bmp") ||type.equalsIgnoreCase("png")) ) {
				result.put("msg","文件格式不正确（必须为.jpg/.gif/.bmp/.png文件）");
			    result.put("success",false);
				return result;
			}
		 
			// 文件处理
			List<Object> list = FileUtil.getNewFile(OriFileName,"headImg", request);
			File newFile = (File) list.get(0);
			StringBuffer path = (StringBuffer)list.get(1);
			
			// 保存到服务器:大于10kb压缩
			String headImgUrl = path.toString();
			if(file.getSize() > 10 * 1024){
				String path1 = newFile.getPath();
				path1 = path1.substring(0, path1.lastIndexOf("."));
				Thumbnails.of(file.getInputStream()).size(240, 240)
		        .outputFormat("jpg").toFile(path1);
				
				headImgUrl  = headImgUrl.substring(0, headImgUrl.lastIndexOf(".")) + ".jpg";
			}else{
				file.transferTo(newFile);
			}
		    
		    // 保存用户头像
		    UserEntity userEntity = service.findOne(userId);
		    userEntity.setHeadImgUrl(headImgUrl);
		    service.save(userEntity);
		    
		    result.put("msg","上传成功！");
		    result.put("success",true);
		    result.put("path",headImgUrl);
		} catch (Exception e) {
			result.put("msg","上传失败！");
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 用户排序
	 * 
	 * @param sortType
	 *            0-升，1-降
	 * @param userId
	 * @param request
	 * @param model
	 * @return
	 */
	@AccessRequired("管理员")
	@RequestMapping(value = "/userSort")
	@ResponseBody
	public Map<String, Object> userSort(@RequestParam int sortType,
			@RequestParam long userId, HttpServletRequest request, Model model) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			UserEntity user = service.findOne(userId);
			int currentSortNumber = user.getSortNumber();

			Page<UserEntity> userEntityList = null;
			// 升
			if (sortType == 0) {
				Map<String, Object> searchParams = new HashMap<String, Object>();
				searchParams.put("LT_sortNumber", currentSortNumber);
				userEntityList = service.findByParams(searchParams,
						new PageRequest(0, 1, new Sort(new Order(
								Direction.DESC, "sortNumber"))));
			} else {
				// 降
				Map<String, Object> searchParams = new HashMap<String, Object>();
				searchParams.put("GT_sortNumber", currentSortNumber);
				userEntityList = service.findByParams(searchParams,
						new PageRequest(0, 1, new Sort(new Order(Direction.ASC,
								"sortNumber"))));
			}
			if (userEntityList != null && userEntityList.getSize() > 0) {
				UserEntity userEntityTemp = userEntityList.getContent().get(0);
				user.setSortNumber(userEntityTemp.getSortNumber());
				userEntityTemp.setSortNumber(currentSortNumber);
				service.save(user);
				service.save(userEntityTemp);
			}
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
		}
		return result;
	}
}
