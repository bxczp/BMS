package com.fnst.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.fnst.entity.Bug;
import com.fnst.entity.BugChangeLog;
import com.fnst.entity.BugFeedback;
import com.fnst.entity.Project;
import com.fnst.entity.User;
import com.fnst.service.BugChangeLogService;
import com.fnst.service.BugFeedbackService;
import com.fnst.service.BugService;
import com.fnst.service.DictService;
import com.fnst.service.ProjectService;
import com.fnst.service.UserService;
import com.fnst.util.MailUtil;
import com.fnst.util.PropertiesUtil;
import com.fnst.util.StringUtil;
import com.mchange.lang.StringUtils;
import com.mysql.jdbc.StreamingNotifiable;

/**
 *
 * @author dengsl.jy
 *
 */
@RequestMapping("/bug")
@Controller
@SessionAttributes("curruser")
public class BugController {
	@Resource
	private BugService bugService;
	@Resource
	private DictService dictService;
	@Resource
	private ProjectService projectService;
	@Resource
	private UserService userService;
	@Resource
	private BugChangeLogService changeLogService;
	@Resource
	private BugFeedbackService feedbackService;

	/**
	 * 獲取bug列表
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"list", ""})

	public String getBugList(HttpServletRequest request, HttpServletResponse response, Model model) {
		String proIdString = request.getParameter("proId");
		Integer proId = 0;
		if (StringUtil.isNotEmpty(proIdString)) {
			proId = Integer.parseInt(proIdString);
		}

		User user = (User) request.getSession().getAttribute("currentUser");
		List<Bug> bugs = new ArrayList<>();
		List<Project> projects=new ArrayList<>();
		if (user.getRoleName().equals("SuperAdmin")) {
			if (proId > 0) {

				bugs = bugService.getBugListByPID(proId);
			} else {

				bugs = bugService.getBugList();
			}

			projects= projectService.getProjectListAll();
		} else if (user.getRoleName().equals("Admin")) {

			if (proId > 0) {

				bugs = bugService.getBugListByPID(proId);
			} else {

				bugs = bugService.getBugList();// 管理员可以看淡所有bug
			}
			projects= projectService.getProjectListByLeaderId(user.getId());

		} else {
			if (proId > 0) {

				bugs = bugService.getBugListByPID(proId);
			} else {
				
				if (projectService.getProListByUID(user.getId()).size()>0) {
					for (int i = 0; i < projectService.getProListByUID(user.getId()).size(); i++) {
						
					List<Bug>	bugSubs= bugService.getBugListByPID(projectService.getProListByUID(user.getId()).get(i).getId());
						bugs.addAll(bugSubs);
					}
					
					
				}
			}

			projects=projectService.getProListByUID(user.getId());

		}
		for(Bug b : bugs) {
		    if (StringUtil.isNotEmpty(b.getDescription())) {
		        b.setDescription(StringUtil.delHTMLTag(b.getDescription()));
		    }
		}
		model.addAttribute("select_check", proId);	
		model.addAttribute("projectList",projects);
		model.addAttribute("bugList", bugs);// 管理员可以看淡所有bug
		return "bug/bugList";
	}

	/**
	 * bug管理表单页面
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("/form")
	public String form(HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = (User) request.getSession().getAttribute("currentUser");
		
		model.addAttribute("categoryTypes", dictService.getDictListByType("bug_category"));
		model.addAttribute("osTypes", dictService.getDictListByType("bug_os"));
		model.addAttribute("statusTypes", dictService.getDictListByType("bug_status"));
		model.addAttribute("priorityTypes", dictService.getDictListByType("bug_priority"));
		List<Project> projects=new ArrayList<>();
		if (user.getRoleName().equals("SuperAdmin")) {
			projects=projectService.getProjectListAll();
		}else if (user.getRoleName().equals("Admin")) {
			projects=projectService.getProjectListByLeaderId(user.getId());
		}
		else{
		 projects=	projectService.getProListByUID(user.getId());
		}
		model.addAttribute("projectList", projects);
		return "bug/form";

	}

	/**
	 * 添加一个bug
	 * 
	 * @param bug
	 * @param response
	 * @param request
	 * @return
	 */

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public int add(Bug bug, HttpServletResponse response, HttpServletRequest request) {
		bug.setCreateDate(new Date());
		bug.setUpdateDate(new Date());
	//	MailUtil.sendMail(fromAddress, fromPassword, toAddress, title, context);
		int maxN = bugService.getMAXID().getId() + 1;
		if (maxN < 100) {

			bug.setDesignation("00000" + maxN);
		} else {
			bug.setDesignation("0000" + maxN);

		}
		return bugService.insert(bug);

	}
	
	@RequestMapping("/sendMail")
	@ResponseBody
	public boolean sendMail(String userId, String proName, String proId, HttpServletRequest request) {
		boolean flag = false;
		if (StringUtil.isNotEmpty(userId)) {
			if (StringUtil.isInteger(userId)) {
				User user = userService.getUserById(Integer.parseInt(userId));
				if (user != null) {
					String title = "你有新指派的bug";
					String context = "项目: "+proName+", 中的番号为: "+"的bug已被指派给你，请尽快修复提交该bug";
					try {
						MailUtil.sendMail(PropertiesUtil.getValue("fromAddress"), PropertiesUtil.getValue("fromPassword"), user.getEmail(), title, context);
					} catch (AddressException e) {
						e.printStackTrace();
						return flag;
					} catch (MessagingException e) {
						e.printStackTrace();
						return flag;
					} catch (Exception e) {
						e.printStackTrace();
						return flag;
					}
					flag = true;
				}
			}
		}
		return flag;
	}

	/**
	 * 文件上传
	 * 
	 * @param files
	 * @param request
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/uploadItem", method = RequestMethod.POST)
	public @ResponseBody List<String> uploaditem(@RequestParam MultipartFile files, HttpServletRequest request)
			throws IOException {
		System.out.println(files.getContentType());
		System.out.println("Nmae:" + files.getOriginalFilename());
		System.out.println("Size:" + files.getSize());
		List<String> names = new ArrayList<>();
		String fileName = files.getOriginalFilename();
		System.out.println(files.getInputStream());
		ServletContext sc = request.getSession().getServletContext();
		String path = sc.getRealPath("/upload") + "/"; // 设定文件保存的目录
		File f = new File(path);
		if (!f.exists()) {
			f.mkdirs();
		}
		if (!files.isEmpty()) {
			try {
				FileOutputStream fos = new FileOutputStream(path + fileName);
				InputStream in = files.getInputStream();
				int b = 0;
				while ((b = in.read()) != -1) {
					fos.write(b);
				}
				fos.close();
				in.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			System.out.println("文件保存地址" + path + fileName);

			names.add(fileName);

		}

		return names;

	}
	/**
	 * bug反馈页面
	 * @param request
	 * @param response
	 * @param model
	 * @param id
	 * @return
	 */
	
	@RequestMapping("feedback")
	public String feedback(HttpServletRequest request,HttpServletResponse response,Model model,@RequestParam Integer id){
		Bug bug=bugService.getBugById(id);
		User user = (User) request.getSession().getAttribute("currentUser");
		String fileTemp=bug.getFiles();
		if (StringUtil.isNotEmpty(fileTemp)) {
			
			String[] files=fileTemp.split(",");
			model.addAttribute("files", files);
		}
		model.addAttribute("bug", bug);
		
		model.addAttribute("currProject", projectService.getProjectById(bug.getProId()));
		model.addAttribute("proUsers",userService.getUserListByPID(bug.getProId()) );
		
		model.addAttribute("categoryTypes", dictService.getDictListByType("bug_category"));
		model.addAttribute("osTypes", dictService.getDictListByType("bug_os"));
		model.addAttribute("statusTypes", dictService.getDictListByType("bug_status"));
		model.addAttribute("priorityTypes", dictService.getDictListByType("bug_priority"));
		
		model.addAttribute("feedbackList", feedbackService.getFeedbackListByBID(id));
		model.addAttribute("projectList", projectService.getProListByUID(user.getId()));
		model.addAttribute("changlogList", changeLogService.getChangeLogByBID(bug.getId()));
		
		return "bug/bugFeedback";
	}
	/**
	 * bug详情页面
	 * @param request
	 * @param response
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping("view")
	public String view(HttpServletRequest request,HttpServletResponse response,Model model,@RequestParam Integer id){
		Bug bug=bugService.getBugById(id);
		User user = (User) request.getSession().getAttribute("currentUser");
		String fileTemp=bug.getFiles();
		if (StringUtil.isNotEmpty(fileTemp)) {
			
			String[] files=fileTemp.split(",");
			model.addAttribute("files", files);
		}
		bug.setAssigner(userService.getUserById(bug.getAssignedId()).getName());
		model.addAttribute("bug", bug);
		
		model.addAttribute("currProject", projectService.getProjectById(bug.getProId()));
		model.addAttribute("proUsers",userService.getUserListByPID(bug.getProId()) );
//		
//		model.addAttribute("categoryTypes", dictService.getDictListByType("bug_category"));
//		model.addAttribute("osTypes", dictService.getDictListByType("bug_os"));
//		model.addAttribute("statusTypes", dictService.getDictListByType("bug_status"));
//		model.addAttribute("priorityTypes", dictService.getDictListByType("bug_priority"));
		
		model.addAttribute("projectList", projectService.getProListByUID(user.getId()));
		model.addAttribute("feedbackList", feedbackService.getFeedbackListByBID(id));
		model.addAttribute("changlogList", changeLogService.getChangeLogByBID(bug.getId()));
		
		
		return "/bug/bugDetail";
	}
	
	@RequestMapping("/addFeedback")
	@ResponseBody
	public boolean addFeedback(HttpServletRequest request,HttpServletResponse response,Bug bug){
		boolean flag=false;
		//获取元bug记录
		Bug beforeBug=bugService.getBugById(bug.getId());
		String content=request.getParameter("content");
		User user=(User) request.getSession().getAttribute("currentUser");
	    BugChangeLog changeLog=new BugChangeLog();
	    changeLog.setBugId(bug.getId());
	    changeLog.setUserId(user.getId());

		//指派人变更
		if (!bug.getAssignedId().equals(beforeBug.getAssignedId())) {
			changeLog.setChangeType("分配给");
			changeLog.setChangeContent(userService.getUserById(beforeBug.getAssignedId()).getName()+" =>> "+userService.getUserById(bug.getAssignedId()).getName());
			changeLogService.insert(changeLog);	//插入记录
		}
		//bug状态变更
		if (!bug.getStatus().equals(beforeBug.getStatus())) {
			changeLog.setChangeType("状态变更");
			changeLog.setChangeContent(dictService.getStatusLabel(beforeBug.getStatus())+" =>> "+dictService.getStatusLabel(bug.getStatus()));
			changeLogService.insert(changeLog);
		}
		//bug分类变更
		if (!bug.getCategory().equals(beforeBug.getCategory())) {
			changeLog.setChangeType("类别变更");
			changeLog.setChangeContent(dictService.getCategoryLabel(beforeBug.getCategory())+" =>> "+dictService.getCategoryLabel(bug.getCategory()));
			changeLogService.insert(changeLog);
		}
		//bug优先级变更
				if (!bug.getPriority().equals(beforeBug.getPriority())) {
					changeLog.setChangeType("优先级变更");
					changeLog.setChangeContent(dictService.getPriorityLabel(beforeBug.getPriority())+" =>> "+dictService.getPriorityLabel(bug.getPriority()));
					changeLogService.insert(changeLog);
				}
		//注释变更
		if (StringUtil.isNotEmpty(content)) {
			String noteCode="";
			int maxN = feedbackService.getMAXFID().getId()+1;
			if (maxN < 100) {

				noteCode="00000" + maxN;
			} else {
				noteCode="0000" + maxN;

			}
			//插入变更记录
			changeLog.setChangeType("添加调查注释");
			changeLog.setChangeContent("");
			changeLogService.insert(changeLog);
			/**
			 * 插入反馈调查记录
			 */
			BugFeedback feedback=new BugFeedback();
			feedback.setBugId(bug.getId());
			feedback.setUserId(user.getId());
			feedback.setNoteCode(noteCode);
			feedback.setNoteDescription(content);
			if (feedbackService.insert(feedback)>0) {
				flag=true;
			}
		}
bugService.updateBugById(bug);//执行更新操作
		return flag;
		
	}
	/**
	 * 根据项目ID  获取项目人员
	 * @param request
	 * @param response
	 * @param proId
	 * @return
	 */
	@RequestMapping("getProUserList")
	@ResponseBody
	public List<User> getProUserList(HttpServletRequest request,HttpServletResponse response,@RequestParam Integer proId){
		return userService.getUserListByPID(proId);
		
	}
	
	/**
	 * APP根据bug番号查询bug  接口
	 * @param response
	 * @param request
	 * @param designation
	 * @return
	 */
	@RequestMapping("getBugByDesignation")
	@ResponseBody
	public Bug getBugByDesignation(HttpServletResponse response,HttpServletRequest request,String designation ){
		
	Bug bug=bugService.getBugByDesignation(designation);

		return bug;
		
	}
	/**
	 * 删除或批量删除bug
	 * @param request
	 * @param response
	 * @param checkValues
	 * @return
	 */
	@RequestMapping("del")
	@ResponseBody
	public boolean del(HttpServletRequest request,HttpServletResponse response,@RequestParam String[] checkValues){
	boolean result=false;
		for (String bugID : checkValues) {
			int res=bugService.delete(Integer.parseInt(bugID));
			
			if (res>0) {
				result=true;
			}
		}
		return result;

	}
	
	@RequestMapping("export")
	@ResponseBody
	public boolean export(HttpServletResponse response,HttpServletRequest request,@RequestParam Integer proId){
		return false;
		
	}
	
	@RequestMapping("userDashboard")
	public String userDashboard(HttpServletResponse response,HttpServletRequest request,Model model){
		User user=(User) request.getSession().getAttribute("currentUser");
		model.addAttribute("unsolvedBugs", bugService.getBugByUIDAndStatus(user.getId(),"2"));//分派给我 (未解决)
		model.addAttribute("solvedBugs", bugService.getBugByUIDAndStatus(user.getId(),"4"));//分派给我(已解决)
		model.addAttribute("publishBugs", bugService.getBugsByPID(user.getId()));//我报告的()
		model.addAttribute("feedBackBugs", bugService.getBugsByUID(user.getId()));//我反馈的
		
		
		return "bug/myDashboard";
		
	}

}
