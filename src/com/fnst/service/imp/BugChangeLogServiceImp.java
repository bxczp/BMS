package com.fnst.service.imp;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fnst.dao.BugChangeLogDao;
import com.fnst.entity.BugChangeLog;
import com.fnst.service.BugChangeLogService;
import com.fnst.service.UserService;

/** 
* @author 作者: dengsl.jy
* @version 创建时间：2017/08/07 23:09:23 
* 类说明 :
*/
@Service("bugChangeLogService")
public class BugChangeLogServiceImp  implements BugChangeLogService{
	@Resource
	private BugChangeLogDao bugChangeLogDao;
@Resource
private UserService userService;
	@Override
	public Integer insert(BugChangeLog changeLog) {
		changeLog.setCreateDate(new Date());
		changeLog.setUpdateDate(new Date());
		return bugChangeLogDao.insert(changeLog);
	}

	@Override
	public  List<BugChangeLog> getChangeLogByBID(Integer bugId) {
		List<BugChangeLog> changeLogs= bugChangeLogDao.getChangeLogByBID(bugId);
		for (BugChangeLog bugChangeLog : changeLogs) {
			bugChangeLog.setChangeName(userService.getUserById(bugChangeLog.getUserId()).getName());
		}
		return changeLogs;
	}

}
