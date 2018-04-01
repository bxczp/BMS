package com.fnst.entity;

import java.util.Date;

/** 
* @author 作者: dengsl.jy
* @version 创建时间：2017/07/31 10:46:39 
* 类说明 :数据字典操作类
*/
public class Dict {
	 
    private Integer id;

    
    private String value;//K_value

    private String label;//

    
    private String type;//类别

   
    private String description;//描述

   
    private Date createDate;//创建日期

   
    private Date updateDate;//更新日期

   
    private String remark;//备注


	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}


	public String getValue() {
		return value;
	}


	public void setValue(String value) {
		this.value = value;
	}


	public String getLabel() {
		return label;
	}


	public void setLabel(String label) {
		this.label = label;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
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


	public Dict() {
		super();
		// TODO Auto-generated constructor stub
	}


	public Dict(String value, String type) {
		super();
		this.value = value;
		this.type = type;
	}


	@Override
	public String toString() {
		return "Dict [id=" + id + ", value=" + value + ", label=" + label + ", type=" + type + ", description="
				+ description + ", createDate=" + createDate + ", updateDate=" + updateDate + ", remark=" + remark
				+ "]";
	}
	
    
    
}
