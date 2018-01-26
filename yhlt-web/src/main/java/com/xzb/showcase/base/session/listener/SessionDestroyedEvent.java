package com.xzb.showcase.base.session.listener;

import org.springframework.context.ApplicationEvent;

/**
 * 會話銷毀事件
 * @author xunxun
 * @date 2015-1-5 下午2:13:49
 */
public abstract class SessionDestroyedEvent extends ApplicationEvent {
	private static final long serialVersionUID = 3029403982208547889L;
	public SessionDestroyedEvent(Object source) {
		super(source);
	}
	/**
     * @return 要銷毀的sessionID.
     */
    public abstract String getId();
}
