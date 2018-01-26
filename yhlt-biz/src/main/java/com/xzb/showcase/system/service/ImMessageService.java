package com.xzb.showcase.system.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import com.google.common.collect.Lists;
import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.modules.Collections3;
import com.xzb.showcase.base.modules.SearchFilter;
import com.xzb.showcase.base.modules.SearchFilter.Operator;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.system.dao.ImMessageDao;
import com.xzb.showcase.system.entity.ImMessageEntity;

@Component
@Transactional
@BusinessLog(service = "WebIm消息管理")
@DataPermission
public class ImMessageService extends
		BaseService<ImMessageEntity, ImMessageDao> {

	public List<ImMessageEntity> findUnReadMessages(Long receiveId) {
		Map<String, Object> searchParams = new HashMap<String, Object>();
		searchParams.put("EQ_receiveId", receiveId);
		searchParams.put("EQ_status", 1);
		return findByParams(searchParams);
	}

	public void setMessageReaded(Long currentUserId) {
		dao.setMessageReaded(currentUserId);
	}

	// 查看聊天记录
	public int findImMessageRecordsSize(Long userId, Long receiveId) {
		List<SearchFilter> filterList = new ArrayList<SearchFilter>();
		filterList.add(new SearchFilter("sendId", Operator.valueOf("EQ"),
				userId));
		filterList.add(new SearchFilter("receiveId", Operator.valueOf("EQ"),
				receiveId));
		filterList.add(new SearchFilter("sendId", Operator.valueOf("EQ"),
				receiveId));
		filterList.add(new SearchFilter("receiveId", Operator.valueOf("EQ"),
				userId));
		Specification<ImMessageEntity> spec = ImMessageService.bySearchFilter(
				filterList, ImMessageEntity.class);
		List<ImMessageEntity> list = dao.findAll(spec);
		return list.size();
	}
	
	public Page<ImMessageEntity> findImMessageRecords(int pageNo, int pageSize,
			Long userId, Long receiveId) {
		PageRequest pageRequest = new PageRequest(pageNo, pageSize, new Sort(
				Direction.DESC, "id"));
		List<SearchFilter> filterList = new ArrayList<SearchFilter>();
		filterList.add(new SearchFilter("sendId", Operator.valueOf("EQ"),
				userId));
		filterList.add(new SearchFilter("receiveId", Operator.valueOf("EQ"),
				receiveId));
		filterList.add(new SearchFilter("sendId", Operator.valueOf("EQ"),
				receiveId));
		filterList.add(new SearchFilter("receiveId", Operator.valueOf("EQ"),
				userId));
		Specification<ImMessageEntity> spec = ImMessageService.bySearchFilter(
				filterList, ImMessageEntity.class);
		Page<ImMessageEntity> list = dao.findAll(spec, pageRequest);
		return list;
	}

	public static <T> Specification<T> bySearchFilter(
			final Collection<SearchFilter> filters, final Class<T> entityClazz) {
		return new Specification<T>() {
			@SuppressWarnings({ "rawtypes" })
			public Predicate toPredicate(Root<T> root, CriteriaQuery<?> query,
					CriteriaBuilder builder) {
				if (Collections3.isNotEmpty(filters)) {
					List<Predicate> predicates = Lists.newArrayList();
					for (SearchFilter filter : filters) {
						String[] names = StringUtils.split(filter.fieldName,
								".");
						Path expression = root.get(names[0]);
						for (int i = 1; i < names.length; i++) {
							expression = expression.get(names[i]);
						}
						predicates.add(builder.equal(expression, filter.value));
					}
					if (!predicates.isEmpty()) {
						Predicate predicateFirst = builder.and(
								predicates.get(0), predicates.get(1));
						Predicate predicateSecond = builder.and(
								predicates.get(2), predicates.get(3));
						return builder.or(predicateFirst, predicateSecond);
					}
				}
				return builder.conjunction();
			}
		};
	}
}
