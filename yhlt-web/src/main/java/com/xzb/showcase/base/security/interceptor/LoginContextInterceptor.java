package com.xzb.showcase.base.security.interceptor;

import java.io.IOException;
import java.lang.reflect.Method;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.xzb.showcase.base.security.AccessRequired;
import com.xzb.showcase.base.security.LoginContext;
import com.xzb.showcase.base.security.LoginContextHolder;
import com.xzb.showcase.base.security.SessionSecurityConstants;
import com.xzb.showcase.base.util.Constants;
import com.xzb.showcase.base.util.Env;
import com.xzb.showcase.base.util.IpUtil;
import com.xzb.showcase.system.entity.UserEntity;
import com.xzb.showcase.system.entity.UserRoleResourceEntity;

/**
 * 从session中读取用户信息，设置到线程上线文中
 * 
 * @author xunxun
 * @date 2015-1-7 下午2:06:38
 */
@Component
public class LoginContextInterceptor extends HandlerInterceptorAdapter {

	private Logger logger = Logger.getLogger(LoginContextInterceptor.class);

	public LoginContextInterceptor() {

	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterConcurrentHandlingStarted(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		super.afterConcurrentHandlingStarted(request, response, handler);
	}

	/**
	 * 在业务处理器处理请求之前被调用 如果返回false 从当前的拦截器往回执行所有拦截器的afterCompletion(),再退出拦截器链
	 * 
	 * 如果返回true 执行下一个拦截器,直到所有的拦截器都执行完毕 再执行被拦截的Controller 然后进入拦截器链,
	 * 从最后一个拦截器往回执行所有的postHandle() 接着再从最后一个拦截器往回执行所有的afterCompletion()
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		String loginName = (String) session
				.getAttribute(SessionSecurityConstants.KEY_LOGIN_NAME);

		String path = request.getServletPath();
		// boolean isContains = isContainsUrl(path);
		// 是否需要拦截
		boolean flag = true;
		// if (!isContains) {// 包含的话：doFilter
		if (StringUtils.isBlank(loginName)) {// 通过登录系统第一次跳转过来
			// ajax 超时检测
			if (request.getHeader("X-Requested-With") != null) {
				response.setContentType("json/html;charset=utf-8");
				response.getWriter().print("{'statusCode':301}");// 如果请求为异步请求，则向页面打印
				return false;
			}
			// request.getRequestDispatcher("/account/login").forward(request,
			// response);
			response.sendRedirect(Env.getProperty(Env.KEY_DYNAMIC_URL));
			return false;
		}else {
			// 用户session
			UserEntity userEntity = (UserEntity) session
					.getAttribute(SessionSecurityConstants.KEY_USER);
			LoginContext loginContext = null;
			if (userEntity != null) {
				loginContext = buildLoginContext(userEntity, request);
				LoginContextHolder.put(loginContext, request);
			}
			if (loginContext == null)
				return false;

			flag = methodAccess(request, response, handler, session,
					loginContext);
		}
		// }
		return flag;
	}

	private boolean methodAccess(HttpServletRequest request,
			HttpServletResponse response, Object handler, HttpSession session,
			LoginContext loginContext) throws ServletException, IOException {
		if (handler instanceof HandlerMethod) {
			// 后台方法拦截器
			HandlerMethod handlerMethod = (HandlerMethod) handler;
			Method method = handlerMethod.getMethod();

			// 获取类注解
			AccessRequired clazzRequired = handlerMethod.getBean().getClass()
					.getAnnotation(AccessRequired.class);
			// 获取方法注解
			AccessRequired methodRequired = handlerMethod
					.getMethodAnnotation(AccessRequired.class);
			// 类和方法都带有AccessRequired的标签,并且value不为空的方法，需要验证
			if (clazzRequired != null
					&& StringUtils.isNoneBlank(clazzRequired.value())
					&& methodRequired != null
					&& StringUtils.isNoneBlank(methodRequired.value())) {
				// 将类验证器+方法验证器拼接成'xxx_xxx'字符串
				String authorization = clazzRequired.value() + "_"
						+ methodRequired.value();
				List<UserRoleResourceEntity> resourcesEntities = (List<UserRoleResourceEntity>) session
						.getAttribute(SessionSecurityConstants.KEY_USER_RESOURCES);
				for (UserRoleResourceEntity userRoleResourceEntity : resourcesEntities) {
					// 功能菜单
					if (userRoleResourceEntity.getType() == Constants.RESOURCE_TYPE_FCUNTION
							&& userRoleResourceEntity.getDescription().equals(
									authorization)) {
						// 验证通过
						return true;
					}
				}
				// 记录日志
				Long id = loginContext.getUserId();
				String name = loginContext.getUserName();
				logger.warn(new StringBuffer().append("用户").append(id)
						.append("-").append(name).append("尝试访问没有权限的方法,")
						.append(handlerMethod.getBean().getClass()).append("-")
						.append(method.getName()));
				// 验证失败跳转MainController-noAccess方法,然后返回json
				request.getRequestDispatcher("/main/noAccess").forward(request,
						response);
				// 验证失败
				return false;
			}
		}
		return true;
	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		LoginContextHolder.clear();
		super.afterCompletion(request, response, handler, ex);
	}

	/**
	 * 当前登录用户上下文信息
	 * 
	 * @param assertion
	 * @param request
	 * @return
	 * @author xunxun
	 * @date 2015-7-15 上午11:01:11
	 */
	protected LoginContext buildLoginContext(UserEntity userEntity,
			HttpServletRequest request) {
		LoginContext loginContext = new LoginContext();
		loginContext.setUserId(userEntity.getId());
		loginContext.setUserName(userEntity.getLoginName());
		loginContext.setIp(IpUtil.getIpAddress(request));
		return loginContext;
	}

	/**
	 * @author hbj
	 * @Description: 当前访问路径是否包含免登陆路径
	 * @param：
	 * @return
	 */
	private boolean isContainsUrl(String path) {
		boolean flag = false;
		String[] urls = Env.getProperty(Env.KEY_NOLOGIN_URL).split(",");
		for (String url : urls) {
			if (!"".equals(url) && path.startsWith(url)) {
				flag = true;
			}
		}
		return flag;
	}
}
