package com.fnst.dao;

import java.util.List;

import com.fnst.entity.Dict;

/** 
* @author 作者: dengsl.jy
* @version 创建时间：2017/07/31 10:58:56 
* 类说明 :
*/
public interface DictDao {
	public List<Dict> getDictList();
	public List<Dict> getDictListByType(String type);
	
	public int insert(Dict dict);
	public int delDictByID(Integer id);
	public Dict getDictListByID(Integer id);
	public int updateDictByID(Dict dict);
	
	public String getDictLabel(Dict dict);

}
