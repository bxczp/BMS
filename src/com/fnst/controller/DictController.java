package com.fnst.controller;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.server.PathParam;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fnst.entity.Dict;
import com.fnst.service.DictService;

/** 
* @author 作者: dengsl.jy
* @version 创建时间：2017/07/31 11:06:34 
* 类说明 :
*/
@RequestMapping("/dict")
@Controller
public class DictController {

	@Resource
	private DictService dictService;
	
	@RequestMapping(value={"","list"})
	public String  list(HttpServletRequest request ,HttpServletResponse response,Model model) {
	model.addAttribute("dictList",  dictService.getDictList());
		return "dict/dictList";
	}
	
	@RequestMapping("form")
	public String form(HttpServletRequest request,HttpServletResponse response){
		return "dict/dictForm";
		
	}
	
	@RequestMapping("get")
	@ResponseBody
	public Dict get(HttpServletRequest request,HttpServletResponse response,@RequestParam Integer id){
		return dictService.getDictListByID(id);
		
	}
	
	@RequestMapping("addOrupdate")
	@ResponseBody
	public boolean add(HttpServletRequest request,HttpServletResponse response,Dict dict){
		boolean flag=false;
		
		int result=0;
		dict.setUpdateDate(new Date());
		if (dict.getId()!=null) {
			result=dictService.updateDictByID(dict);
		}else{
			dict.setCreateDate(new Date());

			result=dictService.insert(dict);
		}
		
		if (result>0) {
			flag=true;
		}
		
			   return flag;
	}
	@ResponseBody
	@RequestMapping(value="delete")
	public boolean delete(HttpServletRequest request,HttpServletResponse response,@RequestParam Integer  id) {
		boolean flag=false;
		int result=dictService.delDictByID(id);
		if (result>0) {
			flag=true;
		}
		  return flag ;
		
	}
	@RequestMapping("edit")
	public String edit(HttpServletRequest request,HttpServletResponse response,@RequestParam Integer id,Model model){
		
		model.addAttribute("dict", dictService.getDictListByID(id));
		return "dict/dictForm";
		
	}
	
	
}
