package com.fnst.service.imp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fnst.dao.UserDao;
import com.fnst.entity.User;
import com.fnst.service.UserService;

@Service("userService")
public class UserServiceImp implements UserService {

	@Resource
	private UserDao userDao;

	@Override
	public List<User> getUserList(Map<String, Object> map) {
		return userDao.getUserList(map);
	}

	@Override
	public int getUserListCount(Map<String, Object> map) {
		return userDao.getUserListCount(map);
	}

	@Override
	public User getAdminByUserId(int userId) {
		return userDao.getAdminByUserId(userId);
	}
	
	
	@Override
	public User getUserById(int id) {
		User user = userDao.getUserById(id);
		return user;
	}

	@Override
	public int 	updateUserPWD(User user){
		int count = userDao.updateUserPWD(user);
		return count;
	}
	@Override
	public int addUser(User user){
		int count= userDao.addUser(user);
		return count;
	}

	@Override
	public int deleteUser(int userId) {
		return userDao.deleteUser(userId);
	}

	@Override
	public int updateUser(Map<String, Object> map) {
		return userDao.updateUser(map);
	}

	@Override
	public List<Integer> getLeaderIdByLeaderName(HashMap<String, Object> map) {
		return userDao.getLeaderIdByLeaderName(map);
	}

	@Override
	public User checkLogin(User user) {
		return userDao.checkLogin(user);
	}

	@Override
	public List<User> getUserListByPID(Integer pId) {
		
		return userDao.getUserListByPID(pId);
	}


	@Override
	public int checkUserIsExist(String IdNo) {
		return userDao.checkUserIsExist(IdNo);
	}

	@Override
	public int checkUserNameIsExist(String name) {
		return userDao.checkUserNameIsExist(name);
	}

	

	

}
