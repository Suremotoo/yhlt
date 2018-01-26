package com.xzb.showcase.system.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xzb.showcase.base.security.LoginContextHolder;
import com.xzb.showcase.base.security.SessionSecurityConstants;
import com.xzb.showcase.system.dto.SystemMenuDto;
import com.xzb.showcase.system.service.UserRoleResourceService;

/**
 * 主页
 * 
 * @author xunxun
 * @date 2014-11-17 下午3:34:34
 */
@Controller
@RequestMapping(value = "/main")
public class MainController {

	@Autowired
	private UserRoleResourceService userRoleResourceService;

	/**
	 * 查询左侧菜单
	 * 
	 * @param model
	 * @return
	 * @author xunxun
	 * @date 2014-11-19 下午3:01:44
	 */
	@RequestMapping()
	public String index(HttpServletRequest request, Model model) {
		// 当前服务器时间
		request.setAttribute(SessionSecurityConstants.KEY_SYSTEM_DATETIME,
				DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
		return "system/main/index";
	}

	@RequestMapping("weboffice")
	public String weboffice() {
		return "system/main/officeIndex";
	}

	/**
	 * 查询左侧菜单
	 * 
	 * @param model
	 * @return
	 * @author xunxun
	 * @date 2014-11-19 下午3:01:44
	 */
	@RequestMapping("/menu/one")
	@ResponseBody
	public List<SystemMenuDto> menuOne(Model model) {
		Long userId = LoginContextHolder.get().getUserId();
		List<SystemMenuDto> lists = userRoleResourceService
				.findSystemMenuByUserId(userId, null);
		return lists;
	}

	/**
	 * 查询左侧菜单
	 * 
	 * @param model
	 * @return
	 * @author xunxun
	 * @date 2014-11-19 下午3:01:44
	 */
	@RequestMapping("/menu/two")
	@ResponseBody
	public List<SystemMenuDto> menuTwo(
			@RequestParam(value = "parentId") Long parentId, Model model) {
		Long userId = LoginContextHolder.get().getUserId();
		List<SystemMenuDto> lists = userRoleResourceService
				.findSystemMenuByUserId(userId, parentId);
		return lists;
	}

	/**
	 * ajax请求无权限跳转到此方法，返回json
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/noAccess")
	@ResponseBody
	public Map<String, Object> noAccess(Model model) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", false);
		result.put("msg", "无权限访问");
		return result;
	}
}
