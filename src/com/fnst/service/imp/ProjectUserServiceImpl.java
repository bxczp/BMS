package com.fnst.service.imp;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fnst.dao.ProjectUserDao;
import com.fnst.service.ProjectUserService;

@Service("projectUserService")
public class ProjectUserServiceImpl implements ProjectUserService{
	
	@Resource
	private ProjectUserDao projectUserDao;

	@Override
	public List<Integer> getProjectIdsByUserId(Map<String, Object> map) {
		return projectUserDao.getProjectIdsByUserId(map);
	}

	@Override
	public List<Integer> getMemberIdsByProjectId(int projectId) {
		return projectUserDao.getMemberIdsByProjectId(projectId);
	}

	@Override
	public int addProjectMember(Map<String, Object> map) {
		return projectUserDao.addProjectMember(map);
	}

	@Override
	public int deleteProjectMember(Map<String, Object> map) {
		return projectUserDao.deleteProjectMember(map);
	}

}
