package com.xzb.showcase.base.session;

import javax.servlet.http.HttpSession;

/**
 * 非集群环境的session实现
 * @author xunxun
 * @date 2015-1-5 下午2:15:32
 */
public class NoneClusterHttpSessionWrapper extends HttpSessionWrapper {
	public NoneClusterHttpSessionWrapper(HttpSession session) {
		super(session);
	}
}
