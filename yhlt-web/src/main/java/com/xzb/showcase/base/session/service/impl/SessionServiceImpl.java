package com.xzb.showcase.base.session.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.cache.support.SimpleValueWrapper;
import org.springframework.util.Assert;

import com.xzb.showcase.base.session.service.SessionService;

/**
 * 基于memcach实现的session存储操作
 * 
 * @author xunxun
 * @date 2015-1-5 下午2:14:54
 */
public class SessionServiceImpl implements SessionService, InitializingBean {
	private CacheManager cacheManager;
	private String cacheName = "session";

	public void setCacheManager(CacheManager cacheManager) {
		this.cacheManager = cacheManager;
	}

	public void setCacheName(String cacheName) {
		this.cacheName = cacheName;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<Object, Object> getSession(String sessionId) {
		Cache cache = getCache();
		SimpleValueWrapper valueWrapper = (SimpleValueWrapper) cache.get(sessionId);
		if (valueWrapper == null) {
			Map<Object, Object> session = new HashMap<Object, Object>();
			session.put("_SESSION_CREATE_TIME_", System.currentTimeMillis());// session创建时间
			addSession(sessionId, session);
			return session;
		} else {
			if (valueWrapper instanceof Map)
				return (Map<Object, Object>) valueWrapper.get();
			else {
				System.err.println(valueWrapper.getClass());
				return (Map<Object, Object>) valueWrapper.get();
			}
		}
	}

	@Override
	public void updateSession(String sessionId, Map<Object, Object> session) {
		Cache cache = getCache();
		cache.put(sessionId, session);
	}

	private Cache getCache() {
		Cache cache = cacheManager.getCache(this.cacheName);
		Assert.notNull(cache);
		return cache;
	}

	@Override
	public void removeSession(String sessionId) {
		Cache cache = getCache();
		cache.evict(sessionId);
	}

	@Override
	public void addSession(String id, Map<Object, Object> session) {
		Cache cache = getCache();
		cache.put(id, session);
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		Assert.notNull(cacheManager);
		Assert.notNull(cacheName);
		Assert.hasText(cacheName);
	}
}
