package com.xzb.showcase.system.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xzb.showcase.base.listener.LoginListener;
import com.xzb.showcase.base.security.SessionSecurityConstants;
import com.xzb.showcase.base.util.MD5Util;
import com.xzb.showcase.base.util.VerifyCodeUtils;
import com.xzb.showcase.system.entity.UserEntity;
import com.xzb.showcase.system.entity.UserRoleResourceEntity;
import com.xzb.showcase.system.service.DictService;
import com.xzb.showcase.system.service.ResourcesService;
import com.xzb.showcase.system.service.UserRoleResourceService;
import com.xzb.showcase.system.service.UserService;

@Controller
@RequestMapping(value = "/login")
public class LoginController {

	@Autowired
	private UserService userService;

	@Autowired
	private UserRoleResourceService userRoleResourceService;

	@Autowired
	private ResourcesService resourcesService;

	@Autowired
	private DictService dictService;

	/**
	 * 招标方登陆
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/userLogin")
	public String login(HttpServletRequest request, HttpServletResponse response) {
		String loginName = request.getParameter("username");
		String password = request.getParameter("password");
//		String verifyCode = request.getParameter("verifiyCode");

		if (StringUtils.isBlank(loginName) || StringUtils.isBlank(password)
//				|| StringUtils.isBlank(verifyCode)
				) {
			return "user_login";
		} 
//		else if (!verifyCode.toUpperCase().equals(
//				request.getSession().getAttribute(
//						SessionSecurityConstants.KEY_USER_VERIFICATION_CODE))) {
//			request.setAttribute("errorMsg", "验证码信息错误!");
//			return "user_login";
//		}

		if (StringUtils.isBlank(loginName) || StringUtils.isBlank(password)) {
			// loginName = "admin";
			// password = "123456";
			return "user_login";
		}
		Map<String, Object> searchParams = new HashMap<String, Object>();
		searchParams.put("EQ_loginName", loginName);
		searchParams.put("EQ_password", MD5Util.MD5(password));
		UserEntity userEntity = userService.findOneByParams(searchParams);
		if (userEntity == null) {
			request.setAttribute("errorMsg", "用户名或密码错误，请重新输入！");
			return "user_login";
		}

		HttpSession httpSession = request.getSession();

		// 加载用户资源信息
		searchParams = new HashMap<String, Object>();
		searchParams.put("EQ_userId", userEntity.getId());
		List<UserRoleResourceEntity> resourcesEntities = userRoleResourceService
				.findByParams(searchParams);
		httpSession.setAttribute(SessionSecurityConstants.KEY_USER_RESOURCES,
				resourcesEntities);

		httpSession.setAttribute(SessionSecurityConstants.KEY_USER, userEntity);
		httpSession.setAttribute(SessionSecurityConstants.KEY_USER_ID,
				userEntity.getId());
		httpSession.setAttribute(SessionSecurityConstants.KEY_LOGIN_NAME,
				userEntity.getLoginName());
		return "redirect:/main";
	}

	@RequestMapping(value = "/code")
	@ResponseBody
	public void code(HttpServletRequest request, HttpServletResponse response) {
		int w = 200, h = 80;
		response.reset();
		try {
			String verifyCode = VerifyCodeUtils.outputVerifyImage(w, h,
					response.getOutputStream(), 4);
			request.getSession().setAttribute(
					SessionSecurityConstants.KEY_USER_VERIFICATION_CODE,
					verifyCode);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		// 登出清空通知状态记录
		String loginName = (String) session
				.getAttribute(SessionSecurityConstants.KEY_LOGIN_NAME);
		LoginListener.loginedUserNoitceStatus.remove(loginName);

		// 登出
		LoginListener.loginedUser.remove(loginName);

		session.removeAttribute(SessionSecurityConstants.KEY_USER);
		session.removeAttribute(SessionSecurityConstants.KEY_USER_ID);
		session.removeAttribute(SessionSecurityConstants.KEY_LOGIN_NAME);

		session.removeAttribute(SessionSecurityConstants.KEY_SUPPLIER_USER);

		session.invalidate();
		return "user_login";
	}
}
