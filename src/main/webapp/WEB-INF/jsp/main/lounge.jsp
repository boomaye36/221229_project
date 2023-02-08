<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
					<!-- 친구 요청 목록 -->
					<%-- <c:forEach items="${requestList}" var="request">
						${request.nickname }
						<button type="button" class="friend-yes" data-friend-id="${request.id}">수락</button>
						<button type="button" class="friend-no" data-friend-id="${request.id}">거절</button>
					</c:forEach> --%>
					<!--친구 수락된 목록 -->
					<%-- <c:forEach items="${friendList}" var="friend">
						${friend.nickname }
					</c:forEach> --%>
					
					<!-- 라운지 -->
					<div class="lounge">
						<!-- 친구 영역 -->
						<div class="lounge-friend-area">
							<!-- 친구요청목록 -->
							<div class="friend-request-list p-3">
								<div class="list-title">친구요청</div>
								<!-- 친구요청 있을 경우: list 반복문 -->
								<c:if test="${!empty requestList}">
									<c:forEach items="${requestList}" var="request">
									<div class="list">
										<div class="user-box">
											<div class="img"><img src="${empty request.profilephoto ? '/static/img/no.png' : request.profilephoto}"></div>
											<div class="user-nickname">${request.nickname}</div>
										</div>
										<div class="btn-box">
											<button type="button" class="friend-request-btn friend-yes" data-friend-id="${request.id}">수락</button>
											<button type="button" class="friend-request-btn friend-no" data-friend-id="${request.id}">거절</button>
										</div>
									</div>
									</c:forEach>
								</c:if>
								<!-- 친구요청 없을 경우: 텍스트 노출 -->
								<c:if test="${empty requestList}">
									<div class="empty-text">받은 친구 요청이 없습니다.</div>
								</c:if>
							</div>
							<!-- 친구목록 -->
							<div class="friend-list">
								<div class="list-title pt-3 px-3">채팅목록</div>
								<!-- 친구목록 있을경우: 채팅 list 반복문 -->
								<c:forEach items="${friendList}" var="friend">
								<div class="list">
									<button type="button" class="friend-btn" data-room-number="${friend.friendId }">
										<div class="inner">
											<div class="img"><img src="${empty friend.profilephoto ? '/static/img/no.png' : friend.profilephoto}"></div>
											<div class="cont">
												<div class="user-nickname">${friend.nickname}</div>
												<div class="user-chat">채팅 내용입니다. 채팅 내용입니다. 채팅 내용입니다.</div>
											</div>
										</div>
									</button>
								</div>
								</c:forEach>
								<!-- 친구목록 없을 경우: 텍스트 노출 -->
								<%-- <c:if test=""> --%>
									<div class="empty-text">채팅 목록이 없습니다.</div>
								<%-- </c:if> --%>
							</div>
						</div>
						
						
						<!-- 채팅 영역 -->
						
						<div class="lounge-chat-area">
							<!-- 메시지 영역 -->
							<!-- <div class="msg-box">
							    상대방 메시지
							    <div class="receive-user">
							    	<div class="user-img mr-2"><img src="/static/img/no.png"></div>
							    	<div class="chat-content">상대방이 보낸 채팅 내용</div>
							    </div>
							    보낸 시간
							    <div class="created-at">2023/02/04 14:44</div>
							    내 메시지
							    <div class="send-user">
							    	<div class="chat-content">내가 보낸 채팅 내용</div>
							    </div>
							</div> -->
							
							<!-- 메시지 전송 영역 -->
						<!-- 	<div class="input-box">
								<input type="text" placeholder="보낼 메세지를 입력하세요." class="content">
								<button type="button" value="전송" class="send-btn">전송</button>
							</div>
						</div>
						 -->
						
						
					</div>
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
	$('.friend-yes').on('click', function(){
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
	$('.friend-no').on('click', function(){
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
	
	// 채팅방 입장
	$('.friend-btn').on('click', function() {
		let room = $(this).data('room-number');
		location.href="/lounge/chat/"+room;
	});
});
</script>
</html>