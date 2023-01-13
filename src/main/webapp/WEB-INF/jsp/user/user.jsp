<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jquery : ajax, bootstrap, datepicker -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>

<!-- bootstrap -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
	integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
	crossorigin="anonymous"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
	integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
	crossorigin="anonymous"></script>

<!-- css -->
<link rel="stylesheet" href="/static/css/style.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gurajada&display=swap" rel="stylesheet">
</head>
<body>
	<!-- #wrap.section > .~~area > .~~box -->
	<div class="user-login d-flex">
		<div class="image-area w-100">
			<!-- 이미지 들어가는 영역 -->
			<img src="https://picsum.photos/1000"  >


			<div class="login-area w-50">
				<!-- 로고 -->
				<h1 class="logo text-center">
					La destinee
				</h1>
				<div class="user-login-content-box">
					<div class="user-login-content">
						<!-- 데이터 입력 -->
						<div class="user-loginbox">
							<input type="text" placeholder="아이디" id="user_loginid"> 
							<input type="password" placeholder="비밀번호" autoComplete="off" id="user_password">
							<!--label은 id값만 먹는 것 같아 input 값 아이디로 지정했음. 체크해야함. -->
							<label for="user-remember-check"> 
								<input type="checkbox" id="user-remember-check"> 아이디 저장하기
							</label>
						</div>
						<!-- 버튼들 -->
						<div class="user-button-box mt-3">
							<input type="button" value="로그인" class="btn user-login-submit">
<!-- 							<input type="button" value="소셜로그인" class="user-login-social">

 -->							
 						<a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=HWYnGH9P3uPQNouoAvyz&state=STATE_STRING&redirect_uri=http://localhost/users/callback.do
 						" clsss="">네이버 로그인</a>
 						<!-- 카카오 로그인 -->
							<a class="" href="https://kauth.kakao.com/oauth/authorize?client_id=32ecb1a2899644d9618755f0e599c459&redirect_uri=http://localhost/oauth/kakao&response_type=code">
								<img src="/static/img/kakao_login_large_wide.png" class="user-login-kakao">
							</a>
						</div>
						<hr>
						<!-- 아이디, 비밀번호찾기, 회원가입 -->
						<p class="user-find">
							<span><a href="/user/id">아이디 찾기</a></span> 
							<span><a href="/user/pwd">비밀번호 찾기</a></span> 
							<span><a href="/user/tos">회원가입</a></span>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
$(document).ready(function(){
	//로그인 버튼 클릭 event
	$('.user-login-submit').on('click', function(e){
		e.preventDefault();
		let loginid = $('#user_loginid').val().trim();
		let password = $('#user_password').val().trim();
		if (loginid == ''){
			alert("아이디를 입력해주세요.");
			return false;
		}
		if (password == ''){
			alert("비밀번호를 입력해주세요.");
			return false;
		}
		//ajax 전송
		$.ajax({
			type:"POST"
			, url : "/user/sign_in"
			, data : {loginid, password}
			, success : function(data){
				if (data.code == 100){
					alert("로그인되었습니다.");
					document.location.href="/main";
				} else {
					//에러코드를 따로 잡아주세요.
				}
			}
			, error : function(e) {
				//에러코드를 따로 잡아주세요.
			}
		});
	}); // 로그인 버튼 클릭 event 닫기
}); // document.ready 닫기
</script>
</html>