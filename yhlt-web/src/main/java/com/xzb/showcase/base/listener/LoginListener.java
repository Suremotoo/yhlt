package com.xzb.showcase.base.listener;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;

import com.xzb.showcase.base.security.SessionSecurityConstants;
import com.xzb.showcase.base.util.ConstantsUtils;

/**
 * 用于监听session属性的添加
 * 
 * @author admin
 * 
 */
public class LoginListener implements HttpSessionAttributeListener {
	// 已经登录用户session
	public static Map<String, HttpSession> loginedUser = Collections
			.synchronizedMap(new HashMap<String, HttpSession>());
	// 登陆用户消息通知状态
	/**
	 * 登陆用户消息通知状态<br>
	 * bool - false 不需要推送消息<br>
	 * bool - true 需要推送消息<br>
	 */
	public static Map<String, Boolean> loginedUserNoitceStatus = Collections
			.synchronizedMap(new HashMap<String, Boolean>());


	@Override
	public void attributeAdded(HttpSessionBindingEvent eventAdd) {
//		// 监听session属性的添加
//		String attrName = eventAdd.getName();
//		// 监听到为属性userName的添加
//		if (SessionSecurityConstants.KEY_LOGIN_NAME.equals(attrName)) {
//			String value = (String) eventAdd.getValue();
//			// 刚登陆
//			loginedUserNoitceStatus.put(value,
//					ConstantsUtils.NOTICE_STATUS_ENABLE);
//
//			HttpSession session = loginedUser.get(value);
//			if (session != null) {
//				// 跟登出代码一致
//				session.removeAttribute(SessionSecurityConstants.KEY_USER);
//				session.removeAttribute(SessionSecurityConstants.KEY_USER_ID);
//				session.removeAttribute(SessionSecurityConstants.KEY_LOGIN_NAME);
//				// session.invalidate();
//			}
//			loginedUser.put(value, eventAdd.getSession());
//		}
	}

	@Override
	public void attributeRemoved(HttpSessionBindingEvent se) {

	}

	@Override
	public void attributeReplaced(HttpSessionBindingEvent se) {
		// 重新登录的事件是attributeReplaced
	}

}
