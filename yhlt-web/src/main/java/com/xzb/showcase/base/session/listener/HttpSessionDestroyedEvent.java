package com.xzb.showcase.base.session.listener;

import javax.servlet.http.HttpSession;

/**
 * 
 * @author xunxun
 * @date 2015-1-5 下午2:14:13
 */
public class HttpSessionDestroyedEvent extends SessionDestroyedEvent{
	private static final long serialVersionUID = -508866280557266007L;

	public HttpSessionDestroyedEvent(HttpSession session) {
		super(session);
	}

	public HttpSession getSession() {
		return (HttpSession) getSource();
	}

	@Override
	public String getId() {
		return getSession().getId();
	}
}
