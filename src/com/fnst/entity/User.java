package com.fnst.entity;

import java.util.Date;

import com.fnst.util.DateUtil;


public class User {
	
	private int id;
	private String password;
	private String name;
	private String email;
	private String roleName;
	private Date createDate;
	private String IdNo;
	// 删除标志位 0为 没有删除 1 为 已删除
	private int deleted;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	
    

	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getIdNo() {
		return IdNo;
	}
	public void setIdNo(String idNo) {
		IdNo = idNo;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", password=" + password + ", name=" + name + ", email=" + email + ", roleName="
				+ roleName + ", createDate=" + createDate + ", IdNo=" + IdNo + "]";
	}
	
	public User() {
		super();
	}
	public User(String idNo,String name,String password,String email) {
		super();
		IdNo = idNo;
		this.name = name;
		this.password = password;
		this.email = email;
		
	}
	public int getDeleted() {
		return deleted;
	}
	public void setDeleted(int deleted) {
		this.deleted = deleted;
	}

	

}

