package com.xzb.showcase.base.datapermission;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;

import com.xzb.showcase.base.modules.DynamicSpecifications;
import com.xzb.showcase.base.modules.SearchFilter;
import com.xzb.showcase.base.modules.SearchFilter.Operator;
import com.xzb.showcase.base.security.LoginContext;
import com.xzb.showcase.base.security.LoginContextHolder;
import com.xzb.showcase.base.util.Env;
import com.xzb.showcase.datapermission.dao.DataPermissionRuleDetailUserDao;
import com.xzb.showcase.datapermission.entity.DataPermissionRuleDetailUserEntity;
import com.xzb.showcase.system.dao.UserDao;
import com.xzb.showcase.system.entity.RoleUserEntity;
import com.xzb.showcase.system.entity.UserEntity;

/**
 * 数据引擎规则切面
 * 
 * @author wj
 * @date 2014-11-18 18:17:37
 * 
 */
@Component
public class DataPermissionServiceAspect {
	public static final int IS_ALL = 1;

	private Logger logger = Logger.getLogger(DataPermissionServiceAspect.class);

	@Autowired
	private UserDao userInfoDao;

	@Autowired
	private DataPermissionRuleDetailUserDao ruleDetailUserDao;

	private boolean debug = false;

	private static Pattern numberPattern = Pattern.compile("^[0-9]*$");

	public DataPermissionServiceAspect() {
		debug = Boolean.parseBoolean(Env.getProperty(Env.DEBUG));
	}

	public void dataPermission(JoinPoint joinPoint) throws Throwable {
		logger.info("数据规则引擎");

		// 类名，如果没有注解则默认使用类名
		String serviceClassName = joinPoint.getTarget().getClass().getName();
		serviceClassName = serviceClassName.substring(serviceClassName
				.lastIndexOf(".") + 1);
		DataPermission classAnnotation = (DataPermission) joinPoint.getTarget()
				.getClass().getAnnotation(DataPermission.class);

		// 方法名，如果没有注解则默认使用方法名
		String operation = joinPoint.getSignature().getName();
		// 拦截的放参数类型
		Method method = ((MethodSignature) joinPoint.getSignature())
				.getMethod();
		// 获取到这个方法上面的方法上面的注释
		DataPermission methodAnnotation = (DataPermission) method
				.getAnnotation(DataPermission.class);

		// 登陆用户
		LoginContext user = LoginContextHolder.get();
		UserEntity userEntity = null;
		// (UserEntity) LoginContextHolder.getSession()
		// .getAttribute("USER_INFO");
		if (user != null && classAnnotation != null && methodAnnotation != null) {
			if (debug) {
				logger.info("当前用户" + user.getUserId() + " 数据规则引擎拦截:"
						+ serviceClassName + "  " + operation);
			}
			// // 比对资源信息
			// ResourcesEntity temp = null;
			// for (ResourcesEntity resourcesEntity : resourcesEntities) {
			// if (StringUtils.isNotBlank(resourcesEntity.getCode())
			// && classAnnotation.code().equals(
			// resourcesEntity.getCode())) {
			// temp = resourcesEntity;
			// break;
			// }
			// }
			userEntity = userInfoDao.findOne(user.getUserId());
			if (userEntity != null) {
				// // 根据用户公司+资源ID查找规则
				Map<String, Object> searchParams = new HashMap<String, Object>();
				searchParams.put("EQ_companyId_1", userEntity
						.getCompanyEntity().getId());
				searchParams.put("EQ_departmentId_2", userEntity
						.getDepartmentEntity().getId());
				// TODO:in问题
				// List ids = new ArrayList();
				// Set<RoleUserEntity> roleUserEntities =
				// userEntity.getRoleUsers();
				// Long [] tempIds = new Long[roleUserEntities.size()];
				// int i = 0;
				// for (RoleUserEntity roleUserEntity : roleUserEntities) {
				// tempIds[i] = roleUserEntity.getRole().getId();
				// i+=1;
				// }
				// searchParams.put("IN_roleId_KEY111", 1L);
				searchParams.put("EQ_userId_3", userEntity.getId());
				searchParams.put("EQ_code", serviceClassName);
				Map<String, SearchFilter> filters = SearchFilter
						.parse(searchParams);
				Specification<DataPermissionRuleDetailUserEntity> spec = DynamicSpecifications
						.bySearchFilter(filters.values(),
								DataPermissionRuleDetailUserEntity.class);

				// 直接使用dao查询，防止service切面死循环
				List<DataPermissionRuleDetailUserEntity> ruleDetailUserEntities = ruleDetailUserDao
						.findAll(spec);
				// 根据index获取searchMap参数
				Object parameter = joinPoint.getArgs()[methodAnnotation
						.parameterIndex()];

				if (parameter instanceof Map) {
					Map<String, Object> parameterMap = (Map<String, Object>) parameter;
					for (DataPermissionRuleDetailUserEntity ruleDetailUserEntity : ruleDetailUserEntities) {
						// In查询
						if (ruleDetailUserEntity.getType().equals("checkbox")
								&& (ruleDetailUserEntity.getIsAll() != IS_ALL)) {
							analysisRule(parameterMap, ruleDetailUserEntity);
						} else
						// 条件查询
						if (ruleDetailUserEntity.getType().equals("input")) {
							analysisRule(parameterMap, ruleDetailUserEntity);
						}
					}
					if (ruleDetailUserEntities == null
							|| ruleDetailUserEntities.size() == 0) {
						// TODO:加上此句,则所有service都必须配置规则，才能显示数据
						// parameterMap.put("EQ_id", -9999L);
					}
				}
			}
		}
	}

	public void analysisRule(Map<String, Object> parameterMap,
			DataPermissionRuleDetailUserEntity ruleDetailUserEntity) {
		// 操作符和值不能为空
		if (StringUtils.isNotBlank(ruleDetailUserEntity.getOperator())
				&& StringUtils.isNotBlank(ruleDetailUserEntity
						.getPropertyName())
				&& StringUtils.isNotBlank(ruleDetailUserEntity.getValue())) {
			// 默认字符型
			Object value = ruleDetailUserEntity.getValue();
			// 如果是数字
			if (numberPattern.matcher(ruleDetailUserEntity.getValue())
					.matches()) {
				value = Long.parseLong(ruleDetailUserEntity.getValue());
			}
			if (Operator.EQ.name().equals(
					ruleDetailUserEntity.getOperator().toUpperCase())) {

			} else if (Operator.NEQ.name().equals(
					ruleDetailUserEntity.getOperator().toUpperCase())) {

			} else if (Operator.GT.name().equals(
					ruleDetailUserEntity.getOperator().toUpperCase())) {

			} else if (Operator.GTE.name().equals(
					ruleDetailUserEntity.getOperator().toUpperCase())) {

			} else if (Operator.LT.name().equals(
					ruleDetailUserEntity.getOperator().toUpperCase())) {

			} else if (Operator.LTE.name().equals(
					ruleDetailUserEntity.getOperator().toUpperCase())) {

			} else if (Operator.LIKE.name().equals(
					ruleDetailUserEntity.getOperator().toUpperCase())) {

			} else if (Operator.IN.name().equals(
					ruleDetailUserEntity.getOperator().toUpperCase())) {
				String[] valueTemp = ruleDetailUserEntity.getValue().split(",");
				List valueList = new ArrayList();
				for (String temp : valueTemp) {
					// 如果是整数
					if (numberPattern.matcher(temp).matches()) {
						valueList.add(Long.parseLong(temp));
					} else {
						// 如果是字符
						valueList.add(temp);
					}
				}
				parameterMap.put(ruleDetailUserEntity.getOperator() + "_"
						+ ruleDetailUserEntity.getPropertyName() + "_"
						+ ruleDetailUserEntity.getConditionGroup(), valueList);
				return;
			}
			parameterMap.put(ruleDetailUserEntity.getOperator() + "_"
					+ ruleDetailUserEntity.getPropertyName() + "_"
					+ ruleDetailUserEntity.getConditionGroup(), value);
		}
	}
}