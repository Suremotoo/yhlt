package com.xzb.showcase.datapermission.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.xzb.showcase.base.controller.BaseController;
import com.xzb.showcase.base.modules.Collections3;
import com.xzb.showcase.base.security.AccessRequired;
import com.xzb.showcase.datapermission.entity.DataPermissionRuleDetailEntity;
import com.xzb.showcase.datapermission.service.DataPermissionRuleDetailService;

/**
 * 数据规则引擎-规则管理controller
 * 
 * @author admin
 * 
 */
@Controller
@RequestMapping(value = "/datapermissionRuleDetail")
@AccessRequired("数据规则引擎-规则管理")
public class DataPermissionRuleDetailController
		extends
		BaseController<DataPermissionRuleDetailEntity, DataPermissionRuleDetailService> {

	@Override
	public Map<String, Object> save(DataPermissionRuleDetailEntity t,
			Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		if (t.getType().equals("checkbox")) {
			JSONArray array = JSONArray.fromObject(t.getValue());
			List<String> ids = new ArrayList<String>();
			List<String> names = new ArrayList<String>();
			for (int i = 0; i < array.size(); i++) {
				JSONObject jsonObject = (JSONObject) array.get(i);
				ids.add(jsonObject.getString("id"));
				names.add(jsonObject.getString("name"));
			}
			t.setValue(Collections3.convertToString(ids, ","));
			t.setName(Collections3.convertToString(names, ","));
		}
		return super.save(t, model, request, response);
	}

	@Override
	public String index(Model model) {
		return "/datapermission/datapermissionRule_index";
	}

}
