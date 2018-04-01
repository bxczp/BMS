package com.fnst.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fnst.entity.Bug;
import com.fnst.entity.BugAnalysis;
import com.fnst.entity.Dict;
import com.fnst.entity.PageBean;
import com.fnst.entity.Project;
import com.fnst.entity.User;
import com.fnst.service.BugService;
import com.fnst.service.DictService;
import com.fnst.service.ProjectService;
import com.fnst.service.ProjectUserService;
import com.fnst.service.UserService;
import com.fnst.util.DateUtil;
import com.fnst.util.PageUtil;
import com.fnst.util.PropertiesUtil;
import com.fnst.util.ResponseUtil;
import com.fnst.util.StringUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/project")
public class ProjectController {
	@Resource
	private ProjectService projectService;
	@Resource
	private ProjectUserService projectUserService;
	@Resource
	private UserService userService;
	@Resource
	private BugService bugService;
	@Resource
	private DictService DictService;

	/**
	 * 项目管理
	 * @param status
	 * @param name
	 * @param leaderName
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/manage")
	public ModelAndView getProjectManageList(@RequestParam(required = false) String status, @RequestParam(required = false) String page,
		                                   	@RequestParam(required = false) String name, @RequestParam(required = false) String leaderName,
    	                                    HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		HttpSession session = request.getSession();
		User currentUser = (User) session.getAttribute("currentUser");

		StringBuffer param = new StringBuffer();

		List<Integer> ids=new ArrayList<Integer>();
		if (PropertiesUtil.getValue("roleAdmin").equals(currentUser.getRoleName())) {
			ids.add(currentUser.getId());
			map.put("leader", ids);
		}

		if(currentUser !=null){
			if (PropertiesUtil.getValue("roleAdmin").equals(currentUser.getRoleName())) {
				map.put("useId",currentUser.getId());
				List<Integer> projectIds=projectUserService.getProjectIdsByUserId(map);
				map.put("projectIds", projectIds);
			}
		}
		if (StringUtil.isNotEmpty(name)) {
			map.put("name", StringUtil.formatLike(StringUtil.keywordHtmlEncode(name)));
			param.append("name="+name+"&");
		}
		if (StringUtil.isNotEmpty(leaderName)) {
			if (ids.size()==0) {
				map.put("leaderName", StringUtil.formatLike(leaderName));
				ids = userService.getLeaderIdByLeaderName(map);
				map.put("leader", ids);	
			}
			
			param.append("leaderName="+leaderName+"&");
		}
		if (StringUtil.isEmpty(status)) {
			status = null;
		}
		if (StringUtil.isNotEmpty(status)) {
			if (StringUtil.isInteger(status)) {
				if (Integer.parseInt(status) != 1 && Integer.parseInt(status) != 2) {
					status = null;
				}
			} else {
				status = null;
			}
		}
		if (StringUtil.isNotEmpty(status)) {
			map.put("status", status);
			param.append("status="+status+"&");
		}
		if (StringUtil.isEmpty(page)) {
			page = "1";
		}
		int totalCount = projectService.getProjectManageListCount(map);
		if (StringUtil.isNotEmpty(page)) {
			if (Integer.parseInt(page) > totalCount) {
				page = "1";
			}
			if (!StringUtil.isInteger(page)) {
				page = "1";
			}
		}
		PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(PropertiesUtil.getValue("projectManagePageSize")));
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		
		int allSize = totalCount;
		int duringSize = 0;
		int finishSize = 0;
		List<Project> projects = projectService.getProjectManageList(map);
		map.remove("start");
		map.remove("size");
		List<Project> projectsNoPage = projectService.getProjectManageList(map);
		for(Project p : projectsNoPage) {
			if (p.getStatus() == 1) {
				duringSize++;
			}
			if (p.getStatus() == 2) {
				finishSize++;
			}
		}
		String pageCode = PageUtil.genPagation("/project/manage",totalCount, Integer.parseInt(page), pageBean.getPageSize(), request, param.toString());
		if (projects.size() != 0) {
			for (Project p : projects) {
				List<Integer> memberIds = projectUserService.getMemberIdsByProjectId(p.getId());
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("ids", memberIds);
				List<User> members = userService.getUserList(m);
				p.setMembers(members);
				User admin = userService.getAdminByUserId(p.getLeader());
				p.setAdmin(admin);
			}
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("project/projectManage");
		modelAndView.addObject("status", status);
		modelAndView.addObject("name", name);
		modelAndView.addObject("projects", projects);
		modelAndView.addObject("allSize", allSize);
		modelAndView.addObject("finishSize", finishSize);
		modelAndView.addObject("duringSize", duringSize);
		modelAndView.addObject("pageCode", pageCode);
		modelAndView.addObject("leaderName", leaderName);
		return modelAndView;
	}

	
	/**
	 * 项目详情
	 * @param proId
	 * @param designation
	 * @param page
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/detail")
	public ModelAndView getProjectDetail(String proId, @RequestParam(required = false) String designation,
			@RequestParam(required = false) String page, HttpServletRequest request) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		Project project = null;
		if (StringUtil.isNotEmpty(proId)) {
			if (StringUtil.isInteger(proId)) {
				project = projectService.getProjectById(Integer.parseInt(proId));
			}
		}
		String pageCode = null;
		StringBuffer param = new StringBuffer();
		param.append("proId=" + proId + "&");
		if (project != null) {
			List<Integer> memberIds = projectUserService.getMemberIdsByProjectId(project.getId());
			Map<String, Object> m = new HashMap<String, Object>();
			m.put("ids", memberIds);
			List<User> members = userService.getUserList(m);
			project.setMembers(members);
			User admin = userService.getAdminByUserId(project.getLeader());
			project.setAdmin(admin);
			m.put("proId", project.getId());
			if (StringUtil.isEmpty(page)) {
				page = "1";
			}
			if (StringUtil.isNotEmpty(designation)) {
				m.put("designation", StringUtil.formatLike(StringUtil.keywordHtmlEncode(designation)));
				param.append("designation=" + designation + "&");
			}
			int totalCount = bugService.getBugListCountByProjectId(m);
			if (StringUtil.isNotEmpty(page)) {
				if (Integer.parseInt(page) > totalCount) {
					page = "1";
				}
				if (!StringUtil.isInteger(page)) {
					page = "1";
				}
			}
			PageBean pageBean = new PageBean(Integer.parseInt(page),
					Integer.parseInt(PropertiesUtil.getValue("projectDetailPageSize")));
			m.put("start", pageBean.getStart());
			m.put("size", pageBean.getPageSize());
			List<Bug> bugs = bugService.getBugListByProjectId(m);
			project.setBugs(bugs);
			pageCode = PageUtil.genPagation("/project/detail", totalCount, Integer.parseInt(page),
					pageBean.getPageSize(), request, param.toString());
		}
		modelAndView.addObject("project", project);
		modelAndView.addObject("designation", designation);
		if (StringUtil.isNotEmpty(pageCode)) {
			modelAndView.addObject("pageCode", pageCode);
		}
		modelAndView.setViewName("project/projectDetail");
		return modelAndView;
	}

	/**
	 * 添加组长
	 * @param proId
	 * @param userId
	 * @param response
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping("/addAdmin")
	public void addAdmin(String proId, String userId, HttpServletResponse response, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		User currentUser = (User) session.getAttribute("currentUser");
		JSONObject result = new JSONObject();
		Map<String, Object> map = new HashMap<String, Object>();
		if (PropertiesUtil.getValue("roleSuperAdmin").equals(currentUser.getRoleName())) {
			map.put("userId", userId);
			map.put("proId", proId);
			int count = projectService.addProjectAdmin(map);
			if (count > 0) {
				result.put("result", true);
			} else {
				result.put("result", false);
			}
		} else {
			result.put("result", false);
		}
		ResponseUtil.write(result, response);
	}

	/**
	 * 添加组员
	 * @param proId
	 * @param userId
	 * @param response
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping("/addMember")
	public void addMember(String proId, String userId, HttpServletResponse response, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		User currentUser = (User) session.getAttribute("currentUser");
		Map<String, Object> map = new HashMap<String, Object>();
		JSONObject result = new JSONObject();
		if (PropertiesUtil.getValue("roleSuperAdmin").equals(currentUser.getRoleName()) ||  PropertiesUtil.getValue("roleAdmin").equals(currentUser.getRoleName()) ) {
			map.put("userId", userId);
			map.put("proId", proId);
			map.put("createDate", DateUtil.formatDate(new Date(), "yyyy-MM-dd hh:mm:ss"));
			if (StringUtil.isEmpty(proId)) {
				result.put("result", false);
			} else {
				int count = projectUserService.addProjectMember(map);
				if (count > 0) {
					result.put("result", true);
				} else {
					result.put("result", false);
				}
			}
		} else {
			result.put("result", false);
		}
		ResponseUtil.write(result, response);
	}
	
	/**
	 * 删除组员
	 * @param proId
	 * @param userId
	 * @param response
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping("/deleteMember")
	public void deleteMember(String proId, String userId, HttpServletResponse response, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		User currentUser = (User) session.getAttribute("currentUser");
		Map<String, Object> map = new HashMap<String, Object>();
		JSONObject result = new JSONObject();
		if (PropertiesUtil.getValue("roleSuperAdmin").equals(currentUser.getRoleName()) ||  PropertiesUtil.getValue("roleAdmin").equals(currentUser.getRoleName()) ) {
			map.put("userId", userId);
			map.put("proId", proId);
			if (StringUtil.isEmpty(proId)) {
				result.put("result", false);
			} else {
				int count = projectUserService.deleteProjectMember(map);
				if (count > 0) {
					result.put("result", true);
				} else {
					result.put("result", false);
				}
			}
		} else {
			result.put("result", false);
		}
		ResponseUtil.write(result, response);
	}

	/**
	 * 跳转页面
	 * @param proId
	 * @return
	 */
	@RequestMapping("/preSave")
	public ModelAndView getPreSave(@RequestParam(required = false)String proId) {
		ModelAndView modelAndView = new ModelAndView();
		if (StringUtil.isNotEmpty(proId)) {
			if (StringUtil.isInteger(proId)) {
				Project project = projectService.getProjectById(Integer.parseInt(proId));
				if (project != null) {
					List<Integer> memberIds = projectUserService.getMemberIdsByProjectId(project.getId());
					Map<String, Object> m = new HashMap<String, Object>();
					m.put("ids", memberIds);
					List<User> members = userService.getUserList(m);
					project.setMembers(members);
					User admin = userService.getAdminByUserId(project.getLeader());
					project.setAdmin(admin);
					modelAndView.addObject("project", project);
				}
				modelAndView.addObject("edit", true);
			}
		}
		modelAndView.setViewName("project/projectSave");
		return modelAndView;
	}
	
	/**
	 * 更新项目为已完成
	 * @param proId
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/updateComplete")
	public void updateUser(String proId, HttpServletRequest request, HttpServletResponse response) throws Exception {
        JSONObject jsonObject = new JSONObject();
        int count =  0;
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("proId", proId);
        if (PropertiesUtil.getValue("roleSuperAdmin").equals(currentUser.getRoleName())){
        	map.put("status", 2);
        	count = projectService.updateProject(map);
        } else {
        	jsonObject.put("result", false);
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
	 * 保存项目
	 * @param proId
	 * @param response
	 * @param description
	 * @param name
	 * @param leaderId
	 * @param memberIds
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping("/save")
	public void saveProject(@RequestParam(required=false)String proId, HttpServletResponse response,
			                String description, String name, String leaderId, String memberIds, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		User currentUser = (User) session.getAttribute("currentUser");
		Map<String, Object> map = new HashMap<String, Object>();
		int count = 0;
		map.put("createDate", DateUtil.formatDate(new Date(), "yyyy-MM-dd hh:mm:ss"));
		JSONObject result = new JSONObject();
		if (!PropertiesUtil.getValue("roleSuperAdmin").equals(currentUser.getRoleName())) {
			result.put("result", false);
		} else {
			map.put("name", name);
			map.put("description", description);
			map.put("leaderId", leaderId);
			map.put("status", 1);
			if (StringUtil.isEmpty(proId)) { 
				// 添加操作
				Project project = new Project();
				project.setDescription(description);
				project.setStatus(1);
				project.setName(name);
				project.setLeader(Integer.parseInt(leaderId));
				project.setCreateDate(new Date());
				count = projectService.addProject(project);
				map.put("proId", project.getId());
				if (StringUtil.isNotEmpty(memberIds)) {
					String[] ids = memberIds.split(",");
					for (String s : ids) {
						map.put("userId", s);
						count = projectUserService.addProjectMember(map);
					}
				}
			} else {
				// 更新操作
				map.put("proId", proId);
				count = projectService.updateProject(map);
			}
			if (count > 0) {
				result.put("result", true);
			} else {
				result.put("result", false);
			}
		}
		ResponseUtil.write(result, response);
	}
	@RequestMapping("analysis")
	@ResponseBody
	public List<BugAnalysis> analysis(HttpServletResponse response,HttpServletRequest request,@RequestParam Integer proId){
	Project project=projectService.getProjectById(proId);
	List<BugAnalysis> analysis=new ArrayList<>();
    List<Dict> dicts=	DictService.getDictListByType("bug_status");
	for (int i = 0; i < dicts.size(); i++)
	{
		BugAnalysis analy=new BugAnalysis();
		analy.setTypeLabel(dicts.get(i).getLabel());
		analy.setCount(projectService.getStatusCount(dicts.get(i).getValue(),proId));
		analysis.add(analy);
	}
		
	return analysis;
	}
	/**
	 * bug分类
	 * @param response
	 * @param request
	 * @param proId
	 * @return
	 */
	@RequestMapping("analysisBugType")
	@ResponseBody
	public List<BugAnalysis> analysisBT(HttpServletResponse response,HttpServletRequest request,@RequestParam Integer proId){
	Project project=projectService.getProjectById(proId);
	List<BugAnalysis> analysis=new ArrayList<>();
    List<Dict> dicts=	DictService.getDictListByType("bug_category");
	for (int i = 0; i < dicts.size(); i++)
	{
		BugAnalysis analy=new BugAnalysis();
		analy.setTypeLabel(dicts.get(i).getLabel());
		analy.setCount(projectService.getCategoryCount(dicts.get(i).getValue(),proId));
		analysis.add(analy);
	}
		
	return analysis;	
	}
	/**
	 * 优先级
	 * @param response
	 * @param request
	 * @param proId
	 * @return
	 */
	@RequestMapping("analysisLevel")
	@ResponseBody
	public List<BugAnalysis> analysisLevel(HttpServletResponse response,HttpServletRequest request,@RequestParam Integer proId){
	Project project=projectService.getProjectById(proId);
	List<BugAnalysis> analysis=new ArrayList<>();
    List<Dict> dicts=	DictService.getDictListByType("bug_priority");
	for (int i = 0; i < dicts.size(); i++)
	{
		BugAnalysis analy=new BugAnalysis();
		analy.setTypeLabel(dicts.get(i).getLabel());
		analy.setCount(projectService.getPriorityCount(dicts.get(i).getValue(),proId));
		analysis.add(analy);
	}
		
	return analysis;	
	}
	/**
	 * 操作系统
	 * @param response
	 * @param request
	 * @param proId
	 * @return
	 */
	@RequestMapping("analysisOS")
	@ResponseBody
	public List<BugAnalysis> analysisOS(HttpServletResponse response,HttpServletRequest request,@RequestParam Integer proId){
		Project project=projectService.getProjectById(proId);
		List<BugAnalysis> analysis=new ArrayList<>();
		List<Dict> dicts=	DictService.getDictListByType("bug_os");
		for (int i = 0; i < dicts.size(); i++)
		{
			BugAnalysis analy=new BugAnalysis();
			analy.setTypeLabel(dicts.get(i).getLabel());
			analy.setCount(projectService.getOsCount(dicts.get(i).getValue(),proId));
			analysis.add(analy);
		}
		
		return analysis;	
	}

	@RequestMapping("/toanalysis")

	public String analysisPage(HttpServletResponse response,HttpServletRequest request,Model model){
		String proIdString = request.getParameter("proId");
		Integer proId = 0;
		if (StringUtil.isNotEmpty(proIdString)) {
			proId = Integer.parseInt(proIdString);
		}
		User user = (User) request.getSession().getAttribute("currentUser");
		List<Bug> bugs = new ArrayList<>();
		List<Project> projects=new ArrayList<>();
		if (user.getRoleName().equals("SuperAdmin")) {
			

			projects= projectService.getProjectListAll();
		} else if (user.getRoleName().equals("Admin")) {

		
			projects= projectService.getProjectListByLeaderId(user.getId());

		} else {
			

			projects=projectService.getProListByUID(user.getId());

		}
		model.addAttribute("select_check", proId);	
		model.addAttribute("projectList",projects);
	
	return "project/projectAnalysis";
	}
	
}
