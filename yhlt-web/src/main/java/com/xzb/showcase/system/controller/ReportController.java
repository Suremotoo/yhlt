package com.xzb.showcase.system.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xzb.showcase.base.controller.BaseController;
import com.xzb.showcase.system.dto.ChartSeriesDto;
import com.xzb.showcase.system.dto.ColumnChartDto;
import com.xzb.showcase.system.dto.LineChartDto;
import com.xzb.showcase.system.dto.PieChartDataDto;
import com.xzb.showcase.system.dto.PieChartDto;
import com.xzb.showcase.system.entity.ReportEntity;
import com.xzb.showcase.system.service.ReportService;

@Controller
@RequestMapping(value = "/system/report")
public class ReportController extends
		BaseController<ReportEntity, ReportService> {

	@Override
	public String index(Model model) {
		return "system/report/report_index";
	}

	/**
	 * 报表显示
	 * 
	 * @param id
	 * @param model
	 * @return
	 * @author xunxun
	 * @data 2015-1-30 上午11:39:57
	 */
	@RequestMapping(value = "/view")
	public String view(Long id, Model model) {
		ReportEntity report = service.findOne(id);
		model.addAttribute("report", report);
		return "system/report/report_view";
	}

	/**
	 * 报表预览
	 * @param report
	 * @param model
	 * @return   
	 * @author  xunxun
	 * @date  2015-1-31 下午1:35:40
	 */
	@RequestMapping(value = "/preview")
	public String preview(@ModelAttribute("T") ReportEntity report, Model model) {
		model.addAttribute("report", report);
		return "system/report/view_index";
	}
	
	/**
	 * 柱状图报表
	 * @return   
	 * @author  xunxun
	 * @date  2015-1-31 下午2:29:49
	 */
	@RequestMapping(value = "/column")
	@ResponseBody
	public ColumnChartDto column(){
		ColumnChartDto column=new ColumnChartDto();
		column.setTitle("月平均降雨量");
		column.setSubTitle("来源：中国气象台");
		column.setCategories(new String[]{"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"});
		column.setMin(0L);
		column.setText("降雨量（毫米）");
		column.setValueSuffix("MM");
		List<ChartSeriesDto> series=new ArrayList<ChartSeriesDto>();
		ChartSeriesDto bj=new ChartSeriesDto();
		bj.setName("北京");
		bj.setData(new Double[]{49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4});
		series.add(bj);
		ChartSeriesDto sh=new ChartSeriesDto();
		sh.setName("上海");
		sh.setData(new Double[]{83.6, 78.8, 98.5, 93.4, 106.0, 84.5, 105.0, 104.3, 91.2, 83.5, 106.6, 92.3});
		series.add(sh);
		ChartSeriesDto qd=new ChartSeriesDto();
		qd.setName("青岛");
		qd.setData(new Double[]{48.9, 38.8, 39.3, 41.4, 47.0, 48.3, 59.0, 59.6, 52.4, 65.2, 59.3, 51.2});
		series.add(qd);
		ChartSeriesDto jn=new ChartSeriesDto();
		jn.setName("济南");
		jn.setData(new Double[]{42.4, 33.2, 34.5, 39.7, 52.6, 75.5, 57.4, 60.4, 47.6, 39.1, 46.8, 51.1});
		series.add(jn);
		column.setSeries(series);
		return column;
	}
	
	/**
	 * 线图报表
	 * @return   
	 * @author  xunxun
	 * @date  2015-1-31 下午2:29:49
	 */
	@RequestMapping(value = "/line")
	@ResponseBody
	public LineChartDto line(){
		LineChartDto line =new LineChartDto();
		line.setTitle("月平均气温");
		line.setSubTitle("来源：中国气象台");
		line.setCategories(new String[]{"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"});
		line.setText("温度(°C)");
		line.setValueSuffix("°C");
		List<ChartSeriesDto> series=new ArrayList<ChartSeriesDto>();
		ChartSeriesDto bj=new ChartSeriesDto();
		bj.setName("北京");
		bj.setData(new Double[]{-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5});
		series.add(bj);
		ChartSeriesDto sh=new ChartSeriesDto();
		sh.setName("上海");
		sh.setData(new Double[]{7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6});
		series.add(sh);
		ChartSeriesDto qd=new ChartSeriesDto();
		qd.setName("青岛");
		qd.setData(new Double[]{-0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0});
		series.add(qd);
		ChartSeriesDto jn=new ChartSeriesDto();
		jn.setName("济南");
		jn.setData(new Double[]{3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8});
		series.add(jn);
		line.setSeries(series);
		return line;
	}
	
	/**
	 * 饼状图报表
	 * @return   
	 * @author  xunxun
	 * @date  2015-1-31 下午2:29:49
	 */
	@RequestMapping(value = "/pie")
	@ResponseBody
	public PieChartDto pie(){
		PieChartDto pie=new PieChartDto();
		pie.setTitle("浏览器的市场份额，2010");
		pie.setSubTitle("来源：某网站");
		pie.setValueSuffix("%");
		List<ChartSeriesDto> series=new ArrayList<ChartSeriesDto>();
		ChartSeriesDto dto=new ChartSeriesDto();
		dto.setType("pie");
		dto.setName("浏览器市场占有率");
		//默认不切片
		//dto.setData(new Object[][]{{"Firefox",45.0},{"IE",26.8},{"Chrome",12.8},{"Safari",8.5},{"Opera",6.2},{"Others",0.7}});
		//默认切片
		List<PieChartDataDto> data=new ArrayList<PieChartDataDto>();
		PieChartDataDto firefox=new PieChartDataDto();
		firefox.setName("Firefox");
		firefox.setY(45.0);
		data.add(firefox);
		PieChartDataDto ie=new PieChartDataDto();
		ie.setName("IE");
		ie.setY(26.8);
		data.add(ie);
		PieChartDataDto chrome=new PieChartDataDto();
		chrome.setName("Chrome");
		chrome.setY(12.8);
		chrome.setSliced(true);
		chrome.setSelected(true);
		data.add(chrome);
		PieChartDataDto safari=new PieChartDataDto();
		safari.setName("Safari");
		safari.setY(8.5);
		data.add(safari);
		PieChartDataDto opera=new PieChartDataDto();
		opera.setName("Opera");
		opera.setY(6.2);
		data.add(opera);
		PieChartDataDto others=new PieChartDataDto();
		others.setName("Others");
		others.setY(0.7);
		data.add(others);
		dto.setData(data);
		series.add(dto);
		pie.setSeries(series);
		return pie;
	}
	
}
