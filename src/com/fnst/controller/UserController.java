package com.fnst.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.fnst.entity.Bug;
import com.fnst.entity.PageBean;

import com.fnst.entity.Project;

import com.fnst.entity.User;
import com.fnst.service.BugService;
import com.fnst.service.ProjectService;
import com.fnst.service.ProjectUserService;
import com.fnst.service.UserService;
import com.fnst.util.PageUtil;
import com.fnst.util.PropertiesUtil;
import com.fnst.util.ResponseUtil;
import com.fnst.util.StringUtil;

import net.sf.json.JSONObject;

@RequestMapping("/user")
@Controller
//@SessionAttributes("currentUser")
public class UserController {
	@Resource
	private UserService userService;
	@Resource
	private ProjectUserService projectUserService;
	@Resource
	private ProjectService projectService;
	@Resource
	private BugService bugService;
	
	/**
	 * 登陆
	 * @param request
	 * @param roleName
	 * @param name
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/login")
	public ModelAndView login(String idNo, String password, HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		if (StringUtil.isEmpty(password) || StringUtil.isEmpty(idNo)) {
			modelAndView.setViewName("user/index");
			return modelAndView;
		}
		User user=new User();
		user.setIdNo(idNo);
		user.setPassword(password);
		User currentUser = userService.checkLogin(user);
		if (currentUser != null) {
			HttpSession session = request.getSession();
			currentUser.setPassword(null);
			session.setAttribute("currentUser", currentUser);
			modelAndView.setViewName("redirect: "+ request.getContextPath() +"/home");
		} else {
			modelAndView.addObject("user", user);
			modelAndView.addObject("error", true);
			modelAndView.setViewName("user/login");
		}
		return modelAndView;
	}
	
	
	
	/**
	 * 用户管理
	 * @param request
	 * @param roleName
	 * @param name
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/manage")
	public ModelAndView getUserManageList(HttpServletRequest request, @RequestParam(required = false)String roleName, 
			                              @RequestParam(required = false)String name, @RequestParam(required = false)String page) throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		if (StringUtil.isNotEmpty(roleName)) {
			if (!PropertiesUtil.getValue("roleAdmin").equals(roleName)&&!PropertiesUtil.getValue("roleMember").equals(roleName)) {
				roleName = null;
			}
		}
		Map<String, Object> map = new HashMap<String, Object>();
		StringBuffer param = new StringBuffer();
		if (StringUtil.isNotEmpty(roleName)) {
			map.put("roleName", roleName);
			param.append("roleName="+roleName+"&");
		}
		if (StringUtil.isNotEmpty(name)) {
			param.append("name="+name);
			name = StringUtil.keywordHtmlEncode(name);
			map.put("name", StringUtil.formatLike(name));
		}
		if (StringUtil.isEmpty(page)) {
			page = "1";
		}
		int totalCount = userService.getUserListCount(map);
		if (StringUtil.isNotEmpty(page)) {
			if (Integer.parseInt(page) > totalCount) {
				page = "1";
			}
			if (!StringUtil.isInteger(page)) {
				page = "1";
			}
		}
		if (StringUtil.isEmpty(roleName)) {
			roleName = null;
		}
		PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(PropertiesUtil.getValue("userManagePageSize")));
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<User> users = userService.getUserList(map);
		String pageCode = PageUtil.genPagation("/user/manage",totalCount, Integer.parseInt(page), pageBean.getPageSize(), request, param.toString());
		modelAndView.addObject("roleName", roleName);
		modelAndView.addObject("name", name);
		modelAndView.addObject("users", users);
        modelAndView.addObject("pageCode", pageCode);
		modelAndView.setViewName("user/userManage");
		return modelAndView;
	}

	/**
	 * 删除用户
	 * @param userId
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/delete")
	public void deleteUser(String userId, HttpServletRequest request, HttpServletResponse response) throws Exception {
        JSONObject jsonObject = new JSONObject();
        int count = 0;
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        if (PropertiesUtil.getValue("roleSuperAdmin").equals(currentUser.getRoleName())){
        	if (StringUtil.isInteger(userId)) {
        		count = userService.deleteUser(Integer.parseInt(userId));
        	}
        }
        if (count > 0) {
            jsonObject.put("result", true);
        } else {
            jsonObject.put("result", false);
        }
        try {
            ResponseUtil.write(jsonObject, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	
	/**
	 * 更新用户
	 * @param userId
	 * @param roleName
	 * @param email
	 * @param name
	 * @param password
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/update")
	public void updateUser(String userId, @RequestParam(required = false)String roleName, @RequestParam(required = false)String email,
			               @RequestParam(required = false)String name, @RequestParam(required = false)String password,
			               HttpServletRequest request, HttpServletResponse response) throws Exception {
        JSONObject jsonObject = new JSONObject();
        int count =  0;
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("userId", userId);
        if (PropertiesUtil.getValue("roleSuperAdmin").equals(currentUser.getRoleName())){
            if (StringUtil.isInteger(userId)) {
            	if (PropertiesUtil.getValue("roleAdmin").equals(roleName)||PropertiesUtil.getValue("roleMember").equals(roleName)) {
            		map.put("roleName", roleName);
            	}
            }
        }
    	if (StringUtil.isInteger(userId)) {
    		if (Integer.parseInt(userId) == currentUser.getId()) {
    			if (StringUtil.isNotEmpty(name)) {
    				map.put("name", name);
    			}
    			if (StringUtil.isNotEmpty(email)) {
    				map.put("email", email);
    			}
    			if (StringUtil.isNotEmpty(password)) {
    				map.put("password", password);
    			}
    		}
    	}
        count = userService.updateUser(map);
        if (count > 0) {
            jsonObject.put("result", true);
        } else {
            jsonObject.put("result", false);
        }
        try {
            ResponseUtil.write(jsonObject, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
	}

	@RequestMapping("/getUserInfo")
	public ModelAndView getUserInfo(@RequestParam(required = false)String id, @RequestParam(required = false)String page, @RequestParam(required = false)String pageBug, HttpServletRequest request) throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		HashMap<String, Object> map = new HashMap<String, Object>();
		HashMap<String, Object> mapBug = new HashMap<String, Object>();
		HttpSession session = request.getSession();
		
		User user = null;
		if(StringUtil.isNotEmpty(id)){
			if(StringUtil.isInteger(id)){
				user=userService.getUserById(Integer.parseInt(id));
				if(user!=null){
					modelAndView.addObject("user", user);
				}
				mapBug.put("userId", id);
			}
		}	
		if(StringUtil.isEmpty(id)){
			user = userService.getUserById(((User) session.getAttribute("currentUser")).getId());
			user.setPassword(null);
			mapBug.put("userId", ((User)session.getAttribute("currentUser")).getId());
			session.removeAttribute("currentUser");
			session.setAttribute("currentUser", user);
			modelAndView.addObject("user", user);
		}

		if (PropertiesUtil.getValue("roleAdmin").equals(user.getRoleName())) {
			map.put("leader", user.getId());
		} else if(PropertiesUtil.getValue("roleMember").equals(user.getRoleName())) {
			map.put("userId", user.getId());
			List<Integer> ids = projectUserService.getProjectIdsByUserId(map);
			map.put("ids", ids);
		} else if (PropertiesUtil.getValue("roleSuperAdmin").equals(user.getRoleName())) {
		} else {
			modelAndView.addObject("projects", null);
			modelAndView.setViewName("user/userInfo");
	        return modelAndView;
		}
		int totalCount = projectService.getProjectListCount(map);
		int totalCountBug = bugService.getBugListCountByUserId(mapBug);
		if (StringUtil.isEmpty(page)) {
			page = "1";
		}
		if (StringUtil.isNotEmpty(page)) {
			if (Integer.parseInt(page) > totalCount) {
				page = "1";
			}
			if (!StringUtil.isInteger(page)) {
				page = "1";
			}
		}
		if (StringUtil.isEmpty(pageBug)) {
			pageBug = "1";
		}
		if (StringUtil.isNotEmpty(pageBug)) {
			if (Integer.parseInt(pageBug) > totalCountBug) {
				pageBug = "1";
			}
			if (!StringUtil.isInteger(pageBug)) {
				pageBug = "1";
			}
		}
		PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(PropertiesUtil.getValue("userInfoPageSize")));
		PageBean pageBeanBug = new PageBean(Integer.parseInt(pageBug), Integer.parseInt(PropertiesUtil.getValue("userInfoPageSize")));
		map.put("start", pageBean.getStart());
		mapBug.put("start", pageBeanBug.getStart());
		map.put("size", pageBean.getPageSize());
		mapBug.put("size", pageBean.getPageSize());
		String pageCode = "";
		String pageCodeBug = "";
		if(StringUtil.isEmpty(id))
		{
			pageCode = PageUtil.genPagation("/user/getUserInfo",totalCount, Integer.parseInt(page), pageBean.getPageSize(), request, "pageBug="+pageBug);
		}
		else
		{
			pageCode = PageUtil.genPagation("/user/getUserInfo",totalCount, Integer.parseInt(page), pageBean.getPageSize(), request,"id="+user.getId()+"&pageBug="+pageBug);
		}
		if(StringUtil.isEmpty(id))
		{
			pageCodeBug = PageUtil.genPagationBug("/user/getUserInfo",totalCountBug, Integer.parseInt(pageBug), pageBean.getPageSize(), request, "page="+page);
		}
		else
		{
			pageCodeBug = PageUtil.genPagationBug("/user/getUserInfo",totalCountBug, Integer.parseInt(pageBug), pageBean.getPageSize(), request,"id="+user.getId()+"&page="+page);
		}
		List<Project> projects = projectService.getProjectList(map);
		List<Bug> bugs = bugService.getBugListByUserId(mapBug);
		if (projects.size() != 0) {
			for (Project p : projects) {
				List<Integer> memberIds = projectUserService.getMemberIdsByProjectId(p.getId());
				Map<String, Object> m = new HashMap<String, Object>();
				m.put("ids", memberIds);
				List<User> members = userService.getUserList(m);
				p.setMembers(members);
				User admin = userService.getAdminByUserId(p.getLeader());
				p.setAdmin(admin);
			}
		}
		modelAndView.addObject("projects", projects);
		modelAndView.addObject("bugs", bugs);
		modelAndView.setViewName("user/userInfo");
		modelAndView.addObject("pageCode", pageCode);
		modelAndView.addObject("pageCodeBug", pageCodeBug);
		return modelAndView;
}
	
	@RequestMapping("/updatePWD")
	@ResponseBody
	public boolean updateUserPWD(String firstPWD,String newPWD,String confirmPWD,HttpServletRequest request, HttpServletResponse response)throws Exception{
		boolean flag=false;
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("currentUser");
		String password = request.getParameter("firstPWD");
		User olduser =  userService.getUserById(user.getId());
		if(olduser.getPassword().equals(password))
		{
			olduser.setPassword(newPWD);
			int result =userService.updateUserPWD(olduser);
			if(result>0){
				session.removeAttribute("currentUser");
				flag=true;
			}else{
				flag=false;
			}
		}
		return flag;
	}

	@RequestMapping("/register")
	public String register(HttpServletRequest request, HttpServletResponse response){

		return "user/register";
		
	}
	
	@RequestMapping("/registerUser")
	@ResponseBody
    public boolean registerUser(HttpServletRequest request, HttpServletResponse response,User user) throws Exception{	
		/**
		 * 添加用户信息
		 * user
		 */
		boolean f = false;
		user.setRoleName(PropertiesUtil.getValue("roleMember"));
		user.setCreateDate(new Date());
		int result=	userService.addUser(user);
		if (result>0) {
			f=true;
		}
			return f;
			
		}

	@RequestMapping("/getUserListByPid")
	@ResponseBody
	public List<User> getUserListByPID(@RequestParam Integer pId,HttpServletRequest request,HttpServletResponse response){
		
		
		return userService.getUserListByPID(pId);
		
	}

	@RequestMapping("/logout")
	public String loginOut(HttpServletRequest request,HttpServletResponse response)
	{	
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect: "+request.getContextPath()+"/login";
	}

	
	@RequestMapping("/logincheckUserID")
	@ResponseBody
	public String logincheckUserID(HttpServletRequest request){
		String IdNo=request.getParameter("idNo");
		JSONObject jsonObject=new JSONObject();
		if (userService.checkUserIsExist(IdNo)>0) {
			jsonObject.put("valid", true);
		}
		else {
			jsonObject.put("valid", false);
		}
		return jsonObject.toString();
	}
	
	@RequestMapping("/checkUserName")
	@ResponseBody
	public String checkUserName(HttpServletRequest request){
		String name=request.getParameter("name");
		JSONObject jsonObject=new JSONObject();
		if (userService.checkUserNameIsExist(name)>0) {
			jsonObject.put("valid", false);
		}
		else {
			jsonObject.put("valid", true);
		}
		return jsonObject.toString();
		
	}
	

	@RequestMapping("/getAdminList")
	@ResponseBody
	public List<User> getAdminList(@RequestParam(required = false)String name, HttpServletResponse response) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("roleName", PropertiesUtil.getValue("roleAdmin"));
		if (StringUtil.isNotEmpty(name)) {
			map.put("name", StringUtil.formatLike(name));
		}
		map.put("start", 0);
		map.put("size", Integer.parseInt(PropertiesUtil.getValue("projectAddAdminPageSize")));
		List<User> adminList = userService.getUserList(map);
		return adminList;
	}
	
	@RequestMapping("/getMemberList")
	@ResponseBody
	public List<User> getMemberList(@RequestParam(required = false)String name, String proId, HttpServletResponse response) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("roleName", PropertiesUtil.getValue("roleMember"));
		if (StringUtil.isNotEmpty(name)) {
			map.put("name", StringUtil.formatLike(name));
		}
		map.put("start", 0);
		map.put("size", Integer.parseInt(PropertiesUtil.getValue("projectAddMemberPageSize")));
		List<User> memberList = userService.getUserList(map);
		if (StringUtil.isNotEmpty(proId)) {
			List<Integer> ids = projectUserService.getMemberIdsByProjectId(Integer.parseInt(proId));
			if (memberList.size() != 0) {
				for (int i = 0; i<memberList.size(); i++) {
					if (ids.contains(memberList.get(i).getId())) {
						memberList.remove(i);
						i--;
					}
				}
			}
		}
		return memberList;
	}
/**
 * 验证哟工号是否存在
 * @param request
 * @param response
 * @return
 */
	
	@RequestMapping(value="/checkIDNoExist")
	@ResponseBody
	public String checkIDNoExist(HttpServletRequest request,HttpServletResponse response){
		String idNo=request.getParameter("idNo");
		JSONObject jsonObject=new JSONObject();
		if (userService.checkUserIsExist(idNo)>0) {
		
			
			jsonObject.put("valid", false);
		}
		else {
			jsonObject.put("valid", true);
		}
		
	
		return jsonObject.toString();
		
	}
	
	@RequestMapping("/appLogin")
	@ResponseBody
	public boolean appLogin(HttpServletRequest request,HttpServletResponse response,@RequestParam String idNo,@RequestParam String password){
		boolean result=false;
		User user=new User();
		user.setIdNo(idNo);
		user.setPassword(password);
		User currentUser = userService.checkLogin(user);
		if (currentUser!=null) {
			result=true;
			HttpSession session = request.getSession();
			currentUser.setPassword(null);
			session.setAttribute("currentUser", currentUser);
		}
		return result;
		
	}
}

