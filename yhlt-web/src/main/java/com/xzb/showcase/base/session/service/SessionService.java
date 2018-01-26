package com.xzb.showcase.base.session.service;

import java.util.Map;

/**
 * 对session进行操作的service接口
 * @author xunxun
 * @date 2015-1-5 下午2:14:45
 */
public interface SessionService {
	/**
	 * 根据sessionID获取session信息
	 * @param id
	 * @return
	 */
	public Map<Object,Object> getSession(String sessionId);
	/**
	 * 更新session信息
	 * @param id
	 * @param session
	 */
	public void updateSession(String id, Map<Object,Object> session);
	/**
	 * 删除session信息
	 * @param id
	 */
	public void removeSession(String id);
	
	/**
	 * 新增session信息
	 * @param id
	 * @param session
	 */
	public void addSession(String id, Map<Object,Object> session);
}
