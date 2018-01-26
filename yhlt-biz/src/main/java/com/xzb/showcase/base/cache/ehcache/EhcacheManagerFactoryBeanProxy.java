package com.xzb.showcase.base.cache.ehcache;

import java.io.IOException;

import net.sf.ehcache.CacheException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.ehcache.EhCacheManagerFactoryBean;

public class EhcacheManagerFactoryBeanProxy extends EhCacheManagerFactoryBean{

	protected final Logger logger = LoggerFactory.getLogger(EhcacheManagerFactoryBeanProxy.class);
	
	private boolean cacheFlag = true;

	@Override
	public void afterPropertiesSet() throws IOException, CacheException {
		if(!cacheFlag){
			logger.warn("************ehcache disabled!!!");
			return;
		}
		super.afterPropertiesSet();
	}

	public boolean isCacheFlag() {
		return cacheFlag;
	}

	public void setCacheFlag(boolean cacheFlag) {
		this.cacheFlag = cacheFlag;
	}
}
