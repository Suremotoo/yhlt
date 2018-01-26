package com.xzb.showcase.meeting.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import com.xzb.showcase.base.datapermission.DataPermission;
import com.xzb.showcase.base.log.BusinessLog;
import com.xzb.showcase.base.service.BaseService;
import com.xzb.showcase.meeting.dao.MeetingInfoDao;
import com.xzb.showcase.meeting.entity.MeetingInfoEntity;

/**
 * 数据字典
 * 
 * @author LauLimXiao
 * 
 */
@Component
@Transactional
@BusinessLog(service = "会议信息管理")
@DataPermission
public class MeetingInfoService extends
BaseService<MeetingInfoEntity, MeetingInfoDao>{

}
