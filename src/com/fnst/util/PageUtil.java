package com.fnst.util;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.support.RequestContext;

public class PageUtil {
    public static String genPagation(String url, int totalNum, int currentPage, int pageSize,HttpServletRequest request, String param) {
    	RequestContext requestContext = new RequestContext(request);
        int totalPage = totalNum % pageSize == 0 ? totalNum / pageSize : totalNum / pageSize + 1;
        if (totalPage == 0) {
            return requestContext.getMessage("no-data");
        }
        StringBuffer pageCode = new StringBuffer();
        pageCode.append("<li><a href='"+request.getContextPath()+url+"?page=1&"+ param +"'>"+requestContext.getMessage("first-page")+"</a></li>");
        if (currentPage == 1) {
            pageCode.append("<li class='disabled'><a href='#'>"+requestContext.getMessage("up-page")+"</a></li>");
        } else {
            pageCode.append("<li><a href='"+request.getContextPath()+url+"?page=" + (currentPage - 1) + "&" + param + "'>"+requestContext.getMessage("up-page")+"</a></li>");
        }
        for (int i = currentPage - 2; i <= currentPage + 2; i++) {
            if (i < 1 || i > totalPage) {
                continue;
            } else {
            	if (i == currentPage ) {
            		pageCode.append("<li class='disabled'><a href='"+request.getContextPath()+url+"?page=" + i + "&" + param + "'>" + i + "</a></li>");
            	} else {
            		pageCode.append("<li><a href='"+request.getContextPath()+url+"?page=" + i + "&" + param + "'>" + i + "</a></li>");
            	}
            }
        }

        if (currentPage == totalPage) {
            pageCode.append("<li class='disabled'><a href='#'>"+requestContext.getMessage("down-page")+"</a></li>");
        } else {
            pageCode.append("<li><a href='"+request.getContextPath()+url+"?page=" + (currentPage + 1) + "&" + param + "'>"+requestContext.getMessage("down-page")+"</a></li>");
        }
        pageCode.append("<li><a href='"+request.getContextPath()+url+"?page=" + totalPage + "&"+ param +"'>"+requestContext.getMessage("last-page")+"</a></li>");

        return pageCode.toString();
    }
    
    public static String genPagationBug(String url, int totalNum, int currentPage, int pageSize,HttpServletRequest request, String param) {
    	RequestContext requestContext = new RequestContext(request);
        int totalPage = totalNum % pageSize == 0 ? totalNum / pageSize : totalNum / pageSize + 1;
        if (totalPage == 0) {
            return requestContext.getMessage("no-data");
        }
        StringBuffer pageCode = new StringBuffer();
        pageCode.append("<li><a href='"+request.getContextPath()+url+"?pageBug=1&"+ param +"'>"+requestContext.getMessage("first-page")+"</a></li>");
        if (currentPage == 1) {
            pageCode.append("<li class='disabled'><a href='#'>"+requestContext.getMessage("up-page")+"</a></li>");
        } else {
            pageCode.append("<li><a href='"+request.getContextPath()+url+"?pageBug=" + (currentPage - 1) + "&" + param + "'>"+requestContext.getMessage("up-page")+"</a></li>");
        }
        for (int i = currentPage - 2; i <= currentPage + 2; i++) {
            if (i < 1 || i > totalPage) {
                continue;
            } else {
            	if (i == currentPage ) {
            		pageCode.append("<li class='disabled'><a href='"+request.getContextPath()+url+"?pageBug=" + i + "&" + param + "'>" + i + "</a></li>");
            	} else {
            		pageCode.append("<li><a href='"+request.getContextPath()+url+"?pageBug=" + i + "&" + param + "'>" + i + "</a></li>");
            	}
            }
        }

        if (currentPage == totalPage) {
            pageCode.append("<li class='disabled'><a href='#'>"+requestContext.getMessage("down-page")+"</a></li>");
        } else {
            pageCode.append("<li><a href='"+request.getContextPath()+url+"?pageBug=" + (currentPage + 1) + "&" + param + "'>"+requestContext.getMessage("down-page")+"</a></li>");
        }
        pageCode.append("<li><a href='"+request.getContextPath()+url+"?pageBug=" + totalPage + "&"+ param +"'>"+requestContext.getMessage("last-page")+"</a></li>");

        return pageCode.toString();
    }

}
