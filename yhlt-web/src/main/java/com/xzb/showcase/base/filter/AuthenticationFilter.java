package com.xzb.showcase.base.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.xzb.showcase.base.security.SessionSecurityConstants;
import com.xzb.showcase.base.util.Env;

/**
 * 权限过滤filter
 * 
 * @author admin
 * 
 */
public class AuthenticationFilter implements Filter {

	public void destroy() {

	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest servletRequest = (HttpServletRequest) request;
		// 注释开始位置
		String path = servletRequest.getServletPath();
		boolean isContains = isContainsUrl(path);
		if (!isContains) {// 包含的话：doFilter
			HttpSession session = servletRequest.getSession();
			String loginName = (String) session.getAttribute(SessionSecurityConstants.KEY_LOGIN_NAME);
			if (loginName != null) {
				chain.doFilter(request, response);
				return;

			} else {
				if (path.indexOf(".") > 0) {// && !path.endsWith(".jsp")
					chain.doFilter(request, response);
					return;
				}
				String url = "/front";
				((HttpServletResponse) response).sendRedirect(servletRequest.getContextPath() + url);
				// servletRequest.getSession().setAttribute(SessionSecurityConstants.ERROR,
				// "用户没有权限访问目的地址，请登录合适账户以继续访问！");
				return;
			}

		}
		chain.doFilter(request, response);
		return;

	}

	public void init(FilterConfig filterConfig) throws ServletException {

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
