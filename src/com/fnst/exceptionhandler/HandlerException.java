package com.fnst.exceptionhandler;

import org.springframework.web.HttpSessionRequiredException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class HandlerException {
	

	@ExceptionHandler({HttpSessionRequiredException.class})
	public String handlerSessionException(Exception ex) {
		
		System.out.println("异常"+ex);
		return "admin/login";
		
	}

}
