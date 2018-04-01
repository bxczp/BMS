package com.fnst.service;

import java.util.List;
import java.util.Map;

import com.fnst.entity.Bug;
import com.fnst.entity.Dict;

public interface BugService {
	public List<Bug> getBugList();
	public int  insert(Bug bug);
	public Bug  getMAXID();

	public List<Bug> getBugListByPID(Integer proId);
	
	public List<Bug> getBugListByUserId(Map<String, Object> map);
	public int getBugListCountByUserId(Map<String, Object> map);
	public List<Bug> getBugListByProjectId(Map<String, Object> map);
	public int getBugListCountByProjectId(Map<String, Object> map);
	public Bug getBugById(Integer id);
	public Bug getBugByDesignation(String designation);
	public int updateBugById(Bug bug);
	public int delete(Integer id);
	public List<Bug> getBugByUIDAndStatus(Integer userId,String status);
	public List<Bug> getBugsByPID(Integer userId);
	public List<Bug> getBugsByUID(Integer Id);
}
