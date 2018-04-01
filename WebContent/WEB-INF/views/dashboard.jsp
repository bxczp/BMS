<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link href="${pageContext.request.contextPath }/style/bootstrap3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath }/style/jquery2.1.4/jquery.min.js"></script>
<script src="${pageContext.request.contextPath }/style/bootstrap3.3.7/js/bootstrap.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="home-page" /></title>

<script>

    function changeUp(proId) {
    	var down = '#down' + proId;
    	var up = '#up' + proId;
    	$(down).addClass('hidden');
    	$(up).removeClass('hidden');
    }
    
    function changeDwon(proId) {
    	var down = '#down' + proId;
    	var up = '#up' + proId;
    	$(up).addClass('hidden');
    	$(down).removeClass('hidden');
    }
</script>

</head>
<body>


	<jsp:include page="layout/header.jsp"></jsp:include>
	
	<div class="container-fluid">
	   <div class="row">
	       <div class="col-md-3 col-md-offset-1" >
	       	<ol class="breadcrumb">
				<li class="active">BMS</li>
			    <li><a href="#"><spring:message code="home-page" /></a></li>
			</ol>
	       </div>
	       
			<div class="col-md-3 col-md-offset-3 ${bug ? 'hidden' : '' }">
				
				<form class="form-inline" role="form" action="${pageContext.request.contextPath }/home" method="GET">
				  <div class="form-group">
				    <input type="text" class="form-control" name="name" placeholder="<spring:message code="input-project" />" value="${name }">
				    <input type="hidden" name="status" value="${status }">
				  </div>
				  <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search"></span><spring:message code="userManage-search" /></button>
				</form>
				
			</div>
			
	   </div>
	</div>
	
	<div class="container">
	   <div class="row">
	       <div class="col-md-6" >
				<ul class="nav nav-pills">
					<li class="${bug ? '' : 'active' }"><a href="${pageContext.request.contextPath }/home"><spring:message code="my-project" /></a></li>
					<li class="${bug ? 'active' : '' }"><a href="${pageContext.request.contextPath }/home?view=bug"><spring:message code="my-bug" /></a></li>
				</ul>	
		  </div>
	   </div>
	</div>

	<div class="container ${bug ? 'hidden' : '' }">
	   <div class="row">
	       <div class="col-md-12" >
				<ul class="nav nav-tabs nav-justified">
					<li class="${status == null ? 'active' : '' }" ><a href="${pageContext.request.contextPath }/home"><span class="glyphicon glyphicon-home"></span><spring:message code="all_project" /></a></li>
					<li class="${status == 1 ? 'active' : '' }" ><a href="${pageContext.request.contextPath }/home?status=1"><span class="glyphicon glyphicon-edit"></span><spring:message code="project_underdevelop" /></a></li>
					<li class="${status == 2 ? 'active' : '' }" ><a href="${pageContext.request.contextPath }/home?status=2"><span class="glyphicon glyphicon-check"></span><spring:message code="project_developed" /></a></li>
				</ul>	       
	       </div>
	   </div>
	</div>
	
	<div class="container ${bug ? '' : 'hidden' }">
	   <div class="row">
	       <div class="col-md-12" >
				<ul class="nav nav-tabs nav-justified">
					<li class="${status == null ? 'active' : '' }" ><a href="${pageContext.request.contextPath }/home?view=bug"><span class="glyphicon glyphicon-home"></span><spring:message code="all-bug" /></a></li>
					<li class="${status == 2 ? 'active' : '' }" ><a href="${pageContext.request.contextPath }/home?view=bug&status=2"><span class="glyphicon glyphicon-edit"></span><spring:message code="un-bug" /></a></li>
					<li class="${status == 4 ? 'active' : '' }" ><a href="${pageContext.request.contextPath }/home?view=bug&status=4"><span class="glyphicon glyphicon-check"></span><spring:message code="al-bug" /></a></li>
					<li class="${status == 3 ? 'active' : '' }" ><a href="${pageContext.request.contextPath }/home?view=bug&status=3"><span class="glyphicon glyphicon-pencil"></span><spring:message code="co-bug" /></a></li>
					<li class="${status == 5 ? 'active' : '' }" ><a href="${pageContext.request.contextPath }/home?view=bug&status=5"><span class="glyphicon glyphicon-ok"></span><spring:message code="cl-bug" /></a></li>
				</ul>	       
	       </div>
	   </div>
	</div>
	
	
	<div class="container ${bug ? 'hidden' : '' }">
	   <div class="row">
	       <div class="col-md-12" >
			<c:choose>
			    <c:when test="${ projects != null and projects.size() != 0 }">
			    	<c:forEach var="project" items="${ projects }" varStatus="status">
			    	<div class="panel ${project.status == 1 ? 'panel-info' : '' } ${project.status == 2 ? 'panel-success' : '' }">
						<div class="panel-heading"> 				
		                   <a href="${pageContext.request.contextPath }/project/detail?proId=${project.id}">${project.name }</a>
				           <a data-toggle="collapse" data-parent="#accordion" href="#collapse${project.id }" title="</span><spring:message code="detail" />">
					          <span id="down${project.id }" onclick="changeUp(${project.id })" class="glyphicon glyphicon-chevron-down"></span>
					          <span id="up${project.id }" onclick="changeDwon(${project.id })" class="glyphicon glyphicon-chevron-up hidden"></span>
					       </a>
						</div>
						<div class="panel-body">
							${project.description }
						</div>
						
						<div id="collapse${project.id }" class="panel-collapse collapse ">			
							<table class="table">
								<tr>
									<td><spring:message code="project_status" />：</td><td>
    								<c:if test='${project.status == 1 }'><span class='glyphicon glyphicon-edit'></span><spring:message code='developing-project' /></c:if>
							        <c:if test='${project.status == 2 }'><span class='glyphicon glyphicon-check'></span><spring:message code='completed-project' /></c:if>
									</td>
									<td><spring:message code="project_createtime" />：</td>
									<td>
									<span class="glyphicon glyphicon-time text-left"></span> 
									<fmt:formatDate pattern="yyyy-MM-dd"  value="${project.createDate }" />
									</td>
									<td><spring:message code="userInfo-project-leader" />：</td><td>
									<c:if test="${project.admin.name != null }">
								    	<a href="${pageContext.request.contextPath }/user/getUserInfo?id=${project.admin.id }" class="btn btn-sm ${project.status == 1 ? 'btn-info' : '' } ${project.status == 2 ? 'btn-success' : '' }" >${project.admin.name }</a>
									</c:if>
     								<c:if test="${project.admin.name == null }">
								    	<spring:message code="no-project-leader" />
									</c:if>
									</td><td></td><td></td>
								</tr>
								<tr><td><spring:message code="project_member" />：</td><td colspan="7">
								<c:if test="${ project.members.size() != 0 }">
									<c:forEach var="member" items="${ project.members }" varStatus="status">
									  <a href="${pageContext.request.contextPath }/user/getUserInfo?id=${member.id }" class="btn btn-sm ${project.status == 1 ? 'btn-info' : '' } ${project.status == 2 ? 'btn-success' : '' }">${ member.name }</a>
									</c:forEach>
								</c:if>
								<c:if test="${ project.members.size() == 0 }">
								    <spring:message code="no-member" />
								</c:if>
								</td></tr>
							</table>
						</div>
					</div>    	
					</c:forEach>
			    </c:when>
			    <c:otherwise>
			        <div class="well"><spring:message code="no-data" />！</div>
			    </c:otherwise>
			</c:choose>
			
	       </div>
	   </div>
	</div>
	
	<div class="container ${bug ? '' : 'hidden' }">
	   <div class="row">
	       <div class="col-md-12" >
			<c:choose>
			    <c:when test="${ bugs != null and bugs.size() != 0 }">
			    	<c:forEach var="bug" items="${ bugs }" varStatus="status">
			    	<div class="panel ${bug.status == 2 || bug.status == 3 ? 'panel-info' : '' } ${bug.status == 4 || bug.status == 5 ? 'panel-success' : '' } ">
						<div class="panel-heading"> 				
		                   <a href="${pageContext.request.contextPath }/bug/view?id=${bug.id}">${bug.designation }</a>
						</div>
						<div class="panel-body">
							${bug.description }
						</div>

					<table class="table">
						<tr>
							<td><spring:message code="bug_status" />：</td>
							<td>
							<span class="glyphicon glyphicon-floppy-saved ${bug.status == 5 ? '' : 'hidden' }"></span>
							     <span class="glyphicon glyphicon-ok ${bug.status == 4 ? '' : 'hidden' }"></span>
							     <span class="glyphicon glyphicon-check ${bug.status == 3 ? '' : 'hidden' }"></span>
							     <span class="glyphicon glyphicon-new-window ${bug.status == 2 ? '' : 'hidden' }"></span>
							     <span class="glyphicon glyphicon-remove ${bug.status == 1 ? '' : 'hidden' }"></span>${bug.statusLabel }
							</td>
							<td><spring:message code="bug_type" /></td>
							<td><span class="label label-primary ${bug.priority == 4 ? 'label-danger' : ''  } ${bug.priority == 3 ? 'label-warning' : ''  } 
							                       ${bug.priority == 2 ? 'label-info' : ''  } ${bug.priority == 1 ? 'label-primary' : ''  }">${bug.priorityLabel }</span> </td>
							 <td><spring:message code="bug_priority" /></td>
							 <td>
							 <span class="label label-default ${bug.category == 5 ? 'label-danger' : ''  } ${bug.category == 4 ? 'label-warning' : ''  } ${bug.category == 3 ? 'label-info' : ''  } 
							                       ${bug.category == 2 ? 'label-primary' : ''  } ${bug.category == 1 ? 'label-default' : ''  }">${bug.categoryLabel }</span>
							</td>
							<td><spring:message code="Bug_time" />：</td>
							<td>
							<span class="glyphicon glyphicon-time text-left"></span> 
							<fmt:formatDate pattern="yyyy-MM-dd"  value="${bug.createDate }" />
							</td>
						</tr>
					</table>	
					</div>    
					</c:forEach>
			    </c:when>
			    <c:otherwise>
			        <div class="well"><spring:message code="no-data" />！</div>
			    </c:otherwise>
			</c:choose>
			
	       </div>
	   </div>
	</div>
	

</body>
</html>