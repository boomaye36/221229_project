<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>La destinee</title>
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
	<link rel="stylesheet" href="/static/css/user.css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Gurajada&display=swap" rel="stylesheet">
	<!-- material icons -->
	<link href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp" rel="stylesheet">
</head>
<body>
	<div class="user-login d-flex">
		<div class="image-area w-100">
			<!-- 배경 이미지 들어가는 영역 -->
			<img src="/static/img/user-bg.jpg">

			<div class="login-area w-50">
				<!-- 로고 -->
				<h1 class="logo text-center">La destinee</h1>
				<!-- 로그인 영역 -->
				<div class="user-login-content-box">
					<div class="user-login-content">
						<!-- 데이터 입력 -->
						<div class="user-loginbox">
							<input type="text" placeholder="아이디" id="user_loginid"> 
							<input type="password" placeholder="비밀번호" autoComplete="off" id="user_password">
							<!--label은 id값만 먹는 것 같아 input 값 아이디로 지정했음. 체크해야함. -->
							<label for="user-remember-check" class="checkbox"> 
								<input type="checkbox" id="user-remember-check" class="check-input">
								<span>아이디 저장</span>
							</label>
						</div>
						<!-- 버튼들 -->
						<div class="user-button-box mt-3">
							<input type="button" value="로그인" class="user-login-submit">
							<!-- <input type="button" value="소셜로그인" class="user-login-social"> -->
							<hr>
 							<!-- 카카오 로그인 -->
							<a class="" href="https://kauth.kakao.com/oauth/authorize?client_id=32ecb1a2899644d9618755f0e599c459&redirect_uri=http://localhost/oauth/kakao&response_type=code">
								<img src="/static/img/kakao_login_large_wide.png" class="user-login-kakao">
							</a>
							<!-- 네이버 로그인 -->					
 							<a type="button" class="user-login-social naver" href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=HWYnGH9P3uPQNouoAvyz&state=STATE_STRING&redirect_uri=http://localhost/users/callback.do">네이버 로그인</a>
							<!-- 구글 로그인 -->
							<a type="button" class="user-login-social google" href="https://accounts.google.com/o/oauth2/v2/auth?client_id=233418186817-v6nlobapoh55eda8bsujrdiabo9p78d1.apps.googleusercontent.com&redirect_uri=http://localhost/redirect&response_type=code&scope=https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile&state=state_parameter_passthrough_value">구글 로그인</a>
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
	
	//비밀번호 입력 후 엔터키 event
	var user_password = document.getElementById("user_password");
	user_password.addEventListener("keyup", function(event){
		if(event.keyCode === 13) {
			event.preventDefault();
			$(".user-login-submit").click();
		}
	});
	
	
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
					alert("로그인 되었습니다.");
					document.location.href="/main";
				} else {
					alert("아이디/비밀번호가 일치하지 않습니다.");
				}
			}
			, error : function(e) {
				//에러코드를 따로 잡아주세요.
				alert("로그인 에러. 관리자에게 문의하세요.");
			}
		});
	}); // 로그인 버튼 클릭 event 닫기
	
	
	//아이디 저장 쿠키
	var key = getCookie("key");
	$("#user_loginid").val(key); 
	if ($("#user_loginid").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
	        $("#user-remember-check").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
	}
	     
    $("#user-remember-check").change(function(){ // 체크박스에 변화가 있다면,
        if($("#user-remember-check").is(":checked")){ // ID 저장하기 체크했을 때,
            setCookie("key", $("#user_loginid").val(), 7); // 7일 동안 쿠키 보관
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie("key");
        }
    });
     
    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $("#user_loginid").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#user-remember-check").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            setCookie("key", $("#user_loginid").val(), 7); // 7일 동안 쿠키 보관
        }
    });
    
    
    
    
    
}); // document.ready 닫기
	
	
	//쿠키 셋팅 function
	function setCookie(cookieName, value, exdays){
	    var exdate = new Date();
	    exdate.setDate(exdate.getDate() + exdays);
	    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
	    document.cookie = cookieName + "=" + cookieValue;
	}
	
	//쿠키 삭제 function
	function deleteCookie(cookieName){
	    var expireDate = new Date();
	    expireDate.setDate(expireDate.getDate() - 1);
	    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	}
	
	//쿠키 가져오기 function
	function getCookie(cookieName) {
	    cookieName = cookieName + '=';
	    var cookieData = document.cookie;
	    var start = cookieData.indexOf(cookieName);
	    var cookieValue = '';
	    if(start != -1){
	        start += cookieName.length;
	        var end = cookieData.indexOf(';', start);
	        if(end == -1)end = cookieData.length;
	        cookieValue = cookieData.substring(start, end);
	    }
	    return unescape(cookieValue);
	}
</script>
</html>