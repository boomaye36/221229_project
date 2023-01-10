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
			<b>지역</b> <select class="m-3 " id="selectedRegion"
				name="selectedRegion">
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
			<b>프로필사진</b> <img src="/static/img/no.png"> <input type="file"
				accept=".gif, .jpg, .png, .jpeg" id="file">

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
	$(document).ready(
		function() {
			
			$('#file').on('click',
					function(e) {
						let fileName = e.target.files[0].name; 
						alert(fileName);
						let ext = fileName.split('.').pop().toLowerCase();

						if (fileName.split('.').length < 2
								|| (ext != 'gif' && ext != 'png'
										&& ext != 'jpg' && ext != 'jpeg')) {
							alert("이미지 파일만 업로드 할 수 있습니다.");
							$(this).val(''); 
							$('#fileName').text(''); 
							return;
						}

				$('#fileName').text(fileName);
					});		 
			
			$('#submit').on('click',function(e) {
				//e.preventDefault();
				let date = $('#yy').val().trim().concat("-", $('#mm').val().trim(), "-", $('#dd').val().trim());
				/* function parse(date){
					var y = date.substr(0,4);
					var m = date.substr(4,2);
					var d = date.substr(6,2);
					return new Date(y, m-1, d);
				} */
				let user_birth = new Date(date);
				let user_area = $('#selectedRegion option:selected').val();
				let user_intro = $('.user_intro').val().trim();
				let file = $('#file').val();
				let ext = file.split('.').pop().toLowerCase();
				alert(user_birth);

				let user_profilephoto = $('#file')[0].files[0];
				let formData = new FormData();

				formData.append("user_birth", user_birth);
				formData.append("user_area", user_area);
				formData.append("user_intro", user_intro);
				formData.append("user_profilephoto", $('#file')[0].files[0]);

			$.ajax({
				type : 'post',
				url : '/user/user_update',
				data : formData,
				enctype : "multipart/form-data" ,

				processData: false, contentType: false,
				success : function(data){
					if (data.code == 100){
						alert("추가되었습니다.");
						
					}
				}
				
			});
			});
		});
</script>
</html>