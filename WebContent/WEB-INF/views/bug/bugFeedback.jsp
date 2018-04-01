<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script
	src="${pageContext.request.contextPath }/style/jquery2.1.4/jquery.min.js"></script>
<script src="${pageContext.request.contextPath }/style/layui/layui.js"></script>
<script
	src="${pageContext.request.contextPath }/style/bootstrap3.3.7/js/bootstrap.min.js"></script>

<script src="${ctx}/style/bootstrap-fileinput-master/js/fileinput.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="${ctx}/style/bootstrap-fileinput-master/js/locales/zh.js"></script>
<script
	src="${pageContext.request.contextPath }/style/jquery-confirm-master/dist/jquery-confirm.min.js"></script>

<link
	href="${pageContext.request.contextPath }/style/bootstrap3.3.7/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath }/style/layui/css/layui.css"
	rel="stylesheet">

<link
	href="${pageContext.request.contextPath }/style/jquery-confirm-master/dist/jquery-confirm.min.css"
	rel="stylesheet">
<title><spring:message code="bug-submit" /></title>
</head>
<body>


	<jsp:include page="../layout/header.jsp"></jsp:include>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-3 col-md-offset-2">
				<ol class="breadcrumb">
					<li>BMS</li>
					<li><a href="${ctx}/bug/list"><spring:message code="bug-manage" /></a></li>
					<li><a class="active"><spring:message code="Bug_feedback" /> </a></li>
				<%-- 	<li><label class="label label-info">${bug.designation}</label></li> --%>
				</ol>
			</div>



		</div>
	</div>


	<div class="container">

		<div class="col-md-12">

			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title"><spring:message code="Bug_details" /> </h3>
				</div>
				<div class="panel-body">
					<div class="row">
						<div class="col-md-4">
							<label for=""><spring:message code="Bug_No" /> </label>
							<div>

								<label for="" class="label label-info">${bug.designation}</label>
							</div>
						</div>
						<div class="col-md-4">
							<label for=""><spring:message code="Bug_project" /> </label>
							<div>
								<label for="" class="label label-default">${currProject.name}</label>
							</div>
						</div>
						<div class="col-md-4">
							<div>

								<label for=""><spring:message code="Bug_rapporteur" /> </label>
								<div>
									<label for="" class="label label-default">${bug.publisher}</label>
								</div>
							</div>
						</div>
					</div>
					<br />
					<div class="row">
						<div class="col-md-4">
							<label for=""><spring:message code="Bug_classification" /> </label>
							<div>
								<select class="form-control" name="category" id="category">
									<c:forEach var="dict" items="${categoryTypes}"
										varStatus="status">
										<c:if test="${bug.category==dict.value}">
											<option value="${dict.value}" selected>${dict.label}</option>
										</c:if>
										<c:if test="${bug.category!=dict.value}">
											<option value="${dict.value}">${dict.label}</option>
										</c:if>
									</c:forEach>
								</select>

							</div>

						</div>
						<div class="col-md-4">
							<label for=""><spring:message code="Bug_time" /> </label>
							<div>

								<label for="" class="label label-default"><fmt:formatDate
										value="${bug.createDate}" pattern="yyyy-MM-dd hh:mm:ss" /></label>
							</div>
						</div>
						<div class="col-md-4">
							<label><spring:message code="Bug_Last_time" /> </label>
							<div>
								<label for="" class="label label-default"><fmt:formatDate
										value="${bug.updateDate}" pattern="yyyy-MM-dd hh:mm:ss" /></label>
							</div>
						</div>
					</div>
					<br />
					<div class="row">
						<div class="col-md-4">
							<label for="" class=""><spring:message code="Bug_priority" /> </label>
							<div>


								<select class="form-control" name="priority" id="priority">
									<c:forEach var="dict" items="${priorityTypes}" varStatus="">
										<c:if test="${bug.priority==dict.value}">
											<option value="${dict.value}" selected>${dict.label}</option>
										</c:if>
										<c:if test="${bug.priority!=dict.value}">
											<option value="${dict.value}">${dict.label}</option>
										</c:if>
									</c:forEach>
								</select>

							</div>
						</div>
						<div class="col-md-4">

							<label for=""><spring:message code="Bug_OS" /> </label>
							<div>


								<select class="form-control" name="os" id="os">
									<c:forEach var="dict" items="${osTypes}" varStatus="status">
										<c:if test="${bug.os==dict.value}">
											<option value="${dict.value}" selected>${dict.label}</option>
										</c:if>
										<c:if test="${bug.os!=dict.value}">
											<option value="${dict.value}">${dict.label}</option>
										</c:if>
									</c:forEach>
								</select>


							</div>
						</div>
						<div class="col-md-4"></div>
					</div>
					<br />
					<div class="row">
						<div class="col-md-4">
							<label for="" class="label label-warning"><spring:message code="Bug_assign" /> </label>
							<div>


								<select class="form-control" name="assignedId" id="assignedId">
									<c:forEach var="userP" items="${proUsers}" varStatus="status">
										<c:if test="${bug.assignedId==userP.id}">
											<option value="${userP.id}" selected>${userP.name}</option>
										</c:if>
										<c:if test="${bug.assignedId!=userP.id}">
											<option value="${userP.id}">${userP.name}</option>
										</c:if>
									</c:forEach>
								</select>

							</div>
						</div>
						<div class="col-md-4">

							<label for="" class="label label-warning"><spring:message code="Bug_state" /> </label>
							<div>


								<select class="form-control" name="status" id="status">
									<c:forEach var="dict" items="${statusTypes}" varStatus="status">
										<c:if test="${bug.status==dict.value}">
											<option value="${dict.value}" selected>${dict.label}</option>
										</c:if>
										<c:if test="${bug.status!=dict.value}">
											<option value="${dict.value}">${dict.label}</option>
										</c:if>
									</c:forEach>
								</select>

							</div>
						</div>

					</div>
					<br />
					<div class="row">
						<div class="col-md-12">
							<label for="" class="labe"><spring:message code="Bug_describe" /> </label>
						<div style="border: 1px solid #d2d2d2;border-radius:15px">${bug.description}</div>
						</div>

					</div>
					<div class="row">
						<div class="col-md-8">
							<label for="" class="labe"><spring:message code="Bug_add" /> </label>
							<div>
								<c:if test="${!empty bug.files}">

									<div id="carousel-example-generic" class="carousel slide"
										data-ride="carousel">
										<!-- Indicators -->
										<ol class="carousel-indicators">
											<c:forEach var="file" items="${files}" varStatus="status">
												<c:if test="${status.index==0}">
													<li data-target="#carousel-example-generic"
														data-slide-to="${status.index}" class="active"></li>
												</c:if>

												<c:if test="${status.index!=0}">
													<li data-target="#carousel-example-generic"
														data-slide-to="${status.index}"></li>
												</c:if>


											</c:forEach>
										</ol>

										<!-- Wrapper for slides -->
										<div class="carousel-inner" role="listbox">

											<c:forEach var="file" items="${files}" varStatus="status">
												<c:if test="${status.index==0}">

													<div class="item active">
														<img src="${ctx}/upload/${file}" alt="${file}">
														<div class="carousel-caption">
															<a href="${ctx}/upload/${file}" target="_blank" class="text text-inverse">${file}</a>
														</div>
													</div>
												</c:if>
												<c:if test="${status.index!=0}">

													<div class="item">
														<img src="${ctx}/upload/${file}" alt="${file}">
														<div class="carousel-caption">
															<a href="${ctx}/upload/${file}"  target="_blank" class="text text-inverse">${file}</a>
														</div>
													</div>
												</c:if>





											</c:forEach>


										</div>

										<!-- Controls -->
										<a class="left carousel-control"
											href="#carousel-example-generic" role="button"
											data-slide="prev"> <span
											class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
											<span class="sr-only">Previous</span>
										</a> <a class="right carousel-control"
											href="#carousel-example-generic" role="button"
											data-slide="next"> <span
											class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
											<span class="sr-only">Next</span>
										</a>
									</div>
								</c:if>
								<c:if test="${empty bug.files}">

									<div class=""><spring:message code="Bug_no" /> </div>


								</c:if>
							</div>
						</div>

					</div>
					<br />
								<div class="panel panel-default">
					<div class="panel-heading">
						<h5 class="panel-title">
							<a data-toggle="collapse" data-parent="#accordion"
								href="#collapseOnes"> <span
								class="glyphicon glyphicon-plus-sign"></span><spring:message code="Bug_backinfo" /> 
							</a>
						</h5>
					</div>
					<div id="collapseOnes" class="panel-collapse collapse in">
						<div class="panel-body">
							<!-- 列表面板组 -->
							<c:forEach var="feedback" items="${feedbackList}" varStatus="status">
							<div class="panel panel-success">
								<div class="panel-heading">
								<div class="row">
								
								 <div class="col-md-4"><label for="" class="label label-info">(${feedback.noteCode})</label></div>
								 <div class="col-md-4" ><label for="" class="label label-info"><a href="${ctx}/user/getUserInfo?id=${feedback.userId}">${feedback.userName}</a></label></div>
								  <div class="col-md-4" ><label for="" class="label label-info"><fmt:formatDate value="${feedback.updateDate}"
													pattern="yyyy-MM-dd hh:mm:ss" /></label></div>
								</div>
								</div>
								<div class="panel-body">
							${feedback.noteDescription}
								
								</div>
							</div>
							</c:forEach>
					
					</div>
				</div>
			</div>
					<div class="panel panel-primary">
						<div class="panel-heading"><spring:message code="Bug_addsurvey" /> </div>
						<div class="panel-body">
							<div class="row">
								<div class="col-md-12">

									<textarea class="layui-textarea" id="LAY_demo1"
										style="display: none">  

                                     </textarea>


								</div>

							</div>



						</div>


						<div class="form-group">
							&nbsp;&nbsp;&nbsp;
							<button type="button" id="sm_btn" class="btn btn-primary"
								onclick="SubmitFeedBack();"><spring:message code="Bug_submit_feedback" /> </button>
							&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn btn-danger" onclick="window.history.back()" ><spring:message code="Bug_back" /> </button>


						</div>

					</div>

				</div>
			</div>



		</div>
		
	<%-- 		<div class="col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h5 class="panel-title">
							<a data-toggle="collapse" data-parent="#accordion"
								href="#collapseOne"> <span
								class="glyphicon glyphicon-plus-sign"></span>反馈历史
							</a>
						</h5>
					</div>
					<div id="collapseOne" class="panel-collapse collapse in">
						<div class="panel-body">
							<table class="table table-hover">
								<thead>
									<tr class="info">
										<th>日期</th>
										<th>反馈人</th>
										<th>时间</th>
										<th>变更事件</th>

									</tr>
								</thead>
								<tbody>
									<c:forEach var="changelog" items="${changlogList}"
										varStatus="status">
										<tr>

											<td><fmt:formatDate value="${changelog.createDate }"
													pattern="yyyy-MM-dd:hh:mm:ss" /></td>
											<td class="success"><a href="link">${changelog.changeName }</a></td>
											<td>${changelog.changeType }</td>
											<td>${changelog.changeContent}</td>

										</tr>
									</c:forEach>
								</tbody>
							</table>
					
					</div>
				</div>
			</div>
		</div> --%>

	</div>


</body>

<script>
	layui.use('layedit', function() {
		var layedit = layui.layedit, $ = layui.jquery;

		//构建一个默认的编辑器
		var index = layedit.build('LAY_demo1');

		//编辑器外部操作
		var active = {
			content : function() {
				alert(layedit.getContent(index)); //获取编辑器内容
			},
			text : function() {
				alert(layedit.getText(index)); //获取编辑器纯文本内容
			},
			selection : function() {
				alert(layedit.getSelection(index));
			}
		};

		//自定义工具栏
		layedit.build('LAY_demo2',
				{
			tool : [ 'strong','italic','face', 'link', 'unlink', '|', 'left', 'center',
				'right' ],
					height :  100
				})
	});
	
	function SubmitFeedBack(){
		/* $.alert({
			title : "提示",
			content : '正在提交....',
		}); */
		var priority=$("#priority option:selected").val();
		var category=$("#category option:selected").val();
		var status=$("#status option:selected").val();
		var assignedId=$("#assignedId option:selected").val();
		var layedit = layui.layedit;
		var id=${bug.id};
		var content = layedit.getContent(1);
		/* alert(id+priority+category+status+assignedId+content); */

		$.ajax({
			url : '${ctx}/bug/addFeedback',
			type : 'post',
			data :{
				"priority":priority,
				"category":category,
				"status":status,
				"assignedId":assignedId,
				"content":content,
				"id":id
			},
			
			success : function(data) {
				if (data ) {
					 $.confirm({
						    title: '<spring:message code="Bug_prompt" />',
						    content: '<spring:message code="Bug_success" />',
						    type: 'dark',
						    typeAnimated: true,
						    animation: 'news',
						    closeAnimation: 'news',
						    autoClose: 'close|4000',
						    buttons: {
						        tryAgain: {
						            text: 'ok',
						            btnClass: 'btn-dark',
						            action: function(id){
						           
						        		window.location.href = "${ctx}/bug/list";
						             
						            	
						            }
						        },
						        close: function () {
						        	location.reload(true )
						        }
						    }
						});
			

				}
			},
			error : function(XMLHttpRequest, data, textStatus) {
				$.alert({
					title : "<spring:message code="Bug_notice" />",
					content : '<spring:message code="Bug_failed" />',
				}); 

			}
		});
		
		
	}
</script>


</html>