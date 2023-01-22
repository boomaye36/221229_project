<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		
		<!-- visual -->
		<section class="main-visual d-flex align-items-center">
			<div class="container">
				<h1>La destinee</h1>
				<h2>다양한 사람들을 만나보세요!</h2>
				<div class="main-visual-btn-box text-center">
					<a href="/call" class="btn btn-custom">랜덤화상채팅 시작!</a>
				</div>
			</div>
		</section>
		
		<!-- contents -->
		<section class="main-content-area">
			<div class="container py-5">
            	<!-- content 1 -->
                <div class="main-content d-flex align-items-center justify-content-between">
                    <div class="order-2">
                        <div class="p-5"><img class="rounded-circle" src="https://picsum.photos/500" alt="image" /></div>
                    </div>
                    <div class="order-1">
                        <div class="py-5">
                            <h2 class="display-4 title">랜덤화상채팅</h2>
                            <p>랜덤화상채팅 쓸 수 있어!</p>
                        </div>
                    </div>
                </div>
                <!-- content 2 -->
                <div class="main-content d-flex align-items-center">
                    <div>
                        <div class="py-5 pr-5"><img class="img-fluid rounded-circle" src="https://picsum.photos/500" alt="image" /></div>
                    </div>
                    <div class="ml-5">
                        <div class="py-5">
                            <h2 class="display-4 title">친구추천</h2>
                            <p>친구추천 가능합니다.</p>
                        </div>
                    </div>
                </div>
                <!-- content 3 -->
                <div class="main-content d-flex align-items-center justify-content-between">
                    <div class="order-2">
                        <div class="p-5"><img class="img-fluid rounded-circle" src="https://picsum.photos/500" alt="image" /></div>
                    </div>
                    <div class="order-1">
                        <div class="py-5">
                            <h2 class="display-4 title">친구와 채팅하기</h2>
                            <p>친구와 채팅까지 할 수 있다.</p>
                        </div>
                    </div>
                </div>
			</div>
		</section>
		
		<!-- footer -->
		<jsp:include page="../include/footer.jsp" />
	</div>
</body>
</html>