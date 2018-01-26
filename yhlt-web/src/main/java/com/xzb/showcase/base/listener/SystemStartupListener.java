package com.xzb.showcase.base.listener;

import javax.servlet.ServletContextEvent;
/**
 * 系统启动监听器
 * @author xunxun
 * @date 2014-11-16 下午2:37:45
 */
public interface SystemStartupListener {

	/**
	 * 系统启动时加载执行对应的逻辑
	 * @param contextEvent   
	 * @author  xunxun
	 * @date  2014-11-16 下午2:37:54
	 */
	public void onStartup(ServletContextEvent contextEvent);
}
