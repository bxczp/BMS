package com.fnst.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fnst.entity.User;

public interface UserService {

	public List<User> getUserList(Map<String, Object> map);
	public int getUserListCount(Map<String,Object> map);
	public int deleteUser(int userId);
	public int updateUser(Map<String, Object> map);
	public User getAdminByUserId(int userId);
	
	public User checkLogin(User user);
	public User getUserById(int id);
	
	public int 	updateUserPWD(User user);
	
	public int addUser(User user);

	public List<Integer> getLeaderIdByLeaderName(HashMap<String, Object> map);

	public List<User> getUserListByPID(Integer pId); 
	

	public int checkUserIsExist(String IdNo);
	public int checkUserNameIsExist(String name);

}
