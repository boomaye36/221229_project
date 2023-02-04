<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<nav class="navbar fixed-top">
	<div class="container justify-content-start">
		<a href="/main" class="logo">La destinee</a>
		<ul class="menu d-flex align-items-center ml-5">
			<li class="nav-item"><a href="/call" class="nav-link">랜덤통화</a></li>
			<li class="nav-item"><a href="/recommend" class="nav-link">추천친구</a></li>
			<li class="nav-item"><a href="/lounge" class="nav-link">라운지</a></li>
		</ul>
		<ul class="menu ml-auto d-flex align-items-center">
			<li class="nav-item">
				<a class="nav-link" href="#!" data-toggle="modal" data-target="#modal"><span class="material-icons">notifications</span></a>
			</li>
			<li class="nav-item dropdown">
				<a href="#!" class="nav-link dropdown-toggle" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="material-icons">account_circle</span></a>
				<div class="dropdown-menu bg-dark p-0 mt-2" aria-labelledby="navbarDropdownMenuLink">
					<a class="dropdown-item bg-dark p-3" href="/mypage">내 정보</a>
					<a class="dropdown-item bg-dark p-3" href="#">문의하기</a>
					<a class="dropdown-item bg-dark p-3" href="/logout">로그아웃</a>
				</div>
			</li>
		</ul>
	</div>
</nav>

<!-- 알림 Modal -->
<div class="modal fade" id="modal">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content p-3">
			<!-- 모달 내용 -->
			모달 내용 들어가는 곳
		</div>
	</div>
</div>