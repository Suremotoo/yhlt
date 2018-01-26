package com.xzb.showcase.base.session.listener;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

/**
 * 
 * @author xunxun
 * @date 2015-1-5 下午2:14:18
 */
public class HttpSessionEventPublisher implements HttpSessionListener {
	private static final Logger LOGGER = LoggerFactory.getLogger(HttpSessionEventPublisher.class);
	ApplicationContext getContext(ServletContext servletContext) {
        return WebApplicationContextUtils.getWebApplicationContext(servletContext);
    }
	@Override
	public void sessionCreated(HttpSessionEvent event) {
		HttpSessionCreatedEvent e = new HttpSessionCreatedEvent(event.getSession());
        if (LOGGER.isDebugEnabled()) {
        	LOGGER.debug("Publishing event: " + e);
        }
        getContext(event.getSession().getServletContext()).publishEvent(e);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		HttpSessionDestroyedEvent e = new HttpSessionDestroyedEvent(event.getSession());
        if (LOGGER.isDebugEnabled()) {
        	LOGGER.debug("Publishing event: " + e);
        }
        getContext(event.getSession().getServletContext()).publishEvent(e);
	}
}
