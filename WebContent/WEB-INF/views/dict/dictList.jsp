<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
	<link
	href="${ctx}/style/bootstrap3.3.7/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${ctx}/style/jquery-confirm-master/dist/jquery-confirm.min.css"
	rel="stylesheet">

<script
	src="${ctx}/style/jquery2.1.4/jquery.min.js"></script>
<script
	src="${ctx}/style/bootstrap3.3.7/js/bootstrap.min.js"></script>
<script
	src="${ctx}/style/DataTables-1.10.15/js/jquery.dataTables.min.js"></script>
<script
	src="${ctx}/style/DataTables-1.10.15/js/dataTables.bootstrap.min.js"></script>
<script
	src="${ctx}/style/jquery-confirm-master/dist/jquery-confirm.min.js"></script>
<title><spring:message code="dict-manage" /></title>

<script type="text/javascript">
$(document).ready(function () {
	  
    $("#dict_tab").DataTable({
          "searching" : true,
            "bLengthChange": true,
            "bProcessing": true, //当datatable获取数据时候是否显示正在处理提示信息。
            'language': {
                'emptyTable': '<spring:message code="Bug_Nodata" />',
                'loadingRecords': '<spring:message code="Bug_Nodata" />',
                'processing': '<spring:message code="Bug_inquery" />',
                'search': '<spring:message code="Bug_nubretival" />',
                'lengthMenu': '<spring:message code="Bug_perpage" />',
                'zeroRecords': '<spring:message code="Bug_Nodata" />',
                'paginate': {
                    'first': '<spring:message code="Bug_fpage" />',
                    'last': '<spring:message code="Bug_lpage" />',
                    'next': '<spring:message code="Bug_npage" />',
                    'previous': '<spring:message code="Bug_ppage" />'
                },
                'info': "<spring:message code="Bug_allage" /> ",//左下角的信息显示，大写的词为关键字。

                'infoEmpty': '<spring:message code="Bug_Nodata" />',
                'infoFiltered': '<spring:message code="Bug_total" />'
            }
        }
    );
});
//删除的对话框
function del(id) {
	var a=id;
	
	 $.confirm({
		    title: '<spring:message code="Bug_del" />',
		    content: '<spring:message code="Bug_suredel" />',
		    type: 'red',
		    typeAnimated: true,
		    animation: 'news',
		    closeAnimation: 'news',
		    buttons: {
		        tryAgain: {
		            text: 'ok',
		            btnClass: 'btn-red',
		            action: function(id){
		           
		            	$.ajax({
		        			url:'${ctx}/dict/delete',
		        			type:'post',
		        			data:{"id":a},
		        			success:function(data){
		        				if(data){
		        					
		        					   $.alert('<spring:message code="Bug_delsucc" />');
		        					   window.location.reload();
		        				}
		        			},
		        			 error:function (XMLHttpRequest, data, textStatus) {
		                         
		        				   $.alert('<spring:message code="Bug_abnormal" />');
		                       
		                     }
		        		});
		             
		            	
		            }
		        },
		        close: function () {
		        	
		        }
		    }
		});
}
/*新增  */
function add(){
	var va=$("#dict_value").val();
	if(va==""){
		$.alert({
		    title: '<spring:message code="Bug_suc" />',
		    content: '<spring:message code="Bug_Isempty" />',
		});
		$("#dict_value").focus();
	}
	else{
	$.ajax({
		url:'${ctx}/dict/addOrupdate',
		type:'post',
		
		data:$("#dictForm").serialize(),
		success:function(data){
			if(data){
				$.alert({
				    title: '<spring:message code="Bug_suc" />',
				    content: '<spring:message code="Bug_dataSuc" />',
				});
		    $("#addDictModal").modal('hide');
		    $("input").val("");
		    $("#dict_remark").val("");
		    $("#myModalLabel").text("<spring:message code="dict-Adddata" />");

	     //   window.location.reload(); 
			}
		},
		 error:function (XMLHttpRequest, data, textStatus) {
			 $.alert({
				    title: '<spring:message code="Bug_fail" />',
				    content: '<spring:message code="Bug_datafail" />',
				});
           
         }
	});
	}
}


/*新增 同类型 */
function addSameType(type){
	
	$("#dict_type").val(type);
	$("#addDictModal").modal('show');
	
}
/*修改  */
function edit(id){
	$.ajax({
		url:'${ctx}/dict/get',
		type:'post',
		
		data:{"id":id},
		success:function(data){
		
			if(data){
				$("#dict_id").val(data.id);
				$("#dict_value").val(data.value);
				$("#dict_label").val(data.label);
				$("#dict_type").val(data.type);
				$("#dict_description").val(data.description);
				$("#dict_remark").val(data.remark);
				$("#myModalLabel").text("<spring:message code="Bug_Modifydictionarydata" />");
				$("#addDictModal").modal('show');
			}
		},
		 error:function (XMLHttpRequest, data, textStatus) {
			 $.alert({
				    title: '<spring:message code="Bug_fail" />',
				    content: '<spring:message code="Bug_datafail" />',
				});
           
         }
	});
	
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
					<li><a class="active"><spring:message code="dict-Dicmanage" /></a></li>
				</ol>
			</div>
			<div class="col-md-2 col-md-offset-4">
				<button class="btn btn-success" type="button" data-toggle="modal" data-target="#addDictModal"><spring:message code="dict-add" /></button>
			</div>

	<%-- 		<div class="col-md-2 col-md-offset-4">

				<form class="form-inline" role="form"
					action="${pageContext.request.contextPath }/dict/search"
					method="GET">
					<div class="form-group">
						<input type="text" class="form-control" name="name"
							placeholder="输入要查询的字典类型" value="${type }">

					</div>
					<button type="submit" class="btn btn-default">搜索</button>
				</form>

			</div> --%>

		</div>
	</div>



	<div class="container">
	
	<br />
		<div class="row">
			<div class="col-md-12">

				<table class="table table-hover" id="dict_tab">
					<thead>
						<tr>
							<th><spring:message code="dict-No" /></th>
							<th><spring:message code="dict-Key" /></th>
							<th><spring:message code="dict-Label" /></th>
							<th><spring:message code="dict-Category" /></th>
							<th><spring:message code="dict-describe" /></th>
							<th><spring:message code="dict-Ctime" /></th>
							<th><spring:message code="dict-Uptime" /></th>
							<th><spring:message code="dict-operation" /></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="dict" items="${dictList}" varStatus="status">
							<tr>
								<td>${status.index + 1 }</td>
								<td>${dict.value}</td>
								<td>${dict.label}</td>
								<td>${dict.type}</td>
								<td>${dict.description}</td>
								<td><fmt:formatDate value="${dict.createDate}"
										pattern="yyyy-MM-dd" /></td>
								<td><fmt:formatDate value="${dict.updateDate}"
										pattern="yyyy-MM-dd" /></td>
								<td>
								<%-- 	<button class="btn btn-primary" type="button"
										onclick="showDetail(${dict.id})">查看</button>
								 --%>
									<button class="btn btn-info" type="button"
										onclick="edit(${dict.id})"><spring:message code="dict-modify" /></button>
									<button class="btn btn-danger" type="button"
										onclick="del(${dict.id})"><spring:message code="dict-delete" /></button>
										<button class="btn btn-success" type="button"
										onclick="addSameType('${dict.type}')"><spring:message code="dict-NewKey" /></button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>


			</div>
		</div>
	</div>

	<%-- <div class="container">
		<div class="row">
			<div class="col-md-5 col-md-offset-4">
				<ul class="pagination">${pageCode }
				</ul>
			</div>
		</div>
	</div> --%>

</body>
<!-- Modal -->
<div class="modal fade" id="addDictModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel"><spring:message code="dict-Adddata" /></h4>
      </div>
      <div class="modal-body">
         <form  id="dictForm">
         <input type="hidden" value="" name="id"  id="dict_id" />
      
          <div class="form-group">
            <label for="recipient-name" class="control-label"><spring:message code="dict-Key" />：</label>
            <input type="text" class="form-control" name="value" value="" id="dict_value">
          </div>
          <div class="form-group">
            <label for="recipient-name" class="control-label"><spring:message code="dict-Label" />：</label>
            <input type="text" class="form-control" name="label" value="" id="dict_label">
          </div>
          <div class="form-group">
            <label for="recipient-name" class="control-label"><spring:message code="dict-Category" />：</label>
            <input type="text" class="form-control" name="type" value="" id="dict_type">
          </div>
          <div class="form-group">
            <label for="recipient-name" class="control-label"><spring:message code="dict-describe" />：</label>
            <input type="text" class="form-control" name="description" value="" id="dict_description">
          </div>
          <div class="form-group">
            <label for="message-text" class="control-label"><spring:message code="Bug_remarks" />：</label>
            <textarea class="form-control" name="remark" id="dict_remark"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="add()"><spring:message code="dict-Submit" /></button>
        <button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="dict-cancel" /></button>
      </div>
    </div>
  </div>
</div>
</html>