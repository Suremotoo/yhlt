package com.xzb.showcase.dome;

import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang3.time.DateUtils;

public class Test2 {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		boolean debug = false;
		boolean needLog = false;
		System.out.println(debug || needLog);
		
		
		System.out.println(DateUtils.truncate(new Date(), Calendar.DATE).before(new Date()));
	}

}
