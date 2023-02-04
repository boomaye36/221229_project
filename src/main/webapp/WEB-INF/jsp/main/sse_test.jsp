<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SSE Test</title>
</head>
<body>
	 <input type="text" id="id"/>
    <button type="button" onclick="login()">로그인</button>

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
</script>
</body>
</html>