<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<link rel="stylesheet" href="/static/css/style.css">
</head>
<body class="tos-body">

	<div class="tos">
		<!-- 1. 로고 -->
		<h2 class="tos-logo" onclick="move('/user/sign-in')">회원가입</h2>

		<!-- 약관동의안내 -->
		<div class="tos-top">
			xxx계정 <br> 서비스 약관에 동의해 주세요.
		</div>
		<div class="tos-middle">
			<img src="/static/img/checkbox.png" width="30px" height="30px">
			<input type="checkbox" id="check-all"> 모두 동의합니다.
		</div>
		<div class="tos-middle-small">전체 동의는 필수 및 선택정보에 대한 동의도 포함되어 있으며,
			개별적으로도 동의를 선택하실 수 있습니다. 선택항목에 대한 동의를 거부하시는 경우에도 서비스는 이용이 가능합니다.</div>
		<hr>

		<!-- 필수 약관동의 -->
		<div class="tos-bottom">
			<img src="/static/img/checkbox.png" width="30px" height="30px">
			<input type="checkbox" id="check-first"> [필수] xxxx계정 약관
		</div>
		<div class="tos-bottom2">
			<img src="/static/img/checkbox.png" width="30px" height="30px">
			<input type="checkbox" id="check-second"> [필수] xxxx통합서비스 약관
		</div>
		<div class="tos-bottom3">
			<img src="/static/img/checkbox.png" width="30px" height="30px">
			<input type="checkbox" id="check-third"> [필수] 개인정보 수신 동의
		</div>
		<div class="tos-bottom4">
			<img src="/static/img/checkbox.png" width="30px" height="30px">
			<input type="checkbox" id="check-fourth"> [선택] 프로모션 정보 수신 동의
		</div>
		<!-- 6. 가입하기 버튼 -->
		<input type="button" value="가입하기" id="submit" name="submit">

	</div>







</body>
<script type="text/javascript">
	//onclick 용
	function move(result) {

		location.href = result;

	}
	$(document).ready(function(){
		$('#check-all').click(function(){
			let checked = $('#check-all').is(':checked');
			if (checked){
				$('input:checkbox').prop('checked', true);
			}else{
				$('input:checkbox').prop('checked', false);

			}
		});
		$('#submit').on('click', function(){
			if ($('#check-all').is(':checked') || ($('#check-first').is(':checked') && $('#check-second').is(':checked') && $('#check-third').is(':checked'))){
				document.location.href="/user/sign-up";
			}else{
				alert("필수 약관에 동의해주세요");
			}
		});
		
		
	});
</script>
</html>