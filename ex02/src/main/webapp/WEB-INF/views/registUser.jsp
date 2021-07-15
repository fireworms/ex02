<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Regist</title>

    <!-- Custom fonts for this template-->
    <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">

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
                                    <form class="user" role="form" method="post" action="/registUser">
                                    	<input type='hidden' name="${_csrf.parameterName }" value="${_csrf.token }" />
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user registCheck"
                                                name="userid" aria-describedby="emailHelp"
                                                placeholder="Enter User ID...">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user"
                                                name="userpw" placeholder="Password">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user"
                                                name="userpwConfirm" placeholder="Password">
                                        </div>
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user"
                                                name="username"
                                                placeholder="Enter User Name...">
                                        </div>
                                        <div class="form-group">
                                            <input type="email" class="form-control form-control-user registCheck"
                                                name="email" placeholder="Enter User EMAIL...">
                                        </div>
                                        <button class="btn btn-primary btn-user btn-block btn-regist">
                                            Regist
                                        </button>
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
		
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
		
		$(".registCheck").on("focusout", function(e){
			
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
						str += "등록가능한 ";
						if(name == "userid"){
							str += "아이디입니다";
						}else if(name == "email"){
							str += "이메일입니다";
						}
					}else{
						str += "등록불가한 ";
						if(name == "userid"){
							str += "아이디입니다";
						}else if(name == "email"){
							str += "이메일입니다";
						}
					}
					console.log(str);
				}
			});
			
		});
	</script>
</body>
</html>