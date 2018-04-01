
function checkPWD(){
	$(".PWDFrom").bootstrapValidator({
	message : 'This value is not valid',
	feedbackIcons : {/*输入框不同状态，显示图片的样式*/
		valid : 'glyphicon glyphicon-ok',
		invalid : 'glyphicon glyphicon-remove',
		validating : 'glyphicon glyphicon-refresh'
	},
	fields : {/*验证*/
		firstPWD : {/*键名employeeId和input employeeId值对应*/
			message : 'The employeeId is not valid',
			validators : {
				notEmpty : {/*非空提示*/
					message : '原密码不能为空'
				},
				stringLength : {/*长度提示*/
					min : 5,
					max: 10,
					message : '原密码长度必须为5~10位数'
				},
			/*最后一个没有逗号*/
			}
		},
		newPWD : {/*键名employeeId和input employeeId值对应*/
			message : 'The employeeId is not valid',
			validators : {
				notEmpty : {/*非空提示*/
					message : '新密码不能为空'
				},
				stringLength : {/*长度提示*/
					min : 5,
					max: 10,
					message : '新密码长度必须为5~10位数'
				},
				different: {//不能和用户名相同
                    field: 'firstPWD',
                    message: '不能和原密码相同'
				}	
				/*最后一个没有逗号*/
			}
		},
		
		confirmPWD : {/*键名employeeId和input employeeId值对应*/
			message : 'The employeeId is not valid',
			validators : {
				notEmpty : {/*非空提示*/
					message : '确认密码不能为空'
				},
				stringLength : {/*长度提示*/
					min : 5,
					max: 10,
					message : '确认密码长度必须为5~10位数'
				},	
				identical: {
					field: 'newPWD',
					message: '两次输入密码不一致'
					}
				
			/*最后一个没有逗号*/
			}
		}
	}
});
}
$(function() {
    $(window).resize(); 
    $(".PWDFrom").bootstrapValidator({
    	message : 'This value is not valid',
    	feedbackIcons : {/*输入框不同状态，显示图片的样式*/
    		valid : 'glyphicon glyphicon-ok',
    		invalid : 'glyphicon glyphicon-remove',
    		validating : 'glyphicon glyphicon-refresh'
    	},
    	fields : {/*验证*/
    		firstPWD : {/*键名employeeId和input employeeId值对应*/
    			message : 'The employeeId is not valid',
    			validators : {
    				notEmpty : {/*非空提示*/
    					message : '原密码不能为空'
    				},
    				stringLength : {/*长度提示*/
    					min : 5,
    					max: 10,
    					message : '原密码长度必须为5~10位数'
    				},
    			/*最后一个没有逗号*/
    			}
    		},
    		newPWD : {/*键名employeeId和input employeeId值对应*/
    			message : 'The employeeId is not valid',
    			validators : {
    				notEmpty : {/*非空提示*/
    					message : '新密码不能为空'
    				},
    				stringLength : {/*长度提示*/
    					min : 5,
    					max: 10,
    					message : '新密码长度必须为5~10位数'
    				},
    				different: {//不能和用户名相同
                        field: 'firstPWD',
                        message: '不能和原密码相同'
    				}
    			/*最后一个没有逗号*/
    			}
    		},
    		
    		confirmPWD : {/*键名employeeId和input employeeId值对应*/
    			message : 'The employeeId is not valid',
    			validators : {
    				notEmpty : {/*非空提示*/
    					message : '确认密码不能为空'
    				},
    				stringLength : {/*长度提示*/
    					min : 5,
    					max: 10,
    					message : '确认密码长度必须为5~10位数'
    				},	
    				identical: {
    					field: 'newPWD',
    					message: '*两次输入密码不一致'
    					}
    				
    			/*最后一个没有逗号*/
    			}
    		}
    	}
    }).on('success.form.bv', function(e) {
		e.preventDefault();
		var ctx = $('#ctx').val();
		$.ajax({
			url : ctx+'/user/updatePWD',
			type : 'post',
			data : $(".PWDFrom").serialize(),
			success : function(data) {
				if (data) {
					$('#PWDSuccess').modal('show');
					
					  setTimeout(function () {
	                        window.location.reload();
	                    }, 2000);
				}else{
					$('#PWDfail').modal('show');
					  setTimeout(function () {
	                        $('#PWDfail').modal('hide');
	                   }, 2000);
				}
			},
			error : function(XMLHttpRequest) {
					$('#Systemfail').modal('show');
					  setTimeout(function () {
						  $('#Systemfail').modal('hide');
                  }, 2000);
			}
		});
	});
	$('#PWDModal').on('hide.bs.modal', function () {
		 $(':input','#PWDFrom').not(':button, :submit, :reset, :hidden') .val('') .removeAttr('checked') .removeAttr('selected');
		 $("#PWDFrom").data('bootstrapValidator').destroy();
		 $('#PWDFrom').data('bootstrapValidator', null);
		 checkPWD();
		})
});




