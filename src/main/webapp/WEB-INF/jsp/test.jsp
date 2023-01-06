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
<body>
	<!-- #wrap.section > .~~area > .~~box -->
	<div class="user-login d-flex">
		<div class="login-area text-center w-50">
			<!-- logo -->
			<h1 class="logo"><a href="/">logo here ^^</a></h1>
			<!-- contents -->
			<div class="input-box w-75">
				<div class="d-flex">
					<div class="input-label">아이디</div>
					<input type="text">
				</div>
				<div class="d-flex">
					<div class="input-label">패스워드</div>
					<input type="password">
				</div>
			</div>
			<!-- buttons -->
			<div class="button-box w-75 mt-3">			
				<div class="d-flex">
					<button type="button" class="btn w-50">로그인</button>
					<button type="button" class="btn w-50">회원가입</button>
				</div>
				<button type="button" class="btn btn-block mt-2">소셜로그인</button>
				아무거나 글쓰기
			</div>
		</div>
		<div class="image-area w-50">
			<!-- 이미지 들어가는 영역 -->
			<img src="https://picsum.photos/1000" alt="">
		</div>
	</div>
</body>
</html>