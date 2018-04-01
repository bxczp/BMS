package com.fnst.test;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.fnst.entity.Dict;
import com.fnst.service.DictService;
import com.fnst.service.UserService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:*.xml"})
public class DictTest {

	@Autowired
	private DataSource dataSource;
	@Autowired
	private UserService userService;
	@Autowired
	private DictService dictService;

	@Test
	public void testMyBatis(){
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
	/**
	 * list
	 */
	
	@Test
	public void getDictList(){
		
	List<Dict> list=	dictService.getDictList();
	for (int i = 0; i < list.size(); i++) {
		System.out.println(list.get(i).toString());
	}
	
	}
/**
 * 增加字典
 */
	@Test
	public void addDict(){
		Dict dict=new Dict();
		dict.setValue("1");
		dict.setLabel("win7");
		dict.setDescription("操作系统");
		dict.setType("bug_os");
		dict.setCreateDate(new Date());
		dict.setUpdateDate(new Date());
		int result=dictService.insert(dict);
		System.out.println(result);
	}
	/**
	 * 删除字典
	 */
	@Test
	public void del(){
		int result=dictService.delDictByID(6);
		System.out.println(result);
	}
	/**
	 * 修改字典
	 */
	@Test
	public void update(){
		Dict dict=dictService.getDictListByID(7);
		dict.setRemark("我就只想看看能不能修改");
		
		dictService.updateDictByID(dict);
		
	}
	
	/**
	 * 根据type 和value 查询label
	 */
	@Test
	public void getDictLabel(){
	
			Dict dict=new Dict();
			dict.setValue("1");
			dict.setType("bug_status");
			String label=dictService.getDictLabel(dict);
			System.out.println(label);
	}
}
