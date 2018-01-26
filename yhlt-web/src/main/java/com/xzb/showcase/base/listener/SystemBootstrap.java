package com.xzb.showcase.base.listener;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.core.env.AbstractEnvironment;

import com.xzb.showcase.base.util.Env;
import com.xzb.showcase.base.util.SysException;

/**
 * 初始化系统配置文件
 * @author xunxun
 * @date 2014-11-16 下午2:50:48
 */
public class SystemBootstrap {
	/**
	 * CONFIG_FILE_PATH 系统变量配置文件路径
	 */
	private static final String CONFIG_FILE_PATH = "/env.properties";
	private static final Log LOG = LogFactory.getLog(SystemBootstrap.class);

	public static void init() {
		InputStream inputStream = null;
		Properties properties = new Properties();
		try {
			inputStream = SysconfigInitListener.class
					.getResourceAsStream(CONFIG_FILE_PATH);
			properties.load(inputStream);
			LOG.info("系统配置项:" + properties);
		} catch (Exception e) {
			LOG.error("读取系统配置文件时发生错误：", e);
			throw new SysException(e);
		} finally {
			if (inputStream != null) {
				try {
					inputStream.close();
				} catch (IOException e) {
					LOG.error("关闭文件输入流失败：", e);
				}
			}
		}
		Env.init(properties);
		System.setProperty(AbstractEnvironment.ACTIVE_PROFILES_PROPERTY_NAME,
				Env.getProperty(Env.ENV_TYPE));
	}
}
