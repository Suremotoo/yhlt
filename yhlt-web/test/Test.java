import java.util.ArrayList;

import com.xzb.showcase.base.util.MD5Util;

public class Test {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// Date current = DateUtils.truncate(new Date(), Calendar.DATE);
		// current = DateUtils.addDays(current, 2);
		// System.out.println(current);
		//
		//
		// Date next = DateUtils.addDays(new Date(), 1);
		// System.out.println(next);
		// System.out.println(current.before(next));

//		ArrayList<String> list1 = new ArrayList<String>();
//		list1.add("b");
//		list1.add("d");
//		// System.out.println(list1);
//		ArrayList<String> list2 = new ArrayList<String>();
//		list2.addAll(list1);// 将list1添加到list2中
//		
//		list1.add("f");
//		list2.remove(0);
//		
//		System.out.println(list1);
//		System.out.println(list2);
		System.out.println(MD5Util.MD5("123456"));
	}

}
