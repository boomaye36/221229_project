<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!-- jquery : ajax, bootstrap, datepicker -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>  
	
	<!-- bootstrap -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

	<!-- css -->
	<link rel="stylesheet" href="/static/css/style.css">
</head>
<body class="pwd-body">
	
	<div class="pwd-wrap">
        <h2 onclick="move('/user/sign-in')">비밀번호 찾기</h2>
        <div class="pwd-form">
        	<input type="text" placeholder="아이디" id="user_id">
            <input type="text" placeholder="회원정보에 등록한 이메일" id="user_email">
            <input type="submit" value="비밀번호 찾기" id ="login">
        </div>
        <hr>
        <p class="id-find">
        <span><a href="/user/sign-in">홈</a></span>
        <span><a href="/user/pwd">비밀번호 찾기</a></span>
        <span><a href="/user/sign-up" >회원가입</a></span>
    	</p>
    </div>
    
    
</body>
<script type="text/javascript">
	
	//엔터키 비밀번호 찾기 클릭 event 
	var user_email = document.getElementById("user_email");
	user_email.addEventListener("keyup", function(event){
		if(event.keyCode === 13) {
			event.preventDefault();
			$("#login").click();
		}
	});
	
	//비밀번호 찾기 버튼 클릭 event
	$('#login').on('click', function(){
		
		var loginid = $('#user_id').val().trim();
		var email = $('#user_email').val().trim();
		
		//아이디 공백검사
		if ( loginid == '') {
			alert('아이디를 확인하세요');
			$('#user_id').focus();
			return false;
		}
		//이메일 공백검사
		if ( email == '') {
			alert('이메일을 확인하세요');
			$('#user_email').focus();
			return false;
		}
		
		//이메일 입력 검사
		var regEmail = /^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/;
 	 	if (!regEmail.test(email)) {
 	 		alert('이메일 주소를 확인하세요');
 	 		$('#user_email').focus();
 	 		return false;
 	 	}
 	 	
 	 	//비밀번호 찾기 ( 아이디 와 이메일 일치 여부 확인)
 	 	$.ajax({
 	 		
 	 		type : 'GET'
 	 		, url : '/user/is_duplicated_email'
 	 		, data : {loginid , email}
 	 		, success : function(result) {
 	 			
 	 			if(result == '') {
 	 				alert('아이디 또는 이메일을 확인하세요');
 	 				return false;
 	 			} else {
 	 				$.ajax({
 	 					type : 'POST'
 	 					, url : "/user/sendEmail"
 	 					, data : {loginid, email }
 	 					, success : function() {
 	 						alert('임시 이메일 전송완료!');
 	 						location.href = "/user/sign-in";
 	 					}
 	 					, error : function() {
 	 						alert('관리자에게 문의하세요');
 	 					}
 	 				})
 	 			}
 	 		}
 	 		, error : function(e) {
				alert('관리자에게 문의하세요'); 	 			
 	 		}
 	 	})
		
	}); // 비밀번호 찾기 event 닫기
</script>
</html>