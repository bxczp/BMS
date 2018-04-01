<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="userInfo-personal-information" /></title>

<link href="${pageContext.request.contextPath }/style/bootstrap3.3.7/css/bootstrap.css" rel="stylesheet">
<script src="${pageContext.request.contextPath }/style/jquery2.1.4/jquery.min.js"></script>
<script src="${pageContext.request.contextPath }/style/bootstrap3.3.7/js/bootstrap.js"></script>

<script>

function modifyInfo() {
	$('#modify').addClass('hidden');
	$('#update').removeClass('hidden');
	$('#cancel').removeClass('hidden');
	$('#email').removeAttr("readonly");
}

function updateInfo() {
	var oldEmail = $('#oldEmail').val();
	var email = $('#email').val();
	if (email == '' || email == null) {
		$('#emailDiv').addClass('has-error');
		$('#emailFailEmpty').modal('show');
        setTimeout(function () {
        	$('#emailFailEmpty').modal('hide');	
         }, 2000);
        return ;
	}
	if (email == oldEmail) {
		$('#emailDiv').addClass('has-error');
		$('#emailFailSame').modal('show');
        setTimeout(function () {
        	$('#emailFailSame').modal('hide');	
         }, 2000);
        return ;
	}
	var myreg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
	if (!myreg.test(email)) {
		$('#emailDiv').addClass('has-error');
		$('#emailFailFormat').modal('show');
        setTimeout(function () {
        	$('#emailFailFormat').modal('hide');	
         }, 2000);
        return ;
	}
	$('#emailDiv').removeClass('has-error');
	$.post( '${pageContext.request.contextPath}/user/update', {
	       'userId':'${user.id}',
	       'email': email,
	   }, function(result){
	       var result = eval ('(' + result + ')');
	       if (result.result)
	       {
	          $('#myModalSuccess').modal('show');
	           setTimeout(function () {
	           	$('#myModalSuccess').modal('hide');
	               window.location.reload();
	           }, 2000);
	       } else {
	           $('#myModalFail').modal('show');
	           setTimeout(function () {
	           	$('#myModalFail').modal('hide');	
	               window.location.reload();
	           }, 2000);
	       }
	   });
}

function cancelInfo() {
	$('#emailDiv').removeClass('has-error');
	$('#email').val($('#oldEmail').val());
	$('#modify').removeClass('hidden');
	$('#update').addClass('hidden');
	$('#cancel').addClass('hidden');
	$('#email').attr("readonly","readonly");
}


</script>



</head>	
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="container-fluid">
	  <div class="col-md-4 col-md-offset-1" >
	       	<ol class="breadcrumb">
				<li class="active">BMS</li>
			    <li><a><spring:message code="userInfo-personal-information" /></a></li>
			</ol>
	       </div>
	       </div>
	</div>
	<div class="container-fluid">
		<div class="col-md-11 column">
			<form class="form-horizontal" role="form">	
				<div class="form-group">
					<label for="inputid3" class="col-sm-3 control-label"><spring:message code="userInfo-user-role" /></label>
						<div class="col-sm-3">
							<input class="form-control" readonly id="inputid3" type="text" value="${user.roleName }" />
						</div>
						<label for="inputEmail3" class="col-sm-1 control-label"><spring:message code="userInfo-user" /></label>
						<div class="col-sm-3">
							<input class="form-control" readonly id="inputEmail3" type="text" value="${user.name}" />
						</div>
				</div>
				<div class="form-group">
					 <label for="inputidNo3" class="col-sm-3 control-label" ><spring:message code="userInfo-ID" /></label>
						<div class="col-sm-3">
							<input class="form-control" readonly id="inputidNo3" type="text" value="${user.idNo}"/>
						</div>
					 <label for="inputEmail3" class="col-sm-1 control-label"><spring:message code="userInfo-user-mail" /></label>
						<div class="col-sm-3" id="emailDiv">
							<input class="form-control" readonly id="email" name="email" type="email" value="${user.email}" />
							<input class="form-control" id="oldEmail" type="hidden" value="${user.email}" />
						</div>
						<button type="button" class="btn btn-primary ${currentUser.id == user.id ? '' : 'hidden' }" id="modify" onclick="modifyInfo()"><spring:message code="userInfo-modify" /></button>
						<button type="button" class="btn btn-info hidden" id="update" onclick="updateInfo()"><spring:message code="userInfo-OK" /></button>
						<button type="button" class="btn btn-primary hidden" id="cancel" onclick="cancelInfo()"><spring:message code="userInfo-cancel" /></button>
				</div>
			</form>
		</div>
	</div>
	
	<!-- modal修改提示 -->
	<div class="modal fade" id="myModalSuccess" tabindex="-2" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
					<h4 class="modal-title" id="myModalLabel">
						<p class="text-primary text-center"><strong><spring:message code="userInfo-success" /></strong></p>
					</h4>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
	</div>
	
	
    <div class="modal fade" id="myModalFail" tabindex="-2" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
					<h4 class="modal-title" id="myModalLabel">
						<p class="text-primary text-center"><strong><spring:message code="userInfo-fail" /></strong></p>
					</h4>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
	</div>
	
	
	<div class="modal fade" id="emailFailSame" tabindex="-2" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
					<h4 class="modal-title" id="myModalLabel">
						<p class="text-primary text-center"><strong><spring:message code="userInfo-new-mail" /></strong></p>
					</h4>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
	</div>
	
	
 <div class="modal fade" id="emailFailEmpty" tabindex="-2" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
					<h4 class="modal-title" id="myModalLabel">
						<p class="text-primary text-center"><strong><spring:message code="userInfo-mail-empty" /></strong></p>
					</h4>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
	</div>
	
 <div class="modal fade" id="emailFailFormat" tabindex="-2" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
					<h4 class="modal-title" id="myModalLabel">
						<p class="text-primary text-center"><strong><spring:message code="userInfo-mail-error" /></strong></p>
					</h4>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
	</div>
	
	
	<div class="container">
	   <div class="row">
	       <div class="col-md-12" >
			<c:choose>
			    <c:when test="${projects != null }">
		      <table class="table table-hover">
				<thead>
					<tr>
				        <th></th>
						<th>
							<spring:message code="userInfo-project-Name" />
						</th>
						<th>
							<spring:message code="userInfo-project-description" />
						</th>
						<th>
							<spring:message code="userManage-createtime" />
						</th>
						<th>
							<spring:message code="userInfo-project-leader" />
						</th>
						<th>
							<spring:message code="userInfo-manage-state" />
						</th>
					</tr>
				</thead>
				<tbody>
    		    	<c:forEach var="project" items="${ projects }" varStatus="status">
						<tr>
	                        <td>${ status.index + 1 }</td>
							<td><a href="${pageContext.request.contextPath }/project/detail?proId=${project.id}" >${project.name }</a></td>
							<td>${project.description }</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd"  value="${project.createDate }" /></td>
							<td>${project.admin.name }</td>
							<td>
								<c:if test='${project.status == 1 }'><span class='glyphicon glyphicon-edit bg-info'></span><spring:message code='developing-project' /></c:if>
						        <c:if test='${project.status == 2 }'><span class='glyphicon glyphicon-check bg-success'></span><spring:message code='completed-project' /></c:if>
							</td>
						</tr>
						</c:forEach>
						</tbody>
					</table>
				    </c:when>
				    <c:otherwise>
				         <div class="well"><strong>没有数据</strong>></div>
				    </c:otherwise>
				</c:choose>

	       </div>
	   </div>
	</div>
	
	<div class="container">
	    <div class="row">
	        <div class="col-md-8 col-md-offset-4">
	               <ul class="pagination">
	                   ${pageCode }
	               </ul>
	        </div>
	    </div>
	</div>
	
	<div class="container">
	   <div class="row">
	       <div class="col-md-12" >
			<c:choose>
			    <c:when test="${bugs != null }">
		      <table class="table table-hover">
				<thead>
					<tr>
				        <th></th>
						<th>
							<spring:message code="Bug_Bnumber" />
						</th>
						<th>
							<spring:message code="Bug_mail_updatetime" />
						</th>
						<th>
							<spring:message code="Bug_mail_describe" />
						</th>
					</tr>
				</thead>
				<tbody>
    		    	<c:forEach var="bug" items="${ bugs }" varStatus="status">
						<tr>
	                        <td>${ status.index + 1 }</td>
							<td><a href="${pageContext.request.contextPath }/bug/view?id=${bug.id}" >${bug.designation}</a></td>
							<td><fmt:formatDate value="${bug.updateDate}" pattern="yyyy-MM-dd" /></td>
							<td>${bug.description}</td>
						</tr>
						</c:forEach>
						</tbody>
					</table>
				    </c:when>
				    <c:otherwise>
				         <div class="well"><strong>没有数据</strong>></div>
				    </c:otherwise>
				</c:choose>

	       </div>
	   </div>
	</div>
	
	<div class="container">
	    <div class="row">
	        <div class="col-md-8 col-md-offset-4">
	               <ul class="pagination">
	                   ${pageCodeBug }
	               </ul>
	        </div>
	    </div>
	</div>
	
</body>
</html>