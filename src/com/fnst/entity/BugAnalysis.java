package com.fnst.entity;
/** 
* @author 作者: dengsl.jy
* @version 创建时间：2017/08/14 9:19:59 
* 类说明 :
*/
public class BugAnalysis {

	private String typeLabel;
	private Integer count;
	public String getTypeLabel() {
		return typeLabel;
	}
	public void setTypeLabel(String typeLabel) {
		this.typeLabel = typeLabel;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	@Override
	public String toString() {
		return "BugAnalysis [typeLabel=" + typeLabel + ", count=" + count + "]";
	}
	
}
