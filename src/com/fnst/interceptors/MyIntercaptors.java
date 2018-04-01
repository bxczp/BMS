package com.fnst.interceptors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.fnst.entity.User;

public class MyIntercaptors implements HandlerInterceptor {

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object arg2, Exception arg3)
			throws Exception {
				
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse arg1,
			Object object) throws Exception {
		System.out.println("preHandle");
		User user=(User) request.getSession().getAttribute("curruser");
		System.out.println(user);
		/*if (user==null) {
			request.getRequestDispatcher("login.jsp").forward(request, arg1);
			return false;
		}*/
	/*	else {
			return true;
		}*/
		return true;
	}
	
	
	
	

	
}
