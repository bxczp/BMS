
 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
<link href="${ctx}/style/bootstrap-fileinput-master/css/fileinput.css"
	media="all" rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath }/style/jquery-confirm-master/dist/jquery-confirm.min.css"
	rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="bug-submit" /></title>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-3 col-md-offset-1">
				<ol class="breadcrumb">
					<li>BMS</li>
					<li><a href="${ctx}/bug/list"><spring:message code="bug-manage" /></a></li>
					<li><a class="active"><spring:message code="bug-submit" /></a></li>
				</ol>
			</div>



		</div>
	

	<div class="container">
<div class="row">
		<div class="col-md-12">

			<!--提交bug   form---start  -->
			<form class="form-horizontal" enctype="multipart/form-data"
				method="post" id="bugForm">
				<input type="hidden" name="publisherId" value="${currentUser.id}"
					class="publisherId" />
				<div class="form-group">
					<label for="category" class="col-sm-2 control-label"><spring:message code="Bug_select" /></label>
					<div class="col-sm-10">
						<select class="form-control" name="proId" id="proId" onchange="changePro(this.options[this.options.selectedIndex].value)">
							<option value=""><spring:message code="Bug_Pselect" /></option>
							<c:forEach var="project" items="${projectList}" varStatus="index">

								<option value="${project.id}">${project.name}</option>
							</c:forEach>
						</select>

					</div>
				</div>


				<div class="form-group">
					<label for="category" class="col-sm-2 control-label"><spring:message code="Bug_Classselect" /></label>
					<div class="col-sm-10">
						<select class="form-control" name="category" id="category">
							<c:forEach var="dict" items="${categoryTypes}" varStatus="status">
								<option value="${dict.value}">${dict.label}</option>
							</c:forEach>
						</select>

					</div>
				</div>

				<div class="form-group">
					<label for="priority" class="col-sm-2 control-label"><spring:message code="Bug_priority" /></label>
					<div class="col-sm-10">
						<select class="form-control" name="priority" id="priority">
							<c:forEach var="dict" items="${priorityTypes}" varStatus="status">
								<option value="${dict.value}">${dict.label}</option>
							</c:forEach>
						</select>

					</div>
				</div>
				<div class="form-group">
					<label for="os" class="col-sm-2 control-label"><spring:message code="Bug_OS" /></label>
					<div class="col-sm-10">
						<select class="form-control" name="os" id="os">
							<c:forEach var="dict" items="${osTypes}" varStatus="status">
								<option value="${dict.value}">${dict.label}</option>
							</c:forEach>
						</select>

					</div>
				</div>
				<div class="form-group">
					<label for="assignedId" class="col-sm-2 control-label"><spring:message code="Bug_assign" /></label>
					<div class="col-sm-7">
						<select class="form-control" name="assignedId" id="assignedId">
						</select>
					</div>
					<div class="col-sm-1 col-sm-offset-1">
					<button type="button" onclick="sendMail()" class="btn btn-primary" disabled="disabled" id="mail"><span class="glyphicon glyphicon-envelope"></span><spring:message code="Bug_mail_Send" /></button>
					</div>
				</div>
				<div class="form-group has-error">
					<label for="status" class="col-sm-2 control-label"><spring:message code="Bug_state" /></label>
					<div class="col-sm-10">
						<select class="form-control" name="status" id="status">
							<c:forEach var="dict" items="${statusTypes}" varStatus="status">
								<option value="${dict.value}">${dict.label}</option>
							</c:forEach>
						</select>

					</div>
				</div>

				<div class="form-group">
					<label for="description" class="col-sm-2 control-label"><spring:message code="Bug_Prodescript" /></label>
					<div class="col-sm-10">
						<textarea class="form-control" rows="3" name="description"
							id="layEdit"></textarea>
					</div>
				</div>

				<div class=" form-group has-primary">
					<label class="col-sm-2 control-label" for="files"><spring:message code="Bug_attUpload" /></label>
					<div class="col-sm-10">
						<input class="projectfile" name="files" id="txtFile" type="file"
							multiple>
					</div>

				</div>

				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label"><spring:message code="Bug_remarks" /></label>
					<div class="col-sm-10">
						<textarea class="form-control" name="remark" rows="3"></textarea>
					</div>
				</div>


				<div class="form-group">
					<div class="col-sm-offset-6 col-sm-10">
						<button type="button" id="sm_btn" class="btn btn-primary"
							onclick="SubmitreportForm();"><spring:message code="Bug_Subquestion" /></button>
						&nbsp;&nbsp;&nbsp;
						<button type="reset" class="btn btn-danger"><spring:message code="Bug_again" /></button>
					</div>

				</div>
			</form>
		</div>

	</div>
</div>
</div>

</body>


<script>
	layui.use('layedit', function() {
		var layedit = layui.layedit, $ = layui.jquery;
		//自定义工具栏
		layedit.build('layEdit',
				{
					tool : [ 'strong','italic','face', 'link', 'unlink', '|', 'left', 'center',
							'right' ],
					height : 100
				});
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
		//建立编辑器
	});
</script>
<script>
	$('#txtFile')
			.fileinput({
				language : 'zh',
				showUpload : true,
				browseLabel : "<spring:message code="Bug_Findfile" />",
				removeLabel : "<spring:message code="Bug_del" />",
				uploadLabel : "<spring:message code="Bug_upload" />",
				dropZoneTitle : '<spring:message code="Bug_Drag" />',
				msgInvalidFileType : '<spring:message code="Bug_Unsupported" />',
				uploadClass : "btn btn-info",
				removeClass : "btn btn-danger",
				uploadUrl : '${ctx}/bug/uploadItem',
				maxFileCount : 5,
				allowedFileExtensions : ['jpg', 'png' ],
				browseClass : "btn btn-default", //按钮样式             
				previewFileIcon : "<i class='glyphicon glyphicon-king'></i>"
			})
			.on("filebatchselected", function(event, files) {
				/*   $(this).fileinput("upload"); */
			})
			.on(
					"fileuploaded",
					function(event, data) {

						$("#bugForm")
								.append(
										"<input class='file' name='files' type='hidden' value='"+data.response+"'>");
					});
	function SubmitreportForm() {
		var va = $('#proId option:selected').val();
		var layedit = layui.layedit;

		var content = layedit.getContent(1);
	
		$("#layEdit").val(content);

		if (va == "") {

			$.alert({
				title : "<spring:message code="Bug_prompt" />",
				content : '<spring:message code="Bug_select_project" />',
			});

		} else {
if(content.length>0){
	

			$.ajax({
				url : '${ctx}/bug/add',
				type : 'post',
				data : $("#bugForm").serialize(),
				success : function(data) {
					if (data > 0) {
						/*  $.confirm({
							    title: '提示',
							    content: 'bug提交成功,是否继续提交bug?',
							    type: 'dark',
							    typeAnimated: true,
							    animation: 'news',
							    closeAnimation: 'news',
							    buttons: {
							        tryAgain: {
							            text: 'ok',
							            btnClass: 'btn-dark',
							            action: function(id){
							            	location.reload(true )
							            }
							        },
							        close: function () {
							        	
							        	window.location.href = "${ctx}/bug/list";
							        }
							    }
							});
				 */
						$.confirm({
						    title: '<spring:message code="Bug_Please_sure" />',
						    type: 'dark',
						    typeAnimated: true,
						    animation: 'news',
						    closeAnimation: 'news',
						    content: '<spring:message code="Bug_submitting_bug" />',

						    autoClose: 'cancle|5000',
						    buttons: {
						        deleteUser: {
						            text: 'OK',
						            btnClass: 'btn-dark',
						            action: function () {
						            	location.reload(true )
						            }
						        },
						        cancle: function () {
						        	window.location.href = "${ctx}/bug/list";
						        }
						    }
						});

					}
				},
				error : function(XMLHttpRequest, data, textStatus) {
					//  $btn.button('reset'); 
					// alert("status:" + XMLHttpRequest.status);

				}
			});
}else{
	$.alert({
		title : "<spring:message code="Bug_mail_prompt" />",
		content : '<spring:message code="Bug_mail_null" />',
	});
}
		}
	}
	
	function sendMail() {
		var userId = $('#assignedId').val();
		var proName = $('#proId').find("option:selected").text();
		var proId = $('#proId').val();
		$.ajax({
			url : '${ctx}/bug/sendMail',
			type : 'post',
			data :{
				'proName':proName,
				'userId':userId
			
			},
			success : function(data) {
				if (data) {
					$.alert({
						title : "<spring:message code="Bug_mail_prompt" />",
						content : '<spring:message code="Bug_mail_Successful" />',
					}); 
				} else {
					$.alert({
						title : "<spring:message code="Bug_mail_prompt" />",
						content : '<spring:message code="Bug_mail_fail" />',
					}); 
				}
			},
			error : function(XMLHttpRequest, data, textStatus) {
				$.alert({
					title : "<spring:message code="Bug_mail_prompt" />",
					content : '<spring:message code="Bug_mail_fail" />',
				}); 

			}
		});
	}

	function changePro(proId){
		$.ajax({
			url : '${ctx}/bug/getProUserList',
			type : 'post',
			data :{
				"proId":proId
			
			},
			
			success : function(data) {
				$('#mail').removeAttr('disabled');
				$("#assignedId").empty();
				  var str = '';
				/*   var data = eval"("+data+")"); */
				/*   alert(data); */
				  for(var o in data) {
				str += '<option value="'+data[o].id+'">'+data[o].name+'</option>';
			    	}
						$("#assignedId").append(str)
				
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