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
<body class="signup-body">

	<div class="signup">
		<!-- 1. 로고 -->
		<h2 class="signup-logo" onclick="move('/user/sign-in')">회원가입 추가정보
			가입</h2>

		<!-- 2. 생년월일 -->
		<div class="signup-birth">
			<b>생년월일</b>
			<div>
				<input type="number" placeholder="년(4자)" id="yy" name="yy">
				<input type="number" placeholder="월" id="mm" name="mm"> <input
					type="number" placeholder="일" id="dd" name="dd">
			</div>
		</div>

		<!-- 3.지역 -->
		<div class="signup-area">
			<b>지역</b>
			<select id="selectedRegion" name="selectedRegion">
				<option value="서울">서울특별시</option>
				<option value="경기">경기도</option>
				<option value="전라">전라도</option>
				<option value="강원">강원도</option>
				<option value="경상">경상도</option>
				<option value="충청">충청도</option>
			</select>
		</div>

		<!-- 4.소개 -->
		<div class="signup-info">
			<b>소개</b>
			<textarea rows="5" cols="44" class="user_intro"></textarea>
		</div>


		<!-- 5.프로필 사진 -->
		<div class="signup-profilephoto">
			<b>프로필사진</b> 
			<div class="d-flex justify-content-center pb-3">
				<img src="/static/img/no.png" id="modifyimg"> 
			</div>
			<input type="file" accept=".gif, .jpg, .png, .jpeg" id="file" onchange="readURL2(this);">
			<div id="fileName" class="ml-2"></div>
		</div>

		<!-- 6. 가입하기 버튼 -->
		<input type="button" class="btn" value="추가하기" id="submit"
			name="submit">

		<!-- 7. 푸터 -->
		<div class="signup-footer">
			<div>
				<a href="#none">이용약관</a> <a href="#none">개인정보처리방침</a> <a
					href="#none">법적고지</a> <a href="#none">회원정보 고객센터</a>
			</div>
			<span><a href="#none">xxxxx World Corp.</a></span>
		</div>
	</div>

</body>

<script type="text/javascript">
	//onclick 용
	function move(result) {

		location.href = result;

	}
	
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
	
	
	$(document).ready( function() {
		
		
		//회원가입 event
		$('#submit').on('click',function(e) {
			//e.preventDefault();
			let year = $('#yy').val().trim();
			let month = $('#mm').val().trim();
			let day = $('#dd').val().trim();
			// 생년월일 유효성 검사 
			if ((year == '' || month == '' || day == '' ) && !(year == "" && month == "" && day == "")){
				alert("생년월일을 확인하세요.");
				return false;
			}
			if (year != "" && month != "" && day != ""){
				
				
			let date = year.concat("-", month, "-", day);
			let birth = new Date(date);
			formData.append("birth", birth);

			}
			let area = $('#selectedRegion option:selected').val();
			let intro = $('.user_intro').val().trim();
			let file = $('#file').val();
			let ext = file.split('.').pop().toLowerCase();
			let formData = new FormData();
			
			
			//파일 유효성 검사
			if ( file != "") {
		 	 		
		 	 //잘려있는 배열중 가장 마지막 배열
		 	 file.split('.').pop();
		 	 //마지막 배열을 소문자로 강제 변환
		 	 const ext = file.split('.').pop().toLowerCase();
		 	 		
		 	 //배열안에 포함된게 없다면 -1로 찍힘. 
		 	 if ( $.inArray(ext, ['gif', 'jpg', 'jpeg', 'png']) == -1) { 
				alert("gif, jpg, jpeg, png 파일만 가능합니다");
				document.getElementById('modifyimg').src = '/static/img/no.png';
				$('#file').val(''); // 업로드 된 파일을 비워준다.
				return false;
				} 
		 	 }
			
			
			
			formData.append("area", area);
			formData.append("intro", intro);
			formData.append("file", $('#file')[0].files[0]);

			$.ajax({
				type : 'POST'
				,url : '/user/user_update'
				,data : formData
				,enctype : "multipart/form-data"
				,processData: false 
				,contentType: false
				,success : function(data){
					if (data.code == 100){
						alert("회원가입이 완료 되었습니다.");
						location.href="/user/sign-in";
						
					} else if ( data.code == 400) {
						alert('회원가입에 실패하였습니다.')
					}
				}
				,error : function(e) {
					alert("관리자에게 문의해주세요.")
				}
				
			});
		});//회원가입 event 닫기
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}); //document 닫기
</script>
</html>