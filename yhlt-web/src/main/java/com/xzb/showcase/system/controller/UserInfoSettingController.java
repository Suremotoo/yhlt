package com.xzb.showcase.system.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xzb.showcase.base.security.LoginContextHolder;
import com.xzb.showcase.base.security.SessionSecurityConstants;
import com.xzb.showcase.base.util.MD5Util;
import com.xzb.showcase.system.entity.UserEntity;
import com.xzb.showcase.system.entity.UserSettingEntity;
import com.xzb.showcase.system.service.UserService;
import com.xzb.showcase.system.service.UserSettingService;

/**
 * 系统用户设置
 * 
 * @author admin
 * 
 */
@Controller
@RequestMapping(value = "/userInfo")
public class UserInfoSettingController {

	@Autowired
	private UserService userInfoService;

	@Autowired
	private UserSettingService userSettingService;

	@RequestMapping(value = "/myInfo")
	@ResponseBody
	public Map<String, Object> myInfo(Model model, HttpServletRequest request,
			HttpServletResponse response) {
		UserEntity userEntity = userInfoService.findOne(LoginContextHolder
				.get().getUserId());
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", true);
		result.put("obj", userEntity);
		return result;
	}

	/**
	 * 重置密码
	 * 
	 * @param pwd
	 * @param newPwd
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/resetPassword")
	@ResponseBody
	public Map<String, Object> resetPassword(
			@RequestParam(value = "pwd", required = true) String pwd,
			@RequestParam(value = "newPwd", required = true) String newPwd,
			Model model, HttpServletRequest request,
			HttpServletResponse response) {
		UserEntity userEntity = userInfoService.findOne(LoginContextHolder
				.get().getUserId());
		String orgPwdMd5 = MD5Util.MD5(pwd);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", false);
		result.put("message", "原密码输入错误");
		// 原密码匹配成功
		if (userEntity.getPassword().equals(orgPwdMd5)) {
			// 新密码和原密码不一致才需要更新
			if (!pwd.equals(newPwd)) {
				userEntity.setPassword(MD5Util.MD5(newPwd));
				userInfoService.save(userEntity);
				result.put("success", true);
				result.put("message", "修改密码成功");
			} else {
				result.put("message", "新旧密码不能相同");
			}
		}
		return result;
	}





	/**
	 * 获取当前用户设置
	 * 
	 * @param request
	 * @return
	 */
	private UserSettingEntity getCurrentUserSetting(HttpServletRequest request) {

		// 获取登录用户
		UserEntity userEntity = (UserEntity) request.getSession().getAttribute(
				SessionSecurityConstants.KEY_USER);
		return getUserSetting(userEntity);
	}

	/*
	 * 获取某个用户的portal设置
	 */
	private UserSettingEntity getUserSetting(UserEntity userEntity) {
		// 查询登录用户设置
		Map<String, Object> searchParams = new HashMap<String, Object>();
		searchParams.put("EQ_user.id", userEntity.getId());
		UserSettingEntity userSettingEntity = userSettingService
				.findOneByParams(searchParams);
		if (userSettingEntity == null) {
			userSettingEntity = new UserSettingEntity();
			userSettingEntity.setUser(userEntity);
			userSettingEntity.setCreateById(userEntity.getId());
		} else {
			userSettingEntity.setLastModifiedById(userEntity.getId());
		}
		return userSettingEntity;
	}

	/**
	 * 获取当前portal设置
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/portalSetting")
	@ResponseBody
	public String portalSetting(HttpServletRequest request) {
		UserSettingEntity userSettingEntity = getCurrentUserSetting(request);
		// String data = (String) request.getSession().getAttribute(
		// ConstantsUtils.USER_PORTAL);
		return userSettingEntity.getPortalContent();
	}

	@RequestMapping()
	public String index(Model model, HttpServletRequest request) {
		return "portal/portal_index";
	}

}
