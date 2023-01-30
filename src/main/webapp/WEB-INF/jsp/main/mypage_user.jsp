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
					<h3 class="mypage-title">내정보 수정</h3>
					<hr>
					
					<!-- 내정보 수정 input -->
					<div class="mypage-input-area">
					
						<!-- 필수 -->
						<div class="mypage-input-section left">
							<div class="mypage-subtitle">필수정보</div>
							
							<!-- 아이디 loginid (변경불가) -->
							<div class="mypage-input-box">
								<div class="input-title d-flex">아이디</div>
								<input type="text" value="${user.loginid}" disabled>
							</div>
							<!-- 닉네임 nickname -->
							<div class="mypage-input-box">
								<div class="input-title">닉네임<span class="required">*</span></div>
								<input type="text" id="nickname" value="${user.nickname}">
							</div>
							<!-- 성별 gender (변경불가) -->
							<div class="mypage-input-box">
								<div class="input-title">성별</div>
								<input type="text" value="${user.gender}" disabled>
							</div>
							<!-- 이메일 email -->
							<div class="mypage-input-box">
								<div class="input-title">이메일<span class="required">*</span></div>
								<input type="text" id="email" value="${user.email}" placeholder="ex) address@naver.com">
							</div>
							<!-- 휴대전화 phonenumber (변경불가) -->
							<div class="mypage-input-box">
								<div class="input-title">휴대전화</div>
								<input type="hidden" id="userPhonenumber" value="${user.phonenumber}">
								<div class="phonenumber d-flex align-items-center">
									<input type="text" class="first" disabled>
									<span class="mx-2 text-secondary">-</span>
									<input type="text" class="second" disabled>
									<span class="mx-2 text-secondary">-</span>
									<input type="text" class="third" disabled>
								</div>
							</div>
						</div> <!-- 필수 끝 -->
						
						<!-- 비필수 -->
						<div class="mypage-input-section right">
							<div class="mypage-subtitle">선택정보</div>
							
							<!-- 생년월일 birth -->
							<div class="mypage-input-box">
								<div class="input-title">생년월일</div>
								<div class="d-flex">
									<input type="number" placeholder="년(4자)" id="yy" name="yy" value="<fmt:formatDate value="${user.birth}" pattern="yyyy" />">
									<input type="number" placeholder="월" id="mm" name="mm" value="<fmt:formatDate value="${user.birth}" pattern="MM" />">
									<input type="number" placeholder="일" id="dd" name="dd" value="<fmt:formatDate value="${user.birth}" pattern="dd" />">
								</div>
							</div>
							<!-- 지역 area -->
							<div class="mypage-input-box">
								<div class="input-title">지역</div>
								<input type="hidden" id="userArea" value="${user.area}">
								<select id="selectedRegion" name="selectedRegion">
									<option value="서울">서울특별시</option>
									<option value="경기">경기도</option>
									<option value="전라">전라도</option>
									<option value="강원">강원도</option>
									<option value="경상">경상도</option>
									<option value="충청">충청도</option>
								</select>
							</div>
							<!-- 소개 intro -->
							<div class="mypage-input-box">
								<div class="input-title">소개</div>
								<textarea rows="5" cols="44" class="user_intro">${user.intro}</textarea>
							</div>
							<!-- 프로필사진 profilephoto -->
							<div class="mypage-input-box">
								<div class="input-title">프로필사진</div>
								<div class="profilephoto d-flex justify-content-center pb-3">
									<img src="${empty sessionScope.loginUser.profilephoto ? '/static/img/no.png' : sessionScope.loginUser.profilephoto}" id="modifyimg"> 
								</div>
								<input type="file" accept=".gif, .jpg, .png, .jpeg" id="file" onchange="readURL2(this);">
								<div id="fileName" class="ml-2"></div>
							</div>
						</div> <!-- 비필수 끝 -->
						
						<!-- 버튼 영역 -->
						<div class="mypage-util-section">
							<div class="mypage-btn-box">
								<button type="button" class="btn btn-custom btn-block">저장</button>
								<a href="/mypage" class="btn btn-secondary btn-block">취소</a>
							</div>
						</div>
						
					</div> <!-- 내정보 수정 input 끝 -->
					
				</div> <!-- content 끝 -->
			</div>
		</section>
		
		<!-- footer -->
		<jsp:include page="../include/footer.jsp" />
	</div>
</body>

<script>

//회원가입시 프로필 사진 미리보기 event
function readURL2(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) {
			document.getElementById('modifyimg').src = e.target.result;
		};
		reader.readAsDataURL(input.files[0]);
	} else {
		document.getElementById('modifyimg').src = '/static/img/no.png';
	}
}

$(document).ready(function() {
	
	// 지역 선택 selected 처리
	let userArea = $('#userArea').val();
	$("#selectedRegion").val(userArea).prop("selected", true);
	
	// 핸드폰번호 자르기
	let userPhonenumber = $('#userPhonenumber').val();
	let first = userPhonenumber.substring(0,3);
	let second = userPhonenumber.substring(3,7);
	let third = userPhonenumber.substring(7,11);
	
	$('.phonenumber > .first').val(first);
	$('.phonenumber > .second').val(second);
	$('.phonenumber > .third').val(third);
});
</script>
</html>