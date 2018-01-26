package com.xzb.showcase.base.session.listener;

import org.springframework.context.ApplicationEvent;

/**
 * 會話創建事件
 * @author xunxun
 * @date 2015-1-5 下午2:14:33
 */
public abstract class SessionCreationEvent extends ApplicationEvent {
	private static final long serialVersionUID = -3006171357970967626L;

	public SessionCreationEvent(Object source) {
		super(source);
	}

}
