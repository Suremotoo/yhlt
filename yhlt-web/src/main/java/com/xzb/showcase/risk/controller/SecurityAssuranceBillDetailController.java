package com.xzb.showcase.risk.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.xzb.showcase.base.controller.BaseController;
import com.xzb.showcase.risk.entity.SecurityAssuranceBillDetailEntity;
import com.xzb.showcase.risk.entity.SecurityAssuranceBillEntity;
import com.xzb.showcase.risk.service.SecurityAssuranceBillDetailService;
import com.xzb.showcase.risk.service.SecurityAssuranceBillService;

/**
 * 安保专项检查单详情
 * 
 * @author LauLimXiao
 * 
 */
@Controller
@RequestMapping(value = "/risk/securityAssurance/billDetail")
public class SecurityAssuranceBillDetailController
		extends
		BaseController<SecurityAssuranceBillDetailEntity, SecurityAssuranceBillDetailService> {

	@Autowired
	private SecurityAssuranceBillService securityAssuranceBillService;

	@Override
	public String index(Model model) {
		return "risk/securityAssurance/security_assurance_bill_detail_index";
	}

	@RequestMapping(value = "/findBillDetail")
	public String findBillDetail(
			@RequestParam("securityBillId") String securityBillId,
			HttpServletRequest request, Model model) {
		Map<String, Object> searchParams = new HashMap<String, Object>();
		SecurityAssuranceBillEntity bill = securityAssuranceBillService
				.findOne(Long.parseLong(securityBillId));
		searchParams.put("EQ_billId", Long.parseLong(securityBillId));
		List<SecurityAssuranceBillDetailEntity> allBills = service
				.findByParams(searchParams);
		request.setAttribute("allBills", allBills);
		request.setAttribute("bill", bill);
		return "risk/securityAssurance/security_assurance_bill_detail_index";
	}

}
