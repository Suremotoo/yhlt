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
import org.springframework.web.bind.annotation.ResponseBody;

import com.xzb.showcase.base.controller.BaseController;
import com.xzb.showcase.base.security.LoginContextHolder;
import com.xzb.showcase.base.util.CopyPropertiesUtil;
import com.xzb.showcase.risk.entity.SecurityAssuranceBillEntity;
import com.xzb.showcase.risk.service.SecurityAssuranceBillService;

/**
 * 安保专项检查单
 * 
 * @author LauLimXiao
 * 
 */
@Controller
@RequestMapping(value = "/risk/securityAssurance/bill")
public class SecurityAssuranceBillController
		extends
		BaseController<SecurityAssuranceBillEntity, SecurityAssuranceBillService> {

	@Override
	public String index(Model model) {
		return "risk/securityAssurance/security_assurance_bill_index";
	}

	/**
	 * 添加 安保检查单
	 * 
	 * @param t
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author LauLimXiao
	 */
	@RequestMapping(value = "/saveBill")
	@ResponseBody
	public Map<String, Object> saveBasis(SecurityAssuranceBillEntity t,
			Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		if (t.getId() != null) {
			SecurityAssuranceBillEntity temp = service.findOne(t.getId());
			CopyPropertiesUtil.copyPropertiesIgnoreNull(t, temp);
			temp.setGmtModified(new Date());
			temp.setLastModifiedById(LoginContextHolder.get().getUserId());
			t = temp;
			service.save(t);
		} else {
			t.setGmtCreate(new Date());
			t.setUuid(UUID.randomUUID().toString());
			service.save(t);
		}

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", true);
		return result;
	}

}
