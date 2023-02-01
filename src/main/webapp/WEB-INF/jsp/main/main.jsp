<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		
		<!-- visual -->
		<section class="main-visual d-flex align-items-center">
			<div class="container">
				<h1>La destinee</h1>
				<h2>더 많은 사람들이 함께 친구가 되고<br>함께 놀 수 있는 세상을 만들어 갑니다.</h2>
				<div class="main-visual-btn-box text-center">
					<a href="/call" class="btn btn-custom">랜덤화상채팅 시작</a>
				</div>
			</div>
		</section>
		
		<!-- contents -->
		<section class="main-content-area">
			<div class="container py-5">
            	<!-- content 1 -->
                <div class="main-content d-flex align-items-center justify-content-between">
                    <div class="order-2">
                        <div class="p-5">
                        	<a href="/call" class="img-link"><img class="rounded-circle" src="/static/img/main-img-01.jpg" alt="메인이미지1" /></a>
                        </div>
                    </div>
                    <div class="order-1">
                        <div class="py-5">
                            <h2 class="display-4 title">랜덤통화</h2>
                            <p>실시간으로 기다림 없이 새로운 친구들을 만나보세요!</p>
                        </div>
                    </div>
                </div>
                <!-- content 2 -->
                <div class="main-content d-flex align-items-center">
                    <div>
                        <div class="py-5 pr-5">
                        	<a href="/recommend" class="img-link"><img class="img-fluid rounded-circle" src="/static/img/main-img-02.jpg" alt="메인이미지2" /></a>
                        </div>
                    </div>
                    <div class="ml-5">
                        <div class="py-5">
                            <h2 class="display-4 title">추천친구</h2>
                            <p>커뮤니티의 수많은 유저들 중 내 마음에 쏙 드는 유저를 찾고<br>직접 친구 요청을 보낼 수도 있습니다.</p>
                        </div>
                    </div>
                </div>
                <!-- content 3 -->
                <div class="main-content d-flex align-items-center justify-content-between">
                    <div class="order-2">
                        <div class="p-5">
                        	<a href="/friend" class="img-link"><img class="img-fluid rounded-circle" src="/static/img/main-img-03.jpg" alt="메인이미지3" /></a>
                        </div>
                    </div>
                    <div class="order-1">
                        <div class="py-5">
                            <h2 class="display-4 title">라운지</h2>
                            <p>바로 영상통화를 할 준비가 되지 않았다면,<br>destinee 라운지에서 친구와 1:1 대화를 시작해보세요.</p>
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