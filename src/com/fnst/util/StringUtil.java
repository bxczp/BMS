package com.fnst.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtil {

    public static boolean isEmpty(String str) {
        if (str == null || "".equals(str)) {
            return true;
        } else {
            return false;
        }
    }

    public static String delHTMLTag(String htmlStr){ 
        String regEx_script="<script[^>]*?>[\\s\\S]*?<\\/script>"; //定义script的正则表达式 
        String regEx_style="<style[^>]*?>[\\s\\S]*?<\\/style>"; //定义style的正则表达式 
        String regEx_html="<[^>]+>"; //定义HTML标签的正则表达式 
         
        Pattern p_script=Pattern.compile(regEx_script,Pattern.CASE_INSENSITIVE); 
        Matcher m_script=p_script.matcher(htmlStr); 
        htmlStr=m_script.replaceAll(""); //过滤script标签 
         
        Pattern p_style=Pattern.compile(regEx_style,Pattern.CASE_INSENSITIVE); 
        Matcher m_style=p_style.matcher(htmlStr); 
        htmlStr=m_style.replaceAll(""); //过滤style标签 
         
        Pattern p_html=Pattern.compile(regEx_html,Pattern.CASE_INSENSITIVE); 
        Matcher m_html=p_html.matcher(htmlStr); 
        htmlStr=m_html.replaceAll(""); //过滤html标签 

        return htmlStr.trim(); //返回文本字符串 
    } 
 
    
    public static boolean isNotEmpty(String str) {
    	if (str != null && !"".equals(str)) {
    		return true;
    	} else {
    		return false;
    	}
    }
    
    public static boolean isInteger(String str) {  
    	Pattern pattern = Pattern.compile("^[-\\+]?[\\d]*$");  
    	return pattern.matcher(str).matches();  
    }
    
    public static String getCurrentDateToString() {
    	SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
    	return format.format(new Date());
    }
    
    public static String formatLike(String str) {
    	if (StringUtil.isEmpty(str)) {
    		return null;
    	} else {
    		return "%" + str + "%";
    	}
    }
    
    
    /**
     * 以下函数为转义特殊字符
     * @param keyword
     * @return
     */
    public static String keywordHtmlEncode(String keyword) {
        keyword = replace(keyword, "\\", "\\\\");
        keyword = replace(keyword, "%", "\\%");
        keyword = replace(keyword, "_", "\\_");
        return keyword;
    }
    
    public static String replace(String str, String strSub, String strRpl) {
        String[] tmp = split(str, strSub);
        String returnstr = "";
        if (tmp.length != 0) {
            returnstr = tmp[0];
            for (int i = 0; i < tmp.length - 1; i++) {
                returnstr = doWithNull(returnstr) + strRpl + tmp[i + 1];
            }
        }
        return doWithNull(returnstr);
    }
    
    public static String[] split(String strSource, String strDiv) {
        int arynum = 0, intIdx = 0, intIdex = 0;
        int div_length = strDiv.length();
        if (strSource.compareTo("") != 0) {
            if (strSource.indexOf(strDiv) != -1) {
                intIdx = strSource.indexOf(strDiv);
                for (int intCount = 1;; intCount++) {
                    if (strSource.indexOf(strDiv, intIdx + div_length) != -1) {
                        intIdx = strSource.indexOf(strDiv, intIdx + div_length);
                        arynum = intCount;
                    } else {
                        arynum += 2;
                        break;
                    }
                }
            } else {
                arynum = 1;
            }
        } else {
            arynum = 0;

        }
        intIdx = 0;
        intIdex = 0;
        String[] returnStr = new String[arynum];

        if (strSource.compareTo("") != 0) {
            if (strSource.indexOf(strDiv) != -1) {
                intIdx = strSource.indexOf(strDiv);
                returnStr[0] = strSource.substring(0, intIdx);
                for (int intCount = 1;; intCount++) {
                    if (strSource.indexOf(strDiv, intIdx + div_length) != -1) {
                        intIdex = strSource.indexOf(strDiv, intIdx + div_length);
                        returnStr[intCount] = strSource.substring(intIdx + div_length, intIdex);
                        intIdx = strSource.indexOf(strDiv, intIdx + div_length);
                    } else {
                        returnStr[intCount] = strSource.substring(intIdx + div_length, strSource.length());
                        break;
                    }
                }
            } else {
                returnStr[0] = strSource.substring(0, strSource.length());
                return returnStr;
            }
        } else {
            return returnStr;
        }
        return returnStr;
    }
    
    public static String doWithNull(Object o) {
        if (o == null) {
            return "";
        } else {
            String returnValue = o.toString();
            if (returnValue.equalsIgnoreCase("null")) {
                return "";
            } else {
                return returnValue.trim();
            }
        }

    }

}
