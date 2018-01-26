package com.xzb.showcase.base.util;

/**
 * 定义系统中系统异常的基类，所有的系统异常需从该类派生出来
 * @author xunxun
 * @date 2014-11-16 下午2:48:10
 */
public class SysException extends RuntimeException {
	private static final long serialVersionUID = 5474572901617208809L;

	public SysException() {
		super();
	}

	public SysException(String message, Throwable cause) {
		super(message, cause);
	}

	public SysException(String message) {
		super(message);
	}

	public SysException(Throwable cause) {
		super(cause);
	}
}
