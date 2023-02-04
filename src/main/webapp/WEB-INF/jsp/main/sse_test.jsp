<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SSE Test</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>  
</head>
<body>
	 <input type="text" id="id"/>
    <button type="button" onclick="login()">로그인</button>
    
    <br>
    <br>
    <button type="button" onclick="push()">알림보내기</button>

<script type="text/javaScript">
    function login() {
        const id = document.getElementById('id').value;

        const eventSource = new EventSource(`/subscribe/` + id);

        eventSource.addEventListener("sse", function (event) {
            console.log(event.data);

            //const data = JSON.parse(event.data);

			//alert(data.content);
        });
    }

    function push(){
    	const receiveid = 2;
    	$.ajax({
    		type:"get"
    		,url:"/sse_push_test"
    		, data:{"receiveid":receiveid}
    		, done: function(e){
    			console.log(e);
    		}
    	});
    }
</script>
</body>
</html>