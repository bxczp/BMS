<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>
<c:if test="${edit}">
<spring:message code="edit-project" />
</c:if>
<c:if test="${!edit}">
<spring:message code="create-project" />
</c:if>
<spring:message code="project" />
</title>

<script>

$(function(){
	$("#projectForm :input").change(function() { 
		$("#projectForm").data("changed",true);
	});
});

var leaderId = null;
var memberIds = new Array();
var memberNames = new Array();
var proId = '$(project.id)';

function checkUpdateForm(proId) {
	var name = $('#name').val();
	var description = $('#description').val();
	if (name == null || name == '') {
		$('#nameDiv').addClass('has-error');
        var d = dialog({
            content: '<spring:message code="null_projectname" />'
        });
        d.showModal();
        setTimeout(function () {
            d.close().remove();
        }, 1000);
		return;
	} else {
		$('#nameDiv').removeClass('has-error');
	}
	if (description == null || description == '') {
		$('#descriptionDiv').addClass('has-error');
        var d = dialog({
            content: '<spring:message code="null_projectdescription" />'
        });
        d.showModal();
        setTimeout(function () {
            d.close().remove();
        }, 1000);
		return;
	} else {
		$('#descriptionDiv').removeClass('has-error');
	}
	if (!$("#projectForm").data("changed")) {
        var d = dialog({
            content: '<spring:message code="shouldnot_update" />'
        });
        d.showModal();
        setTimeout(function () {
            d.close().remove();
        }, 2000);
		return;
	}
	$.ajax({
		url : "${pageContext.request.contextPath}/project/save",
		type : 'post',
		data : {
			'proId':proId,
			'name':name,
			'description':description,
		},
		success: function(data){
			var result = eval('('+data+')');
			if (result.result) {
	            var d = dialog({
	                content: '<spring:message code="update_success" />'
	            });
	            d.showModal();
	            setTimeout(function () {
	            	window.location.href="${pageContext.request.contextPath }/project/manage";
	            }, 1000);
			} else {
	            var d = dialog({
	                content: '<spring:message code="update_fail" />'
	            });
	            d.showModal();
	            setTimeout(function () {
	                d.close().remove();
	                window.location.reload();
	            }, 1000);
			}
		},
		error : function(XMLHttpRequest) {
            var d = dialog({
                content: '<spring:message code="update_fail" />'
            });
            d.showModal();
            setTimeout(function () {
                d.close().remove();
                window.location.reload();
            }, 1000);
		}
	});
}


function checkAddForm(proId) {
	var name = $('#name').val();
	var description = $('#description').val();
	if (name == null || name == '') {
		$('#nameDiv').addClass('has-error');
        var d = dialog({
            content: '<spring:message code="null_projectname" />'
        });
        d.showModal();
        setTimeout(function () {
            d.close().remove();
        }, 1000);
		return;
	} else {
		$('#nameDiv').removeClass('has-error');
	}
	if (description == null || description == '') {
		$('#descriptionDiv').addClass('has-error');
        var d = dialog({
            content: '<spring:message code="null_projectdescription" />'
        });
        d.showModal();
        setTimeout(function () {
            d.close().remove();
        }, 1000);
		return;
	} else {
		$('#descriptionDiv').removeClass('has-error');
	}
	if (leaderId == null || leaderId == '') {
        var d = dialog({
            content: '<spring:message code="please_assign_leader" />'
        });
        d.showModal();
        setTimeout(function () {
            d.close().remove();
        }, 1000);
        showAddAdminDialog(proId);
        return;
	}
	$.ajax({
		url : "${pageContext.request.contextPath}/project/save",
		type : 'post',
		data : {
			'proId':proId,
			'name':name,
			'description':description,
			'leaderId':leaderId,
			'memberIds':memberIds.join(',')
		},
		success: function(data){
			var result = eval('('+data+')');
			if (result.result) {
	            var d = dialog({
	                content: '<spring:message code="create_successfully" />'
	            });
	            d.showModal();
	            setTimeout(function () {
	            	window.location.href="${pageContext.request.contextPath }/project/manage";
	            }, 1000);
			} else {
	            var d = dialog({
	                content: '<spring:message code="create_failed" />'
	            });
	            d.showModal();
	            setTimeout(function () {
	                d.close().remove();
	                window.location.reload();
	            }, 1000);
			}
		},
		error : function(XMLHttpRequest) {
            var d = dialog({
                content: '<spring:message code="create_failed" />'
            });
            d.showModal();
            setTimeout(function () {
                d.close().remove();
                window.location.reload();
            }, 1000);
		}
	});
}


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
					if (proId　== null || proId == '') {
						$('#adminTableBody').append("<tr><td>"+data[i].name+"</td><td><button type='button' class='btn btn-primary' onclick='addAdminWithoutProId("+data[i].id+",\""+data[i].name+"\")'><spring:message code='add-admin' /></button></td></tr>");
					} else {
						if (data[i].id == '${project.admin.id }') {
							continue;
						} else {
							$('#adminTableBody').append("<tr><td>"+data[i].name+"</td><td><button type='button' class='btn btn-primary' onclick='addAdmin("+proId+","+data[i].id+",\""+data[i].name+"\")'><spring:message code='add-admin' /></button></td></tr>");
						}
					}
				}
			} else {
				$('#adminTableBody').append('<spring:message code="no_data" />')
			}
		},
		error : function(XMLHttpRequest) {
            var d = dialog({
                content: '<spring:message code="search_failed" />'
            });
            d.showModal();
            setTimeout(function () {
                d.close().remove();
                window.location.reload();
            }, 1000);
		}
	});
	$('#adminDiv').removeClass('hidden');
	$('#hideAdmin').removeClass('hidden');
	$('#showAdmin').addClass('hidden');
}

function showMember () {
	$('#membersDiv').html('');
	for (var i=0;i<memberIds.length;i++) {
		$('#membersDiv').append("<a style='margin-left:5px;margin-right:5px;' href='${pageContext.request.contextPath }/user/getUserInfo?id="+memberIds[i] +"' class='btn btn-sm btn-success'>"+memberNames[i]+"</a>");
	}
}

function hideAddAdminDialog(proId) {
	$('#adminName').val('');
	$('#adminDiv').addClass('hidden');
	$('#hideAdmin').addClass('hidden');
	$('#showAdmin').removeClass('hidden');
}

function addAdminWithoutProId(userId, userName) {
	leaderId = userId;
	$('#leader').attr("href","${pageContext.request.contextPath }/user/getUserInfo?id="+userId);
	$('#leader').text(userName);
	$('#leader').removeClass('hidden');
	$('#showAdmin').addClass('hidden');
	$('#hideAdmin').addClass('hidden');
	$('#adminDiv').addClass('hidden');
    var d = dialog({
	    content: '<spring:message code="add_successfully" />'
	});
	d.showModal();
	setTimeout(function () {
	    d.close().remove();
	}, 1000);
}

function addMemberWithoutProId(userId, userName) {
	    $('#member'+userId).addClass('hidden');
	    memberIds.push(userId);
	    memberNames.push(userName);
         var d = dialog({
             content: '<spring:message code="add_successfully" />'
         });
         d.showModal();
         setTimeout(function () {
             d.close().remove();
         }, 1000);
         showMember();
}

function addAdmin(proId, userId, userName) {
	$.ajax({
		url : "${pageContext.request.contextPath}/project/addAdmin",
		type : 'post',
		data : {
			'proId':proId,
			'userId': userId
		},
		success: function(data){
			var result = eval('('+data+')');
			if (result.result) {
	            var d = dialog({
	                content: '<spring:message code="assign_success_leaderupdate" />'
	            });
	            d.showModal();
	            setTimeout(function () {
	                d.close().remove();
	                window.location.reload();
	            }, 1000);
			} else {
	            var d = dialog({
	                content: '<spring:message code="assign_fail" />'
	            });
	            d.showModal();
	            setTimeout(function () {
	                d.close().remove();
	                window.location.reload();
	            }, 1000);
			}
		},
		error : function(XMLHttpRequest) {
            var d = dialog({
                content: '<spring:message code="assign_fail" />'
            });
            d.showModal();
            setTimeout(function () {
                d.close().remove();
                window.location.reload();
            }, 1000);
		}
	});
}

function addMember(proId, userId, userName) {
	$.ajax({
		url : "${pageContext.request.contextPath}/project/addMember",
		type : 'post',
		data : {
			'proId':proId,
			'userId': userId
		},
		success: function(data){
			var result = eval('('+data+')');
			if (result.result) {
	            var d = dialog({
	                content: '<spring:message code="assign_success_memberupdate" />'
	            });
	            d.showModal();
	            setTimeout(function () {
	                d.close().remove();
	                window.location.reload();
	            }, 1000);
			} else {
	            var d = dialog({
	                content: '<spring:message code="add_failed" />'
	            });
	            d.showModal();
	            setTimeout(function () {
	                d.close().remove();
	                window.location.reload();
	            }, 1000);
			}
		},
		error : function(XMLHttpRequest) {
            var d = dialog({
                content: '<spring:message code="add_failed" />'
            });
            d.showModal();
            setTimeout(function () {
                d.close().remove();
                window.location.reload();
            }, 1000);
		}
	});
}

function showDeleteDialog(proId, userId, userName) {
    dialog({
        title: '<spring:message code="Information-OK" />',
        content: '<spring:message code="ensure_delete_teammember" />',
        okValue: '<spring:message code="userInfo-OK" />',
        ok: function () {
            $.post('${pageContext.request.contextPath}/project/deleteMember', {
    			'proId':proId,
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
					if (proId == null || proId == '') {
						$('#adminTableBody').append("<tr><td>"+data[i].name+"</td><td><button type='button' class='btn btn-primary' onclick='addAdminWithoutProId("+data[i].id+",\""+data[i].name+"\")'><spring:message code='add-admin' /></button></td></tr>");
					} else {
						if (data[i].id == '${project.admin.id }') {
							continue;
						} else {
        					$('#adminTableBody').append("<tr><td>"+data[i].name+"</td><td><button type='button' class='btn btn-primary' onclick='addAdmin("+proId+","+data[i].id+",\""+data[i].name+"\")'><spring:message code='add-admin' /></button></td></tr>");
						}
					}
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
            }, 1000);
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
			var arrayIds = new Array();  
			var arrayNames = new Array();
			<c:forEach items="${project.members}" var="t">  
				arrayIds.push(${t.id}); //js中可以使用此标签，将EL表达式中的值push到数组中  
				arrayNames.push('${t.name}');
			</c:forEach>  
			for(var i=0;i<arrayIds.length;i++)  
			{  
				$('#memberTableBody').append("<tr id='member"+arrayIds[i]+"'><td>"+arrayNames[i]+"</td><td><button type='button' class='btn btn-danger' onclick='showDeleteDialog("+proId+","+arrayIds[i]+",\""+arrayNames[i]+"\")'><spring:message code='delete-member' /></button></td></tr>");
			}
			if (data.length > 0) {
				for(var i=0; i<data.length; i++) {
					if (proId == null || proId == '') {
						$('#memberTableBody').append("<tr id='member"+data[i].id+"'><td>"+data[i].name+"</td><td><button type='button' class='btn btn-primary' onclick='addMemberWithoutProId("+data[i].id+",\""+data[i].name+"\")'><spring:message code='add-member' /></button></td></tr>");
					} else {
						$('#memberTableBody').append("<tr id='member"+data[i].id+"'><td>"+data[i].name+"</td><td><button type='button' class='btn btn-primary' onclick='addMember("+proId+","+data[i].id+",\""+data[i].name+"\")'><spring:message code='add-member' /></button></td></tr>");
					}
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
            }, 1000);
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
			var arrayIds = new Array();  
			var arrayNames = new Array();
			<c:forEach items="${project.members}" var="t">  
				arrayIds.push(${t.id}); //js中可以使用此标签，将EL表达式中的值push到数组中  
				arrayNames.push('${t.name}');
			</c:forEach>  
			for(var i=0;i<arrayIds.length;i++)  
			{  
				$('#memberTableBody').append("<tr id='member"+arrayIds[i]+"'><td>"+arrayNames[i]+"</td><td><button type='button' class='btn btn-danger' onclick='showDeleteDialog("+proId+","+arrayIds[i]+",\""+arrayNames[i]+"\")'><spring:message code='delete-member' /></button></td></tr>");
			}  
			if (data.length > 0) {
				for(var i=0; i<data.length; i++) {
					if (proId == null || proId == '') {
						$('#memberTableBody').append("<tr id='member"+data[i].id+"'><td>"+data[i].name+"</td><td><button type='button' class='btn btn-primary' onclick='addMemberWithoutProId("+data[i].id+",\""+data[i].name+"\")'><spring:message code='add-member' /></button></td></tr>");
					} else {
						$('#memberTableBody').append("<tr id='member"+data[i].id+"'><td>"+data[i].name+"</td><td><button type='button' class='btn btn-primary' onclick='addMember("+proId+","+data[i].id+",\""+data[i].name+"\")'><spring:message code='add-member' /></button></td></tr>");
					}
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
            }, 1000);
		}
	});
    $('#memberDiv').removeClass('hidden');
	$('#showMember').addClass('hidden');
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
			<li><a href="${pageContext.request.contextPath }/project/manage"><spring:message code="project_manage" /></a></li>
			<li><a class="active">
			<c:if test="${edit}">
			<spring:message code="edit-project" />
			</c:if>
			<c:if test="${!edit}">
			<spring:message code="create-project" />
			</c:if>
            <spring:message code="project" /></a></li>
			</ol>
	       </div>
			
	   </div>
	</div>
	
	<div class="container">
	   <div class="row">
	     <form class="form-horizontal" id="projectForm" role="form">
			<div class="form-group">
				<label class="col-md-2 control-label"><spring:message code="project_name" /></label>
				<div class="col-md-10" id="nameDiv">
					<input type="text" class="form-control" name="name" id="name" placeholder="<spring:message code="please_project_name" />" value="${project.name }">
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-2 control-label"><spring:message code="project_description" /></label>
				<div class="col-md-10" id="descriptionDiv">
					<textarea class="form-control" rows="3" name="description" id="description" placeholder="<spring:message code="please_project_description" />">${project.description }</textarea>
				</div>
			</div>
			<div class="form-group">
				<div class="col-md-offset-2 col-md-10">
					<button type="button" class="btn btn-info ${edit ? '' : 'hidden' }" onclick="checkUpdateForm(${project.id})"><spring:message code="update" /></button>
					<button type="button" class="btn btn-primary ${edit ? '' : 'hidden' }" onclick="window.history.back()"><spring:message code="return" /></button>
				</div>
			</div>
			<div class="form-group">
				<div class="col-md-offset-2 col-md-10">
				</div>
			</div>
			<div class="${currentUser.roleName == 'SuperAdmin' ? '' : 'hidden'}">
    		<div class="form-group ${edit ? '' : 'hidden' }">
				<label class="col-md-2 control-label"><spring:message code="present_leader" />：</label>
				<div class="col-md-10">
				     <a href="${pageContext.request.contextPath }/user/getUserInfo?id=${project.admin.id }" class="${project.admin.name == null || project.admin.name == '' ? 'hidden' : ''  } btn btn-sm ${project.status == 1 ? 'btn-info' : '' } ${project.status == 2 ? 'btn-success' : '' }">${project.admin.name }</a>
			    </div>
			</div>
			<div class="form-group">
				<label class="col-md-2 control-label"><spring:message code="assign_projectleader" /></label>
			       <div class="col-md-10">
			           <a href="#"  id="leader" class="btn btn-sm btn-success hidden"></a>
				       <a class="btn ${currentUser.roleName == 'SuperAdmin' ? '' : 'hidden' } ${ edit ? 'btn-warning' : 'btn-success' }  btn-sm" 
				       href="javascript:0;" id="showAdmin" onclick="showAddAdminDialog(${project.id})" ><spring:message code="assign_projectleader" /></a>
    				   <a class="btn ${currentUser.roleName == 'SuperAdmin' ? '' : 'hidden' } ${ edit ? 'btn-warning' : 'btn-success' }  btn-sm hidden" 
				       href="javascript:0;" id="hideAdmin" onclick="hideAddAdminDialog(${project.id})" ><spring:message code="hide_assign_projectleader" /></a>
			       </div>
			</div>
			</div>
			<div class="form-group hidden" id="adminDiv">
				<label class="col-md-2 control-label"></label>
			       <div class="col-md-10">
					<div class="input-group">
						<input type="text" class="form-control " id="adminName"   placeholder="<spring:message code="project_leadersearch" />">
						<span class="input-group-btn">
                        <button type="button" class="btn btn-default" onclick="reloadAdminDate(${project.id})"><spring:message code="man_search" /></button>
						</span>
					</div>
					<table class="table table-hover" id="adminTable">
						<caption><spring:message code="five_records" /></caption>
						<thead>
							<tr>
								<th><spring:message code="leader_name" /></th>
								<th><spring:message code="operation" /></th>
							</tr>
						</thead>
						<tbody id="adminTableBody">
						</tbody>
					</table>
			       </div>
			</div>
    		<div class="form-group">
				<label class="col-md-2 control-label"><spring:message code="present_member" />：</label>
				<div class="col-md-10">
					<c:if test="${ project.members.size() != 0 }">
						<c:forEach var="member" items="${ project.members }" varStatus="status">
						      <a href="${pageContext.request.contextPath }/user/getUserInfo?id=${member.id }" class="btn btn-sm ${project.status == 1 ? 'btn-info' : '' } ${project.status == 2 ? 'btn-success' : '' }">${ member.name }</a>
						</c:forEach>
					</c:if>
					<c:if test="${ project.members.size() == 0 }">
					     <spring:message code="no_members" />
					</c:if>
				    <div id="membersDiv">
				    </div>
			    </div>
			</div>
    		<div class="form-group">
				<label class="col-md-2 control-label"><spring:message code="addupdate_teammembers" /></label>
				<div class="col-md-10">
				    <a class="btn ${currentUser.roleName != 'Member' ? '' : 'hidden' } ${ edit ? 'btn-warning' : 'btn-success' }  btn-sm" 
				    href="javascript:0;" id="showMember" onclick="showAddMemberDialog(${project.id})" ><spring:message code="addupdate_teammembers" /></a>
			    </div>
			</div>
			<div class="form-group hidden" id="memberDiv">
				<label class="col-md-2 control-label"></label>
			       <div class="col-md-10">
					<div class="input-group">
						<input type="text" class="form-control" id="memberName"  placeholder="<spring:message code="project_membersearch" />">
						<span class="input-group-btn">
	    					<button type="button" class="btn btn-default" onclick="reloadMemberDate(${project.id})"><spring:message code="man_search" /></button>
						</span>
					</div>
					<table class="table table-striped" id="memberTable">
						<caption><spring:message code="five_records" /></caption>
						<thead>
							<tr>
								<th><spring:message code="member_name" /></th>
								<th><spring:message code="operation" /></th>
							</tr>
						</thead>
						<tbody id="memberTableBody">
						</tbody>
					</table>
			       </div>
			</div>
			<div class="form-group">
				<div class="col-md-offset-2 col-md-10">
					<button type="button" class="btn btn-info ${edit ? 'hidden' : '' }" onclick="checkAddForm(${project.id})"><spring:message code="create" /></button>
				</div>
			</div>
		</form>
	   </div>
	</div>
	

</body>
</html>