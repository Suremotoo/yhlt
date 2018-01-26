package com.xzb.showcase.base.session.listener;

import javax.servlet.http.HttpSession;

/**
 * 
 * @author xunxun
 * @date 2015-1-5 下午2:14:08
 */
public class HttpSessionCreatedEvent extends SessionCreationEvent{
	private static final long serialVersionUID = -5867480727372430377L;

	public HttpSessionCreatedEvent(HttpSession session) {
        super(session);
    }

    public HttpSession getSession() {
        return (HttpSession) getSource();
    }
}
