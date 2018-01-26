package com.xzb.showcase.base.security;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * controller后台方法安全验证注解<br>
 * 
 * 在controller类方法上增加@SupplierAccessRequired<br>
 * 
 * @author wyt
 * 
 */
@Target({ ElementType.METHOD, ElementType.TYPE })
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface SupplierAccessRequired {

}