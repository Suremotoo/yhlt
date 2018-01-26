package com.xzb.showcase.system.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xzb.showcase.base.controller.BaseController;
import com.xzb.showcase.base.security.LoginContextHolder;
import com.xzb.showcase.base.util.Constants;
import com.xzb.showcase.base.util.CopyPropertiesUtil;
import com.xzb.showcase.base.util.Servlets;
import com.xzb.showcase.system.entity.QualificationEntity;
import com.xzb.showcase.system.service.QualificationService;

/**
 * 资质证书管理
 * 
 * @author LauLimXiao
 * 
 */
@Controller
@RequestMapping(value = "/system/qualification")
public class QualificationController extends
		BaseController<QualificationEntity, QualificationService> {

	@Autowired
	private QualificationService qualificationService;

	@Override
	public String index(Model model) {
		return "system/qualification/qualification_index_best";
	}

	/**
	 * 根据资质证书名称判断证书是否重复
	 * 
	 * @param qualificationName
	 * @param request
	 * @param model
	 * @return
	 * @author LauLimXiao
	 */
	@RequestMapping(value = "/check")
	@ResponseBody
	public Map<String, Object> check(
			@RequestParam("qualificationName") String qualificationName,
			HttpServletRequest request, Model model) {
		Map<String, Object> searchParams = new HashMap<String, Object>();
		searchParams.put("EQ_name", qualificationName);
		List<QualificationEntity> entities = service.findByParams(searchParams);

		Map<String, Object> result = new HashMap<String, Object>();
		// flag=true 没有注册，false已被注册
		boolean flag = entities == null || entities.size() == 0;
		result.put("success", flag);
		result.put("msg", flag ? "" : "该标识已被注册");
		return result;
	}

	/**
	 * 查询combotree，用于树形选择
	 * 
	 * @return
	 * @author LauLimXiao
	 */
	@RequestMapping(value = "/combotree")
	@ResponseBody
	public List<QualificationEntity> combotree(HttpServletRequest request,
			Model model) {
		List<QualificationEntity> list = new ArrayList<QualificationEntity>();
		QualificationEntity resource = new QualificationEntity();
		resource.setId(0L);
		resource.setName("无父节点");
		list.add(resource);
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_", true);
		list.addAll(service.findByParams(searchParams));
		return list;
	}

	/**
	 * 查询treegrid，用于资质证书展示
	 * 
	 * @return
	 * @author LauLimXiao
	 */
	@RequestMapping(value = "/treegrid")
	@ResponseBody
	public List<QualificationEntity> treegrid(
			@RequestParam(value = "qualificationId", required = false) Long qualificationId,
			@RequestParam(value = "order", defaultValue = "asc", required = false) String order,
			HttpServletRequest request, Model model) {
		Long theId = null;
		if (qualificationId != null && !"".equals(qualificationId))
			theId = Long.valueOf(qualificationId.toString());
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_", true);
		// 递归循环子集记录
		List<QualificationEntity> result = new ArrayList<QualificationEntity>();
		if (theId == null || theId == Constants.ZERO)
			result = service.findByParams(searchParams);
		else {
			Map<String, Object> searchParams2 = new HashMap<String, Object>();
			searchParams2.put("EQ_id", theId);
			QualificationEntity newsTypeEntity = qualificationService
					.findOneByParams(searchParams2);
			Set<Long> ids = new HashSet<Long>();
			fillChildIds(newsTypeEntity, ids);
			searchParams.put("IN_companyEntity.id", ids);
			result = service.findByParams(searchParams);
		}
		return result;
	}

	/**
	 * 查找证书的子证书
	 * 
	 * @param entity
	 * @param ids
	 * @author LauLimXiao
	 */
	private void fillChildIds(QualificationEntity entity, Set<Long> ids) {
		ids.add(entity.getId());
		if (entity.getChildren().size() > 0) {
			for (QualificationEntity children : entity.getChildren()) {
				ids.add(children.getId());
				fillChildIds(children, ids);
			}
		}
	}

	/**
	 * 查询资质证书有没有下级
	 * 
	 * @param id
	 *            parentId
	 * @param request
	 * @param model
	 * @return
	 * @author LauLimXiao
	 */
	@RequestMapping(value = "/checkNext")
	@ResponseBody
	public Map<String, Object> checkChild(@RequestParam("id") String id,
			HttpServletRequest request, Model model) {
		Map<String, Object> searchParams = new HashMap<String, Object>();
		searchParams.put("EQ_parentId", id);
		List<QualificationEntity> entities = service.findByParams(searchParams);

		Map<String, Object> result = new HashMap<String, Object>();
		// flag=true 没有子级证书，false有子级证书
		boolean flag = entities == null || entities.size() == 0;
		result.put("success", flag);
		return result;
	}

	/**
	 * 保存更新方法<br>
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
	public Map<String, Object> save(QualificationEntity t, Model model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		if (t.getId() != null) {
			QualificationEntity temp = service.findOne(t.getId());
			CopyPropertiesUtil.copyPropertiesIgnoreNull(t, temp);
			temp.setGmtModified(new Date());
			temp.setLastModifiedById(LoginContextHolder.get().getUserId());
			t = temp;
			service.save(t);
		} else {
			// 父节点为空证明是添加父级资质证书,不为空是添加子级证书
			if (t.getParentId() == null) {
				t.setParentId(0);
			}
			t.setGmtCreate(new Date());
			t.setCreateById(LoginContextHolder.get().getUserId());
			service.save(t);
		}

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", true);
		return result;
	}

}
