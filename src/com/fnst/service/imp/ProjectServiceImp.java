package com.fnst.service.imp;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fnst.dao.ProjectDao;
import com.fnst.dao.ProjectUserDao;
import com.fnst.entity.Project;
import com.fnst.service.ProjectService;

@Service("projectService")
public class ProjectServiceImp implements ProjectService {
	
	@Resource
	private ProjectDao projectDao;

	@Override
	public List<Project> getProjectList(Map<String, Object> map) {
		return projectDao.getProjectList(map);
	}

	@Override
	public int getProjectListCount(Map<String, Object> map) {
		return projectDao.getProjectListCount(map);
	}

	@Override
	public List<Project> getProjectManageList(Map<String, Object> map) {
		return projectDao.getProjectManageList(map);
	}


	@Override
	public Project getProjectById(int id) {
		return projectDao.getProjectById(id);
	}

	@Override
	public int addProjectAdmin(Map<String, Object> map) {
		return projectDao.addProjectAdmin(map);
	}


	@Override
	public List<Project> getProListByUID(Integer userId) {
		
		return projectDao.getProListByUID(userId);
	}

	@Override
	public List<Project> getProjectListAll() {
		
		return projectDao.getProjectListAll();
	}

	@Override
	public List<Project> getProjectListByLeaderId(Integer userId) {
		
		return projectDao.getProjectListByLeaderId(userId);
	}

	@Override
	public int getProjectManageListCount(Map<String, Object> map) {
		return projectDao.getProjectManageListCount(map);
	}

	@Override
	public int addProject(Project project) {
		return projectDao.addProject(project);
	}

	@Override
	public int updateProject(Map<String, Object> map) {
		return projectDao.updateProject(map);
	}

	@Override
	public Integer getStatusCount(String statusValue,Integer PID) {
		
		return projectDao.getStatusCount(statusValue,PID);
	}

	@Override
	public Integer getCategoryCount(String statusValue, Integer PID) {
		
		return projectDao.getCategoryCount(statusValue, PID);
	}

	@Override
	public Integer getPriorityCount(String statusValue, Integer PID) {
		
		return projectDao.getCategoryCount(statusValue, PID);
	}

	@Override
	public Integer getOsCount(String statusValue, Integer PID) {
		
		return projectDao.getOsCount(statusValue, PID);
	}

	

}
