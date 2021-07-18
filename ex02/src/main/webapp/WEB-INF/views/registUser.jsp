<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>

<%@include file="./includes/header.jsp"%>

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">Welcome Back!</h1>
                                    </div>
                                    <form class="user" role="form" method="post" action="/registUser" onsubmit="return dupChk();">
                                    	<input type='hidden' name="${_csrf.parameterName }" value="${_csrf.token }" />
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user registCheck"
                                                name="userid" aria-describedby="emailHelp" pattern="^([a-z0-9_]){6,50}$"
                                                title="영어소문자, 밑줄, 숫자를 6~50자 내로 입력하세요"
                                                placeholder="Enter User ID..." required>
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user"
                                                name="userpw" pattern="^(?=.*[\d\W])(?=.*[a-z])(?=.*[A-Z]).{8,50}$"
                                                title="숫자, 영어소문자, 영어대문자를 하나 이상 사용하여 8~50자 내로 입력하세요" 
                                                placeholder="Password" required>
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user"
                                                name="userpwConfirm" maxlength="50" placeholder="Confirm Password" required>
                                        </div>
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user"
                                                name="username" pattern="^([가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9]){2,50}$" 
                                                placeholder="Enter User Name..." required>
                                        </div>
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user registCheck"
                                                name="email" pattern="^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$"
												placeholder="Enter User EMAIL..." required>
                                        </div>
                                        <div class="btn-group container-fluid" role="group">
										<button class="btn btn-secondary btn-user btn-back">
                                            Back
                                        </button>
                                        <button class="btn btn-primary btn-user btn-regist">
                                            Regist
                                        </button>
										</div>
                                    </form>
                                    <hr>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="/resources/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/js/sb-admin-2.min.js"></script>

	<script>
	
	var dupChkID = false;
	var dupChkEmail = false;
	var confirmPass = false;
	
	function dupChk(){
		
		if(dupChkID && dupChkEmail && confirmPass){
			return true;
		}else if(!dupChkEmail){
			$("input[name='email']").focus();
			return false;
		}else if(!confirmPass){
			$("input[name='userpwConfirm']").focus();
			return false;
		}else if(!dupChkID){
			$("input[name='userid']").focus();
			return false;
		}
		
	}
	
	$(".btn-back").on("click", function(e){
		
		e.preventDefault();
		
		document.referrer&&-1!=document.referrer.indexOf("localhost")?history.back():location.href="http://localhost:8090/board/list";
	});
	
	$("input[name='userpwConfirm']").on("focusout", function(e){
		
		var target = $(e.target);
		var password = $("input[name='userpw']");
		var passwordConfirm = $("input[name='userpwConfirm']");
		
		if(password.val() == passwordConfirm.val()){
			console.log("패스워드 일치");
			confirmPass = true;
			this.setCustomValidity('');
			target.removeClass('border-danger');
		}else{
			console.log("패스워드 불일치");
			confirmPass = false;
			this.setCustomValidity('패스워드가 불일치합니다');
			target.addClass('border-danger');
		}
	});	
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
		
	$(".registCheck").on("focusout", function(e){
		
		var target = $(e.target);
		var name = e.target.name;
		var text = e.target.value;
		
		$.ajax({
			url: "/checkRegist",
			type: "POST",
			data: {'name' : name, 'text' : text},
	        cache: false,
			beforeSend: function(xhr){
	       		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	        },
			success: function(result){
				var str = "";
				if(result == "true"){

					target.removeClass('border-danger');
					
					if(name == "userid"){
						dupChkID = true;
					}else if(name == "email"){
						dupChkEmail = true;
					}
				}else{
					
					target.addClass('border-danger');
					
					str += "중복된 ";
					if(name == "userid"){
						dupChkID = false;
						str += "아이디입니다";
					}else if(name == "email"){
						dupChkEmail = false;
						str += "이메일입니다";
					}
				}
				e.target.setCustomValidity(str);
			}
		});
		
	});
	</script>
</body>
</html>