package com.xzb.showcase.base.util;

import java.util.Properties;

/**
 * 读取env.properties配置文件中的配置项
 * 
 * @author xunxun
 * @date 2014-11-16 下午2:30:25
 */
public final class Env {
	public static final String KEY_STATIC_URL = "server.static";
	public static final String KEY_DYNAMIC_URL = "server.dynamic";
	public static final String KEY_SERVER_NAME = "server.name";
	public static final String APP_NAME = "app.name";
	public static final String APP_URL = "app.url";
	public static final String APP_EAMIL = "app.email";
	public static final String SYS_ADMIN = "system.admin";
	public static final String ENV_TYPE = "env.type";
	public static final String KEY_JQUERY_EASY_VERSION = "jquery.easyui.version";
	public static final String KEY_JQUERY_EASY_THEME = "jquery.easyui.theme";
	public static final String KEY_CAS_SERVER_URL_PREFIX = "cas.server.urlPrefix";
	public static final String KEY_CAS_SERVER_NAME = "cas.server.name";
	public static final String KEY_CAS_SERVER_LOGINURL = "cas.server.loginUrl";
	public static final String KEY_FILE_SAVE_PATH = "file.save.path";
	public static final String DEBUG = "debug";
	public static final String KEY_DEFAULT_PASSWORD = "default.password";
	public static final String KEY_NOLOGIN_URL = "nologin.url";
	public static final String KEY_SUPPLIER_PASSWORD = "supplier.password";

	/**
	 * 流程附件存储路径
	 */
	public static final String WORKFLOW_URL = "workflowfile.url";

	/**
	 * 流程部署后生产流程部署图片导入到的本地路径
	 */
	public static final String KEY_EXPORT_DIAGRAM_PATH = "export.diagram.path";
	/**
	 * UEditor配置
	 */
	public static final String KEY_UEDITOR_HOME_URL = "ueditor.homeUrl";
	public static final String KEY_UEDITOR_URL_PREFIX = "ueditor.urlPrefix";
	public static final String KEY_UEDITOR_IMAGE_URL = "ueditor.imagePathFormat";
	public static final String KEY_UEDITOR_VIDEO_URL = "ueditor.videoPathFormat";

	/**
	 * 短信模块配置
	 */
	public static final String KEY_SMS_ENABLE = "sms.enable";
	/**
	 * SWF 转换工具地址
	 */
	public static final String SWFTOOLS_PATH = "swf.tools.path";

	private static Properties props;

	public static synchronized void init(Properties properties) {
		props = properties;
	}

	/**
	 * 读取配置项
	 * 
	 * @param key
	 * @return
	 * @author xunxun
	 * @date 2014-11-16 下午2:30:41
	 */
	public static final String getProperty(String key) {
		return props.getProperty(key);
	}
}
