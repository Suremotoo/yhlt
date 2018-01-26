package com.xzb.showcase.base.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jasig.cas.client.session.SessionMappingStorage;
import org.jasig.cas.client.session.SingleSignOutHandler;
import org.jasig.cas.client.util.AbstractConfigurationFilter;
import org.springframework.cache.CacheManager;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.xzb.showcase.base.filter.support.ClusterSessionMappingStorage;
import com.xzb.showcase.base.util.Env;

public class ClusterSingleSignOutFilter extends AbstractConfigurationFilter {

	private static final SingleSignOutHandler handler = new SingleSignOutHandler();
	private CacheManager cacheManager;

	public void init(final FilterConfig filterConfig) throws ServletException {
		if (!isIgnoreInitConfiguration()) {
			handler.setArtifactParameterName(getPropertyFromInitParams(
					filterConfig, "artifactParameterName", "ticket"));
			handler.setLogoutParameterName(getPropertyFromInitParams(
					filterConfig, "logoutParameterName", "logoutRequest"));
		}
		handler.init();
		ApplicationContext applicationContext = WebApplicationContextUtils
				.getWebApplicationContext(filterConfig.getServletContext());
		this.cacheManager = applicationContext.getBean("ehcacheManager",
				CacheManager.class);
		ClusterSessionMappingStorage sessionMappingStorage = new ClusterSessionMappingStorage(
				cacheManager);
		handler.setSessionMappingStorage(sessionMappingStorage);
	}

	public void setArtifactParameterName(final String name) {
		handler.setArtifactParameterName(name);
	}

	public void setLogoutParameterName(final String name) {
		handler.setLogoutParameterName(name);
	}

	public void setSessionMappingStorage(final SessionMappingStorage storage) {
		handler.setSessionMappingStorage(storage);
	}

	public void doFilter(final ServletRequest servletRequest,
			final ServletResponse servletResponse, final FilterChain filterChain)
			throws IOException, ServletException {
		final HttpServletRequest request = (HttpServletRequest) servletRequest;
		try {
			if (handler.isTokenRequest(request)) {
				handler.recordSession(request);
			} else if (handler.isLogoutRequest(request)) {
				handler.destroySession(request);
				return;
			} else {
				log.trace("Ignoring URI " + request.getRequestURI());
			}
			filterChain.doFilter(servletRequest, servletResponse);
		} catch (Exception e) {
			if (e.getMessage()!=null && e.getMessage()
					.contains(
							"org.jasig.cas.client.validation.TicketValidationException:")) {
				// 跳转登陆
				((HttpServletResponse) servletResponse).sendRedirect(Env
						.getProperty(Env.KEY_CAS_SERVER_LOGINURL));
			} else {
				if (e instanceof IOException) {
					throw new IOException(e);
				}
				if (e instanceof ServletException) {
					throw new ServletException(e);
				}
			}
		}

	}

	public void destroy() {
		// nothing to do
	}

	protected static SingleSignOutHandler getSingleSignOutHandler() {
		return handler;
	}

}
