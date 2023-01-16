<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
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
<body class="id-body">

	<div class="id-wrap">
        <h2 onclick="move('/user/sign-in')">화상영상통화 아이디 찾기</h2>
        <div class="id-form">
         <c:if test="${findid == null}">
        
           <span>아이디를 찾기위한 수단을 선택해주세요</span><br>
           <label class="mb-0"><input type="radio" class='valid-id' id='phone' name="valid-id" value="phone">휴대폰</label>
           <label class="mb-0 ml-2"><input type="radio" class='valid-id' id='email' name="valid-id" value="email">이메일</label>
            <input type="text" placeholder="회원정보에 등록한 이메일" id="user_email" class="d-none">
            <input type="text" placeholder="회원정보에 등록한 휴대번호" id="user_phone" class="d-none">
            <div class="id-box">
	            <span>등록하신 Id </span><br>
	            <input type="text" placeholder="" id="user_id">
            </div>
            <input type="button" class="btn" value="아이디 찾기" id ="login">
                 </c:if>
         <c:if test="${findid != null}">
         <h2>등록하신 id는 ${findid} 입니다.</h2>
         </c:if>
        </div>
        <hr>
        <p class="id-find">
        <span><a href="/user/sign-in">홈</a></span>
        <span><a href="/user/pwd">비밀번호 찾기</a></span>
        <span><a href="/user/sign-up" >회원가입</a></span>
    	</p>
    </div>

</body>
<script type="text/javascript">


//아이디 찾기 
$(document).ready(function(){
	$('.valid-id').on('click', function(){
	let checkVal = $('input[name=valid-id]:checked').val();
	if (checkVal == 'phone'){
		$('#user_phone').removeClass('d-none');
		$('#user_email').addClass('d-none');
		
	}else{
		$('#user_phone').addClass('d-none');
		$('#user_email').removeClass('d-none');

	}
	
	});
	$('#login').on('click', function(){
		let phonenumber = $('#user_phone').val().trim();
		let email = $('#user_email').val().trim();

		document.location.href="/user/id_find?phonenumber=" + phonenumber +"&email=" + email;
	});
	
});


</script>
</html>