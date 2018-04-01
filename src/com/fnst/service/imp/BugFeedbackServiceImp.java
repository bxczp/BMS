package com.fnst.service.imp;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fnst.dao.BugFeedbackDao;
import com.fnst.dao.UserDao;
import com.fnst.entity.BugFeedback;
import com.fnst.service.BugFeedbackService;

/** 
* @author 作者: dengsl.jy
* @version 创建时间：2017/08/09 21:27:04 
* 类说明 :
*/
@Service("bugFeedbackService")
public class BugFeedbackServiceImp  implements BugFeedbackService{
	@Resource
	private BugFeedbackDao bugFeedbackDao;
	@Resource
	private UserDao userDao;
	@Override
	public Integer insert(BugFeedback bugFeedback) {
		bugFeedback.setCreateDate(new Date());
		bugFeedback.setUpdateDate(new Date());
		return bugFeedbackDao.insert(bugFeedback);
	}

	@Override
	public List<BugFeedback> getFeedbackListByBID(Integer bugId) {
		List<BugFeedback> bugFeedbacks=bugFeedbackDao.getFeedbackListByBID(bugId);
	for (BugFeedback bugFeedback : bugFeedbacks) {
		bugFeedback.setUserName(userDao.getUserById(bugFeedback.getUserId()).getName());
	}
		return bugFeedbacks;
	}

	@SuppressWarnings("null")
	@Override
	public BugFeedback getMAXFID() {
		BugFeedback bugFeedback=bugFeedbackDao.getMAXFID();
		if (bugFeedback==null) {
			bugFeedback=new BugFeedback();
			bugFeedback.setId(0);
		}
		return bugFeedback;
	}

	@Override
	public List<BugFeedback> getBugIDS(Integer userId) {
		
		return bugFeedbackDao.getBugIDS(userId);
	}

}
