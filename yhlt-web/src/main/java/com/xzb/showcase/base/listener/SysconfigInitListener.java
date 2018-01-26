package com.xzb.showcase.base.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;

import com.xzb.showcase.base.util.Env;

/**
 * 加载env.properties中的配置项，将静态资源地址和动态资源地址放到application变量中
 * @author xunxun
 * @date 2014-11-16 下午2:40:26
 */
public class SysconfigInitListener implements SystemStartupListener {
	@Override
	public void onStartup(ServletContextEvent contextEvent) {
		SystemBootstrap.init();
		ServletContext servletContext = contextEvent.getServletContext();
		servletContext.setAttribute("appUrl", Env.getProperty(Env.APP_URL));
		servletContext.setAttribute("staticURL", Env.getProperty(Env.KEY_STATIC_URL));
		servletContext.setAttribute("dynamicURL", Env.getProperty(Env.KEY_DYNAMIC_URL));
		//jquery
		servletContext.setAttribute("easyUIVersion", Env.getProperty(Env.KEY_JQUERY_EASY_VERSION));
		servletContext.setAttribute("easyUITheme", Env.getProperty(Env.KEY_JQUERY_EASY_THEME));
		//cas
		servletContext.setAttribute("casServerUrlPrefix", Env.getProperty(Env.KEY_CAS_SERVER_URL_PREFIX));
		servletContext.setAttribute("casServerLoginUrl", Env.getProperty(Env.KEY_CAS_SERVER_LOGINURL));
		servletContext.setAttribute("casServerName", Env.getProperty(Env.KEY_CAS_SERVER_NAME));
		//UEditor
		servletContext.setAttribute("ueditorHomeUrl", Env.getProperty(Env.KEY_UEDITOR_HOME_URL));
		servletContext.setAttribute("urlPrefix", Env.getProperty(Env.KEY_UEDITOR_URL_PREFIX));
		servletContext.setAttribute("imagePathFormat", Env.getProperty(Env.KEY_UEDITOR_IMAGE_URL));
		servletContext.setAttribute("videoPathFormat", Env.getProperty(Env.KEY_UEDITOR_VIDEO_URL));
		//sms
		servletContext.setAttribute("smsEnable", Env.getProperty(Env.KEY_SMS_ENABLE));
	}
}
