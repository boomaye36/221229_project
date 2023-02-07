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
                            <c:forEach items="${userList}" var="user">
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
                            </c:forEach>
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
  sliderMove: function(s, e) {
	  console.log('ttttttttttttt', s, e)
  }
});

var handleButton = function(){
    var slideLength = $('.swiper-slide').length;
    if(slideLength == swiper.realIndex + 1) {
        
        $.ajax({
            
            type : "GET"
            ,url : "friend_get"
            ,success : function(data){

                let html = "";
                const { userList : list } = data
                for ( var i = 0; i<list.length; i++) {
                    const user = list[i];
                    var { id, nickname, birth, area, profilephoto } = user;
                    console.log(user, id, nickname, birth, area, profilephoto)
                    html = '    <img src="' + (!profilephoto ? '/static/img/no.png' : profilephoto) + '" alt="유저이미지" class="swiper-img">';
                    html += `    <div class="swiper-user-info">`;
                    html += '        <div class="user-info-nickname">' + nickname + '</div>';
                    if (birth) {
                        html += `<div class="user-info-birth">`
                        html += '&nbsp;&nbsp;|&nbsp;&nbsp;' + birth.substring(2, 4) + '년생';
                        html += `</div>`;
                    }
                    if (area) {
                        html += `<div class="user-info-area">`;
                        html += '&nbsp;&nbsp;|&nbsp;&nbsp;' + area;
                        html += `</div>`;
                        
                    }
                    html += `    </div>`;
                    `<c:set var='id' value="` + id + `"/>`
                    html += `    <div class="swiper-btn-box">
                            <button class="friend-btn pass" data-user-id="${id}">
                                <span class="material-icons">cancel</span>
                            </button>
                            <button class="friend-btn add" data-user-id="${id}">
                                <span class="material-icons">favorite</span>
                            </button>
                            <button class="friend-btn block" data-user-id="${id}">
                                <span class="material-icons">remove_circle</span>
                            </button>
                        </div>
                        `
                    // html += `</div>`;
                    // console.log(html);
                    const $div = $(`<div class="swiper-slide" />`);
                    $div.html(html);

                    //최종 마지막
                    // $('.swiper-wrapper').append($div);
                    swiper.appendSlide($div);
                }
                swiper.slideNext();
            }
            ,error : function(){
                
            }
        })
    } else {
        swiper.slideNext();
    }
}

$(document).ready(function(){
         
    //친구 추가 버튼
    $(document).on('click', '.add', function(){
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
        handleButton();
    });
    
    //친구 차단 버튼
    $(document).on('click', '.block', function(){
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
        
        handleButton();
        
    })
    
    //친구 패스 버튼
    $(document).on('click', '.pass', handleButton)
    
});
</script>
</html>