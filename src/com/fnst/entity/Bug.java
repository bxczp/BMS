package com.fnst.entity;

import java.util.Date;

public class Bug {
	
		private Integer id;

	    private String designation;//bug番号

	    private Integer proId;//项目ID
	    private String proName;//项目名称

	    private String category;//bug分类
	    private String categoryLabel;//bug分类

	    private String priority;//优先级
	    private String priorityLabel;//优先级Label

	    private Integer publisherId;//发布人ID
	    private String publisher;//发布人
	    

	    private Integer assignedId;//分派给
	    private String  assigner;//分派给  user

	    private String os;//操作系统
	    private String osLabel;//操作系统Label

	    private String description;//描述

	    private String status;//状态
	    private String statusLabel;//状态Label
	   
	    private String files;//附件

	    private Date createDate;//创建日期

	    private Date updateDate;//更新日期
	    private String remark;//备注

		public Integer getId() {
			return id;
		}

		public void setId(Integer id) {
			this.id = id;
		}

		public String getDesignation() {
			return designation;
		}

		public void setDesignation(String designation) {
			this.designation = designation;
		}

		public Integer getProId() {
			return proId;
		}

		public void setProId(Integer proId) {
			this.proId = proId;
		}

		public String getCategory() {
			return category;
		}

		public void setCategory(String category) {
			this.category = category;
		}

		public String getPriority() {
			return priority;
		}

		public void setPriority(String priority) {
			this.priority = priority;
		}

		public Integer getPublisherId() {
			return publisherId;
		}

		public void setPublisherId(Integer publisherId) {
			this.publisherId = publisherId;
		}

		public Integer getAssignedId() {
			return assignedId;
		}

		public void setAssignedId(Integer assignedId) {
			this.assignedId = assignedId;
		}

		public String getOs() {
			return os;
		}

		public String getPublisher() {
			return publisher;
		}

		public void setPublisher(String publisher) {
			this.publisher = publisher;
		}

		public void setOs(String os) {
			this.os = os;
		}

		public String getDescription() {
			return description;
		}

		public void setDescription(String description) {
			this.description = description;
		}

		public String getStatus() {
			return status;
		}

		public void setStatus(String status) {
			this.status = status;
		}

		public String getFiles() {
			return files;
		}

		public void setFiles(String files) {
			this.files = files;
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

		public String getRemark() {
			return remark;
		}

		public void setRemark(String remark) {
			this.remark = remark;
		}

		public String getCategoryLabel() {
			return categoryLabel;
		}

		public void setCategoryLabel(String categoryLabel) {
			this.categoryLabel = categoryLabel;
		}

		public String getPriorityLabel() {
			return priorityLabel;
		}

		public void setPriorityLabel(String priorityLabel) {
			this.priorityLabel = priorityLabel;
		}

		public String getOsLabel() {
			return osLabel;
		}

		public void setOsLabel(String osLabel) {
			this.osLabel = osLabel;
		}

		public String getStatusLabel() {
			return statusLabel;
		}

		public void setStatusLabel(String statusLabel) {
			this.statusLabel = statusLabel;
		}

		public String getAssigner() {
			return assigner;
		}

		public void setAssigner(String assigner) {
			this.assigner = assigner;
		}

		public String getProName() {
			return proName;
		}

		public void setProName(String proName) {
			this.proName = proName;
		}
	    
	

}
