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
	<script src="${ctx}/style/echarts/echarts.common.min.js"></script>
<script
	src="${ctx}/style/bootstrap3.3.7/js/bootstrap.min.js"></script>
<script
	src="${ctx}/style/DataTables-1.10.15/js/jquery.dataTables.min.js"></script>
<script
	src="${ctx}/style/DataTables-1.10.15/js/dataTables.bootstrap.min.js"></script>
<script
	src="${ctx}/style/jquery-confirm-master/dist/jquery-confirm.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="bug_analysis" /></title>

<script type="text/javascript">
$(document).ready(function () {
	var obj = document.getElementById("category"); //定位id
	var index = obj.selectedIndex; // 选中索引
	var value = obj.options[index].value; // 选中值 

	//status
	$.get("analysis?proId="+value).done(function(data) {

		var str = data; // 解析json
		var array = [];
		var ss = [];

		for (i = 0; i < data.length; i++) {
			// alert(str.name[i]+"===========》"+str.id[i]);
			var map = {};
			map.name = str[i].typeLabel;
			map.value = str[i].count;
			array[i] = map;
			ss[i] = map.name;
		}
		var mychart = echarts.init(document.getElementById('main'));
		// 指定图表的配置项和数据
		var option = {
			backgroundColor : 'snow',
			/* notMerge: true, */
			title : {
				text : '<spring:message code="bug_status_analysis" />',
				subtext : '<spring:message code="lateral_analysis" />',
				x : 'center',
				textStyle : {
					color : '#235894'
				}
			},
			calculable : true,
			tooltip : {
				trigger : 'item',
				formatter : "{a} <br/>{b} : {c} ({d}%)"
			},
			toolbox : {
				show : true,
				feature : {
					mark : {
						show : true
					},
					dataView : {
						show : true,
						readOnly : false
					},
					magicType : {
						show : true,
						type : [ 'pie', 'funnel' ]
					},
					restore : {
						show : true
					},
					saveAsImage : {
						show : true
					}
				}
			},
			legend : {
				orient : 'vertical',
				left : 'left',
				data : ss
			},
			series : [ {
				name : '<spring:message code="bug_status" />',
				type : 'pie',
				radius : '55%',
				center : [ '65%', '60%' ],
				data : array,
				itemStyle : {
					emphasis : {
						shadowBlur : 10,
						shadowOffsetX : 0,
						shadowColor : 'rgba(0, 0, 0, 0.5)'
					}
				}
			} ]
		};
		mychart.setOption(option);

	});
	/**
	 * bug类别分类
	 */
	$.get("analysisBugType?proId="+value).done(function(data) {

		var str = data; // 解析json
		var array = [];
		var ss = [];

		for (i = 0; i < data.length; i++) {
			// alert(str.name[i]+"===========》"+str.id[i]);
			var map = {};
			map.name = str[i].typeLabel;
			map.value = str[i].count;
			array[i] = map;
			ss[i] = map.name;
		}
		var mychart = echarts.init(document.getElementById('main2'));
		// 指定图表的配置项和数据
		var option = {
			backgroundColor : 'snow',
			/* notMerge: true, */
			title : {
				text : '<spring:message code="bug_class_analysis" />',
				subtext : '<spring:message code="lateral_analysis" />',
				x : 'center',
				textStyle : {
					color : '#235894'
				}
			},
			calculable : true,
			tooltip : {
				trigger : 'item',
				formatter : "{a} <br/>{b} : {c} ({d}%)"
			},
			toolbox : {
				show : true,
				feature : {
					mark : {
						show : true
					},
					dataView : {
						show : true,
						readOnly : false
					},
					magicType : {
						show : true,
						type : [ 'pie', 'funnel' ]
					},
					restore : {
						show : true
					},
					saveAsImage : {
						show : true
					}
				}
			},
			legend : {
				orient : 'vertical',
				left : 'left',
				data : ss
			},
			series : [ {
				name : '<spring:message code="bug_grad" />',
				type : 'pie',
				radius : '55%',
				center : [ '65%', '60%' ],
				data : array,
				itemStyle : {
					emphasis : {
						shadowBlur : 10,
						shadowOffsetX : 0,
						shadowColor : 'rgba(0, 0, 0, 0.5)'
					}
				}
			} ]
		};
		mychart.setOption(option);

	});
	/**
	 * 住房条件分析
	 */

	$.get("analysisLevel?proId="+value).done(function(data) {

		var str = data; // 解析json
		var array = [];
		var ss = [];
		var dd = [];
		for (i = 0; i < data.length; i++) {
			// alert(str.name[i]+"===========》"+str.id[i]);
			var map = {};
			map.name = str[i].typeLabel;
			map.value = str[i].count;
			array[i] = map;
			ss[i] = map.name;
			dd[i] = map.value;
		}
		var myChart = echarts.init(document.getElementById('main3'));
		myChart.setOption({
			title : {
				text : '<spring:message code="bug_priority_analysis" />',
				  x:'center'
			},
			tooltip : {
				trigger : 'item',
			
			},
			toolbox : {
				show : true,
				feature : {
					mark : {
						show : true
					},
					dataView : {
						show : true,
						readOnly : false
					},
					magicType : {
						show : true,
						type : [ 'pie', 'line' ]
					},
					restore : {
						show : true
					},
					saveAsImage : {
						show : true
					}
				}
			},
			
			xAxis : {
				data : ss
			},
			yAxis : {
				 name : '单位(件)',
		            type : 'value',
				
			},
			series : [ {
				name : '<spring:message code="bug_priority" />',
				type : 'bar',
				data : dd
			} ]
		});

	});
	
	/*操作系统分析  */
	$.get("analysisOS?proId="+value).done(function(data) {

		
		var str = data; // 解析json
		var array = [];
		var ss = [];
		var dd = [];
		for (i = 0; i < data.length; i++) {
			// alert(str.name[i]+"===========》"+str.id[i]);
			var map = {};
			map.name = str[i].typeLabel;
			map.value = str[i].count;
			array[i] = map;
			ss[i] = map.name;
			dd[i] = map.value;
		}
		var myChart = echarts.init(document.getElementById('main4'));
		myChart.setOption({
			title : {
				text : '<spring:message code="bug_targeted_analysis" />'
			},
			tooltip : {
				trigger : 'item',
			
			},
			toolbox : {
				show : true,
				feature : {
					mark : {
						show : true
					},
					dataView : {
						show : true,
						readOnly : false
					},
					magicType : {
						show : true,
						type : [ 'pie', 'line' ]
					},
					restore : {
						show : true
					},
					saveAsImage : {
						show : true
					}
				}
			},
			
			xAxis : {
				data : ss
			},
			yAxis : {
				 name : '单位(件)',
		            type : 'value',
				
			},
			series : [ {
				name : '<spring:message code="operating_system" />',
				type : 'bar',
				data : dd
			} ]
		});

	
});
});

/*
 * 切换项目
 */
function changePro(selectValue){
	
	   window.location.href="${ctx}/project/toanalysis?proId="+selectValue;
	   
	   
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
				
					<li><a class="active"><spring:message code="bug_analysis" /></a></li>
				</ol>
			</div>

			<div class="col-md-2 col-md-offset-5">

				<form class="form-inline" role="form"
					action="${ctx}/bug/search"
					method="GET">
					<div class="form-group">
						<label for="recipient-name" class="control-label"></label> <select
							class="form-control" name="proId" id="category"  onchange="changePro(this.options[this.options.selectedIndex].value)"  >
					<%-- 	<option value="0"><spring:message code="all_project" /></option> --%>
						<c:forEach var="project" items="${projectList}" varStatus="index">
						<c:if  test="${project.id==select_check}" >
								<option value="${project.id}" selected>${project.name}</option>
						</c:if>
							<c:if  test="${project.id!=select_check}" >
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
			<div class="col-md-12"></div>
			<div class="col-lg-12">
<!-- 					<h1 class="page-header">图表分析一览</h1> -->
				</div>
				<div class="col-lg-6">
					<div class="panel panel-primary">
						<div class="panel-heading"><spring:message code="bug_status_analysis" /></div>
						<!-- /.panel-heading -->
						<div class="panel-body">
						 <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="width: 500px;height:400px;"></div>


						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
				</div>
				<!-- /.col-lg-6 -->
				<div class="col-lg-6">
					<div class="panel panel-danger">
						<div class="panel-heading">
							<spring:message code="bug_class_analysis" />
						</div>
						<div class="panel-body">
							<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main2" style="width: 500px;height:400px;"></div>
						</div>
					</div>
					<!-- /.panel -->
				</div>
					<!-- /.col-lg-6 -->
			</div>
			<!-- /.row -->
			<div class="row">
			<div class="col-lg-6">
				<div class="panel panel-info">
					<div class="panel-heading">
					<spring:message code="bug_priority_analysis" />
					</div>
					<div class="panel-body">
						  <div id="main3" style="width: 500px;height:400px;"></div>
								
						</div>
					</div>
					</div><!-- col-lg-6 -->
					<div class="col-lg-6">
				<div class="panel panel-success">
					<div class="panel-heading">
						<spring:message code="bug_targeted_analysis" />
					</div>
					<div class="panel-body">
						  <div id="main4" style="width: 500px;height:400px;"></div>
						
						</div>
					</div>
					</div><!-- col-lg-6 -->
				</div>
		<!-- /#page-wrapper -->
		
		</div>
<!-- 	</div> -->

	

</body>

</html>