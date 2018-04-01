package com.fnst.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.fnst.entity.Bug;
import com.fnst.entity.BugChangeLog;
import com.fnst.service.BugChangeLogService;
import com.fnst.service.BugService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:*.xml"})
public class BugTest {


	@Autowired
private BugService bugService;
	@Autowired
	private BugChangeLogService changeLogService;

	@Test
	public void testMyBatis(){
	}
	
	/**
	 * list
	 */
	
	@Test
	public void getBugListByPID(){
			
	List<Bug> bugs=	bugService.getBugListByPID(1);
	System.out.println(bugs.size());
	
	}
	/**
	 * get
	 */
	@Test
	public void getBug(){
		
		Bug bug=bugService.getBugById(25);
		System.out.println(bug);
		
	}
	/**
	 * 插入历史记录
	 */
@Test
public void ChangLogInserttest(){
	BugChangeLog changeLog=new BugChangeLog();
	changeLog.setBugId(25);
	changeLog.setUserId(1);
	changeLog.setChangeType("状态变更");
	int res=changeLogService.insert(changeLog);
	
}
/**
 * 获取bug的修正记录
 */
@Test
public void getChangeL(){
	System.out.println(changeLogService.getChangeLogByBID(26).size());
}
@Test
public void getBugByDesignation(){
	System.out.println(bugService.getBugByDesignation("0000086"));
	
}

@Test
public void getBugsByUIDAndStatus(){
	System.out.println(bugService.getBugByUIDAndStatus(209,"2").size());
}


}
