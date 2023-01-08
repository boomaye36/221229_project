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
		<h2 class="signup-logo" onclick="move('/user/sign-in')">회원가입 추가정보 가입</h2>
        
        <!-- 2. 생년월일 -->
        <div class="signup-birth">
            <b>생년월일</b>
            <div>
                <input type="number" placeholder="년(4자)" id="yy" name="yy">                
                <input type="number" placeholder="월" id="mm" name="mm">
                <input type="number" placeholder="일" id="dd" name="dd">
            </div>
        </div>
    
    	<!-- 3.지역 -->
        <div class="signup-area">
            <b>지역</b>
            <input type="email" placeholder="선택입력" id="user_email">
        </div>
	
		<!-- 4.소개 -->
		<div class="signup-info">
			<b>소개</b>
			<textarea rows="5" cols="44" class="user_intro"></textarea>
		</div>
		
		
		<!-- 5.프로필 사진 -->
		<div class="signup-profilephoto">
			<b>프로필사진</b>
			<img src="/static/img/no.png" >
			<input type="file">
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