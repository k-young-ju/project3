<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"  /> 
<link rel="stylesheet" type="text/css" href ="/css/header.css">
<link rel="stylesheet" type="text/css" href ="/css/loginPage.css">


<title>탱그램 쇼핑몰</title>
</head>
<body onload="dsn(event)" onscroll="headerbarToggle()">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.4.1.min.js"></script>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<header id="headerbar">
<div style="height:30px;" ></div>

<div >
	<c:choose>
		<c:when test="${url =='index' }">
			<div>
			<span class="toprightBtn" style="margin-right: 100px;" onclick = "javascript:search_go()"><img src = "/img/search22.png" class ="img_size"></span>
			<span class="toprightBtn" onclick = "javascript:cart_go()"><img src = "/img/basket22.png" class ="img_size"></span>
			<span class="toprightBtn" id="dropMyMenu"><img src ="/img/my22.png" class ="img_size">
			<div id="dropmy"  class="speech-bubble">
				<c:choose>
					<c:when test="${m_id != null }">
						<span class="menu" onclick="location.href='/member/logout'" style="color:white;">로그아웃</span><br>
					</c:when>
					<c:otherwise>
						<span class="menu" onclick="location.href='/member/login'" style="color:white;">로그인</span><br>
					</c:otherwise>
				</c:choose>
				<span class="menu" style="color:white;">주문/배송 조회</span><br>
				<span class="menu" style="color:white;" onclick="mypage_go()">마이페이지</span>
			</div>
			</span>
			</div>
		</c:when>
		<c:otherwise>
			<div >
			<c:if test="${level =='10' }"><span>관리자 페이지로 이동</span></c:if>
			<span style="margin-right: 100px;" onclick = "search_go()" class="toprightBtn"><img src = "/img/search11.png" class ="img_size"></span>
			<span  onclick = "cart_go()" class="toprightBtn"><img src = "/img/basket11.png" class ="img_size"></span>
			<div  id="dropMyMenu" class="toprightBtn"><img src ="/img/my11.png" class ="img_size">
				<div id="dropmy" class="speech-bubble">
					<c:choose>
						<c:when test="${m_id != null }">
							<div class="menu" onclick="location.href='/member/logout'">로그아웃</div><br>
						</c:when>
						<c:otherwise>
							<div class="menu" onclick="location.href='/member/login'">로그인</div><br>
						</c:otherwise>
					</c:choose>
					<div class="menu">주문/배송 조회</div><br>
					<div class="menu" onclick="mypage_go()">마이페이지</div>
					
				</div>
			</div>
			</div>
		</c:otherwise>
	</c:choose>
	<span></span>
	<c:choose>
		<c:when test="${url =='index' }">
			<span class="maintitle" onclick = "location.href='/'" style="color:white;">TANGRAM</span>
			<span class="topbutton" onclick="location.href='item'" style="color:white;">product</span>
			<span class="topbutton" onclick = "location.href='review'" style="color:white;">Review</span>
			<span class="topbutton" onclick="location.href='howto'" style="color:white;">How To</span>
			<span class="topbutton" onclick="location.href='notice'"  id="dropNotice" style="position: relative;color: white;">고객센터
				<div id="dropN"  class="dropNoticeMenu" >
					<span class="menu"  style="color:white;">FAQ</span><br>
					<span class="menu" style="color:white;">1:1문의</span><br>
					<span class="menu" style="color:white;">공지사항</span>
				</div>
			</span>
		</c:when>
		<c:otherwise>
			<span class="maintitle" onclick = "location.href='/'">TANGRAM</span>
			<span class="topbutton" onclick="location.href='item'">product</span>
			<span class="topbutton" onclick = "location.href='review'">Review</span>
			<span class="topbutton" onclick="location.href='howto'">How To</span>
			<span class="topbutton" onclick="location.href='notice'"  id="dropNotice" style="position: relative;">고객센터
				<div id="dropN"  class="dropNoticeMenu" >
					<span class="menu" >FAQ</span><br>
					<span class="menu">1:1문의</span><br>
					<span class="menu">공지사항</span>
				</div>
			</span>
		</c:otherwise>
	</c:choose>
</div>
</header>
<script>

$("#dropMyMenu").on("mouseenter",function(){
	$("#dropmy").show();
});
$("#dropMyMenu").on("mouseleave",function(){
	$("#dropmy").hide();
});

$("#dropNotice").on("mouseenter",function(){
	$("#dropN").show();
});
$("#dropNotice").on("mouseleave",function(){
	$("#dropN").hide();
});

var url = "${url}";
//alert("header"+url);
function mypage_go(){
	var id = "${m_id}";
	//alert(id);
	if(id == ''){
		var result = confirm("회원만 이용가능합니다. \n로그인 페이지로 이동하시겠습니까?");
		
		if(result == true){
			location.href= "/member/login";
		}else{
			return false;
		}
	}else{
		location.href= "/member/myPage";
	}
}



var preScrollpos = window.pageYOffset; //처음 높이 0

//alert("높이"+preScrollpos);
window.onscroll = headerbarToggle();

function headerbarToggle(){
	var header = document.getElementById("headerbar");
	
	var currentScrollPos =  window.pageYOffset; //현재 높이
	if(preScrollpos < currentScrollPos ){
		headerbar.style.color = "black";
		
	}
}


</script>	
	
<div style="height:20px"></div>
<script>
var naverLogin = new naver.LoginWithNaverId(
	{
		clientId: "snwIq2rIuigoLPb9h3Lk", //내 애플리케이션 정보에 cliendId를 입력해줍니다.
		callbackUrl: "http://localhost:8080", // 내 애플리케이션 API설정의 Callback URL 을 입력해줍니다.
		isPopup: false,
		callbackHandle: true
	}
);	
naverLogin.init();

window.addEventListener('load', function () {
	naverLogin.getLoginStatus(function (status) {
		//alert(status);
		if (status) {
			var email = naverLogin.user.getEmail(); // 필수로 설정할것을 받아와 아래처럼 조건문을 줍니다.
    		
			console.log(naverLogin.user); // 체크된 항목 객체로 전달

			console.log(naverLogin.user.id); // 네이버에서 제공하는 식별 아이디
			console.log(naverLogin.user.nickname); // 닉네임
			console.log(naverLogin.user.email); // 이메일  

			
			if( email == undefined || email == null) {
				alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
				naverLogin.reprompt();
				return;
			}
		} else {
			console.log("callback 처리에 실패하였습니다.");
		}
	});
});


function openPopUp() {
    testPopUp= window.open("https://nid.naver.com/nidlogin.logout", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,width=1,height=1");
}
function closePopUp(){
    testPopUp.close();
}
function naverLogout() {
	openPopUp();
	setTimeout(function() {
		closePopUp();
	}, 1000);
}

</script>

<script>

Kakao.init('eacf4492b3e5e7837316dc6757......'); // 발급받은 키 중 javascript 키를 사용
console.log(Kakao.isInitialized()); // sdk초기화여부판단

//카카오로그인
function kakaoLogin() {
	Kakao.Auth.login({
		success: function (response) {
			Kakao.API.request({
				url: '/v2/user/me',
				success: function (response) {
					console.log(response); //회원정보
					console.log("식별 아이디:"+response.id);
					console.log("닉네임:"+response.properties.nickname); 
					console.log("이메일:"+response.kakao_account.email); 
				},
				fail: function (error) {
					console.log(error)
				},
			})
		},
		fail: function (error) {
			console.log(error)
		},
	})
}
 

</script>