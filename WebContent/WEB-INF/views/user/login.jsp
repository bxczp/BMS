<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/style/artdialog/ui-dialog.css">
<link href="${pageContext.request.contextPath }/style/bootstrap3.3.7/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/style/bootstrapvalidator-master/dist/css/bootstrapValidator.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath }/style/jquery2.1.4/jquery.min.js"></script>
<script src="${pageContext.request.contextPath }/style/bootstrap3.3.7/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath }/style/artdialog/dialog.js"></script>
<script src="${pageContext.request.contextPath }/style/bootstrapvalidator-master/dist/js/bootstrapValidator.min.js"></script>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="login_submit" /></title>
<script type="text/javascript">
	$(function() {
		
		if ('${error}') {
            setTimeout(function () {
    			$('#errorMsg').addClass('hidden');
            }, 2000);
		}
		
	    $(window).resize(); 

		$(".loginForm").bootstrapValidator({

			message : 'This value is not valid',
			feedbackIcons : {/*输入框不同状态，显示图片的样式*/
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			fields : {/*验证*/
				idNo : {/*键名idNo和input idNo值对应*/
					message : 'The idNo is not valid',
					validators : {
						notEmpty : {/*非空提示*/
							message : '<spring:message code="ID-not-empty" />'
						},
						stringLength : {/*长度提示*/
							min : 6,
							message : '<spring:message code="ID-length" />'
						},
						regexp: {
                            regexp: /^[0-9]{6}$/,
                            message: '<spring:message code="ID-number" />'
                        }
// 						,remote: {//ajax验证。server result:{"valid",true or false} 向服务发送当前input name值，获得一个json数据。例表示正确：{"valid",true}  
// 	                        url: '${pageContext.request.contextPath}/user/logincheckUserID',//验证地址
// 	                        message: '用户不存在',//提示消息
// 	                        delay :  2000,//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
// 	                        type: 'POST',//请求方式
// 	                        /**自定义提交数据，默认值提交当前input value */
// 	                          data: function(validator) {
// 	                              return {
// 	                              };
// 	                           }
// 	                    }
					/*最后一个没有逗号*/
					}
				},
				password : {
					message : '<spring:message code="password-invaild" />',
					validators : {
						notEmpty : {
							message : '<spring:message code="password-not-empty" />'
						},
						regexp : {/* 只需加此键值对，包含正则表达式，和提示 */
							regexp : /^[a-zA-Z0-9_\.]+$/,
							message : '<spring:message code="password" />'
						},
						stringLength : {
							min : 5,
							max : 10,
							message : '<spring:message code="password-length" />'
						}
					}
				}

			}
		})
	});
	
	$(window).resize(function(){ 
	    $(".container").css({ 
	        position: "absolute", 
	        left: ($(window).width() - $(".container").outerWidth())/2, 
	        top: ($(window).height() - $(".container").outerHeight())/3 
	    });        
	});
</script>
</head>
<body>
   <div class="container" id="container">
    <div class="row">
        <div class="col-md-4">
           <div class="row">
                <div class="col-md-6 col-md-offset-4">
                    <h1><strong>FNST</strong></h1>                 
                </div>
           </div>
           <div class="row">
              <div class="col-md-3 col-md-offset-3">
                <ul class="list-group list-unstyled">
                   <li><h2>Bug</h2></li>
                   <li><h2>Management</h2></li>
                   <li><h2>System</h2></li>
                </ul>
              </div>
           </div>  
           <div class="row">
             <div class="col-md-offset-3">
                <ul class="nav nav-pills">
					<li><a href="?language=zh_CN"><spring:message code="chinese" /></a></li>
					<li><a href="?language=en_US"><spring:message code="english" /></a></li>
					<li><a href="?language=ja_JA"><spring:message code="japanses" /></a></li>
				</ul>
			  </div>
           </div>   
        </div>
        <div class="col-md-6 col-md-offset-2">
            <h1 class="text-center"><spring:message code="welcome" /></h1>
            <form class="form-horizontal loginForm" id="loginForm" role="form" action="${pageContext.request.contextPath}/user/login" method="POST">
                <div class="form-group ${error ? 'has-error' : '' }" style="margin-top:20px">
                    <label for="idNo" class="col-md-3 control-label input-lg"><spring:message code="login_idNo" /></label>
                    <div class="col-md-9">
                        <input type="text" class="form-control input-lg" class="idNo" name="idNo" placeholder="<spring:message code="login_idNo" />" value="${user.idNo }">
                    </div>
                </div>
                <div class="form-group ${error ? 'has-error' : '' }" style="margin-top:20px">
                    <label for="password" class="col-md-3 control-label input-lg"><spring:message code="login_password" /></label>
                    <div class="col-md-9">
                        <input type="password" class="form-control input-lg" class="password" name="password" placeholder="<spring:message code="login_password" />" value="${user.password }">
                    </div>
                </div>
                <h6 class="text-right" style="margin-top:20px"><a href="${pageContext.request.contextPath }/user/register"><spring:message code="register-idNo" /></a></h6>

                <div class="form-group ${error ? 'has-error' : 'hidden' }" id="errorMsg" style="margin-top:20px">
                    <label class="col-md-3 control-label input-lg"></label>
                    <div class="col-md-9">
	                    <div id="myAlert" class="alert alert-danger">
							<a href="#" class="close" data-dismiss="alert">&times;</a>
							<strong><spring:message code="warning" />!   </strong><spring:message code="error" />！
						</div>
                    </div>
                </div>

                <div class="col-md-offset-4">
                   <button type="submit" class="btn btn-primary"><spring:message code="login_submit" /></button>
                   <button type="reset" class="btn btn-danger" style="margin-left:80px"><spring:message code="login_reset" /></button>
                </div>
            </form>
        </div>
    </div>
  </div>
</body>
</html>