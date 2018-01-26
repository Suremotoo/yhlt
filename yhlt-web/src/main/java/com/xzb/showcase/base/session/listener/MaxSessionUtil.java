package com.xzb.showcase.base.session.listener;

/**
 * session工具類
 * @author xunxun
 * @date 2015-1-5 下午2:14:25
 */
public final class MaxSessionUtil {
	private static final String SEPARATOR = "_$@#_";//分隔符
	private static String maxSessionKey = "MAX_SESSION_KEY";
	private MaxSessionUtil(){
	}
	/**
	 * 生成存儲session個數的sessionKey字符串
	 * @param userName
	 * @param appKey
	 * @return
	 */
	public static String generateMaxSessionKey(String userName){
		return new StringBuffer(userName).append(SEPARATOR).append(maxSessionKey).toString();
	}
	
	public static void setMaxSessionKey(String sessionKey){
		maxSessionKey = sessionKey;
	}
}
