package com.xzb.showcase.system.controller;

import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.xzb.showcase.base.controller.BaseController;
import com.xzb.showcase.base.security.AccessRequired;
import com.xzb.showcase.base.security.LoginContextHolder;
import com.xzb.showcase.base.util.Constants;
import com.xzb.showcase.base.util.CopyPropertiesUtil;
import com.xzb.showcase.base.util.FileUtil;
import com.xzb.showcase.base.util.Servlets;
import com.xzb.showcase.system.dto.ResourcesDto;
import com.xzb.showcase.system.entity.ResourcesEntity;
import com.xzb.showcase.system.service.ResourcesService;
import com.xzb.showcase.upload.entity.UploadEntity;
import com.xzb.showcase.upload.service.UploadService;

/**
 * 系统资源
 * 
 * @author xunxun
 * @date 2014-11-15 下午2:45:18
 */
@Controller
@RequestMapping(value = "/system/resources")
@AccessRequired("资源管理")
public class ResourcesController extends
		BaseController<ResourcesEntity, ResourcesService> {
	@Autowired
	private UploadService uploadService;

	@Override
	public String index(Model model) {
		return "system/resources/resources_index";
	}
	/**
	 * 供应商资源维护
	 */
	@RequestMapping(value = "/supplier")
	public String supplier(Model model) {
		return "system/resources/supplier_resources_index";
	}
	
	@Override
	public Map<String, Object> save(@ModelAttribute("T") ResourcesEntity t, Model model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		if (t.getId() != null) {
			ResourcesEntity temp = service.findOne(t.getId());
			CopyPropertiesUtil.copyPropertiesIgnoreNull(t, temp);
			temp.setGmtModified(new Date());
			temp.setLastModifiedById(LoginContextHolder.get().getUserId());
			t = temp;
		} else {
			t.setGmtCreate(new Date());
			t.setCreateById(LoginContextHolder.get().getUserId());
		}
		// 验证实体类
		Set<ConstraintViolation<ResourcesEntity>> constraintViolations = validator
				.getValidator().validate(t);
		// 如果大于0，说明有验证未通过信息
		if (constraintViolations.size() > 0) {
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("success", false);
			result.put("msg", constraintViolations.iterator().next()
					.getMessage());
			return result;
		}

		Map<String, Object> result = service.saveMap(t);
		return result;
	}


	/**
	 * 查询treegrid,用于显示树
	 * 
	 * @return
	 * @author xunxun
	 * @date 2014-11-19 下午3:02:15
	 */
	@RequestMapping(value = "/treegrid")
	@ResponseBody
	public List<ResourcesEntity> treegrid(HttpServletRequest request,
			Model model) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		searchParams.put("EQ_deleteFlag", Constants.DELETE_FLAG_FALSE);
		String strParentId = request.getParameter("id");
		if (StringUtils.isNotBlank(strParentId)) {
			Long parentId = Long.valueOf(strParentId);
			searchParams.put("EQ_parentId", parentId);
		}
		return service.findByParams(searchParams);
	}

	/**
	 * 普通的资源树
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/ntreegrid")
	@ResponseBody
	public List<ResourcesDto> ntreegrid(HttpServletRequest request, Model model) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		searchParams.put("EQ_deleteFlag", Constants.DELETE_FLAG_FALSE);
		List<ResourcesEntity> resources = service.findByParams(searchParams);
		List<ResourcesDto> result = new ArrayList<ResourcesDto>();
		for (ResourcesEntity resourcesEntity : resources) {
			ResourcesDto dto = new ResourcesDto(resourcesEntity);
			initChilds(dto);
			result.add(dto);
		}
		return result;
	}

	/**
	 * 加载子级资源
	 * 
	 * @param parent
	 */
	private void initChilds(ResourcesDto parent) {
		Map<String, Object> searchParams = new HashMap<String, Object>();
		if (parent != null) {
			searchParams.put("EQ_parentId", parent.getId());
			List<ResourcesEntity> childs = service.findByParams(searchParams);
			List<ResourcesDto> dtos = new ArrayList<ResourcesDto>();
			if (childs != null && childs.size() > 0) {
				for (ResourcesEntity resource : childs) {
					ResourcesDto dto = new ResourcesDto(resource);
					initChilds(dto);
					dtos.add(dto);
				}
				parent.setChildren(dtos);
			}
		}
	}

	/**
	 * 查询combotree，用于树形选择
	 * 
	 * @return
	 * @author xunxun
	 * @date 2014-11-19 下午3:02:15
	 */
	@RequestMapping(value = "/combotree")
	@ResponseBody
	public List<ResourcesEntity> combotree(HttpServletRequest request,
			Model model) {
		List<ResourcesEntity> list = new ArrayList<ResourcesEntity>();
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		searchParams.put("EQ_deleteFlag", Constants.DELETE_FLAG_FALSE);
		String strParentId = request.getParameter("id");
		if (StringUtils.isNotBlank(strParentId)) {
			Long parentId = Long.valueOf(strParentId);
			if (parentId != 0) {
				searchParams.put("EQ_parentId", parentId);
			} else {
				return list;
			}
		} else {
			ResourcesEntity resource = new ResourcesEntity();
			resource.setId(Constants.ZERO);
			resource.setName("无");
			list.add(resource);
		}
		list.addAll(service.findByParams(searchParams));
		return list;
	}

	/**
	 * 逻辑删除
	 * 
	 * @param id
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author xunxun
	 * @date 2015-1-15 上午11:52:31
	 */
	// @Override
	// public Map<String, Object> delete(@RequestParam("ids") long id, Model
	// model,
	// HttpServletRequest request, HttpServletResponse response)
	// throws Exception {
	// Date date=new Date();
	// ResourcesEntity resources = service.findOne(id);
	// delete(resources, date);
	// return super.save(resources, model, request, response);
	// }

	/**
	 * 逻辑删除 递归赋值
	 * 
	 * @param resources
	 * @param date
	 * @author xunxun
	 * @date 2015-1-15 下午2:49:24
	 */
	private void delete(ResourcesEntity resources, Date date) {
		resources.setDeleteFlag(Constants.DELETE_FLAG_TRUE);
		resources.setGmtModified(date);
		resources.setLastModifiedById(LoginContextHolder.get().getUserId());
		/*
		 * Set<ResourcesEntity> reSet = resources.getChildren(); if (reSet !=
		 * null && reSet.size() > 0) { for (ResourcesEntity res : reSet) {
		 * delete(res, date); } }
		 */
	}

	@RequestMapping(value = "/upload")
	@ResponseBody
	public Map<String, Object> upload(@RequestParam("file") MultipartFile file,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		/*
		 * System.out.println(request.getParameter("name") + "-" +
		 * request.getParameter("lastModified"));
		 */
		String fileName = request.getParameter("name");
		String strLastModified = request.getParameter("lastModified");
		long lm = Long.parseLong(strLastModified);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", false);
		try {
			if (!file.isEmpty()) {
				List<Object> list = FileUtil.getNewFile(fileName, "test",
						request);
				File tmpFile = (File) list.get(0);
				RandomAccessFile oSavedFile = null;
				try {
					// 判断文件是否存在-->>
					String filePath = "";
					Map<String, Object> searchParams = new HashMap<String, Object>();
					searchParams.put("EQ_lastModified", new Date(lm));
					searchParams.put("EQ_fileName", fileName);
					searchParams.put("EQ_createById", LoginContextHolder.get()
							.getUserId());
					List<UploadEntity> files = uploadService
							.findByParams(searchParams);
					if (files != null && files.size() > 0) {
						filePath = files.get(0).getRealPath();
					}
					File tempFile = null;
					if (StringUtils.isNoneBlank(filePath)) {
						tempFile = new File(filePath);
					}
					// 判断文件是否存在--<<
					if (tempFile != null && tempFile.exists()) {
						byte[] s = file.getBytes();
						oSavedFile = new RandomAccessFile(tempFile, "rw");
						oSavedFile.seek(FileUtils.sizeOf(tempFile));
						oSavedFile.write(s);
					} else {
						file.transferTo(tmpFile);
						UploadEntity uploadEntity = new UploadEntity();
						uploadEntity.setFileName(fileName);
						uploadEntity.setLastModified(new Date(lm));
						uploadEntity.setRealName(tmpFile.getName());
						uploadEntity.setRealPath(tmpFile.toString());
						uploadEntity.setCreateById(LoginContextHolder.get()
								.getUserId());
						uploadService.save(uploadEntity);
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					if (oSavedFile != null)
						try {
							oSavedFile.close();
						} catch (IOException e) {
							e.printStackTrace();
						}
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		result.put("success", true);
		return result;
	}

	@RequestMapping(value = "/uploadedSize")
	@ResponseBody
	public Map<String, Object> uploadedSize(String fileName,
			String strLastModified, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		long lm = Long.parseLong(strLastModified);
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> searchParams = new HashMap<String, Object>();
		searchParams.put("EQ_lastModified", new Date(lm));
		searchParams.put("EQ_fileName", fileName);
		searchParams.put("EQ_createById", LoginContextHolder.get().getUserId());
		List<UploadEntity> files = uploadService.findByParams(searchParams);
		String filePath = "";
		if (files != null && files.size() > 0) {
			filePath = files.get(0).getRealPath();
		}
		File tempFile = null;
		if (StringUtils.isNoneBlank(filePath)) {
			tempFile = new File(filePath);
		}
		Long size = 0L;
		if (tempFile != null && tempFile.exists()) {
			size = FileUtils.sizeOf(tempFile);
		}
		result.put("uploadedSize", size);
		return result;
	}
}
