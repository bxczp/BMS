<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>index</title>

<script>

var language = navigator.browserLanguage?navigator.browserLanguage:navigator.language; 
if (language.indexOf('en') > -1) document.location.href = '${pageContext.request.contextPath }/getLogin?language=en_US'; 
else if (language.indexOf('ja') > -1) document.location.href = '${pageContext.request.contextPath }/getLogin?language=ja_JA'; 
else if (language.indexOf('zh') > -1) document.location.href = '${pageContext.request.contextPath }/getLogin?language=zh_CN'; 
else 
document.location.href = '${pageContext.request.contextPath }/getLogin?language=zh_CN'; 

</script>

</head>
<body>

</body>
</html>