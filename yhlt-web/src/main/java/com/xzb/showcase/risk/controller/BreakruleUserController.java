package com.xzb.showcase.risk.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.xzb.showcase.base.controller.BaseController;
import com.xzb.showcase.base.security.LoginContextHolder;
import com.xzb.showcase.base.util.CopyPropertiesUtil;
import com.xzb.showcase.risk.entity.BreakruleUserEntity;
import com.xzb.showcase.risk.service.BreakruleUserService;

@Controller
@RequestMapping(value = "/risk/breakrule")
public class BreakruleUserController extends
		BaseController<BreakruleUserEntity, BreakruleUserService> {

	@Override
	public String index(Model model) {
		return "risk/breakrule/breakrule_user_index";
	}

	/**
	 * 跳转到违规单新增页面
	 * 
	 * @param request
	 * @param model
	 * 
	 */
	@RequestMapping(value = "/toAddPage")
	public String toAddPage(HttpServletRequest request, Model model) {
		return "risk/breakrule/breakrule_user_add";
	}
	
	/**
	 * 添加 违规检查单
	 * 
	 * @param t
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author LauLimXiao
	 */
	@Override
	public Map<String, Object> save(BreakruleUserEntity t,
			Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		if (t.getId() != null) {
			BreakruleUserEntity temp = service.findOne(t.getId());
			CopyPropertiesUtil.copyPropertiesIgnoreNull(t, temp);
			temp.setGmtModified(new Date());
			temp.setLastModifiedById(LoginContextHolder.get().getUserId());
			t = temp;
			service.save(t);
		} else {
			t.setGmtCreate(new Date());
			t.setCreateById(LoginContextHolder.get().getUserId());
			t.setUuid(UUID.randomUUID().toString());
			service.save(t);
		}

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", true);
		result.put("msg", "保存成功！");
		return result;
	}

}
