package com.xzb.showcase.base.session;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpSession;

import com.xzb.showcase.base.session.service.SessionService;

/**
 *  基于SessionService管理的httpRequest包装
 * @author xunxun
 * @date 2015-1-5 下午2:15:06
 */
public class ClusterHttpServletRequestWrapper extends HttpServletRequestWrapper {
	private SessionService sessionService;
	private String sessionId;
	private HttpSession httpSession;
	private ServletContext servletContext;

	public ClusterHttpServletRequestWrapper(ServletContext servletContext, HttpServletRequest request, String sessionId, SessionService sessionService) {
		super(request);
		this.sessionId = sessionId;
		this.sessionService = sessionService;
		this.servletContext = servletContext;
	}

	@Override
	public HttpSession getSession(boolean create) {
		if(this.httpSession == null){
			this.httpSession = new ClusterHttpSessionWrapper(this.sessionId, servletContext, this.sessionService);
		}
		return this.httpSession;
	}

	@Override
	public HttpSession getSession() {
		return getSession(false);
	}
}
