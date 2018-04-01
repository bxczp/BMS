package com.fnst.dao;

import java.util.List;

import com.fnst.entity.BugFeedback;

/** 
* @author 作者: dengsl.jy
* @version 创建时间：2017/08/09 21:22:54 
* 类说明 :
*/
public interface BugFeedbackDao {
	public Integer insert(BugFeedback bugFeedback);
	public List<BugFeedback> getFeedbackListByBID(Integer bugId);
	public BugFeedback getMAXFID();
	public List<BugFeedback> getBugIDS(Integer userId);

}
