package com.xzb.showcase.dome;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;

import com.xzb.showcase.system.entity.UserEntity;
import com.xzb.showcase.system.service.UserService;

@ContextConfiguration(locations = { "/applicationContext.xml" })
public class JdbcTest extends SpringTxTestCase {

	@Autowired
	private UserService userInfoService;

	@Test
	@Rollback(value = false)
	public void crud() {
		long start = System.currentTimeMillis();

		List<UserEntity> userInfos = new ArrayList<UserEntity>();
		for (int i = 100; i < 1000; i++) {
			UserEntity userInfo = new UserEntity();
//			userInfo.setLoginname("test" + i);
			userInfo.setName("name" + i);
			userInfo.setPassword("123456");
//			userInfo.setCudate(new Date());
			userInfos.add(userInfo);
		}
		userInfoService.save(userInfos);
		System.out.println("System-currentTimeMillis"
				+ (System.currentTimeMillis() - start));
	}
}
