package com.fnst.service.imp;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fnst.dao.BugDao;
import com.fnst.dao.BugFeedbackDao;
import com.fnst.dao.DictDao;
import com.fnst.dao.ProjectDao;
import com.fnst.dao.UserDao;
import com.fnst.entity.Bug;
import com.fnst.entity.BugFeedback;
import com.fnst.entity.Dict;
import com.fnst.service.BugService;
@Service("bugService")
public class BugServiceImp  implements BugService{
	
	@Resource 
	private BugDao bugDao;
	@Resource
	private DictDao dictDao;
	@Resource 
	private UserDao userDao;
	@Resource
	private ProjectDao projectDao;
	@Resource
	private BugFeedbackDao bugFeedbackDao;
	/**
	 * bug 列表
	 */
	@Override
	public List<Bug> getBugList() {
		// TODO Auto-generated method stub
		List<Bug> bugs=bugDao.getBugList();
		for(int i=0;i<bugs.size();i++){
			Bug bug=bugs.get(i);
//			bug.setOsLabel(dictDao.getDictLabel(new Dict(bugs.get(i).getOs(),"bug_os")));
			bug.setPriorityLabel(dictDao.getDictLabel(new Dict(bugs.get(i).getPriority(),"bug_priority")));
			bug.setCategoryLabel(dictDao.getDictLabel(new Dict(bug.getCategory(), "bug_category")));
			bug.setStatusLabel(dictDao.getDictLabel(new Dict(bug.getStatus(), "bug_status")));
			bug.setPublisher(userDao.getUserById(bug.getPublisherId()).getName());
			bug.setProName(projectDao.getProjectById(bug.getProId()).getName());
		}
		
		return bugs;
	}
	
	/**
	 * 增加一个bug
	 */
	@Override
	public int insert(Bug bug) {
		
		return bugDao.insert(bug);
	}

	@Override
	public Bug getMAXID() {
		Bug bug=bugDao.getMAXID();
		if (bug==null) {
			bug=new Bug();
			bug.setId(1);
		}
		return bug;
	}


	@Override
	public List<Bug> getBugListByPID(Integer proId) {
		List<Bug> bugs= bugDao.getBugListByPID(proId);
		for(int i=0;i<bugs.size();i++){
			Bug bug=bugs.get(i);
//			bug.setOsLabel(dictDao.getDictLabel(new Dict(bugs.get(i).getOs(),"bug_os")));
			bug.setPriorityLabel(dictDao.getDictLabel(new Dict(bugs.get(i).getPriority(),"bug_priority")));
			bug.setCategoryLabel(dictDao.getDictLabel(new Dict(bug.getCategory(), "bug_category")));
			bug.setStatusLabel(dictDao.getDictLabel(new Dict(bug.getStatus(), "bug_status")));
			bug.setPublisher(userDao.getUserById(bug.getPublisherId()).getName());
			bug.setProName(projectDao.getProjectById(bug.getProId()).getName());
		}
		return bugs;
	}


	@Override
	public List<Bug> getBugListByProjectId(Map<String, Object> map) {
		List<Bug> bugs=bugDao.getBugListByProjectId(map);
		for(int i=0;i<bugs.size();i++){
			Bug bug=bugs.get(i);
//			bug.setOsLabel(dictDao.getDictLabel(new Dict(bugs.get(i).getOs(),"bug_os")));
			bug.setPriorityLabel(dictDao.getDictLabel(new Dict(bugs.get(i).getPriority(),"bug_priority")));
			bug.setCategoryLabel(dictDao.getDictLabel(new Dict(bug.getCategory(), "bug_category")));
			bug.setStatusLabel(dictDao.getDictLabel(new Dict(bug.getStatus(), "bug_status")));
			bug.setPublisher(userDao.getUserById(bug.getPublisherId()).getName());
			bug.setProName(projectDao.getProjectById(bug.getProId()).getName());
		}
		return bugs;
	}

	@Override
	public int getBugListCountByProjectId(Map<String, Object> map) {
		return bugDao.getBugListCountByProjectId(map);
	}

	@Override
	public Bug getBugById(Integer id) {
		Bug bug =bugDao.getBugById(id);
		bug.setOsLabel(dictDao.getDictLabel(new Dict(bug.getOs(),"bug_os")));
		bug.setPriorityLabel(dictDao.getDictLabel(new Dict(bug.getPriority(),"bug_priority")));
		bug.setCategoryLabel(dictDao.getDictLabel(new Dict(bug.getCategory(), "bug_category")));
		bug.setStatusLabel(dictDao.getDictLabel(new Dict(bug.getStatus(), "bug_status")));
		bug.setPublisher(userDao.getUserById(bug.getPublisherId()).getName());
		bug.setProName(projectDao.getProjectById(bug.getProId()).getName());
		return bug;
	}

	@Override
	public Bug getBugByDesignation(String designation) {
		Bug bug =bugDao.getBugByDesignation(designation);
		bug.setOsLabel(dictDao.getDictLabel(new Dict(bug.getOs(),"bug_os")));
		bug.setPriorityLabel(dictDao.getDictLabel(new Dict(bug.getPriority(),"bug_priority")));
		bug.setCategoryLabel(dictDao.getDictLabel(new Dict(bug.getCategory(), "bug_category")));
		bug.setStatusLabel(dictDao.getDictLabel(new Dict(bug.getStatus(), "bug_status")));
		bug.setPublisher(userDao.getUserById(bug.getPublisherId()).getName());
		bug.setProName(projectDao.getProjectById(bug.getProId()).getName());
		return bug;
	}

	@Override
	public int updateBugById(Bug bug) {
		bug.setUpdateDate(new Date());
		return bugDao.updateBugById(bug);
	}

	@Override
	public int delete(Integer id) {
		
		return bugDao.delete(id);
	}

	@Override
	public List<Bug> getBugListByUserId(Map<String, Object> map) {
		List<Bug> bugs=bugDao.getBugListByUserId(map);
		
		for(int i=0;i<bugs.size();i++){
			Bug bug=bugs.get(i);
//			bug.setOsLabel(dictDao.getDictLabel(new Dict(bugs.get(i).getOs(),"bug_os")));
			bug.setPriorityLabel(dictDao.getDictLabel(new Dict(bugs.get(i).getPriority(),"bug_priority")));
			bug.setCategoryLabel(dictDao.getDictLabel(new Dict(bug.getCategory(), "bug_category")));
			bug.setStatusLabel(dictDao.getDictLabel(new Dict(bug.getStatus(), "bug_status")));
			bug.setPublisher(userDao.getUserById(bug.getPublisherId()).getName());
			bug.setProName(projectDao.getProjectById(bug.getProId()).getName());
		}
		return bugs;
	}

	@Override
	public List<Bug> getBugByUIDAndStatus(Integer userId, String status) {
		List<Bug> bugs=bugDao.getBugByUIDAndStatus(userId, status);
		if (bugs.size()>0) {
		for(int i=0;i<bugs.size();i++){
			Bug bug=bugs.get(i);
			bug.setOsLabel(dictDao.getDictLabel(new Dict(bugs.get(i).getOs(),"bug_os")));
			bug.setPriorityLabel(dictDao.getDictLabel(new Dict(bugs.get(i).getPriority(),"bug_priority")));
			bug.setCategoryLabel(dictDao.getDictLabel(new Dict(bug.getCategory(), "bug_category")));
			bug.setStatusLabel(dictDao.getDictLabel(new Dict(bug.getStatus(), "bug_status")));
			bug.setPublisher(userDao.getUserById(bug.getPublisherId()).getName());
			bug.setProName(projectDao.getProjectById(bug.getProId()).getName());
		}
		}
		return bugs;
	}

	@Override
	public int getBugListCountByUserId(Map<String, Object> map) {
		return bugDao.getBugListCountByUserId(map);
	}

	@Override
	public List<Bug> getBugsByPID(Integer userId) {
		
		List<Bug> bugs=bugDao.getBugsByPID(userId);
		if (bugs.size()>0) {
		for(int i=0;i<bugs.size();i++){
			Bug bug=bugs.get(i);
			bug.setOsLabel(dictDao.getDictLabel(new Dict(bugs.get(i).getOs(),"bug_os")));
			bug.setPriorityLabel(dictDao.getDictLabel(new Dict(bugs.get(i).getPriority(),"bug_priority")));
			bug.setCategoryLabel(dictDao.getDictLabel(new Dict(bug.getCategory(), "bug_category")));
			bug.setStatusLabel(dictDao.getDictLabel(new Dict(bug.getStatus(), "bug_status")));
			bug.setPublisher(userDao.getUserById(bug.getPublisherId()).getName());
			bug.setProName(projectDao.getProjectById(bug.getProId()).getName());
		}
		}
		return bugs;
	}

	@Override
	public List<Bug> getBugsByUID(Integer Id) {
		List<BugFeedback>feedbacks= bugFeedbackDao.getBugIDS(Id);
		List<Bug> bugs=new ArrayList<>();
		if (feedbacks.size()>0) {
			
		for (int i = 0; i < feedbacks.size(); i++) {
			Bug bug=bugDao.getBugById(feedbacks.get(i).getBugId());
			//bug.setOsLabel(dictDao.getDictLabel(new Dict(bugs.get(i).getOs(),"bug_os")));
			bug.setPriorityLabel(dictDao.getDictLabel(new Dict(bug.getPriority(),"bug_priority")));
		//	bug.setCategoryLabel(dictDao.getDictLabel(new Dict(bug.getCategory(), "bug_category")));
			bug.setStatusLabel(dictDao.getDictLabel(new Dict(bug.getStatus(), "bug_status")));
			bug.setPublisher(userDao.getUserById(bug.getPublisherId()).getName());
			bug.setProName(projectDao.getProjectById(bug.getProId()).getName());
			bugs.add(bug);
		}
		}
		return bugs;
	}


}
