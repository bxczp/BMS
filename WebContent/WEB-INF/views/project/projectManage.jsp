<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link rel="stylesheet" href="${pageContext.request.contextPath}/style/artdialog/ui-dialog.css">
<link href="${pageContext.request.contextPath }/style/bootstrap3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath }/style/jquery2.1.4/jquery.min.js"></script>
<script src="${pageContext.request.contextPath }/style/bootstrap3.3.7/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath }/style/artdialog/dialog.js"></script>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="project_manage" /></title>

<script type="text/javascript">

function updateComplete(proId) {
    dialog({
        title: '<spring:message code="Information-OK" />',
        content: '<spring:message code="ensure_complete_project" />',
        okValue: '<spring:message code="userInfo-OK" />',
        ok: function () {
            $.post('${pageContext.request.contextPath}/project/updateComplete', {
                'proId': proId
            }, function(result){
                var result = eval ('(' + result + ')');
                if (result.result)
                {
                    var d = dialog({
                        content: '<spring:message code="update_success" />'
                    });
                    d.showModal();
                    setTimeout(function () {
                        d.close().remove();
                        window.location.reload();
                    }, 2000);
                } else {
                    var d = dialog({
                        content: '<spring:message code="update_success" />'
                    });
                    d.showModal();
                    setTimeout(function () {
                        d.close().remove();
                        window.location.reload();
                    }, 2000);
                }
            });
        },
        cancelValue: '<spring:message code="userInfo-cancel" />',
        cancel: function () {
        }
    }).showModal();
}

</script>

</head>
<body>


	<jsp:include page="../layout/header.jsp"></jsp:include>
	
	<div class="container-fluid">
	   <div class="row">
	       <div class="col-md-3 col-md-offset-1" >
	       	<ol class="breadcrumb">
			<li>BMS</li>
			<li><a class="active"><spring:message code="project_manage" /></a></li>
			</ol>
	       </div>
	       
	       <div class="col-md-1 col-md-offset-4" >
	      		 <a type="button" href="${pageContext.request.contextPath }/project/preSave" class="btn btn-success ${currentUser.roleName == 'SuperAdmin' ? '' : 'hidden' }"><spring:message code="create_project" /></a>
	       </div>
			
	   </div>
	</div>
	
	
	<div class="container">
	   <div class="row">
	       <div class="col-md-6" >
				<ul class="nav nav-pills">
					<li class="${status == null ? 'active' : '' }"><a href="${pageContext.request.contextPath }/project/manage"><spring:message code="all_project" /><span class="${status == null ? '' : 'hidden' } badge">${allSize }</span></a></li>
					<li class="${status == 1 ? 'active' : '' }"><a href="${pageContext.request.contextPath }/project/manage?status=1"><spring:message code="project_underdevelop" /><span class="${status == 1 ? '' : 'hidden' } badge">${duringSize }</span></a></li>
					<li class="${status == 2 ? 'active' : '' }"><a href="${pageContext.request.contextPath }/project/manage?status=2"><spring:message code="project_developed" /><span class="${status == 2 ? '' : 'hidden' } badge">${finishSize }</span></a></li>
				</ul>	
		  </div>
          <div class="col-md-6" >   
			    <form class="form-inline" role="form" action="${pageContext.request.contextPath }/project/manage" method="GET">
				  <div class="form-group">
				    <input type="text" class="form-control ${currentUser.roleName == 'SuperAdmin' ? '' : 'hidden' }" name="leaderName" placeholder="<spring:message code="project_leadersearch" />" value="${leaderName }">
				    <input type="text" class="form-control" name="name" placeholder="<spring:message code="please_project_name" />" value="${name }">
				    <input type="hidden" name="status" value="${status }">
				  </div>
				  <button type="submit" class="btn btn-default"><spring:message code="bug_search" /></button>
				</form>       
	       </div>
	   </div>
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
						<th><spring:message code="project_name" /></th>
						<th><spring:message code="project_description" /></th>
						<th><spring:message code="project_createtime" /></th>
						<th><spring:message code="project_leader" /></th>
						<th><spring:message code="operation" /></th>
					</tr>
				</thead>
				<tbody>
    		    	<c:forEach var="project" items="${ projects }" varStatus="status">
						<tr>
	                        <td>${ status.index + 1 }</td>
							<td><a href="${pageContext.request.contextPath }/project/detail?proId=${project.id}">
							<c:choose> 
						     <c:when test="${fn:length(project.name) > 10}"> 
						      <c:out value="${fn:substring(project.name, 0, 10)}......" /> 
						     </c:when> 
						     <c:otherwise> 
						      <c:out value="${project.name}" /> 
						     </c:otherwise>
						    </c:choose>
							</a></td>
							<td>
							<c:choose> 
						     <c:when test="${fn:length(project.description) > 10}"> 
						      <c:out value="${fn:substring(project.description, 0, 10)}......" /> 
						     </c:when> 
						     <c:otherwise> 
						      <c:out value="${project.description}" /> 
						     </c:otherwise>
						    </c:choose>
							</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd"  value="${project.createDate }" /></td>
							<td>${project.admin.name }</td>
							<td>
							    <a type="button" href="${pageContext.request.contextPath }/project/preSave?proId=${project.id}" class="btn btn-info btn-sm ${project.status == 2 ? 'hidden' : ''}"><spring:message code="modify_project" /></a>
							    <button type="button" onclick="updateComplete(${project.id})"  class="btn btn-success btn-sm ${project.status == 2 ? 'hidden' : ''}"><spring:message code="to_finish" /></button>
							    <a type="button" class="btn btn-primary btn-sm" href="${pageContext.request.contextPath }/project/detail?proId=${project.id}"><spring:message code="view_project" /></a>
							</td>
						</tr>
						</c:forEach>
						</tbody>
					</table>
				    </c:when>
				    <c:otherwise>
				         <div class="well"><spring:message code="no_data" /></div>
				    </c:otherwise>
				</c:choose>

	       </div>
	   </div>
	</div>
	
	<div class="container">
	    <div class="row">
	        <div class="col-md-5 col-md-offset-4">
	               <ul class="pagination">
	                   ${pageCode }
	               </ul>
	        </div>
	    </div>
	</div>

</body>
</html>