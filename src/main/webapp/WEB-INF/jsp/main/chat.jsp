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
									<button type="button" class="friend-btn">
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
							<div class="msg-box">
							    <!-- 상대방 메시지 -->
							    <div class="receive-user">
							    	<div class="user-img mr-2"><img src="/static/img/no.png"></div>
							    	<div class="chat-content">상대방이 보낸 채팅 내용</div>
							    </div>
							    <!-- 보낸 시간 -->
							    <div class="created-at">2023/02/04 14:44</div>
							    <!-- 내 메시지 -->
							    <div class="send-user">
							    	<div class="chat-content">내가 보낸 채팅 내용</div>
							    </div>
							</div>
							
							<!-- 메시지 전송 영역 -->
							<div class="input-box">
								<input type="text" placeholder="보낼 메세지를 입력하세요." id="chatContent" maxlength=200>
								<button type="button" value="전송" class="send-btn" id="sendChatBtn">전송</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		
		<!-- footer -->
		<jsp:include page="../include/footer.jsp" />
		
	</div>
	
	<input type="hidden" value="${sessionScope.loginUser.id}" id="userId">
</body>
<script>

const userId = document.getElementById("userId").value;

function setInnerHTML(sender, content, time) {
	const msgBox = document.getElementsByClassName("msg-box")[0];
	
	var eh = msgBox.clientHeight + msgBox.scrollTop; // 스크롤 현재 높이
	var isScroll = msgBox.scrollHeight <= eh;
	if (sender == userId ){
		msgBox.innerHTML += '<div class="send-user"><div class="chat-timestamp"><div>' + time + '</div></div><div class="chat-content">'+ content +'</div></div>';
	} else {
		msgBox.innerHTML += '<div class="receive-user"><div class="user-img mr-2"><img src="/static/img/no.png"></div><div class="chat-content">'+ content +'</div><div class="chat-timestamp"><div>' + time + '</div></div></div>';
	}
	
	if (isScroll){	
		msgBox.scrollTop = msgBox.scrollHeight; // 스크롤이 최하단에 위치해있었을 경우에만 스크롤 위치 하단 고정
	} 
}


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
	
	// 채팅 설정
    const pathname = window.location.pathname;
    const room = pathname.split('/lounge/chat/')[1];
    const socket = new WebSocket("ws://localhost/websocket/{"+room+"}");
	console.log(room + "번 방에 입장");
    
    socket.onopen = function (e) {
        console.log('open server!')
    };

    socket.onerror = function (e){
        console.log(e);
    }
    
    socket.onmessage = function (e) {
        console.log(e.data);
        var jsondata = JSON.parse(e.data);
        let time = new Date(jsondata.createdat);	// 날짜 비교용으로 string으로 나누기 전에 date 포멧에 할당
        let timeString = time.toLocaleTimeString();
        let hhmm = timeString.substring(0,timeString.length-3);
		let content = jsondata.content;
		let sender = jsondata.user_sendid;
		setInnerHTML(sender,content, hhmm);
    }
	
    let sendChatBtn = document.getElementById("sendChatBtn");
    sendChatBtn.addEventListener("click", 
    function() {
    	let content =  document.getElementById("chatContent").value;
    	if (content != ""){
	        let now = new Date();
	        var sendData = {
	        		user_sendid : userId,
	        		user_receiveid : "받는 유저",
	        		content : content,
	        		createdat : now
	        	}	
	        socket.send(JSON.stringify(sendData));
	        document.getElementById("chatContent").value = null;
    	}
    	document.getElementById("chatContent").focus();
    });

    document.getElementById("chatContent").addEventListener("keyup", function(e){
    	if ( e.keyCode == 13){
    		sendChatBtn.click();		
    	}
    });
});
</script>
</html>