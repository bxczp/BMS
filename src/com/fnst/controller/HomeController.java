package com.fnst.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fnst.entity.Bug;
import com.fnst.entity.PageBean;
import com.fnst.entity.Project;
import com.fnst.entity.User;
import com.fnst.service.BugService;
import com.fnst.service.ProjectService;
import com.fnst.service.ProjectUserService;
import com.fnst.service.UserService;
import com.fnst.util.PropertiesUtil;
import com.fnst.util.StringUtil;

@Controller
public class HomeController {


	@Resource
	private ProjectService projectService; 
	@Resource
	private ProjectUserService projectUserService;
	@Resource
	private UserService userService;
	@Resource
	private BugService bugService;
	
	@RequestMapping({"/login", "/"})
	public ModelAndView login() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("user/index");
		return modelAndView;
	}
	
	@RequestMapping("/getLogin")
	public ModelAndView getLogin() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("user/login");
		return modelAndView;
	}

	@RequestMapping("/home")
	public ModelAndView index(HttpServletRequest request, @RequestParam(required = false)String status, 
                              @RequestParam(required = false)String name, @RequestParam(required = false)String view) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession();
		User currentUser = (User) session.getAttribute("currentUser");
		if ("bug".equals(view)) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("userId", currentUser.getId());
			if (StringUtil.isNotEmpty(status)) {
				map.put("status", status);
			}
			PageBean pageBean = new PageBean(1, Integer.parseInt(PropertiesUtil.getValue("dashboradBugPageSize")));
			map.put("start", pageBean.getStart());
			map.put("size", pageBean.getPageSize());
			List<Bug> bugs = bugService.getBugListByUserId(map);
			modelAndView.addObject("bugs", bugs);
			modelAndView.addObject("status", status);
			modelAndView.addObject("bug", true);
		} else {
			Map<String, Object> map = new HashMap<String, Object>();
			PageBean pageBean = new PageBean(1, Integer.parseInt(PropertiesUtil.getValue("dashboradPageSize")));
			map.put("start", pageBean.getStart());
			map.put("size", pageBean.getPageSize());
			if (PropertiesUtil.getValue("roleAdmin").equals(currentUser.getRoleName())) {
				map.put("leader", currentUser.getId());
			} else if(PropertiesUtil.getValue("roleMember").equals(currentUser.getRoleName())) {
				map.put("userId", currentUser.getId());
				List<Integer> ids = projectUserService.getProjectIdsByUserId(map);
				map.put("ids", ids);
			} else if (PropertiesUtil.getValue("roleSuperAdmin").equals(currentUser.getRoleName())) {
			} else {
				modelAndView.addObject("projects", null);
				modelAndView.addObject("name", name);
				modelAndView.addObject("status", status);
				modelAndView.setViewName("/dashboard");
		        return modelAndView;
			}
			if (StringUtil.isNotEmpty(status)) {
				if (!PropertiesUtil.getValue("projectStatusOpened").equals(status)&&!PropertiesUtil.getValue("projectStatusClosed").equals(status)) {
					status = null;
				}
			}
			if (StringUtil.isEmpty(status)) {
				status = null;
			}
			if (StringUtil.isNotEmpty(name)) {
				map.put("name", StringUtil.formatLike(name));
			}
			if (StringUtil.isNotEmpty(status)) {
				map.put("status", status);
			}
			
			List<Project> projects = projectService.getProjectList(map);
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
			modelAndView.addObject("name", name);
			modelAndView.addObject("status", status);
	}
		modelAndView.setViewName("/dashboard");
        return modelAndView;
	}
	

	
	
}
