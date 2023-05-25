<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@page import="java.text.SimpleDateFormat"%>
<%
//오늘 날짜
java.util.Date today = new java.util.Date();
SimpleDateFormat cal = new SimpleDateFormat("yyyyMMddHHmmss");
String signdate = cal.format(today);

String session_id = (String)session.getAttribute("m_id");
String str = "b" + signdate ; //문자열 + 아이디
String session_cart = (String)session.getAttribute("cart");
if(session_id == null && session_cart == null){ //장바구니 세션 값이 없다면
	session.setAttribute("cart", str);
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"  /> 
<link rel="stylesheet" type="text/css" href ="/css/header.css">
<link rel="stylesheet" type="text/css" href ="/css/loginPage.css">


<title>탱그램 쇼핑몰</title>
</head>
<style>
@font-face {
    font-family: 'anemone';
    src: url('/css/Cafe24Ohsqyare.ttf') format('truetype');
  }
	  
@font-face{
	font-family: 'danjung';
	src:url('/css/Cafe24Danjunghae.ttf') format('truetype');
}	  
</style>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.4.1.min.js"></script>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<script>

Kakao.init('b1c205967d7b8b38d1e072e593b2b11a'); // 발급받은 키 중 javascript 키를 사용
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
					//console.log("닉네임:"+response.properties.nickname); 
					console.log("이메일:"+response.kakao_account.email); 
					// 세션에 값 저장
					sessionStorage.setItem("m_id", response.id);

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
<header id="headerbar" class="headerbar">
<div class="headBar2">
	<div class="leftHeader">
			<div></div>
			<div class="maintitle" onclick = "location.href='/'">TANGRAM</div>
			<div class="topbutton" onclick="location.href='/item/list'">product</div>
			<div class="topbutton" onclick = "location.href='/review/list'">Review</div>
			<div id="noticeDrop" >
				<div class="topbutton" onclick="location.href='/notice/list?option=faq'"  id="dropNotice" style="position: relative;">고객센터
				</div>
				<div id="dropN"  class="dropNoticeMenu" >
						<span class="menu" onclick="location.href='/notice/list?option=faq'">FAQ</span><br>
						<span class="menu" onclick="location.href='/notice/list?option=qna'">1:1문의</span><br>
						<span class="menu" onclick="location.href='/notice/list?option=gongji'">공지사항</span>
				</div>
			</div>
			<c:if test="${level =='10' }" ><span class="topbutton" onclick="location.href='/admin'">관리자 페이지로 이동</span></c:if>
		</div>
	<div >
		
		<span style="margin-right: 100px;" onclick = "search_go()" class="toprightBtn">
			<c:choose>
				<c:when test="${url =='index' }">
					<img src = "/img/search22.png" class ="img_size" id = "searchImg">
				</c:when>
				<c:otherwise>
					<img src = "/img/search11.png" class ="img_size" >
				</c:otherwise>
			</c:choose>
		</span>
		<span  onclick = "cart_go()" class="toprightBtn">
			<c:choose>
				<c:when test="${url =='index' }">
					<img src = "/img/basket22.png" class ="img_size" id="basketImg" onclick="location.href='/cart/list'">
				</c:when>
				<c:otherwise>
					<img src = "/img/basket11.png" class ="img_size" onclick="location.href='/cart/list'">
				</c:otherwise>
			</c:choose>	
		</span>
		<div  id="dropMyMenu" class="toprightBtn">
			<c:choose>
				<c:when test="${url =='index' }">
					<img src = "/img/my22.png" class ="img_size" id="myImg">
				</c:when>
				<c:otherwise>
					<img src ="/img/my11.png" class ="img_size">
				</c:otherwise>
			</c:choose>		
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
		
</div>
</header>
<script>

$("#dropMyMenu").on("mouseenter",function(){
	$("#dropmy").show();
});
$("#dropMyMenu").on("mouseleave",function(){
	$("#dropmy").hide();
});

$("#noticeDrop").on("mouseenter",function(){
	$("#dropN").show();
});
 $("#noticeDrop").on("mouseleave",function(){
 	$("#dropN").hide();
 });

var url = "${url}";
//alert("header"+url);
if(url =='index'){
	$("#headerbar").css("color", "white");
	$(document).on('scroll', () => {
		if(window.scrollY >1){
			$("#headerbar").css("color", "black");
 			$("#searchImg").attr("src", "/img/search11.png");
 			$("#basketImg").attr("src", "/img/basket11.png");
 			$("#myImg").attr("src", "/img/my11.png");
		}else{
			$("#headerbar").css("color", "white");
			$("#searchImg").attr("src", "/img/search22.png");
			$("#basketImg").attr("src", "/img/basket22.png");
 			$("#myImg").attr("src", "/img/my22.png");
		}
	});	
}
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


var header = $("#headerbar");

$(document).on('scroll', () => {
  if (window.scrollY > 1) {
    header.addClass('headerbarch');
  } else {
    header.removeClass('headerbarch');
  }
});


</script>	
	
<div style="height:20px"></div>


