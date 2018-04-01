
package com.fnst.entity;

import java.util.Date;
import java.util.List;

public class Project {
	
	private int id;
	private String name;
	// 项目状态 1 为正在开发 2为开发完成
	private int status;
	private int leader;
	private String description;
	private Date createDate;
	// 对应组长实体
	private User Admin;
	// 对应组员
	private List<User> members;

	// 对应该项目的bug列表
	private List<Bug> bugs;


	public User getAdmin() {
		return Admin;
	}
	public void setAdmin(User admin) {
		Admin = admin;
	}
	public List<User> getMembers() {
		return members;
	}
	public void setMembers(List<User> members) {
		this.members = members;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getLeader() {
		return leader;
	}
	public void setLeader(int leader) {
		this.leader = leader;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public List<Bug> getBugs() {
		return bugs;
	}
	public void setBugs(List<Bug> bugs) {
		this.bugs = bugs;
	}
	
}
