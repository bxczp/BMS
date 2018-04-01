package com.fnst.service;

import java.util.List;
import java.util.Map;

import com.fnst.entity.User;

public interface ProjectUserService {
	
	public List<Integer> getProjectIdsByUserId(Map<String, Object> map);
	public List<Integer> getMemberIdsByProjectId(int projectId);
	public int addProjectMember(Map<String, Object> map);
	public int deleteProjectMember(Map<String, Object> map);
}
