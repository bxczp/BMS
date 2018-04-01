package com.fnst.service.imp;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fnst.dao.DictDao;
import com.fnst.entity.Bug;
import com.fnst.entity.Dict;
import com.fnst.service.DictService;

/** 
* @author 作者: dengsl.jy
* @version 创建时间：2017/07/31 11:03:23 
* 类说明 :
*/
@Service("dictService")
public class DictServiceImp implements DictService{
	@Resource
	private DictDao dictDao;

	@Override
	public List<Dict> getDictList() {
		
		return dictDao.getDictList();
	}

	@Override
	public List<Dict> getDictListByType(String type) {
		
		return dictDao.getDictListByType(type);
	}

	@Override
	public int insert(Dict dict) {
		
		return dictDao.insert(dict);
	}

	@Override
	public int delDictByID(Integer id) {
		
		return dictDao.delDictByID(id);
	}

	@Override
	public Dict getDictListByID(Integer id) {
		
		return dictDao.getDictListByID(id);
	}

	@Override
	public int updateDictByID(Dict dict) {
		
		return dictDao.updateDictByID(dict);
	}

	@Override
	public String getDictLabel(Dict dict) {
		
		return dictDao.getDictLabel(dict);
	}

	@Override
	public String getOSLabel(String oSId) {
		
		return dictDao.getDictLabel(new Dict(oSId, "bug_os"));
	}

	@Override
	public String getPriorityLabel(String priorityId) {
		
		return dictDao.getDictLabel(new Dict(priorityId, "bug_priority"));
	}

	@Override
	public String getCategoryLabel(String categoryId) {
		
		return dictDao.getDictLabel(new Dict(categoryId, "bug_category"));
	}

	@Override
	public String getStatusLabel(String statusId) {
		
		return dictDao.getDictLabel(new Dict(statusId, "bug_status"));
	}
	

}
