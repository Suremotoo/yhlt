package com.xzb.showcase.base.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegexExam {

	public static String composeMessage(String template, String key, String value) throws Exception {
		String regex = "\\$\\{(" + key + ")\\}";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(template);
		StringBuffer sb = new StringBuffer();
		while (matcher.find()) {
			if (value == null) {
				value = "";
			} else {
				value = value.replaceAll("\\$", "\\\\\\$");
			}
			matcher.appendReplacement(sb, value);
			matcher.appendTail(sb);
			return sb.toString();
		}
		return template;
	}

}