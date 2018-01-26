package com.xzb.showcase.system.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xzb.showcase.base.controller.BaseController;
import com.xzb.showcase.base.util.Servlets;
import com.xzb.showcase.schedule.entity.ScheduleEntity;
import com.xzb.showcase.schedule.service.ScheduleService;

/**
 * 日程管理
 * 
 * @author lls
 * 
 */
@Controller
@RequestMapping(value = "/schedule")
public class ScheduleController extends
		BaseController<ScheduleEntity, ScheduleService> {

	@Override
	public String index(Model model) {
		return "/schedule/schedule_index";
	}

	/**
	 * 所有日程 order by start and end
	 */
	@Override
	public Map<String, Object> list(
			@RequestParam(value = "page", defaultValue = "1") Integer pageNum,
			@RequestParam(value = "rows", defaultValue = "10") Integer pageRows,
			@RequestParam(value = "sort", defaultValue = "id") String sort,
			@RequestParam(value = "order", defaultValue = "desc") String order,
			HttpServletRequest request, Model model) throws Exception {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_", true);
		Map<String, Object> result = service.findByParamsMap(searchParams,
				new PageRequest(pageNum - 1, pageRows, new Sort(Direction.DESC,
						"start", "end")));
		return result;
	}

	/**
	 * 当前日程表日程 中文日历跨度为3个月（上月尾，本月，下月初）
	 * 
	 * @param leftYear
	 * @param leftMonth
	 * @param leftDay
	 * @param rightYear
	 * @param rightMonth
	 * @param rightDay
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/listSchedule")
	@ResponseBody
	public List<ScheduleEntity> listSchedule(
			@RequestParam(value = "leftYear") Integer leftYear,
			@RequestParam(value = "leftMonth") Integer leftMonth,
			@RequestParam(value = "leftDay") Integer leftDay,
			@RequestParam(value = "rightYear") Integer rightYear,
			@RequestParam(value = "rightMonth") Integer rightMonth,
			@RequestParam(value = "rightDay") Integer rightDay,
			HttpServletRequest request, Model model) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		String leftCondition = leftYear + "-" + leftMonth + "-" + leftDay
				+ " 00:00:00";
		String rightCondition = rightYear + "-" + rightMonth + "-" + rightDay
				+ " 00:00:00";
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			Date leftDate = df.parse(leftCondition);
			Date rightDate = df.parse(rightCondition);
			searchParams.put("GT_start", leftDate);
			searchParams.put("LT_start", rightDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return service.findByParams(searchParams, new Sort(Direction.DESC,
				"start", "end"));
	}

}
