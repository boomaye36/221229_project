<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	
	<!-- swiper -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css" />
	<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
	
	<!-- css -->
	<link href="/static/css/main.css" rel="stylesheet" />
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
</head>
<body class="bodytest">
	<div class="main-wrap">
	
		<!-- navigation -->
		<jsp:include page="../include/nav.jsp" />
		
		<!-- contents -->
		<section class="content-area">
			
				<div class="recommend-outer">
					<!-- Swiper -->
					<div class="swiper mySwiper">
					    <div class="swiper-wrapper">
					    	<c:set var="number" value="0" />
					    	<c:forEach items="${userList}" var="user" varStatus="status">
					    		<div class="swiper-slide">
					    			<img src="${empty user.profilephoto ? '/static/img/no.png' : user.profilephoto}" alt="유저이미지" class="swiper-img">
					    			<div class="swiper-user-info">
						    			<div class="user-info-nickname">${user.nickname}</div>
					    				<c:if test="${not empty user.birth}">
						    				<div class="user-info-birth">
						    					&nbsp;&nbsp;|&nbsp;&nbsp;
						    					<fmt:formatDate value="${user.birth}" pattern="yy"/>년생
						    				</div>
					    				</c:if>
					    				<c:if test="${not empty user.area}">
						    				<div class="user-info-area">
						    					&nbsp;&nbsp;|&nbsp;&nbsp;
						    					${user.area}
						    				</div>
					    				</c:if>
					    				
					    			</div>
					    			<div class="swiper-btn-box">
						    			<button class="friend-btn pass" data-user-id="${user.id}">
						    				<span class="material-icons">cancel</span>
						    			</button>
						    			<button class="friend-btn add" data-user-id="${user.id}">
						    				<span class="material-icons">favorite</span>
						    			</button>
						    			<button class="friend-btn block" data-user-id="${user.id}">
						    				<span class="material-icons">remove_circle</span>
						    			</button>
					    			</div>
					    		</div>
					    		<c:set var="number" value="${number + 1}" /> 
					    	</c:forEach>
					    	<input type="hidden" value="${number}" class="lastindex">
					    	
					    </div>
					 </div>
				 </div>
				  
		</section>
		
		<!-- footer -->
		<jsp:include page="../include/footer.jsp" />
	</div>
</body>

	



<script>
<!-- Initialize Swiper -->
var swiper = new Swiper(".mySwiper", {
  effect: "cards",
  grabCursor: true,
  
});


$(document).ready(function(){
	// 친구 추가 버튼 
	$('.add').on('click', function(){
		let user_receiveid = $(this).data('user-id');
		$.ajax({
			type : 'post'
			,url : "/friend_insert"
			,data : {user_receiveid}
			,success:function(data){
				if (data.code == 100){
					alert("친구 신청이 되었습니다.");
				}
			}
		});
		var index = swiper.activeIndex + 1;
		swiper.slideTo(index);
		var lastindex = $('.lastindex').val();
		if ( index == lastindex) {
			location.reload();
		}
		
	});
	
	//친구 차단 버튼
	$('.block').on('click', function(){
		let user_receiveid = $(this).data('user-id');
		$.ajax({
			type : 'post'
			,url : "/block_insert"
			,data : {user_receiveid}
			,success:function(data){
				if (data.code == 100){
					alert("차단되었습니다.");
				}
			}
		});
		
		var index = swiper.activeIndex + 1;
		swiper.slideTo(index);
		var lastindex = $('.lastindex').val();
		if ( index == lastindex) {
			location.reload();
		}
		
	})
	
	
	//친구 패스 버튼
	$('.pass').on('click', function(){
		var index = swiper.activeIndex + 1;
		swiper.slideTo(index);
		var lastindex = $('.lastindex').val();
		if ( index == lastindex) {
			location.reload();
		}
	})
	
	
});
</script>
</html>