package com.fnst.dao;

import java.util.List;

import com.fnst.entity.BugChangeLog;

/** 
* @author 作者: dengsl.jy
* @version 创建时间：2017/08/07 23:07:43 
* 类说明 :
*/
public interface BugChangeLogDao {
	
	public Integer insert(BugChangeLog changeLog);
	public List<BugChangeLog> getChangeLogByBID(Integer bugId);

}
