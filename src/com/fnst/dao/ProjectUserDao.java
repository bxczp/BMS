package com.fnst.dao;

import java.util.List;
import java.util.Map;

public interface ProjectUserDao {

	public List<Integer> getProjectIdsByUserId(Map<String, Object> map);
	public List<Integer> getMemberIdsByProjectId(int projectId);
	public int addProjectMember(Map<String, Object> map);
	public int deleteProjectMember(Map<String, Object> map);
}
