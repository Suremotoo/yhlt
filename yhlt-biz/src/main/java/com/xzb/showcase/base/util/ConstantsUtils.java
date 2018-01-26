package com.xzb.showcase.base.util;

import java.util.Date;

import net.sf.json.JsonConfig;

/**
 * 常量定义类
 * 
 * @author wj
 * 
 */
public class ConstantsUtils {
	// 用户主题
	// public static final String USER_THEMES = "USER_THEMES";
	// public static final String USER_MODETHEMES = "USER_MODETHEMES";
	// public static final String USER_COMPONENTTHEMES = "USER_COMPONENTTHEMES";

	// 用户portal
	// public static final String USER_PORTAL = "USER_PORTAL";

	// 用户信息-存session用
	// public static final String USER_INFO = "USER_INFO";

	// 用户资源
	// public static final String USER_RESOURCES = "USER_RESOURCES";

	// 在线聊天中标示系统消息的ID
	public static final Long IMMESSAGE_SYSTEM_ID = 0L;

	// 在线聊天中标示系统消息的名称
	public static final String IMMESSAGE_SYSTEM_NAME = "系统消息";

	// 在线聊天中标示消息的已读未读状态 0 表示已读
	public static final int IMMESSAGE_MESSAGE_STATUS_READ = 0;

	// 在线聊天中标示消息的已读未读状态 1表示未读
	public static final int IMMESSAGE_MESSAGE_STATUS_NOTREAD = 1;

	/**
	 * 公告信息-用户类型-ZBF 招标方
	 */
	public static final String NOTICE_USER_TYPE_ZBF = "ZBF";
	/**
	 * 公告信息-用户类型-ZJ 专家
	 */
	public static final String NOTICE_USER_TYPE_ZJ = "ZJ";
	/**
	 * 公告信息-用户类型-JD 监督
	 */
	public static final String NOTICE_USER_TYPE_JD = "JD";
	/**
	 * 流程审批状态：作废
	 */
	public static final int WORKFLOW_APPROVAL_STATUS_1 = -1;
	/**
	 * 流程审批状态：未发起
	 */
	public static final int WORKFLOW_APPROVAL_STATUS_2 = 0;
	/**
	 * 流程审批状态：审批中
	 */
	public static final int WORKFLOW_APPROVAL_STATUS_3 = 1;
	/**
	 * 流程审批状态：重新填写
	 */
	public static final int WORKFLOW_APPROVAL_STATUS_4 = 2;
	/**
	 * 流程审批状态：审批完成
	 */
	public static final int WORKFLOW_APPROVAL_STATUS_5 = 3;

	/**
	 * 公告信息-用户组员0
	 */
	public static final int NOTICE_USER_TEAM_NORMAL = 0;
	/**
	 * 公告信息-用户组长1
	 */
	public static final int NOTICE_USER_TEAM_LEADER = 1;

	/**
	 * 推送消息状态可用
	 */
	public static final boolean NOTICE_STATUS_ENABLE = true;
	/**
	 * 推送消息状态禁用
	 */
	public static final boolean NOTICE_STATUS_DISABLE = false;

	/**
	 * 公告文件类型-招标方
	 */
	public static final int NOTICE_FILE_USER_TYPE_ZBF = 0;

	/**
	 * 公告文件类型-投标方
	 */
	public static final int NOTICE_FILE_USER_TYPE_TBF = 1;

	/**
	 * 招标文件-主文件
	 */
	public static final int NOTICE_FILE_TYPE_MASTER = 0;
	/**
	 * 招标文件-附属文件
	 */
	public static final int NOTICE_FILE_TYPE_SLAVE = 1;

	/**
	 * 公告-应约状态 -未应约
	 */
	public static final int NOTICE_INVITE_STATE_0 = 0;
	/**
	 * 公告-应约状态 -已应约
	 */
	public static final int NOTICE_INVITE_STATE_1 = 1;
	/**
	 * 招标项目发售标书
	 */
	public static final int NOTICE_SELL_TYPE_PUBLISH = 1;
	/**
	 * 招标项目未发售标书
	 */
	public static final int NOTICE_SELL_TYPE_UNPUBLISH = 0;

	/**
	 * 招标文件-锁定
	 */
	public static final int NOTICE_FILE_STATUS_LOCK = 0;
	/**
	 * 招标文件-解锁
	 */
	public static final int NOTICE_FILE_STATUS_UNLOCK = 1;

	/**
	 * 公告发布状态-未发布
	 */
	public static final int NOTICE_PUBLISH_STATUS_UNPUBLISH = 0;
	/**
	 * 公告发布状态-发布
	 */
	public static final int NOTICE_PUBLISH_STATUS_PUBLISH = 1;

	// 是否中标 0还没决定 1中标 2未中标 3流标
	/**
	 * 公告中标状态-未处理状态
	 */
	public static final int NOTICE_WIN_TYPE_NORMAL = 0;
	/**
	 * 公告中标状态-中标
	 */
	public static final int NOTICE_WIN_TYPE_WIN = 1;
	/**
	 * 公告中标状态-未中标
	 */
	public static final int NOTICE_WIN_TYPE_FAIL = 2;
	/**
	 * 公告中标状态-流标
	 */
	public static final int NOTICE_WIN_TYPE_ALL_FAIL = 3;

	/**
	 * 大厅签到常量,0-未签到
	 */
	public static final int NOTICE_USER_CHECKIN_0 = 0;

	/**
	 * 大厅签到常量,1-已签到
	 */
	public static final int NOTICE_USER_CHECKIN_1 = 1;
	
	
	/**
	 * 门户名片显示
	 */
	public static final int USER_NODISPALY = 0;
	public static final int USER_DISPALY = 1;

	public static final JsonConfig JSON_CONFIG = new JsonConfig();
	static {
		String[] taskArray = new String[] { "variableInstances",
				"identityLinks", "variableNamesLocal", "candidates",
				"variables", "variablesLocal", "variableNames", "execution",
				"taskDefinition", "processInstance" };
		String[] proDefArray = new String[] { "processDefinition" };
		String[] proinstArray = new String[] { "processBusinessKey",
				"activity", "executions", "tasks", "subProcessInstance" };

		String[] array = new String[taskArray.length + proDefArray.length
				+ proinstArray.length];
		System.arraycopy(taskArray, 0, array, 0, taskArray.length);
		System.arraycopy(proDefArray, 0, array, taskArray.length,
				proDefArray.length);
		System.arraycopy(proinstArray, 0, array, taskArray.length
				+ proDefArray.length, proinstArray.length);

		JSON_CONFIG.registerJsonValueProcessor(Date.class,
				new JsonDateValueProcessor());
		JSON_CONFIG.setExcludes(array);
	}
}
