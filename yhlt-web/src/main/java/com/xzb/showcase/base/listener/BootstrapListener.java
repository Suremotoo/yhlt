package com.xzb.showcase.base.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.xzb.showcase.base.util.SysException;

/**
 * 系统启动初始化监听器
 * @author xunxun
 * @date 2014-11-16 下午3:05:18
 */
public class BootstrapListener implements ServletContextListener {
	private static final String CONFIG_KEY = "startupListeners";
	private static final String SPERATOR = ",";//不同监听器之间的分隔符

	@Override
	public void contextDestroyed(ServletContextEvent contextEvent) {
	}

	@SuppressWarnings("unchecked")
	@Override
	public void contextInitialized(ServletContextEvent contextEvent) {
		String startupListeners = contextEvent.getServletContext().getInitParameter(CONFIG_KEY);
		if(startupListeners == null || startupListeners.isEmpty()){
			return;
		}
		String[] listeners = startupListeners.split(SPERATOR);
		for(String listenerClass : listeners){
			try {
				Class<SystemStartupListener> clazz = (Class<SystemStartupListener>) Class.forName(listenerClass);
				clazz.newInstance().onStartup(contextEvent);
			} catch (Exception e) {
				throw new SysException(e);
			}
		}
	}
}
