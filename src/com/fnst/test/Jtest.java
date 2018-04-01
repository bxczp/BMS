package com.fnst.test;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.fnst.entity.BugFeedback;
import com.fnst.entity.Project;
import com.fnst.entity.User;
import com.fnst.service.BugFeedbackService;
import com.fnst.service.ProjectService;
import com.fnst.service.UserService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:*.xml"})
public class Jtest {

	@Autowired
	private DataSource dataSource;
	@Autowired
	private UserService userService;
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private BugFeedbackService bugFeedbackService;

	@Test
	public void testListM(){
		
		List<Project> projects=projectService.getProListByUID(2);
		System.out.println(projects.size());
		
	}
	
	
	@Test
	public void testListSA(){
		
		List<Project> projects=projectService.getProjectListByLeaderId(1);
		System.out.println(projects.size());
		
	}
	
	@Test
	public void testListS(){
		
		List<Project> projects=projectService.getProjectListAll();
		System.out.println(projects.size());
		
	}
	
	@Test
	public void testDatasource() {
		try {
			System.out.println(dataSource.getConnection());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Test
	public void insertFeedback(){
		BugFeedback bugFeedback=new BugFeedback();
		bugFeedback.setBugId(26);
		bugFeedback.setNoteCode("0000001");
		bugFeedback.setNoteDescription("该问题无需修正");
		bugFeedback.setUserId(1);
		
	int res=	bugFeedbackService.insert(bugFeedback);
	System.out.println(res);
		
	}
	
	@Test
	public void getFeedback(){
	List<BugFeedback> bugFeedbacks=	bugFeedbackService.getFeedbackListByBID(26);
	System.out.println(bugFeedbacks.size());
	}
	
	@Test
	public void getNoteCode(){
		System.out.println(bugFeedbackService.getMAXFID().getId());
	}
	@Test
	public void getStatusCount(){
		System.out.println(projectService.getStatusCount("1",2));
	}
	@Test
	public void getDD(){
		System.out.println(bugFeedbackService.getBugIDS(1).size());
	}
	

}
