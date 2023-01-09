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
            <div class="d-flex">
             <span class="placehold-text"><input type="text" id="user_id"  ></span>
             <button type="button" id="duplicateBtn" class="btn btn-info ml-3">중복 확인 </button>
            </div>
			 <div  id="idcheckLength" class="ml-5 small text-danger d-none">4자 이상으로 입력하세요.</div>
			 <div  id="duplicateNo" class="ml-5 small text-danger d-none">중복된 아이디입니다 .</div>
			 <div id="confirmOk" class="ml-5 small text-success d-none">사용 가능한 아이디입니다 .</div>
        </div>
        <div class="signup-pwd">
            <b>비밀번호</b>
            <input class="userpw" type="password" id="user_password">
            <small id="limitText" class="showLimit d-none">4~12자의 영문 소문자, 숫자와 특수기호만 사용 가능합니다.</small>
            
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
                <label><input type="radio" name="gender" value="남자">남자</label>
                <label><input type="radio" name="gender" value="여자">여자</label>
                <label><input type="radio" name="gender" value="비공개">비공개</label>
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
                <input type="tel" placeholder="전화번호 입력" id="user_phonenumber">
                <input type="button" value="인증번호 받기">
            </div>
            <input type="number" placeholder="인증번호를 입력하세요">
        </div>

        <!-- 6. 가입하기 버튼 -->
        <input type="button"class="btn" value="가입하기" id="submit" name="submit">

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

$(document).ready( function(){
	
	//아이디 중복확인 유효성 event
	$('#duplicateBtn').on('click', function(){
		let user_loginid = $('#user_id').val().trim();
		if (user_id.length < 4){
			$('#idcheckLength').removeClass('d-none');
			$('#duplicateNo').addClass('d-none');
			$('#confirmOk').addClass('d-none');
			return;
		}
		$.ajax({
			url:"/user/is_duplicated_id"
			,data:{user_loginid}
			,success:function(data){
				if (data.result == true){
					$('#idCheckLength').addClass('d-none'); 
					$('#duplicateNo').removeClass('d-none'); 
					$('#confirmOk').addClass('d-none'); 
				}else{
					$('#idCheckLength').addClass('d-none'); 
					$('#duplicateNo').addClass('d-none'); 
					$('#confirmOk').removeClass('d-none'); 				
				}
			}
			, error:function(e){
				alert("아이디 중복확인에 실패했습니다.");
			}
		});
	});
	
	//회원가입 버튼 클릭 event
	$('#submit').on('click', function(e){
		e.preventDefault();
		let user_loginid = $('#user_id').val().trim();
 		let user_password = $('#user_password').val().trim();
		let userpw_confirm = $('#user_repassword').val().trim();
		let user_nickname = $('#user_nickname').val().trim();
		let user_gender = $('input[name="gender"]:checked').val();
		let user_email = $('#user_email').val().trim();
		let user_phonenumber = $('#user_phonenumber').val().trim();
		
		/* //아이디 유효성 검사
		if (user_loginid==''){
			alert("아이디를 입력하세요 ");
			$('#user_loginid').focus();
			return false;
		} 
		
		//패스워드 및 패스워드 확인 검사
		if (user_password=='' || userpw_confirm== ''){
			alert("비밀번호를 입력하세요 ");
			return false;
		}
		
		//패스워드 및 패스워드 확인 일치 검사
		if (user_password != userpw_confirm){
			alert("비밀번호가 일치하지 않습니다");
			return false;
		}
		
		//비밀번호입력시 특수문자조합 검사
		var reg = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
		if (!reg.test(user_password)) {
			alert('비밀번호는 영문+숫자+특수문자 조합으로 8~16자리 사용해야 합니다.');
			$('#user_password').focus();
			return false;
		} 
		
		//성별 검사
		if(user_gender == undefined) {
			alert('성별을 선택해주세요');
			return false;
		} 
		
		//이메일 유효성 검사
		var regEmail = /^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/;
 	 	if (!regEmail.test(user_email) || user_email == '') {
 	 		alert('이메일 주소를 확인하세요');
 	 		$('#user_email').focus();
 	 		return false;
 	 	}
		
		
		//핸드폰 유효성 검사
		var regPhone = /^\d{3}-\d{3,4}-\d{4}$/;
		if(!regPhone.test(user_phonenumber) || user_phonenumber == '') {
			alert('핸드폰 번호를 확인하세요');
			$('#user_phonenumber').focus();
			return false;
		}
		
		//닉네임 검사
		if (user_nickname==''){
			alert("닉네임을 입력하세요 ");
			$('#user_nickname').focus();
			return false;
		} 
				
		$.ajax({
			type:"POST"
			, url : "/user/user_insert"
			, data : {user_loginid, user_password, user_nickname, user_gender, user_email,user_phonenumber }
			, success : function(data) {
				if (data.code == 100) {
					alert("회원가입 되었습니다.");
					document.location.href="/user/sign-in"
				} 
			}	
		});
				
	});	 //회원가입 버튼 event 닫기

	
	
	
	
}); // document.ready 닫기
</script>
</html>