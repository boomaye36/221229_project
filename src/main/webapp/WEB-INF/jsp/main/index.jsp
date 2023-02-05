<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<input type="text" placeholder="보낼 메세지를 입력하세요." class="content">
    <button type="button" value="전송" class="sendBtn" onclick="sendMsg()">전송</button>

	
<div class="msgArea">
    <span>메세지</span>
    <div class="msgArea"></div>
</div>



</body>
<script>
        const pathname = window.location.pathname;
        const room = pathname.split('/test/')[1];
		console.log(room);
        const socket = new WebSocket("ws://localhost/websocket/{"+room+"}");
        
        socket.onopen = function (e) {
            console.log('open server!')
        };

        socket.onerror = function (e){
            console.log(e);
        }
        
        socket.onmessage = function (e) {
            console.log(e.data);
            let msgArea = document.querySelector('.msgArea');
            let newMsg = document.createElement('div');
            newMsg.innerText=e.data;
            msgArea.append(newMsg);
        }

        function sendMsg() {
            let content=document.querySelector('.content').value;
            var sendData = {
            		id : "유저",
            		content : content
            }
            
            socket.send(JSON.stringify(sendData));
        }
</script>
</html>