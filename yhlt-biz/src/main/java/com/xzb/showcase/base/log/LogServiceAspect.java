package com.xzb.showcase.base.log;

import java.lang.reflect.Method;

import javax.validation.ConstraintViolationException;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.xzb.showcase.base.entity.IdEntity;
import com.xzb.showcase.base.modules.JsonMapper;
import com.xzb.showcase.base.security.LoginContext;
import com.xzb.showcase.base.security.LoginContextHolder;
import com.xzb.showcase.base.util.Env;
import com.xzb.showcase.system.entity.SystemLog;
import com.xzb.showcase.system.service.SystemLogService;

/**
 * 业务日志切面
 * 
 * @author wj
 * @date 2014-11-18 18:17:37
 * 
 */
@Component
public class LogServiceAspect {
	// 日志result最大长度
	private static final int REUSLT_MAX_LENGTH = 4000;

	private Logger logger = Logger.getLogger(LogServiceAspect.class);

	@Autowired
	private SystemLogService systemLogService;
	/**
	 * DEBUG模式下，所有操作都记录数据库<br>
	 * 非DEBUG模式，只有带@BusinessLog的类和方法
	 */
	private boolean debug = false;

	public LogServiceAspect() {
		debug = Boolean.parseBoolean(Env.getProperty(Env.DEBUG));
	}

	@SuppressWarnings("unchecked")
	public Object logAround(ProceedingJoinPoint joinPoint) throws Throwable {
		// 日志内容
		StringBuffer content = new StringBuffer();
		SystemLog proLog = new SystemLog();
		// 登陆用户
		LoginContext user = LoginContextHolder.get();
		// 记录登陆用户信息
		writeLoginUserLog(user, content);
		// 需要记录日志
		Boolean needLog = false;
		// 日志增加业务调用类
		needLog = createServiceClassLog(joinPoint, content, needLog, proLog);
		// 日志增加业务调用方法
		needLog = createServiceMethodLog(joinPoint, content, needLog, proLog);

		// 日志增加业务方法参数内容
		// 参数部分
		StringBuffer argument = new StringBuffer();
		// 业务主键
		StringBuffer entityKey = new StringBuffer();
		argument.append("ARGUMENT{");
		for (int i = 0; i < joinPoint.getArgs().length; i++) {
			Object obj = joinPoint.getArgs()[i];
			if (obj instanceof IdEntity) {
				IdEntity<Long> entity = (IdEntity<Long>) obj;
				entityKey.append(entity.getId()).append(",");
				argument.append(JsonMapper.nonEmptyMapper().toJson(obj));
			} else {
				argument.append("[").append(joinPoint.getArgs()[i]).append("]");
			}
		}
		argument.append("}");

		content.append(content);
		logger.info(content);

		Object obj = null;
		try {
			// 具体业务方法执行
			obj = joinPoint.proceed();
		} catch (ConstraintViolationException e) {
			logger.error("业务操作失败", e);
			return obj;
		}

		// 返回结果如果是实体类，不需要输出太多内容
		String result = JsonMapper.nonEmptyMapper().toJson(obj);
		result = result.length() > REUSLT_MAX_LENGTH ? result.substring(0,
				REUSLT_MAX_LENGTH) : result;
		logger.info("RESULT{" + result + "}");

		if (debug || needLog) {
			try {
				proLog.setEntityId(entityKey.toString());
				String argumentTemp = argument.length() > REUSLT_MAX_LENGTH ? argument
						.substring(0, REUSLT_MAX_LENGTH) : argument.toString();
				proLog.setContent(argumentTemp);
				proLog.setResult(result);
				proLog.setCreateById(LoginContextHolder.get().getUserId());
				systemLogService.log(proLog);
			} catch (Exception e) {
				e.printStackTrace();
				logger.error("增加日志错误", e);
			}
		}
		return obj;
	}

	private Boolean createServiceMethodLog(ProceedingJoinPoint joinPoint,
			StringBuffer content, Boolean needLog, SystemLog proLog) {
		/*
		 * 方法注解
		 */

		// 方法名，如果没有注解则默认使用方法名
		String operation = joinPoint.getSignature().getName();
		// 拦截的放参数类型
		Method method = ((MethodSignature) joinPoint.getSignature())
				.getMethod();

		// 获取到这个方法上面的方法上面的注释
		BusinessLog methodlogAnnotation = (BusinessLog) method
				.getAnnotation(BusinessLog.class);

		// 判断CLASS@BusinessLog注解
		if (methodlogAnnotation != null
				&& StringUtils.isNotBlank(methodlogAnnotation.operation())) {
			operation = methodlogAnnotation.operation();
			proLog.setOperation(operation);
			needLog = needLog && true;
		}
		// 方法名
		content.append("METHOD{").append(operation).append("}");
		return needLog;
	}

	private Boolean createServiceClassLog(ProceedingJoinPoint joinPoint,
			StringBuffer content, Boolean needLog, SystemLog proLog) {
		/*
		 * 类注解
		 */
		BusinessLog classlogAnnotation = (BusinessLog) joinPoint.getTarget()
				.getClass().getAnnotation(BusinessLog.class);
		// 类名，如果没有注解则默认使用类名
		String serviceClassName = joinPoint.getTarget().getClass().getName();
		proLog.setClassName(serviceClassName);
		// 判断CLASS@BusinessLog注解
		if (classlogAnnotation != null
				&& StringUtils.isNotBlank(classlogAnnotation.service())) {
			serviceClassName = classlogAnnotation.service();
			proLog.setService(serviceClassName);
			needLog = true;
		}
		content.append("CLASS{").append(serviceClassName).append("}");
		return needLog;
	}

	private void writeLoginUserLog(LoginContext user, StringBuffer content) {
		if (user != null) {
			content.append("USER{")
					.append(JsonMapper.nonEmptyMapper().toJson(user))
					.append("}");
		}
	}

}