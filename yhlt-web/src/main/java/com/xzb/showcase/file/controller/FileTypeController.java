package com.xzb.showcase.file.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

import com.xzb.showcase.base.controller.BaseController;
import com.xzb.showcase.base.security.AccessRequired;
import com.xzb.showcase.base.security.LoginContextHolder;
import com.xzb.showcase.base.util.CopyPropertiesUtil;
import com.xzb.showcase.base.util.Servlets;
import com.xzb.showcase.file.entity.FileTypeEntity;
import com.xzb.showcase.file.service.FileTypeService;

@Controller
@RequestMapping(value = "/file/fileType")
public class FileTypeController extends
		BaseController<FileTypeEntity, FileTypeService> {

	@Override
	public String index(Model model) {
		return "file/file_type_index";
	}

	/**
	 * 添加 文件类型
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
	public Map<String, Object> save(FileTypeEntity t, Model model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		if (t.getId() != null) {
			FileTypeEntity temp = service.findOne(t.getId());
			CopyPropertiesUtil.copyPropertiesIgnoreNull(t, temp);
			temp.setGmtModified(new Date());
			temp.setLastModifiedById(LoginContextHolder.get().getUserId());
			t = temp;
			service.save(t);
		} else {
			t.setGmtCreate(new Date());
			t.setCreateById(LoginContextHolder.get().getUserId());
			t.setSortNumber(service.findFileTypeSortNumberMax() + 1);
			t.setUuid(UUID.randomUUID().toString());
			service.save(t);
		}

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", true);
		return result;
	}

	/**
	 * 查询treegrid，用于文件类型展示
	 * 
	 * @return
	 * @author LauLImxiao
	 */
	@RequestMapping(value = "/treegrid")
	@ResponseBody
	public List<FileTypeEntity> treegrid(
			@RequestParam(value = "sort", defaultValue = "sortNumber", required = false) String sort,
			@RequestParam(value = "order", defaultValue = "asc", required = false) String order,
			HttpServletRequest request, Model model) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_", true);
		Order o = new Order("desc".equals(order) ? Direction.DESC
				: Direction.ASC, sort);
		// 递归循环子集记录
		List<FileTypeEntity> result = new ArrayList<FileTypeEntity>();
		result = service.findByParams(searchParams, new Sort(o));
		return result;
	}

	/**
	 * 文件类型列排序
	 * 
	 * @param sortType
	 *            0-升，1-降
	 * @param userId
	 * @param request
	 * @param model
	 * @return
	 */
	@AccessRequired("管理员")
	@RequestMapping(value = "/fileTypeSort")
	@ResponseBody
	public Map<String, Object> userSort(@RequestParam int sortType,
			@RequestParam long fileTypeId, HttpServletRequest request,
			Model model) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			FileTypeEntity entity = service.findOne(fileTypeId);
			int currentSortNumber = entity.getSortNumber();

			Page<FileTypeEntity> fileTypeEntityList = null;
			// 升
			if (sortType == 0) {
				Map<String, Object> searchParams = new HashMap<String, Object>();
				searchParams.put("LT_sortNumber", currentSortNumber);
				fileTypeEntityList = service.findByParams(searchParams,
						new PageRequest(0, 1, new Sort(new Order(
								Direction.DESC, "sortNumber"))));
			} else {
				// 降
				Map<String, Object> searchParams = new HashMap<String, Object>();
				searchParams.put("GT_sortNumber", currentSortNumber);
				fileTypeEntityList = service.findByParams(searchParams,
						new PageRequest(0, 1, new Sort(new Order(Direction.ASC,
								"sortNumber"))));
			}
			if (fileTypeEntityList != null && fileTypeEntityList.getSize() > 0) {
				FileTypeEntity entityTemp = fileTypeEntityList.getContent()
						.get(0);
				entity.setSortNumber(entityTemp.getSortNumber());
				entityTemp.setSortNumber(currentSortNumber);
				service.save(entity);
				service.save(entityTemp);
			}
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
		}
		return result;
	}

	/**
	 * 查询类型树
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @author LauLimXiao
	 */
	@RequestMapping(value = "/combotree")
	@ResponseBody
	public List<FileTypeEntity> tree(HttpServletRequest request, Model model) {
		List<FileTypeEntity> list = new ArrayList<FileTypeEntity>();
		FileTypeEntity resource = new FileTypeEntity();
		resource.setId(0L);
		resource.setName("无父节点");
		list.add(resource);
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_", true);
		list.addAll(service.findByParams(searchParams));
		return list;
	}

}
