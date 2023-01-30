<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>La destinee</title>
	<!-- jquery : ajax, bootstrap, datepicker -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>  
	
	<!-- bootstrap -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

	<!-- material icons -->
	<link href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp" rel="stylesheet">
	
	<!-- css -->
	<link href="/static/css/main.css" rel="stylesheet" />
</head>
<body>
	<div class="main-wrap">
	
		<!-- navigation -->
		<jsp:include page="../include/nav.jsp" />
		
		<!-- contents -->
		<section class="content-area">
			<div class="container">
				<!-- content -->
				<div class="content">
					<!-- 타이틀 영역 -->
					<div class="mypage-title-section">
						<h3 class="mypage-title">비밀번호 변경</h3>
						<!-- 소셜로그인 회원으로 로그인 시에만 안내문구 노출 -->
						<c:if test="${user.path != '일반'}">
						<div class="noti"><span class="material-icons">info_outline</span>소셜로그인 회원은 비밀번호를 변경할 수 없습니다.</div>
						</c:if>
					</div>
					<hr>
					
					<!-- 비밀번호 변경 영역 -->
					<input type="hidden" id="userPath" value="${user.path}">
					<div class="mypage-input-section">
						<div class="mypage-input-box">
							<div class="input-title d-flex">현재 비밀번호<span class="required">*</span></div>
							<input type="password" id="password">
						</div>
						<div class="mypage-input-box">
							<div class="input-title d-flex">새 비밀번호<span class="required">*</span></div>
							<input type="password" id="changedPassword">
            				<small id="limitText" class="ml-1 noti d-none">8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.</small>
						</div>
						<div class="mypage-input-box">
							<div class="input-title d-flex">새 비밀번호 확인<span class="required">*</span></div>
							<input type="password" id="changedPasswordCheck">
						</div>
					</div> <!-- 비밀번호 변경 영역 끝 -->
					
					<!-- 버튼 영역 -->
					<div class="mypage-btn-section">
						<button type="button" id="updatePassword" class="btn btn-custom btn-block">저장</button>
						<a href="/mypage" class="btn btn-secondary btn-block mt-0 ml-2">취소</a>
					</div>
					
					<!-- 회원탈퇴 -->
					<div class="mypage-util-box">
						<button type="button" id="withdrawal" class="btn-text">회원탈퇴</button>
					</div>
					
				</div> <!-- content 끝 -->
			</div>
		</section>
		
		<!-- footer -->
		<jsp:include page="../include/footer.jsp" />
	</div>
</body>

<script>
$(document).ready(function() {
	
	// 비밀번호 변경
	$('#updatePassword').on('click', function() {
		let password = $('#password').val().trim();
		let changedPassword = $('#changedPassword').val().trim();
		let changedPasswordCheck = $('#changedPasswordCheck').val().trim();
		
		// 일반로그인 회원일때만 비밀번호 변경
		let userPath = $('#userPath').val();
		if (userPath === '일반') {
			// 일반로그인 회원인 경우
			// 유효성 검사
			if (password == '') {
				alert('현재 비밀번호를 입력해주세요.');
				$('#password').focus();
				return;
			}
			if (changedPassword == '') {
				alert('새 비밀번호를 입력해주세요.');
				$('#changedPassword').focus();
				return;
			}
			if (changedPasswordCheck == '') {
				alert('새 비밀번호 확인을 입력해주세요.');
				$('#changedPasswordCheck').focus();
				return;
			}
			
			// 현재 비밀번호와 일치 여부 검사
			if (password == changedPassword) {
				alert('현재 비밀번호와 동일한 비밀번호입니다. 다시 입력해주세요.');
				$('#changedPassword').val('');
				$('#changedPasswordCheck').val('');
				$('#changedPassword').focus();
				return;
			}
			//패스워드 및 패스워드 확인 일치 검사
			if (changedPassword != changedPasswordCheck){
				alert("새 비밀번호가 일치하지 않습니다");
				return false;
			}
			
			//비밀번호입력시 특수문자조합 검사
			var reg = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
			if (!reg.test(changedPassword)) {
				$('#limitText').removeClass('d-none');
				$('#changedPassword').focus();
				return false;
			}
			
			// ajax
			$.ajax({
				type: "POST"
				, url: "/user/mypage/pwd_update"
				, data : {password, "changedPassword":changedPassword}
				, success: function(data) {
					if (data.result == true) {
						// 현재 비밀번호 일치
						if (data.code == 100) {
							// 성공
							alert("비밀번호가 변경되었습니다");
							location.reload();
						} else {
							// 에러
							alert("비밀번호 변경 실패");
						}
					} else if (data.result == false) {
						// 현재 비밀번호 불일치
						alert('현재 비밀번호가 일치하지 않습니다.');
						$('#password').focus();
					}
				}
				, error: function(e) {
					alert('관리자에게 문의해주세요.');
				}
			});
		} else {
			// 일반로그인 회원이 아닌 경우
			alert('소셜로그인 회원은 비밀번호를 변경할 수 없습니다.');
			return;
		}
	}); // 비밀번호 변경 끝
	
	// 회원탈퇴
	$('#withdrawal').on('click', function() {
		if (confirm('탈퇴시 정보는 복구되지 않습니다.\n정말로 탈퇴하시겠습니까?')) {
			$.ajax({
				type: 'delete'
				, url: '/user/mypage/user_delete'
				
				, success: function(data) {
					if (data.code == 100) {
						alert('정상적으로 탈퇴되었습니다.');
						location.href='/user/sign-in';
					} else {
						alert('관리자에게 문의하세요');
					}
				}
				, error: function(e) {
					alert('회원 탈퇴 실패');
				}
			});
		}
	}); // 회원탈퇴 끝
});
</script>
</html>