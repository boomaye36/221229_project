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

							<!-- 카메라 표시 마이크 카메라 설정 -->
							<div class="call-check-status">
							    <input type="text" name="localPeerId" id="localPeerId"><br>
							
								<br>
								<br>
								<video id="localVideo"></video>
								<video id="remoteVideo"></video>
								<script src="https://unpkg.com/peerjs@1.4.7/dist/peerjs.min.js"></script>
							</div>

							<!-- 매칭 옵션 체크 -->
							<div class="call-search-option">

								<div class="call-gender-option-subject">
									<span>성별 선택</span>
								</div>
								<div class="call-gender-option-content">
									<input type="radio" id="gender1" name="genderSelectRadio"  value="모두"><label for="gender1">모두</label> 
									<input type="radio" id="gender2" name="genderSelectRadio"  value="남자"><label for="gender2">남자</label>
									<input type="radio" id="gender3" name="genderSelectRadio"  value="여자"><label for="gender3">여자</label>
								</div>
								<div class="call-btn-box">
									<a href="#" id="call-btn" class="btn btn-custom">영상통화</a>
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
//console.log(inputLocalPeerId);
navigator.mediaDevices.getUserMedia({video:true})
    .then(stream => {
        localStream = stream;
        const videoElement = document.getElementById("localVideo");
        videoElement.srcObject = stream;
        videoElement.onloadedmetadata = () => videoElement.play();
    });
peer.on("open", id=> {
    inputLocalPeerId.value = id;

});

/* btnCall.addEventListener("click", function(){
    const remotePeerId = inputRemotePeerId.value;
    const call = peer.call(remotePeerId, localStream);
    call.on("stream", stream => {
       const remoteVideo =  document.getElementById("remoteVideo");
       remoteVideo.srcObject = stream;
       remoteVideo.onloadedmetadata = () => remoteVideo.play();

    });
}); */
$(document).ready(function(){
	
	$('#call-btn').on('click', function(){
		let localid = $('#localPeerId').val().trim();
        let preference = $('input[name="genderSelectRadio"]:checked').val(); 
        $.ajax({
        	type : 'post',
			url : '/wait_insert',
			data : {localid, preference},
			success : function(result) {
				console.log(result.result)
				if(result.result === null) {
					console.log("대기방 대기중")
				} else {
					console.log("매칭");
				}
			}
        });
	});
});
peer.on("call", call => {
    call.answer(localStream);
    call.on("stream", stream => {
        const remoteVideo =  document.getElementById("remoteVideo");
        remoteVideo.srcObject = stream;
        remoteVideo.onloadedmetadata = () => remoteVideo.play();
    });
});
</script>
</html>