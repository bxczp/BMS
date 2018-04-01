<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link rel="stylesheet" href="${pageContext.request.contextPath}/style/artdialog/ui-dialog.css">
<link href="${pageContext.request.contextPath }/style/bootstrap3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/style/DataTables-1.10.15/css/dataTables.bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath }/style/jquery2.1.4/jquery.min.js"></script>
<script src="${pageContext.request.contextPath }/style/bootstrap3.3.7/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath }/style/artdialog/dialog.js"></script>
<script src="${pageContext.request.contextPath }/style/DataTables-1.10.15/js/jquery.dataTables.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="project_detail" /></title>

<script>

function showAddAdminDialog(proId) {
	$.ajax({
		url : "${pageContext.request.contextPath}/user/getAdminList",
		type : 'post',
		data : {
			'name': $('#adminName').val()
		},
		success: function(data){
			$('#adminTableBody').html('');
			if (data.length > 0) {
				for(var i=0; i<data.length; i++) {
					$('#adminTableBody').append("<tr><td>"+data[i].name+"</td><td><button type='button' class='btn btn-primary' onclick='addAdmin("+proId+","+data[i].id+")'>指派为组长</button></td></tr>")
				}
			} else {
				$('#adminTableBody').append('<spring:message code="no_data" />')
			}
		},
		error : function(XMLHttpRequest) {
            var d = dialog({
                content: '<spring:message code="fail_search" />'
            });
            d.showModal();
            setTimeout(function () {
                d.close().remove();
                window.location.reload();
            }, 2000);
		}
	});
	var d = dialog({
		title: '<spring:message code="assign_projectleader" />',
		content: $('#adminForm'),
		onclose: function () {
			$('#adminName').val('');
		},
	});
	d.showModal();
}

function addAdmin(proId, userId) {
	$.ajax({
		url : "${pageContext.request.contextPath}/project/addAdmin",
		type : 'post',
		data : {
			'proId':proId,
			'userId': userId
		},
		success: function(data){
            var d = dialog({
                content: '<spring:message code="assign_success" />'
            });
            d.showModal();
            setTimeout(function () {
                d.close().remove();
                window.location.reload();
            }, 2000);
		},
		error : function(XMLHttpRequest) {
            var d = dialog({
                content: '<spring:message code="assign_fail" />'
            });
            d.showModal();
            setTimeout(function () {
                d.close().remove();
                window.location.reload();
            }, 2000);
		}
	});
}

function addMember(proId, userId) {
	$.ajax({
		url : "${pageContext.request.contextPath}/project/addMember",
		type : 'post',
		data : {
			'proId':proId,
			'userId': userId
		},
		success: function(data){
            var d = dialog({
                content: '添加成功'
            });
            d.showModal();
            setTimeout(function () {
                d.close().remove();
                window.location.reload();
            }, 2000);
		},
		error : function(XMLHttpRequest) {
            var d = dialog({
                content: '添加失败'
            });
            d.showModal();
            setTimeout(function () {
                d.close().remove();
                window.location.reload();
            }, 2000);
		}
	});
}


function reloadAdminDate(proId) {
	$.ajax({
		url : "${pageContext.request.contextPath}/user/getAdminList",
		type : 'post',
		data : {
			'name': $('#adminName').val()
		},
		success: function(data){
			$('#adminTableBody').html('');
			if (data.length > 0) {
				for(var i=0; i<data.length; i++) {
					$('#adminTableBody').append("<tr><td>"+data[i].name+"</td><td><button type='button' class='btn btn-primary' onclick='addAdmin("+proId+","+data[i].id+")'>指派为组长</button></td></tr>")
				}
			} else {
				$('#adminTableBody').append('<spring:message code="no_data" />')
			}
		},
		error : function(XMLHttpRequest) {
            var d = dialog({
                content: '<spring:message code="fail_search" />'
            });
            d.showModal();
            setTimeout(function () {
                d.close().remove();
                window.location.reload();
            }, 2000);
		}
	});
}


function reloadMemberDate(proId) {
	$.ajax({
		url : "${pageContext.request.contextPath}/user/getMemberList",
		type : 'post',
		data : {
			'name': $('#memberName').val(),
			'proId': proId
		},
		success: function(data){
			$('#memberTableBody').html('');
			if (data.length > 0) {
				for(var i=0; i<data.length; i++) {
					$('#memberTableBody').append("<tr><td>"+data[i].name+"</td><td><button type='button' class='btn btn-primary' onclick='addMember("+proId+","+data[i].id+")'>添加组员</button></td></tr>")
				}
			} else {
				$('#memberTableBody').append('<spring:message code="no_data" />');
			}
		},
		error : function(XMLHttpRequest) {
            var d = dialog({
                content: '<spring:message code="fail_search" />'
            });
            d.showModal();
            setTimeout(function () {
                d.close().remove();
                window.location.reload();
            }, 2000);
		}
	});
}

function showAddMemberDialog(proId) {
	
	$.ajax({
		url : "${pageContext.request.contextPath}/user/getMemberList",
		type : 'post',
		data : {
			'name': $('memberName').val(),
			'proId': proId
		},
		success: function(data){
			$('#memberTableBody').html('');
			if (data.length > 0) {
				for(var i=0; i<data.length; i++) {
					$('#memberTableBody').append("<tr><td>"+data[i].name+"</td><td><button type='button' class='btn btn-primary' onclick='addMember("+proId+","+data[i].id+")'>添加组员</button></td></tr>")
				}
			} else {
				$('#memberTableBody').append('<spring:message code="no_data" />');
			}
		},
		error : function(XMLHttpRequest) {
            var d = dialog({
                content: '查询失败'
            });
            d.showModal();
            setTimeout(function () {
                d.close().remove();
                window.location.reload();
            }, 2000);
		}
	});
	var d = dialog({
		title: '添加组员',
		content: $('#memberForm'),
		onclose: function () {
			$('#memberName').val('');
		}
	});
	d.showModal();
}

</script>

</head>
<body>

	<jsp:include page="../layout/header.jsp"></jsp:include>
	
	<div class="container-fluid">
	   <div class="row">
	       <div class="col-md-3 col-md-offset-2" >
	       	<ol class="breadcrumb">
				<li>BMS</li>
				<li><a href="${pageContext.request.contextPath }/home"><spring:message code="home_page" /></a></li>
			    <li class="active"><a href="#"><spring:message code="project_detail" /></a></li>
			</ol>
	       </div>
	       
			<div class="col-md-3 col-md-offset-2">
				<form class="form-inline" role="form" action="${pageContext.request.contextPath }/project/detail" method="GET">
				  <div class="form-group">
				    <input type="text" class="form-control" name="designation" placeholder=<spring:message code="enter_bugid" /> value="${designation }">
				    <input type="hidden" name="proId" value="${project.id }">
				  </div>
				  <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search"></span><spring:message code="bug_search" /></button>
				</form>
			</div>
			
	   </div>
	</div>
	
	<div class="container">
	   <div class="row">
	       <div class="col-md-12" >
	    		<div class="panel ${project.status == 1 ? 'panel-info' : '' } ${project.status == 2 ? 'panel-success' : '' }">
					<div class="panel-heading"> 				
	                   ${project.name }
                      <a class="btn ${project.status == 1 ? 'btn-info' : '' } ${project.status == 2 ? 'btn-success' : '' } btn-sm" href="${pageContext.request.contextPath }/project/toanalysis?proId=${project.id}" ></span><spring:message code="project_statistics" /></a>
					</div>
					<div class="panel-body">
						${project.description }
					</div>
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
							<td><spring:message code="project_leader" />：</td><td>
<!-- 					 ////////////////////       -->
<%-- 					        <a class="btn ${currentUser.roleName == 'SuperAdmin' && project.admin.name == null ? '' : 'hidden' } ${project.status == 1 ? 'btn-info' : '' } ${project.status == 2 ? 'btn-success' : '' } btn-sm"  --%>
<%-- 					        href="javascript:0;" onclick="showAddAdminDialog(${project.id})" ><spring:message code="assign_projectleader" /></a> --%>
<!-- 				    /////////////////////////// -->
							<c:if test="${project.admin.name == null || project.admin.name == '' }">
							    <spring:message code="not_assign_leader" />
							</c:if>
							<c:if test="${project.admin.name != null }">
						    	<a href="${pageContext.request.contextPath }/user/getUserInfo?id=${project.admin.id }" class="btn btn-sm ${project.status == 1 ? 'btn-info' : '' } ${project.status == 2 ? 'btn-success' : '' }">${project.admin.name }</a>
							</c:if>
							</td><td></td><td></td>
						</tr>
						<tr><td><spring:message code="project_member" />：</td><td colspan="7">
<!-- 					    //////////////////// -->
<%-- 					    <a class="btn ${currentUser.roleName != 'Member' ? '' : 'hidden' } ${project.status == 1 ? 'btn-info' : '' } ${project.status == 2 ? 'btn-success' : '' } btn-sm" href="javascript:0;" onclick="showAddMemberDialog(${project.id})" ><spring:message code="add_teammembers" /></a> --%>
<!-- 					    ///////////////////// -->
                        <c:if test="${ project.members == null || project.members.size() == 0  }"><spring:message code="no_member" /></c:if>
						<c:forEach var="member" items="${ project.members }" varStatus="status">
						      <a href="${pageContext.request.contextPath }/user/getUserInfo?id=${member.id }" class="btn btn-sm ${project.status == 1 ? 'btn-info' : '' } ${project.status == 2 ? 'btn-success' : '' }">${ member.name }</a>
						</c:forEach>
						</td></tr>
					</table>
				</div>
	       </div>
	   </div>
	</div>
	
	<div class="container">
	   <div class="row">
	       <div class="col-md-12" >
			<c:choose>
			    <c:when test="${project.bugs != null }">
		      <table class="table table-striped">
		      <caption><spring:message code="bug_list" /></caption>
				<thead>
					<tr>
				        <th></th>
						<th><spring:message code="bug_ID" /></th>
						<th><spring:message code="bug_type" /></th>
						<th><spring:message code="bug_priority" /></th>
						<th><spring:message code="bug_condition" /></th>
						<th><spring:message code="bug_description" /></th>
					</tr>
				</thead>
				<tbody>
    		    	<c:forEach var="bug" items="${ project.bugs }" varStatus="status">
						<tr>
	                        <td>${status.index + 1 }</td>
							<td><a href="${pageContext.request.contextPath }/bug/view?id=${bug.id}">${bug.designation }</a></td>
							<td><span class="label label-default ${bug.category == 5 ? 'label-danger' : ''  } ${bug.category == 4 ? 'label-warning' : ''  } ${bug.category == 3 ? 'label-info' : ''  } 
							                       ${bug.category == 2 ? 'label-primary' : ''  } ${bug.category == 1 ? 'label-default' : ''  }">${bug.categoryLabel }</span></td>
							<td><span class="label label-primary ${bug.priority == 4 ? 'label-danger' : ''  } ${bug.priority == 3 ? 'label-warning' : ''  } 
							                       ${bug.priority == 2 ? 'label-info' : ''  } ${bug.priority == 1 ? 'label-primary' : ''  }">${bug.priorityLabel }</span> </td>
							<td><span class="glyphicon glyphicon-floppy-saved ${bug.status == 5 ? '' : 'hidden' }"></span>
							     <span class="glyphicon glyphicon-ok ${bug.status == 4 ? '' : 'hidden' }"></span>
							     <span class="glyphicon glyphicon-check ${bug.status == 3 ? '' : 'hidden' }"></span>
							     <span class="glyphicon glyphicon-new-window ${bug.status == 2 ? '' : 'hidden' }"></span>
							     <span class="glyphicon glyphicon-remove ${bug.status == 1 ? '' : 'hidden' }"></span>${bug.statusLabel }</td>
							<td>${bug.description }</td>
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
	
	<div class="hidden">
		<form class="form-inline" id="adminForm" role="form">
			<div class="form-group">
				<label class="sr-only" for="name"><spring:message code="leader_name" /></label>
				<input type="text" class="form-control" id="adminName" 
					   placeholder="<spring:message code="project_leadersearch" />">
			</div>
			<button type="button" class="btn btn-default" onclick="reloadAdminDate(${project.id})"><spring:message code="man_search" /></button>
			<table class="table table-hover" id="adminTable">
				<caption><spring:message code="query_results" /></caption>
				<thead>
					<tr>
						<th><spring:message code="leader_name" /></th>
						<th><spring:message code="operation" /></th>
					</tr>
				</thead>
				<tbody id="adminTableBody">
				</tbody>
			</table>
		</form>
	</div>
	
	<div class="hidden">	
		<form class="form-inline" id="memberForm" role="form">
			<div class="form-group">
				<label class="sr-only" for="name"><spring:message code="member_name" /></label>
				<input type="text" class="form-control" id="memberName" 
					   placeholder="<spring:message code="project_membersearch" />">
			</div>
			<button type="button" class="btn btn-default" onclick="reloadMemberDate(${project.id})"><spring:message code="man_search" /></button>
			<table class="table table-striped" id="memberTable">
				<caption><spring:message code="query_results" /></caption>
				<thead>
					<tr>
						<th><spring:message code="member_name" /></th>
						<th><spring:message code="operation" /></th>
					</tr>
				</thead>
				<tbody id="memberTableBody">
				</tbody>
			</table>
		</form>
	</div>

</body>
</html>