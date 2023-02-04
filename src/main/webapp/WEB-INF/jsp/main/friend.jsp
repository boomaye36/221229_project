<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
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
					<!-- 친구 요청 목록 -->
					<c:forEach items="${requestList}" var="request">
						${request.nickname }
						<button id="friend-yes" data-friend-id="${request.id}">수락</button>
						<button id="friend-no" data-friend-id="${request.id}">거절</button>
					</c:forEach>
				<!--친구 수락된 목록 -->
					<c:forEach items="${friendList}" var="friend">
						${friend.nickname }
						<button class="chat-btn" data-chat-id="${friend.id }">채팅하기</button>
					</c:forEach>
				
				
				</div>
			</div>
		</section>
		
		<!-- footer -->
		<jsp:include page="../include/footer.jsp" />
	</div>
</body>
<script>
$(document).ready(function(){
	// 수락 버튼 
	$('#friend-yes').on('click', function(){
		let user_id = $(this).data('friend-id');
		let confirm = '수락';
		$.ajax({
			type : 'post',
			url : "/friend_update",
			data : {user_id, confirm},
			success:function(data){
				if (data.code == 100){
					alert("친구 확인");
					location.reload();
				}
			}
		});
	});
	
	//거절 버튼
	$('#friend-no').on('click', function(){
		let user_id = $(this).data('friend-id');
		let confirm = '거절';
		$.ajax({
			type : 'post',
			url : "/friend_update",
			data : {user_id, confirm},
			success:function(data){
				if (data.code == 100){
					alert("친구 확인");
					location.reload();
				}
			}
		});
	});
});
</script>
</html>