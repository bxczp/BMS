package com.fnst.entity;

import java.util.Date;

/** 
* @author 作者: dengsl.jy
* @version 创建时间：2017/08/07 22:22:08 
* 类说明 :
*/
public class BugChangeLog {
	private Integer id;

    private Integer bugId;

    private Integer userId;
    private String changeName;

 
    private String changeContent;

  
    private String changeType;

   
    private Date createDate;

  
    private Date updateDate;


	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}


	public Integer getBugId() {
		return bugId;
	}


	public void setBugId(Integer bugId) {
		this.bugId = bugId;
	}


	public Integer getUserId() {
		return userId;
	}


	public void setUserId(Integer userId) {
		this.userId = userId;
	}


	public String getChangeContent() {
		return changeContent;
	}


	public void setChangeContent(String changeContent) {
		this.changeContent = changeContent;
	}


	public String getChangeType() {
		return changeType;
	}


	public void setChangeType(String changeType) {
		this.changeType = changeType;
	}


	public Date getCreateDate() {
		return createDate;
	}


	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}


	public Date getUpdateDate() {
		return updateDate;
	}


	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}


	public String getChangeName() {
		return changeName;
	}


	public void setChangeName(String changeName) {
		this.changeName = changeName;
	}
	

}
