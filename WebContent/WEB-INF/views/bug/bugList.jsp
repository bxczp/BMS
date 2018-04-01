<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
<script type="text/javascript">
	$(document).ready(function() {
		
	
		$("#bug_tab").DataTable({
			"searching" : true,
			"bLengthChange" : true,
			"bProcessing" : true, //当datatable获取数据时候是否显示正在处理提示信息。
			'language' : {
				'emptyTable' : '<spring:message code="Bug_Nodata" />',
				'loadingRecords' : '<spring:message code="Bug_inload" />',
				'processing' : '<spring:message code="Bug_inquery" />',
				'search' : '<spring:message code="Bug_nubretival" />',
				'lengthMenu' : '<spring:message code="Bug_perpage" />',
				'zeroRecords' : '<spring:message code="Bug_Nodata" />',
				'paginate' : {
					'first' : '<spring:message code="Bug_fpage" />',
					'last' : '<spring:message code="Bug_lpage" />',
					'next' : '<spring:message code="Bug_npage" />',
					'previous' : '<spring:message code="Bug_ppage" />'
				},
				'info' : "<spring:message code="Bug_allage" /> ",//左下角的信息显示，大写的词为关键字。

				'infoEmpty' : '<spring:message code="Bug_Nodata" />',
				'infoFiltered' : '<spring:message code="Bug_total" />'
			}
		});
	});

	//删除的对话框
	function del(id) {
		var a = id;

		$.confirm({
					title : '<spring:message code="dict-delete" />',
					content : '<spring:message code="Bug_suredel" />',
					type : 'red',
					typeAnimated : true,
					animation : 'news',
					closeAnimation : 'news',
					buttons : {
						tryAgain : {
							text : 'ok',
							btnClass : 'btn-red',
							action : function(id) {

								$
										.ajax({
											url : '${ctx}/dict/delete',
											type : 'post',
											data : {
												"id" : a
											},
											success : function(data) {
												if (data) {

													$
															.alert('<spring:message code="Bug_delsucc" />');
													window.location.reload();
												}
											},
											error : function(XMLHttpRequest,
													data, textStatus) {

												$
														.alert('<spring:message code="Bug_last_time" />');

											}
										});

							}
						},
						close : function() {

						}
					}
				});
	}
	/*新增  */
	function add() {

		$.ajax({
			url : '${ctx}/dict/addOrupdate',
			type : 'post',

			data : $("#dictForm").serialize(),
			success : function(data) {
				if (data) {
					$.alert({
						title : '<spring:message code="Bug_suc" />',
						content : '<spring:message code="Bug_dataSuc" />',
					});
					$("#addDictModal").modal('hide');
					$("input").val("");
					$("#dict_remark").val("");
					$("#myModalLabel").text(
							"<spring:message code="dict-Adddata" />");

					//   window.location.reload(); 
				}
			},
			error : function(XMLHttpRequest, data, textStatus) {
				$.alert({
					title : '<spring:message code="Bug_fail" />',
					content : '<spring:message code="Bug_datafail" />',
				});

			}
		});
	}

	/*新增 同类型 */
	function addSameType(type) {

		$("#dict_type").val(type);
		$("#addDictModal").modal('show');

	}
	/*修改  */
	function edit(id) {
		$
				.ajax({
					url : '${ctx}/dict/get',
					type : 'post',

					data : {
						"id" : id
					},
					success : function(data) {

						if (data) {
							$("#dict_id").val(data.id);
							$("#dict_value").val(data.value);
							$("#dict_label").val(data.label);
							$("#dict_type").val(data.type);
							$("#dict_description").val(data.description);
							$("#dict_remark").val(data.remark);
							$("#myModalLabel")
									.text(
											"<spring:message code="Bug_Modifydictionarydata" />");
							$("#addDictModal").modal('show');
						}
					},
					error : function(XMLHttpRequest, data, textStatus) {
						$.alert({
							title : '<spring:message code="Bug_fail" />',
							content : '<spring:message code="Bug_datafail" />',
						});

					}
				});

	}

	/*
	 * 切换项目
	 */
	function changePro(selectValue) {

		window.location.href = "${ctx}/bug/list?proId=" + selectValue;
		

	}
	$(function() {
		//获取被选中checkbox值
		var checked = function() {
			var checks = $("input[name='Check[]']:checked");
			if (checks.length == 0) {

				$.alert({
					title : '<spring:message code="Bug_mail_prompt" />',
					content : '<spring:message code="Bug_mail_nochosse" />',
				});
				return false;
			}

			var checkData = new Array();
			checks.each(function() {
				checkData.push($(this).val());
			});
			return checkData;
		};

		//全选/全不选
		$("#checkAll").bind("click", function() {
			$("input[name='Check[]']").prop("checked", this.checked);

		});
		//批量删除 
		$("#Delete").click(function() {
			if (val = checked()) {
				$.confirm({
					title : '<spring:message code="Bug_mail_careful" />',
					content : '<spring:message code="Bug_mail_delete" />',
					type : 'red',
					typeAnimated : true,
					animation : 'news',
					closeAnimation : 'news',
					autoClose : 'close|4000',
					buttons : {
						tryAgain : {
							text : 'ok',
							btnClass : 'btn-dark',
							action : function(s) {
								  $.ajax({  
						                type: "POST",  
						                url: "${ctx}/bug/del",  
						                data: {'checkValues':checked().toString()},  
						                success: function(result) {  
						                   
						                    window.location.reload();  
						                } 
						            });  

							}
						},
						close : function() {
						
						}
					}
				});

			/* 	if (confirm('确定要删除所选吗?')) {
					alert(val);
					//  $.get("<{spUrl c=order a=delete}>",{Check:val.toString()},function(result){ if(result = true){ window.location.reload();}});  
				} */
			}
		});
		//批量操作...
	});
	
	function Export(){
		var pro_id=$("#category").val();
		if(pro_id==0){
			$.alert({
				title:"<spring:message code="Bug_mail_careful" />",
				content:"<spring:message code="Bug_mail_select" />"
			});
		}else{
			
		
		$.confirm({
			title : '<spring:message code="Bug_mail_prompt" />',
			content : '?<spring:message code="Bug_mail_export" />',
			type : 'blue',
			typeAnimated : true,
			animation : 'news',
			closeAnimation : 'news',
			autoClose : 'close|4000',
			buttons : {
				tryAgain : {
					text : 'ok',
					btnClass : 'btn-dark',
					action : function(s) {
						  $.ajax({  
				                type: "POST",  
				                url: "${ctx}/bug/export",  
				                data: {'proId':pro_id},  
				                success: function(result) {  
				                	if(resul){
				                		$.alert({
					        				title:"<spring:message code="Bug_mail_prompt" />",
					        				content:"<spring:message code="Bug_mail_datesucc" />"
					        			});  
				                	}
				                
				                } ,
				                error:function(){
				                	$.alert({
				        				title:"<spring:message code="Bug_mail_prompt" />",
				        				content:"<spring:message code="Bug_mail_datefail" />"
				        			}); 
				                }
				            });  

					}
				},
				close : function() {
				
				}
			}
		});
		}
	}
</script>


</head>
<body>


	<jsp:include page="../layout/header.jsp"></jsp:include>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-3 col-md-offset-1">
				<ol class="breadcrumb">
					<li>BMS</li>

					<li><a class="active"><spring:message code="bug-manage" /></a></li>
				</ol>
			</div>

			<div class="col-md-2 col-md-offset-5">

				<form class="form-inline" role="form" action="${ctx}/bug/search"
					method="GET">
					<div class="form-group">
						<label for="recipient-name" class="control-label"></label> <select
							class="form-control" name="proId" id="category"
							onchange="changePro(this.options[this.options.selectedIndex].value)">
							<option value="0"><spring:message
									code="Bug_all_projects" /></option>
							<c:forEach var="project" items="${projectList}" varStatus="index">
								<c:if test="${project.id==select_check}">
									<option value="${project.id}" selected>${project.name}</option>
								</c:if>
								<c:if test="${project.id!=select_check}">
									<option value="${project.id}">${project.name}</option>
								</c:if>
							</c:forEach>

						</select>

					</div>

				</form>

			</div>

		</div>
	</div>



	<div class="container">
		<div class="row">
			<div class="col-md-4"></div>
		</div>
		<br />
		<div class="row">
			<div class="col-md-12">

				<table class="table table-striped table-bordered" id="bug_tab">
					<thead>
						<tr>
							<th><input type="checkbox" id="checkAll" /></th>
							<th><spring:message code="Bug_edit" /></th>
							<th><spring:message code="Bug_number" /></th>
							<th><spring:message code="Bug_classification" /></th>
							<th><spring:message code="Bug_serious" /></th>
							<th><spring:message code="Bug_state" /></th>
							<th><spring:message code="Bug_sbmitter" /></th>
							<th><spring:message code="Bug_Last_time" /></th>
							<th><spring:message code="Bug_describe" /></th>

						</tr>
					</thead>
					<tbody>
						<c:forEach var="bug" items="${bugList}" varStatus="index">
							<c:if test="${bug.status==1}">
								<tr class="success">
							</c:if>
							<c:if test="${bug.status==2}">
								<tr class="danger">
							</c:if>
							<c:if test="${bug.status==3}">
								<tr class="info">
							</c:if>
							<c:if test="${bug.status==4}">
								<tr class="warning">
							</c:if>
							<c:if test="${bug.status==5}">
								<tr class="active">
							</c:if>


							<td><input type="checkbox" id="Check[]" name="Check[]"
								value="${bug.id}" /></td>
							<td><a href="${ctx}/bug/feedback?id=${bug.id}" title="<spring:message code="Bug_mail_feedback" />"><span
									class="glyphicon glyphicon-edit"></span></a></td>
							<td><a href="${ctx}/bug/view?id=${bug.id}" title="<spring:message code="Bug_mail_detail" />"><strong>${bug.designation}</strong></a></td>
							<td>${bug.categoryLabel}</td>
							<td>${bug.priorityLabel}</td>
							<td>${bug.statusLabel}</td>
							<td>${bug.publisher}</td>
							<td><fmt:formatDate value="${bug.updateDate}"
									pattern="yyyy-MM-dd" /></td>
							<td>
							<c:choose> 
						     <c:when test="${fn:length(bug.description) >40}"> 
						      <c:out value="${fn:substring(bug.description, 0, 40)}......" /> 
						     </c:when> 
						     <c:otherwise> 
						      <c:out value="${bug.description}" /> 
						     </c:otherwise>
						    </c:choose>
							</td>
							</tr>
						</c:forEach>

					</tbody>
				</table>
			<c:if test="${currentUser.roleName=='Admin'||currentUser.roleName=='SuperAdmin'}">
				<div id="bottom">
					<input id="Delete" name="Delete" type="button" value="<spring:message code="Bug_del" />"
						class="btn btn-danger radius" />
						<button type="button" class="btn btn-primary" onclick="Export()"><spring:message code="Bug_mail_export" /></button>
				</div>
				</c:if>	

			</div>
		</div>
	</div>


</body>

</html>