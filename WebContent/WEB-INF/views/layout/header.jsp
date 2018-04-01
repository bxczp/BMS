<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%-- <link href="${pageContext.request.contextPath }/bootstrap3.3.7/css/bootstrap.min.css" rel="stylesheet"> --%>
<%-- <script src="${pageContext.request.contextPath }/jquery2.1.4/jquery.min.js"></script> --%>
<%-- <script src="${pageContext.request.contextPath }/bootstrap3.3.7/js/bootstrap.min.js"></script> --%>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/artdialog/ui-dialog.css"> --%>

<link href="${pageContext.request.contextPath }/style/bootstrapvalidator-master/dist/css/bootstrapValidator.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath }/style/bootstrapvalidator-master/dist/js/bootstrapValidator.min.js"></script>
<script src="${pageContext.request.contextPath }/js/header.js"></script>

<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> -->

<!-- </head> -->
<!-- <body> -->

<nav class="navbar navbar-default">
	<div class="container-fluid"> 
    <div class="navbar-header">
        <a class="navbar-brand" href="${pageContext.request.contextPath }/home"><span class="glyphicon glyphicon-credit-card"></span>&nbsp;&nbsp;Bug Management System</a>
    </div>
	<ul class="nav navbar-nav">
	    <li class="dropdown">
			<a href="#" class="dropdown-toggle" data-toggle="dropdown">
				<span class="glyphicon glyphicon-globe"></span>
				<b class="caret"></b>
			</a>
			<ul class="dropdown-menu">
				<li><a id="zh_CN" href="${pageContext.request.contextPath }/home?language=zh_CN"><spring:message code="chinese" /></a></li>
				<li class="divider"></li>
				<li><a id="en_US" href="${pageContext.request.contextPath }/home?language=en_US"><spring:message code="english" /></a></li>
				<li class="divider"></li>
				<li><a id="ja_JA" href="${pageContext.request.contextPath }/home?language=ja_JA"><spring:message code="japanses" /></a></li>
			</ul>
		</li>
	</ul>
    <div>
        
          <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-user"></span>${currentUser.name} <b class="caret"></b>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="${pageContext.request.contextPath }/user/getUserInfo"><spring:message code="user_center" /></a></li>
                    <li class="divider"></li>
                    <li><a href="" data-toggle="modal" data-target="#PWDModal"><spring:message code="user_modifyPassword" /></a></li>
                    <li class="divider"></li>
                    <li><a href="${pageContext.request.contextPath }/user/logout"><spring:message code="user_quit" /></a></li>
                </ul>
            </li>
        </ul>
       
  
   	    <ul class="nav navbar-nav navbar-right">
	    	<li><a href="${ctx}/bug/form"><span class="glyphicon glyphicon-new-window"></span><spring:message code="bug-submit" /></a></li>
		</ul>
  <ul class="nav navbar-nav navbar-right ${currentUser.roleName == 'SuperAdmin' || currentUser.roleName == 'Admin' ? '' : 'hidden' }">
	    	<li><a href="${ctx}/dict/list"><span class="glyphicon glyphicon-book"></span><spring:message code="dict-manage" /></a></li>
		</ul>
        
	    <ul class="nav navbar-nav navbar-right">
	    	<li><a href="${ctx}/bug/list"><span class="glyphicon glyphicon-flash"></span><spring:message code="bug-manage" /></a></li>
		</ul>
		
	    <ul class="nav navbar-nav navbar-right ${currentUser.roleName == 'SuperAdmin' || currentUser.roleName == 'Admin' ? '' : 'hidden' }">
	    	<li><a href="${pageContext.request.contextPath }/project/manage"><span class="glyphicon glyphicon-align-justify"></span><spring:message code="project-manage" /></a></li>
		</ul>
		
	    <ul class="nav navbar-nav navbar-right ${currentUser.roleName == 'SuperAdmin' ? '' : 'hidden' }">
	    	<li><a href="${pageContext.request.contextPath }/user/manage"><span class="glyphicon glyphicon-th-large"></span></span><spring:message code="user-manage" /></a></li>
		</ul>
		
		<ul class="nav navbar-nav navbar-right">
	    	<li><a href="${ctx}/project/toanalysis"><span class="glyphicon glyphicon-equalizer"></span><spring:message code="analysis" /></a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
	    	<li><a href="${ctx}/bug/userDashboard"><span class="glyphicon glyphicon-tasks"></span><spring:message code="my-view" /></a></li>
		</ul>

    </div>
    
	</div>
</nav>

<!-- Modal   修改密码-->
	<div class="modal fade" id="PWDModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"  data-backdrop="static">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">
						<strong class="text-primary"><spring:message code="header-modify" /></strong>
					</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-primary">
								<div class="panel-heading"><spring:message code="userInfo-modify" /></div>
								<!-- /.panel-heading -->
								<div class="panel-body">
								    <input type="hidden" id="ctx" value="${ctx}" />
									<form role="PWDFrom" class="PWDFrom" id="PWDFrom">
										<div class="form-group">
											<label for=""><spring:message code="header-old-password" /></label> <input type="password"
												class="form-control" id="firstPWD" name="firstPWD">
										</div>
										<div class="form-group">
											<label for=""><spring:message code="header-new-password" /></label> <input type="password"
												class="form-control" id="newPWD" name="newPWD">
										</div>
										<div class="form-group">
											<label for=""><spring:message code="header-password" /></label> <input type="password"
												class="form-control" id="confirmPWD" name="confirmPWD">
										</div>
										<div class="modal-footer" id="footer">
											<button type="submit" class="btn btn-primary"><spring:message code="userInfo-OK" /></button>
											<button type="button" class="btn btn-primary" data-dismiss="modal"><spring:message code="userInfo-cancel" /></button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- Modal   原密码不正确--> 
    <div class="modal fade" id="failfirstPWD" tabindex="-2" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
					<h4 class="modal-title" id="myModalLabel">
						<p class="text-primary text-center"><strong><spring:message code="old-password-error" /></strong></p>
					</h4>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
	</div>
		<!-- modal密码修改提示 -->
	<div class="modal fade" id="PWDSuccess" tabindex="-2" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
					<h4 class="modal-title" id="myModalLabel">
						<p class="text-primary text-center"><strong id="text"><spring:message code="success-login" />！</strong></p>
					</h4>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
	</div>
	
   <div class="modal fade" id="PWDfail" tabindex="-2" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
					<h4 class="modal-title" id="myModalLabel">
						<p class="text-primary text-center"><strong><spring:message code="old-password-error" /></strong></p>
					</h4>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
	</div>
	
   <div class="modal fade" id="Systemfail" tabindex="-2" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
					<h4 class="modal-title" id="myModalLabel">
						<p class="text-primary text-center"><strong><spring:message code="system-error" /></strong></p>
					</h4>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
	</div>
<!-- </body> -->
<!-- </html> -->