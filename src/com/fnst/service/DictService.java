package com.fnst.service;

import java.util.List;

import com.fnst.entity.Dict;

/** 
* @author 作者: dengsl.jy
* @version 创建时间：2017/07/31 11:02:56 
* 类说明 :
*/
public interface DictService {
	public List<Dict> getDictList();
	public List<Dict> getDictListByType(String type);
	
	public int insert(Dict dict);
	public int delDictByID(Integer id);
	
	public Dict getDictListByID(Integer id);
	public int updateDictByID(Dict dict);
	public String getDictLabel(Dict dict);
	public String getOSLabel(String oSId);//操作系统  label
	public String getPriorityLabel(String priorityId);//优先级label
	public String getCategoryLabel(String categoryId);//bug分类label
	public String getStatusLabel(String statusId);//bug状态label
}
