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
<body class="signup-body">
	
	<div class="signup">
        <!-- 1. 로고 -->
		<h2 class="signup-logo" onclick="move('/user/sign-in')">회원가입</h2>
        <!-- 2. 필드 -->
        <div class="signup-id">
            <b>아이디</b>
            <span class="placehold-text"><input type="text" id="user_id"  onfocusout="duplicateCheck()"></span>
            <small id="limitText" class="showLimit d-none">4~12자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.</small>
            <small id="isDuplicationText" class="showTrue d-none">이미 사용중이거나 탈퇴한 아이디입니다. </small>
            <small id="availableText" class="showFalse d-none">멋진 아이디네요!</small>
        </div>
        <div class="signup-pwd">
            <b>비밀번호</b>
            <input class="userpw" type="password" id="user_password">
        </div>
        <div class="signup-repwd">
            <b>비밀번호 재확인</b>
            <input class="userpw-confirm" type="password" id="user_repassword">
        </div>
        <div class="signup-nickname">
            <b>닉네임</b>
            <input type="text" id="user_nickname">
        </div>
        
		<!-- 4. 필드(성별) -->
        <div class="signup-gender">
            <b>성별</b>
            <div>
                <label><input type="radio" name="gender" value="male">남자</label>
                <label><input type="radio" name="gender" value="female">여자</label>
                <label><input type="radio" name="gender" value="private">비공개</label>
            </div>
        </div>
        
        <!-- 5. 이메일_전화번호 -->
        <div class="signup-email">
            <b>본인 확인 이메일</b>
            <input type="email" placeholder="선택입력" id="user_email">
        </div>
        
       <!-- 6. 휴대폰 번호  -->
        <div class="signup-number">
            <b>휴대전화</b>
            <div>
                <input type="tel" placeholder="전화번호 입력">
                <input type="button" value="인증번호 받기">
            </div>
            <input type="number" placeholder="인증번호를 입력하세요">
        </div>

        <!-- 6. 가입하기 버튼 -->
        <input type="button" value="가입하기" id="submit" name="submit">

        <!-- 7. 푸터 -->
        <div class="signup-footer">
            <div>
                <a href="#none">이용약관</a>
                <a href="#none">개인정보처리방침</a>
                <a href="#none">법적고지</a>
                <a href="#none">회원정보 고객센터</a>
            </div>
            <span><a href="#none">xxxxx World Corp.</a></span>
        </div>
    </div>
    
    
    
    
    	
     	
    
</body>
<script type="text/javascript">

//onclick 용
function move(result){
	
	location.href = result;
	
}




</script>
</html>