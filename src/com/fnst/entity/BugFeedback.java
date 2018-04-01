package com.fnst.entity;

import java.util.Date;

/** 
* @author 作者: dengsl.jy
* @version 创建时间：2017/08/09 21:21:09 
* 类说明 :
*/
public class BugFeedback {
/**
 * 反馈 ID
 */
    private Integer id;

    /**
     * user 关联ID
     */
    private Integer userId;
    
    private String userName;
/**
 * bug  关联ID
 */
   
    private Integer bugId;
/**
 * 反馈描述
 */
    private String noteDescription;

   /**
    * 创建日期
    */
    private Date createDate;

  /**
   * 更新日期
   */
    private Date updateDate;

  /**
   * 反馈番号
   */
    private String noteCode;


	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}


	public Integer getUserId() {
		return userId;
	}


	public void setUserId(Integer userId) {
		this.userId = userId;
	}


	public Integer getBugId() {
		return bugId;
	}


	public void setBugId(Integer bugId) {
		this.bugId = bugId;
	}


	public String getNoteDescription() {
		return noteDescription;
	}


	public void setNoteDescription(String noteDescription) {
		this.noteDescription = noteDescription;
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


	public String getNoteCode() {
		return noteCode;
	}


	public void setNoteCode(String noteCode) {
		this.noteCode = noteCode;
	}


	public String getUserName() {
		return userName;
	}


	public void setUserName(String userName) {
		this.userName = userName;
	}
	

}
