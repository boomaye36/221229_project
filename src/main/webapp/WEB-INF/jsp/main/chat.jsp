<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
					
					<input type="hidden" value="${sessionScope.loginUser.id}" id="userId">
					<input type="hidden" value="${opponentId}" id="opponentId">
					
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
								<div class="list-title pt-3 px-3">친구목록</div>
								<!-- 친구목록 있을경우: 채팅 list 반복문 -->
								<c:forEach items="${friendList}" var="friend">
								<div class="list">
									<button type="button" class="friend-btn" data-room-number="${friend.friendId}">
										<div class="inner">
											<div class="img"><img src="${empty friend.profilephoto ? '/static/img/no.png' : friend.profilephoto}"></div>
											<div class="cont">
												<div class="user-nickname">${friend.nickname}</div>
												<div class="user-chat"><!-- 채팅 내용 --></div>
											</div>
										</div>
									</button>
								</div>
								</c:forEach>
								<!-- 친구목록 없을 경우: 텍스트 노출 -->
								<c:if test="${empty friendList}">
									<div class="empty-text">채팅 목록이 없습니다.</div>
								</c:if>
							</div>
						</div>
						
						<!-- 채팅 영역 -->
						<div class="lounge-chat-area">
							<!-- 메시지 영역 -->
							<div class="msg-box">
							
							<c:set var="datecompare" value="0"/>
							
							<c:choose>
							<c:when test="${fn:length(chatlog) == 0}">
								<input type="hidden" class="no-chat-data">  <!-- 추가 로딩 방지 -->
							</c:when>
							<c:otherwise>
								<c:forEach items="${chatlog}" var="log" varStatus="status">
									<c:set var="timestamp" value="${log.createdat }" />
									<fmt:formatDate value="${timestamp}" var="logDate" pattern="yyyy-MM-dd" type="date"/>
										<input type="hidden" name="chat-id" value="${log.id}" data-date="${logDate}">  <!-- chat DB id, createdat 정보 저장 -->
									<c:if test="${datecompare ne logDate}">
										<div class="date-change w-100 text-center">
										<fmt:formatDate value="${timestamp}" pattern="M월 d일" type="date"/>
										<c:set var="datecompare" value="${logDate}"/>	
										</div>
									</c:if>
									<c:choose>
										<c:when test="${log.user_sendid eq opponentId}">
											<div class="receive-user">
									    		<div class="user-img mr-2"><img src="/static/img/no.png"></div>
									    		<div class="chat-content">${log.content}</div>
									    		<div class="chat-timestamp"><div><fmt:formatDate value="${timestamp}" pattern="a h:mm" type="date"/></div></div>
									    	</div>
										</c:when>
										<c:otherwise>
											<div class="send-user">
									    		<div class="chat-timestamp"><div><fmt:formatDate value="${timestamp}" pattern="a h:mm" type="date"/></div></div>
									    		<div class="chat-content">${log.content}</div>
									    	</div>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</c:otherwise>
							</c:choose>
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
	
	
</body>
<script>

const userId = document.getElementById("userId").value;
const opponentId = document.getElementById("opponentId").value;

const msgBox = document.getElementsByClassName("msg-box")[0];

function setInnerHTML(sender, content, time) {
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
	
	msgBox.scrollTop = msgBox.scrollHeight;
	
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
			type : "post",
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
	
    socket.onclose = function (e){
    	console.log('close server!');
    	msgBox.innerHTML += "<div class='w-100 text-center'>연결이 중단되었습니다.</div>";
    };
    
    // DB 에서 불러온 날짜 저장. 없다면 현재날짜  
    let oldDate = new Date();
    var chatLog = document.getElementsByName("chat-id");
    if (! chatLog.length < 1){
    	oldDate = new Date(chatLog[chatLog.length - 1].dataset['date']); 
    	}	
    
    // 메시지 받음 
    socket.onmessage = function (e) {
    	console.log(e.data);
        var jsondata = JSON.parse(e.data);
        var time = new Date(jsondata.createdat);	// 날짜 비교용으로 string으로 나누기 전에 date 포멧에 할당
        var timeString = time.toLocaleTimeString();
        var hhmm = timeString.substring(0,timeString.length-3);
        var content = jsondata.content;
        var sender = jsondata.user_sendid;
		if ( oldDate.getYear() != time.getYear() || oldDate.getMonth() != time.getMonth() || oldDate.getDate() != time.getDate()) {
			var month = time.getMonth() + 1;
			msgBox.innerHTML += "<div class='date-change w-100 text-center'>"+ month + "월 "+ time.getDate() +"일</div>";
		}
		oldDate = time;
		setInnerHTML(sender,content, hhmm);
    }
    
    // 메시지 보냄
    let sendChatBtn = document.getElementById("sendChatBtn");
    sendChatBtn.addEventListener("click", 
    function() {
    	msgBox.scrollTop = msgBox.scrollHeight;
    	let content =  document.getElementById("chatContent").value;
    	if (content != ""){
	        let now = new Date();
	        var sendData = {
	        		user_sendid : userId,
	        		user_receiveid : opponentId,
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
    
    // 스크롤 최상단으로 이동시 채팅 추가 로딩 발생
    msgBox.addEventListener('scroll',function(){
    	if (msgBox.scrollTop == 0){
			if (document.getElementsByClassName("no-chat-data").length > 0 ){	
			} else {
	    		var chatLog = document.getElementsByName("chat-id");
	    	    if (chatLog.length > 0){
	    	    	chatId = chatLog[0].value;
					
	    	    	var beforeHeight = msgBox.scrollHeight;
	    	    	
	    	    	$.ajax({
	    	    		type:"post" ,
	    	    		url:"/read_chat",
	    	    		data: { userId, opponentId, chatId},
	    	    		success:function(data){
							if (data.code == 300){
								msgBox.insertAdjacentHTML('afterbegin','<input type="hidden" class="no-chat-data">');	// 받아온 채팅로그가 없다면 추가 로딩 방지 
								return false;
							} else if (data.code == 100) {
								
								var firstDateChange = document.getElementsByClassName("date-change")[0];
								    firstDateChange.remove();
								  
								for (var log in data.chatlog){
									
									var time = new Date(data.chatlog[log].createdat);
									var content = data.chatlog[log].content;
								    var timeString = time.toLocaleTimeString();
								    var hhmm = timeString.substring(0,timeString.length-3);
								    oldDate = new Date(chatLog[0].dataset['date']);
								    if ( oldDate.getYear() != time.getYear() || oldDate.getMonth() != time.getMonth() || oldDate.getDate() != time.getDate()) {
										var month = oldDate.getMonth() + 1;
										msgBox.insertAdjacentHTML('afterbegin', "<div class='date-change w-100 text-center'>"+ month + "월 "+ oldDate.getDate() +"일</div>");
									}
									msgBox.insertAdjacentHTML('afterbegin','<input type="hidden" name="chat-id">');
									chatLog[0].value = data.chatlog[log].id;
									chatLog[0].dataset.date = time;
									
									if (data.chatlog[log].user_sendid == userId ){
										msgBox.insertAdjacentHTML('afterbegin', '<div class="send-user"><div class="chat-timestamp"><div>' + hhmm + '</div></div><div class="chat-content">'+ content +'</div></div>');
									} else {
										msgBox.insertAdjacentHTML('afterbegin', '<div class="receive-user"><div class="user-img mr-2"><img src="/static/img/no.png"></div><div class="chat-content">'+ content +'</div><div class="chat-timestamp"><div>' + hhmm + '</div></div></div>');
									}
								}
								var month = time.getMonth() + 1;
								msgBox.insertAdjacentHTML('afterbegin', "<div class='date-change w-100 text-center'>"+ month + "월 "+ time.getDate() +"일</div>");
							}    	    			
	    	    		},
	    	    		complete: function(){
    	    			msgBox.scrollTop = msgBox.scrollHeight - beforeHeight;
	    	    		}
    	    		}); // ajax 종료
    	    	}	
			}
			
    	}
    });
});
</script>
</html>