<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <input type="text" name="localPeerId" id="localPeerId"><br>
    <input type="text" name="remotePeerId" id="remotePeerId">
    <button id="btn-call">Call</button><br><br>
    <video id="localVideo"></video>
    <video id="remoteVideo"></video>
    <script src="https://unpkg.com/peerjs@1.4.7/dist/peerjs.min.js"></script>
    <script src="peerjs.js"></script>
</body>

<script type="text/javascript">

let localStream;
var peer = new Peer();
const inputLocalPeerId = document.getElementById("localPeerId");
const inputRemotePeerId = document.getElementById("remotePeerId");
const btnCall = document.getElementById("btn-call");

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

btnCall.addEventListener("click", function(){
    const remotePeerId = inputRemotePeerId.value;
    const call = peer.call(remotePeerId, localStream);
    call.on("stream", stream => {
       const remoteVideo =  document.getElementById("remoteVideo");
       remoteVideo.srcObject = stream;
       remoteVideo.onloadedmetadata = () => remoteVideo.onplay();

    });
});

peer.on("call", call => {
    call.answer(localStream);
    call.on("stream", stream => {
        const remoteVideo =  document.getElementById("remoteVideo");
        remoteVideo.srcObject = stream;
        remoteVideo.onloadedmetadata = () => remoteVideo.onplay();
    });
});
</script>
</html>