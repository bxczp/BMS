package com.fnst.service;

import java.util.List;
import java.util.Map;

import com.fnst.entity.Project;

public interface ProjectService {
	
	public List<Project> getProjectList(Map<String, Object> map);

	public List<Project> getProjectManageList(Map<String, Object> map);
	public int getProjectManageListCount(Map<String, Object> map);
	
	public int getProjectListCount(Map<String, Object> map);
	public Project getProjectById(int id);
	
	public int addProject(Project project);
	public int updateProject(Map<String, Object> map);

	public int addProjectAdmin(Map<String, Object> map);

	public List<Project> getProListByUID(Integer userId);
	

	public List<Project> getProjectListByLeaderId(Integer userId);
	public List<Project> getProjectListAll();
	public Integer getStatusCount(String statusValue,Integer PID);
	public Integer getCategoryCount(String statusValue,Integer PID);
	public Integer getPriorityCount(String statusValue,Integer PID);
	public Integer getOsCount(String statusValue,Integer PID);


}
