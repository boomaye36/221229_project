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
	<link href="/static/css/main.css" rel="stylesheet" />
</head>
<body>
	<!-- nav메뉴 -->
	<nav class="navbar fixed-top">
		<div class="container px-5">
			<a href="#page-top" class="logo">La destinee</a>
			
            <div class="menu-box d-flex">
            	<ul class="menu d-flex">
                    <li class="nav-item"><a class="nav-link" href="#!">랜덤통화</a></li>
                    <li class="nav-item"><a class="nav-link" href="#!">친구추천</a></li>
                    <li class="nav-item"><a class="nav-link" href="#!">친구목록</a></li>
                </ul>
                <ul class="menu d-flex">
               		<li class="nav-item"><a class="nav-link" href="#!">종모양이미지</a></li>
                    <li class="nav-item"><a class="nav-link" href="#!">마이페이지</a></li>
               		<li class="nav-item"><a class="nav-link" href="/logout">로그아웃</a></li>
                </ul>
            </div>
		</div>
	</nav>
	<!-- visual -->
	<section class="main-visual bg-dark">
		<div class="container p-5">
			<h1 class="mb-0">La destinee</h1>
			<h2 class="mb-0">다양한 사람들을 만나보세요!</h2>
			<a class="btn btn-primary btn-xl rounded-pill mt-5" href="#scroll">랜덤화상채팅 시작!</a>
		</div>
	</section>
</body>
</html>