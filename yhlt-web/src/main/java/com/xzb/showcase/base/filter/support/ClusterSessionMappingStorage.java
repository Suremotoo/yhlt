package com.xzb.showcase.base.filter.support;
import javax.servlet.http.HttpSession;

import org.jasig.cas.client.session.SessionMappingStorage;
import org.springframework.cache.Cache;
import org.springframework.cache.Cache.ValueWrapper;
import org.springframework.cache.CacheManager;

/**
 * 基于缓存实现的session对象缓存
 * @author xunxun
 * @date 2015-1-5 上午10:05:13
 */
public class ClusterSessionMappingStorage implements SessionMappingStorage {
	private Cache idToSessionkeyMappingCache;
	private Cache sessionKeyToIdMappingCache;
	private Cache sessionCache;
	public ClusterSessionMappingStorage(CacheManager cacheManager){
		this.idToSessionkeyMappingCache = cacheManager.getCache("idToSessionkeyMapping");
		this.sessionKeyToIdMappingCache = cacheManager.getCache("sessionKeyToIdMapping");
		this.sessionCache = cacheManager.getCache("session");
	}
	@Override
	public HttpSession removeSessionByMappingId(String mappingId) {
		ValueWrapper valueWrapper = idToSessionkeyMappingCache.get(mappingId);
		if(valueWrapper != null){
			String sessionId = (String)valueWrapper.get();
			removeBySessionById(sessionId);
			sessionCache.evict(sessionId);
		}
		return null;
	}

	@Override
	public void removeBySessionById(String sessionId) {
		ValueWrapper valueWrapper = sessionKeyToIdMappingCache.get(sessionId);
		if(valueWrapper != null){
			String mappingId = (String)valueWrapper.get();
			idToSessionkeyMappingCache.evict(mappingId);
			sessionKeyToIdMappingCache.evict(sessionId);
		}
	}

	@Override
	public void addSessionById(String mappingId, HttpSession session) {
		sessionKeyToIdMappingCache.put(session.getId(), mappingId);
		idToSessionkeyMappingCache.put(mappingId, session.getId());
	}
}
