package com.fnst.service;

import java.util.List;

import com.fnst.entity.BugFeedback;

/** 
* @author 作者: dengsl.jy
* @version 创建时间：2017/08/09 21:26:30 
* 类说明 :
*/
public interface BugFeedbackService {
	Integer insert(BugFeedback bugFeedback);
	public List<BugFeedback> getFeedbackListByBID(Integer bugId);
	public BugFeedback getMAXFID();
	public List<BugFeedback> getBugIDS(Integer userId);
}
