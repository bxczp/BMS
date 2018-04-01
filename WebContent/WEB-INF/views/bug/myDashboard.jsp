<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


<link
	href="${ctx}/style/DataTables-1.10.15/css/dataTables.bootstrap.min.css"
	rel="stylesheet">
<%-- <link
	href="${ctx}/DataTables-1.10.15/css/jquery.dataTables.min.css"
	rel="stylesheet"> --%>
<link href="${ctx}/style/bootstrap3.3.7/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${ctx}/style/jquery-confirm-master/dist/jquery-confirm.min.css"
	rel="stylesheet">

<script src="${ctx}/style/jquery2.1.4/jquery.min.js"></script>
<script src="${ctx}/style/bootstrap3.3.7/js/bootstrap.min.js"></script>
<script
	src="${ctx}/style/DataTables-1.10.15/js/jquery.dataTables.min.js"></script>
<script
	src="${ctx}/style/DataTables-1.10.15/js/dataTables.bootstrap.min.js"></script>
<script
	src="${ctx}/style/jquery-confirm-master/dist/jquery-confirm.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="bug-manage" /></title>



</head>
<body>


	<jsp:include page="../layout/header.jsp"></jsp:include>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-3 col-md-offset-1">
				<ol class="breadcrumb">
					<li>BMS</li>

					<li><a class="active"><spring:message code="Bug_view" /></a></li>
				</ol>
			</div>

			<div class="col-md-2 col-md-offset-4">

			

			</div>

		</div>
	</div>



	<div class="container">
		<div class="row">
			<div class="col-md-6">
					<div class="panel panel-danger">
						<div class="panel-heading"><spring:message code="Bug_view_assigned" /><label for="" class="label label-danger">(<spring:message code="Bug_view_unresolved" />)</label></div>
						<div class="panel-body">
							<div class="row">
								<div class="col-md-12">
							<table class="table table-hover">
								
								<tbody>
									<c:forEach var="bug" items="${unsolvedBugs}"
										varStatus="status">
										<tr class="danger">
								<td style="border-right:1px solid #fff">			
	 				<a href="${ctx}/bug/view?id=${bug.id}" title="<spring:message code="Bug_mail_detail" />"><strong>${bug.designation}</strong></a>
					<a href="${ctx}/bug/feedback?id=${bug.id}" title="<spring:message code="Bug_mail_feedback" />">
					<span class="glyphicon glyphicon-edit"></span>
					</a>
						</td>
											
											<td class="">
											<strong>[${bug.proName}]</strong>
										
											<span>${bug.description}</span>
											
											<label for="" class=""><fmt:formatDate value="${bug.updateDate }" pattern="yyyy-MM-dd" /></label>
											
											<span class="label ${bug.priority == 4 ? 'label-danger' : ''  } ${bug.priority == 3 ? 'label-warning' : ''  } 
							                       ${bug.priority == 2 ? 'label-info' : ''  } ${bug.priority == 1 ? 'label-primary' : ''  }">${bug.priorityLabel }</span> 
											</td>

										</tr>
									</c:forEach>
								</tbody>
							</table>

								</div>

							</div>



						</div>


					</div>
			</div>
			<div class="col-md-6">
				<div class="panel panel-success">
						<div class="panel-heading"><spring:message code="Bug_view_assigned" />	<label for="" class="label label-success">(<spring:message code="Bug_view_resolved" />)</label></div>
						<div class="panel-body">
							<div class="row">
								<div class="col-md-12">

							<table class="table table-hover">
								
								<tbody>
									<c:forEach var="bug" items="${solvedBugs}"
										varStatus="status">
										<tr class="success">
								<td style="border-right:1px solid #fff">			
	 				<a href="${ctx}/bug/view?id=${bug.id}" title="<spring:message code="Bug_mail_detail" />"><strong>${bug.designation}</strong></a>
					<a href="${ctx}/bug/feedback?id=${bug.id}" title="<spring:message code="Bug_mail_feedback" />">
					<span class="glyphicon glyphicon-edit"></span>
					</a>
						</td>
											
											<td class="">
											<strong>[${bug.proName}]</strong>
										
											<span>${bug.description}</span>
											
											<label for="" class=""><fmt:formatDate value="${bug.updateDate }" pattern="yyyy-MM-dd" /></label>
											
											<span class="label ${bug.priority == 4 ? 'label-danger' : ''  } ${bug.priority == 3 ? 'label-warning' : ''  } 
							                       ${bug.priority == 2 ? 'label-info' : ''  } ${bug.priority == 1 ? 'label-primary' : ''  }">${bug.priorityLabel }</span> 
											</td>

										</tr>
									</c:forEach>
								</tbody>
							</table>
								</div>

							</div>



						</div>


					</div>
					</div>
		</div>
		
			<div class="row">
			<div class="col-md-6">
					<div class="panel panel-primary">
						<div class="panel-heading"><spring:message code="Bug_view_report" /></div>
						<div class="panel-body">
							<div class="row">
								<div class="col-md-12">
<table class="table table-hover">
								
								<tbody>
									<c:forEach var="bug" items="${publishBugs}"
										varStatus="status">
										<tr class="primary">
								<td style="border-right:1px solid #fff">			
	 				<a href="${ctx}/bug/view?id=${bug.id}" title="<spring:message code="Bug_mail_detail" />"><strong>${bug.designation}</strong></a>
					<a href="${ctx}/bug/feedback?id=${bug.id}" title="<spring:message code="Bug_mail_feedback" />">
					<span class="glyphicon glyphicon-edit"></span>
					</a>
						</td>
											
											<td class="">
											<strong>[${bug.proName}]</strong>
										
											<span>${bug.description}</span>
											
											<label for="" class=""><fmt:formatDate value="${bug.updateDate }" pattern="yyyy-MM-dd" /></label>
											
											<span class="label ${bug.priority == 4 ? 'label-danger' : ''  } ${bug.priority == 3 ? 'label-warning' : ''  } 
							                       ${bug.priority == 2 ? 'label-info' : ''  } ${bug.priority == 1 ? 'label-primary' : ''  }">${bug.priorityLabel }</span> 
											</td>

										</tr>
									</c:forEach>
								</tbody>
							</table>

								</div>

							</div>



						</div>


					</div>
			</div>
			<div class="col-md-6">
				<div class="panel panel-info">
						<div class="panel-heading"><spring:message code="Bug_Recent_feedback" /></div>
						<div class="panel-body">
							<div class="row">
								<div class="col-md-12">

							<table class="table table-hover">
								
								<tbody>
									<c:forEach var="bug" items="${feedBackBugs}"
										varStatus="status">
										<tr class="info">
								<td style="border-right:1px solid #fff">			
	 				<a href="${ctx}/bug/view?id=${bug.id}" title="<spring:message code="Bug_mail_detail" />"><strong>${bug.designation}</strong></a>
					<a href="${ctx}/bug/feedback?id=${bug.id}" title="<spring:message code="Bug_mail_export" />">
					<span class="glyphicon glyphicon-edit"></span>
					</a>
						</td>
											
											<td class="">
											<strong>[${bug.proName}]</strong>
										
											<span>${bug.description}</span>
											
											<label for="" class=""><fmt:formatDate value="${bug.updateDate }" pattern="yyyy-MM-dd" /></label>
											
											<span class="label ${bug.priority == 4 ? 'label-danger' : ''  } ${bug.priority == 3 ? 'label-warning' : ''  } 
							                       ${bug.priority == 2 ? 'label-info' : ''  } ${bug.priority == 1 ? 'label-primary' : ''  }">${bug.priorityLabel }</span> 
											</td>

										</tr>
									</c:forEach>
								</tbody>
							</table>
								</div>

							</div>



						</div>


					</div>
			</div>
		</div>
	
	
	</div>


</body>

</html>