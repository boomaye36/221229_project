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
<script src="https://unpkg.com/peerjs@1.4.7/dist/peerjs.min.js"></script>
<!-- material icons -->
<link
	href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp"
	rel="stylesheet">

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
					<div class="call-area border">
						<div class="call-top">
							<!-- user profile 영역 -->
							<div class="call-user-profile-box">
								<div class="user-profile">
									<!-- 내 프로필 -->
									<div class="profile">
										<!-- <img src="/static/img/no.png"> --> <!-- 기본이미지 -->
										<img src="${empty sessionScope.loginUser.profilephoto ? '/static/img/no.png' : sessionScope.loginUser.profilephoto }">
										<div class="user-nickname">${sessionScope.loginUser.nickname}</div>
										<input type="hidden" id="userNickname" value="${sessionScope.loginUser.nickname}">
									</div>
									<!-- 카메라/마이크 on/off 버튼 -->
									<div class="d-flex">
										<button id="camera-btn"><span class="material-icons">videocam_off</span></button>
										<button id="voice-btn" class="ml-1"><span class="material-icons">mic_off</span></button>
									</div>
								</div>
								<div class="user-profile">
									<!-- 상대방 프로필 -->
									<div class="profile">									
										<img src="/static/img/no.png"> <!-- 기본이미지 -->
										<div class="user-nickname"><input type="text" name="user-nickname"></div>
										<div class="user-nickname">상대방닉네임</div>
										<img src="/static/img/no.png" class="respose-profilephoto"> <!-- 기본이미지 -->
										<div class="response-nickname user-nickname">상대방닉네임</div>
									</div>
								</div>
							</div>
							
							<!-- 카메라 표시 마이크 카메라 설정 -->
							<div class="call-check-status">
								<!-- peerJS id input -->
								<div class="peerid-input-box">
								    <input type="text" name="localPeerId" id="localPeerId" class="d-none">
								    <input type="text" name="remotePeerId" id="remotePeerId"  class="d-none">
								</div>
								<!-- 웹캠 -->
								<div class="video-box">
								    <div class="video">
										<video id="localVideo"></video>
								    </div>
								    <div class="video">
										<video id="remoteVideo"></video>
								    </div>
								</div>
							</div>

							<!-- 웹캠 하단영역 -->
							<div class="d-flex">
								<!-- 매칭 옵션 체크 -->
								<div class="call-search-option">
	
									<div class="call-gender-option-subject">
										<span>성별 선택</span>
									</div>
									<div class="call-gender-option-content">
										<input type="radio" id="gender1" name="genderSelectRadio" value="모두"><label for="gender1">모두</label> 
										<input type="radio" id="gender2" name="genderSelectRadio" value="남자"><label for="gender2">남자</label>
										<input type="radio" id="gender3" name="genderSelectRadio" value="여자"><label for="gender3">여자</label>
									</div>
									
									<div class="call-btn-box">
										<button type="button" id="call-btn" class="btn btn-custom" >랜덤영상통화 시작!</button>
									</div>
								</div>
								
								<!-- 채팅 -->
								<div class="call-chat">
									<div class="chat-box">
										<!-- 채팅 내용 -->
										<!-- <div class="chat">
											<div class="user-nickname">닉네임</div>
											<div class="chat-content">채팅내용</div>
										</div> -->
									</div>
									<form>
										<div class="input-box">
											<input type="text" class="chat-input" placeholder="내용을 입력하세요">
											<button type="submit" id="chatSend" class="chat-send-btn">전송</button>
										</div>
									</form>
								</div>
							</div>
						</div>

						<div class="call-bottom">

							<!-- 매칭 이력 -->

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
let localStream;
var peer = new Peer();
const inputLocalPeerId = document.getElementById("localPeerId");
const inputRemotePeerId = document.getElementById("remotePeerId");

//비디오 설정 
navigator.mediaDevices.getUserMedia({video:true, audio:true})
    .then(stream => {
        localStream = stream;
        const videoElement = document.getElementById("localVideo");
        videoElement.srcObject = stream;
        videoElement.onloadedmetadata = () => videoElement.play();
    });
peer.on("open", id=> {
    inputLocalPeerId.value = id;

});

// chat div영역 설정
function setInnerHTML(nickname, text) {
	const element = document.getElementsByClassName("chat-box")[0];
	
	var eh = element.clientHeight + element.scrollTop; // 스크롤 현재 높이
	var isScroll = element.scrollHeight <= eh;
	
	element.innerHTML += '<div class="chat">'+'<span class="user-nickname">'+nickname+'</span><span class="chat-content">'+text+'</span></div>';
	
	if (isScroll){	
		element.scrollTop = element.scrollHeight; // 스크롤이 최하단에 위치해있었을 경우에만 스크롤 위치 하단 고정
	} 
}

const chatSend = document.getElementById("chatSend");
const nickName = document.getElementById("userNickname").value;

$(document).ready(function(){
	
	
	// 채팅 임시 세팅
	chatSend.onclick = function(e){
		e.preventDefault();
	};
	
	//카메라 on / off
	$(document).on("click", "#camera-btn", function(){
		if (($('#camera-btn > .material-icons').text() === "videocam_off") && ($('#voice-btn > .material-icons').text() === "mic_off")){
			navigator.mediaDevices.getUserMedia({video:false, audio:true})
			.then(stream => {
		        localStream = stream;
		        const videoElement = document.getElementById("localVideo");
		        videoElement.srcObject = stream;
		        videoElement.onloadedmetadata = () => videoElement.play();
		    });
		
		    $('#camera-btn > .material-icons').text("videocam");

		}
		else if (($('#camera-btn > .material-icons').text() === "videocam_off") && ($('#voice-btn > .material-icons').text() === "mic")){
			navigator.mediaDevices.getUserMedia({video:false, audio:false})
			.then(stream => {
		        localStream = stream;
		        const videoElement = document.getElementById("localVideo");
		        videoElement.srcObject = stream;
		        videoElement.onloadedmetadata = () => videoElement.play();
		    });
		
		    $('#camera-btn > .material-icons').text("videocam");

		}
		else if (($('#camera-btn > .material-icons').text() === "videocam") && ($('#voice-btn > .material-icons').text() === "mic")){
			navigator.mediaDevices.getUserMedia({video:true, audio:false})
			.then(stream => {
		        localStream = stream;
		        const videoElement = document.getElementById("localVideo");
		        videoElement.srcObject = stream;
		        videoElement.onloadedmetadata = () => videoElement.play();
		    });
		
		    $('#camera-btn > .material-icons').text("videocam_off");

		}
		else{
			navigator.mediaDevices.getUserMedia({video:true, audio:true})
			.then(stream => {
		        localStream = stream;
		        const videoElement = document.getElementById("localVideo");
		        videoElement.srcObject = stream;
		        videoElement.onloadedmetadata = () => videoElement.play();
		    });
		
		    $('#camera-btn > .material-icons').text("videocam_off");
		}
	});
	// 소리 on / off
	$(document).on("click", "#voice-btn", function(){
		if (($('#voice-btn > .material-icons').text() === "mic_off") && ($('#camera-btn > .material-icons').text() === "videocam_off")){
			navigator.mediaDevices.getUserMedia({video:true, audio:false})
			.then(stream => {
		        localStream = stream;
		        const videoElement = document.getElementById("localVideo");
		        videoElement.srcObject = stream;
		        videoElement.onloadedmetadata = () => videoElement.play();
		    });
		 
		    $('#voice-btn > .material-icons').text("mic");

		}
		else if (($('#voice-btn > .material-icons').text() === "mic_off") && ($('#camera-btn > .material-icons').text() === "videocam")){
			navigator.mediaDevices.getUserMedia({video:false, audio:false})
			.then(stream => {
		        localStream = stream;
		        const videoElement = document.getElementById("localVideo");
		        videoElement.srcObject = stream;
		        videoElement.onloadedmetadata = () => videoElement.play();
		    });
		 
		    $('#voice-btn > .material-icons').text("mic");

		}
		else if (($('#voice-btn > .material-icons').text() === "mic") && ($('#camera-btn > .material-icons').text() === "videocam_off")){
			navigator.mediaDevices.getUserMedia({video:true, audio:true})
			.then(stream => {
		        localStream = stream;
		        const videoElement = document.getElementById("localVideo");
		        videoElement.srcObject = stream;
		        videoElement.onloadedmetadata = () => videoElement.play();
		    });
		 
		    $('#voice-btn > .material-icons').text("mic_off");

		}
		else{
			navigator.mediaDevices.getUserMedia({video:false, audio:true})
			.then(stream => {
		        localStream = stream;
		        const videoElement = document.getElementById("localVideo");
		        videoElement.srcObject = stream;
		        videoElement.onloadedmetadata = () => videoElement.play();
		    });
		
		    $('#voice-btn > .material-icons').text("mic_off");

		}
	});

	//변수차단 ( 뒤로가기 , 새로고침, 이동시 대기방테이블 삭제)
	$(window).bind("beforeunload", function(e){
		
		$.ajax({
			type : "DELETE"
			,url : "/wait_out"
			,success : function(result){
				console.log(result);
			}
			,error : function(){
				
			}
			
		})
			
	});
	
	//동적 클릭 이벤트
	$(document).on("click", "#call-btn", function(){

		var btn = $('#call-btn').text();
		let localid = $('#localPeerId').val().trim();
        let preference = $('input[name="genderSelectRadio"]:checked').val(); 
		//성별선택 안하면 끝내기
		if(preference === undefined) {
			alert('성별을 선택해주세요');
			return false;
		}
		if (btn === '랜덤영상통화 시작!') {
			$('#call-btn').text("매칭취소");
			
	        $.ajax({
	        	type : 'post'
				,url : '/wait_insert'
				,data : {localid, preference}
				,success : function(result) {
					if(result.result === null) {
						console.log("대기방 대기중")
						$('#call-btn').text('멈춤');
					} else {
						console.log("매칭");
						
						// 원하는 조건의 상대방 카메라 id 값
						var remote = result.result.localid;
						//let nickname = result.user.nickname;
						var user_receiveid = result.result.user_id;
						//input 상대방 태그의 값에 넣어줌 
						$('input[name=remotePeerId]').attr('value', remote);
						
						//넣어준 remoteid값 가져옴 
						const remotePeerId = inputRemotePeerId.value;
					    const call = peer.call(remotePeerId, localStream);

					    call.on("stream", stream => {
					       const remoteVideo =  document.getElementById("remoteVideo");
					       remoteVideo.srcObject = stream;
					       remoteVideo.onloadedmetadata = () => remoteVideo.play();
					      
					    });
					    
					    // 채팅 세팅
					    const conn = peer.connect(remotePeerId);
					    conn.on('open', function() {
					    	// Receive messages
					    	setInnerHTML('접속확인테스트','');  
					    	$(document).on("click", "#call-btn", async function(){
					    		var closeMessage = {
			    						"type":"system",
			    						"content":"close"
			    				}
				    			conn.send(closeMessage);
						   		//conn.close();
						   		
						   		chatSend.onclick = function(e){
						   			e.preventDefault();
						    		}
					    	});
					    		
					    	
					    		chatSend.onclick = function(e){
					    			e.preventDefault();
					    			var chatContent = document.getElementsByClassName("chat-input")[0].value;
					    			if (chatContent != ''){
					    				var chatData = {
					    						"type":"chatData",
					    						"nickName":nickName,
					    						"chatContent":chatContent
					    				}
						    			conn.send(chatData);
					    				setInnerHTML(nickName,chatContent);
					    				document.getElementsByClassName("chat-input")[0].value = null;
					    			}
					    			document.getElementsByClassName("chat-input")[0].focus(); 
					    		};
					    	conn.on('data', function(data) {
					    		if (data['type']=='chatData'){
					    			setInnerHTML(data['nickName'],data['chatContent']);
					    				}
					    		else if (data['type']=='system'){
					    			if (data['content'] == "close"){
					    				setInnerHTML("통화가 종료되었습니다","");
					    				conn.close();
					    		   		chatSend.onclick = function(e){
					    		   			e.preventDefault();
					    		    		}
					    			}
					    		}
					    	});
					      }); 
					    
					    
					    //원하는 조건의 상대방 id값
					    var callNickname = result.responseUser.nickname;
					    
					    //원하는 조건의 상대방 프로필 값
					    var callPhoto = result.responseUser.profilephoto;
					    
					    $('.response-nickname').text(callNickname)
					    if (callPhoto != null) {
					    	$('.respose-profilephoto').attr("src" , callPhoto);
					    }
					    
					    $('#call-btn').text('멈춤');
					    
					   // 매칭되면 recent 테이블 추가, wait테이블 삭제 ajax
					    $.ajax({
							type : "post"
							,url : "/recent_insert"
							,data : {user_receiveid}
							,success : function(result) {
								if(result.result > 0 ) {
									console.log("대기방 삭제 및 recent 테이블 insert 완료")
								} else {
									console.log("삭제오류있음.")
								}
								
							}
						});
					}
				}
	        });
		} else {
			//멈춤버튼 누르면 연결 끊김 
			peer.destroy();
			$('#call-btn').text("랜덤영상통화 시작!");
			$.ajax({
				type : "DELETE"
				,url : "/wait_out"
				,success : function(result) {
					location.reload();
				}
			});
			
		} 
		
	}); //동적이벤트 닫기
	
	
	
});


//전화를 받는 사람의 on 메소드
peer.on("call", call => {
    call.answer(localStream);
    call.on("stream", stream => {
        const remoteVideo =  document.getElementById("remoteVideo");
        remoteVideo.srcObject = stream;
        remoteVideo.onloadedmetadata = () => remoteVideo.play();
    });
    
    $.ajax({
    	type : "GET"
    	,url : "/recent_check"
    	,success : function(result) {
    		var responseNickname = result.user.nickname;
    		var responsePhoto = result.user.profilephoto;
    		
    		 $('.response-nickname').text(responseNickname)
			    if (responsePhoto != null) {
			    	$('.respose-profilephoto').attr("src" , responsePhoto);
			    }
    		
    	}
    })
});

// 채팅 세팅
peer.on('connection', function(conn) { 
	setInnerHTML('매칭확인테스트','');

	conn.on('data',data=>{
		console.log(data);
		if (data['type']=='chatData'){
		setInnerHTML(data['nickName'],data['chatContent']);
		}
		else if (data['type']=='system'){
			if (data['content'] == "close"){
				setInnerHTML("통화가 종료되었습니다","");
				conn.close();
		   		chatSend.onclick = function(e){
		   			e.preventDefault();
		    		}
			}
		}
	});
	
	$(document).on("click", "#call-btn", async function(){
		var closeMessage = {
				"type":"system",
				"content":"close"
		}
		conn.send(closeMessage);
   		//conn.close();
   		
   		chatSend.onclick = function(e){
   			e.preventDefault();
    		}
	});
	
	chatSend.onclick = function(e){
		e.preventDefault();
		var chatContent = document.getElementsByClassName("chat-input")[0].value;
		if (chatContent != ''){
			var chatData = {
					"type":"chatData",
					"nickName":nickName,
					"chatContent":chatContent
			}
   			conn.send(chatData);
			setInnerHTML(nickName,chatContent);
			document.getElementsByClassName("chat-input")[0].value = null;
		}
		document.getElementsByClassName("chat-input")[0].focus(); 
	};
});

</script>
</html>