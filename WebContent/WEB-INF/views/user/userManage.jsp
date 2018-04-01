<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link rel="stylesheet" href="${pageContext.request.contextPath}/style/artdialog/ui-dialog.css">
<link href="${pageContext.request.contextPath }/style/bootstrap3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath }/style/jquery2.1.4/jquery.min.js"></script>
<script src="${pageContext.request.contextPath }/style/bootstrap3.3.7/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath }/style/artdialog/dialog.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="userManage-usermanage" /></title>

<script type="text/javascript">

//删除的对话框
function showDeleteDialog(userId) {
    dialog({
        title: '<spring:message code="Information-OK" />',
        content: '<spring:message code="delete-username" />？',
        okValue: '<spring:message code="userInfo-OK" />',
        ok: function () {
            $.post('${pageContext.request.contextPath}/user/delete', {
                'userId': userId
            }, function(result){
                var result = eval ('(' + result + ')');
                if (result.result)
                {
                    var d = dialog({
                        content: '<spring:message code="deleted-success" />'
                    });
                    d.showModal();
                    setTimeout(function () {
                        d.close().remove();
                        window.location.reload();
                    }, 2000);
                } else {
                    var d = dialog({
                        content: '<spring:message code="deleted-fail" />'
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

// 更新为普通用户对话框
function showUpdateMemberDialog(userId) {
    dialog({
        title: '<spring:message code="Information-OK" />',
        content: '<spring:message code="update-username" />？',
        okValue: '<spring:message code="userInfo-OK" />',
        ok: function () {
            $.post('${pageContext.request.contextPath}/user/update', {
                'userId': userId,
                'roleName':'Member'
            }, function(result){
                var result = eval ('(' + result + ')');
                if (result.result)
                {
                    var d = dialog({
                        content: '<spring:message code="update-success" />'
                    });
                    d.showModal();
                    setTimeout(function () {
                        d.close().remove();
                    }, 2000);
                    $('#roleName'+userId).html('<spring:message code="userManage-generaluser" />');
                    $('#MemberBtn'+userId).addClass('hidden');
                    $('#AdminBtn'+userId).removeClass('hidden');
                } else {
                    var d = dialog({
                        content: '<spring:message code="update-fail" />'
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

// 更新为管理员 对话框
function showUpdateAdminDialog(userId) {
    dialog({
        title: '<spring:message code="Information-OK" />',
        content: '<spring:message code="update-admin" />？',
        okValue: '<spring:message code="userInfo-OK" />',
        ok: function () {
            $.post('${pageContext.request.contextPath}/user/update', {
                'userId': userId,
                'roleName' :'Admin'
            }, function(result){
                var result = eval ('(' + result + ')');
                if (result.result)
                {
                    var d = dialog({
                        content: '<spring:message code="update-success" />'
                    });
                    d.showModal();
                    setTimeout(function () {
                        d.close().remove();
                    }, 2000);
                    $('#roleName'+userId).html('<spring:message code="userManage-administrator" />');
                    $('#MemberBtn'+userId).removeClass('hidden');
                    $('#AdminBtn'+userId).addClass('hidden');
                } else {
                    var d = dialog({
                        content: '<spring:message code="update-fail" />'
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

			<li><a class="active"><spring:message code="userManage-usermanage" /></a></li>

			</ol>
	       </div>
	       
			<div class="col-md-3 col-md-offset-3">
				
				<form class="form-inline" role="form" action="${pageContext.request.contextPath }/user/manage" method="GET">
				  <div class="form-group">
				    <input type="text" class="form-control" name="name" placeholder="<spring:message code="userManage-username" />" value="${name }">
				    <input type="hidden" name="roleName" value="${roleName }">
				  </div>
				  <button type="submit" class="btn btn-default"><spring:message code="userManage-search" /></button>
				</form>
				
			</div>
			
	   </div>
	</div>
	
	
	<div class="container">
	   <div class="row">
	       <div class="col-md-12" >
				<ul class="nav nav-tabs nav-justified">
					<li class="${roleName == null ? 'active' : '' }" ><a href="${pageContext.request.contextPath }/user/manage"><spring:message code="userManage-alluser" /></a></li>
					<li class="${roleName == 'Admin' ? 'active' : '' }" ><a href="${pageContext.request.contextPath }/user/manage?roleName=Admin"><spring:message code="userManage-administrator" /></a></li>
					<li class="${roleName == 'Member' ? 'active' : '' }" ><a href="${pageContext.request.contextPath }/user/manage?roleName=Member"><spring:message code="userManage-generaluser" /></a></li>
				</ul>	       
	       </div>
	   </div>
	</div>
	
	<div class="container">
	   <div class="row">
	       <div class="col-md-12" >
			<c:choose>
			    <c:when test="${users != null }">
		      <table class="table table-hover">
				<thead>
					<tr>
				        <th></th>
						<th><spring:message code="userManage-user" /></th>
						<th><spring:message code="userManage-ID" /></th>
						<th><spring:message code="userManage-mail" /></th>
						<th><spring:message code="userManage-createtime" /></th>
						<th><spring:message code="userManage-role" /></th>
						<th><spring:message code="userManage-operator" /></th>
					</tr>
				</thead>
				<tbody>
    		    	<c:forEach var="user" items="${ users }" varStatus="status">
						<tr>
	                        <td>${ status.index + 1 }</td>
							<td><a href="${pageContext.request.contextPath }/user/getUserInfo?id=${user.id }">${user.name }</a></td>
							<td>${user.idNo }</td>
							<td>${user.email }</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd"  value="${user.createDate }" /></td>
							<td id="roleName${user.id }">
							<label class="${user.roleName == 'Admin' ?  '' : 'hidden'}"><spring:message code='userManage-administrator' /></label>
							<label class="${user.roleName == 'Member' ?  '' : 'hidden'}"><spring:message code='userManage-generaluser' /></label>
							</td>
							<td>
							    <button id="MemberBtn${user.id }" type="button" onclick="showUpdateMemberDialog(${user.id})" class="btn btn-primary btn-sm ${user.roleName == 'Member' ? 'hidden' : ''}"><spring:message code="userManage-update-generaluser" /></button>
							    <button id="AdminBtn${user.id }" type="button" onclick="showUpdateAdminDialog(${user.id})" class="btn btn-info btn-sm ${user.roleName == 'Admin' ? 'hidden' : ''}"><spring:message code="userManage-update-administrator" /></button>
							    <button type="button" onclick="showDeleteDialog(${user.id})" class="btn btn-danger btn-sm"><spring:message code="userManage-deleteuser" /></button>
							</td>
						</tr>
						</c:forEach>
						</tbody>
					</table>
				    </c:when>
				    <c:otherwise>
				         <div class="well"><spring:message code="no-data" /></div>
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