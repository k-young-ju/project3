<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href ="/css/header.css">
<link rel="stylesheet" type="text/css" href ="/css/loginPage.css">


<title>탱그램 쇼핑몰</title>
</head>
<body onload="dsn(event)" onscroll="headerbarToggle()">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.4.1.min.js"></script>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<header id="headerbar">
<div style="height:30px;" ></div>

<div >
	<c:choose>
		<c:when test="${url =='index' }">
			<span style="float: right" onclick = "javascript:search_go()"><img src = "/img/search22.png" class ="img_size"></span>
			<span style="float: right" onclick = "javascript:cart_go()"><img src = "/img/basket22.png" class ="img_size"></span>
			<span style="float: right" id="dropMyMenu"><img src ="/img/my22.png" class ="img_size">
			<div id="dropmy"  class="dropmember">
				<c:choose>
					<c:when test="${m_id != null }">
						<span class="menu" onclick="location.href='/member/logout'" style="color:white;">로그아웃</span><br>
					</c:when>
					<c:otherwise>
						<span class="menu" onclick="location.href='/member/login'" style="color:white;">로그인</span><br>
					</c:otherwise>
				</c:choose>
				<span class="menu" style="color:white;">주문/배송 조회</span><br>
				<span class="menu" style="color:white;border: 1px solid black" onclick="location.href='/member/mypage'" >마이페이지</span>
			</div>
			</span>
		</c:when>
		<c:otherwise>
			<span style="float: right" onclick = "javascript:search_go()"><img src = "/img/search11.png" class ="img_size"></span>
			<span style="float: right" onclick = "javascript:cart_go()"><img src = "/img/basket11.png" class ="img_size"></span>
			<span style="float: right" id="dropMyMenu"><img src ="/img/my11.png" class ="img_size">
				<div id="dropmy" class="dropmember">
					<c:choose>
						<c:when test="${m_id != null }">
							<div class="menu" onclick="location.href='/member/logout'">로그아웃</div>
						</c:when>
						<c:otherwise>
							<div class="menu" onclick="location.href='/member/login'">로그인</div>
						</c:otherwise>
					</c:choose>
					<div class="menu">주문/배송 조회</div>
					<div class="menu"  onclick="location.href='/member/mypage'" style="border:1px solid white">마이페이지</div>
				</div>
			</span>
		</c:otherwise>
	</c:choose>
	<span></span>
	<c:choose>
		<c:when test="${url =='index' }">
			<span class="maintitle" onclick = "location.href='/'" style="color:white;">TANGRAM</span>
			<span class="topbutton" onclick="location.href='/item'" style="color:white;">product</span>
			<span class="topbutton" onclick = "location.href='/review'" style="color:white;">Review</span>
			<span class="topbutton" onclick="location.href='/howto'" style="color:white;">How To</span>
			<span class="topbutton" onclick="location.href='/notice'"  id="dropNotice" style="position: relative;color: white">고객센터
				<div id="dropN"  class="dropNoticeMenu" >
					<div class="menu"  style="color:white;">FAQ</div>
					<div class="menu" style="color:white;">1:1문의</div>
					<div class="menu" style="color:white;">공지사항</div>
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

var preScrollpos = window.pageYOffset; //처음 높이 0

//alert("높이"+preScrollpos);
// window.onscroll = headerbarToggle();

// function headerbarToggle(){
// 	var header = document.getElementById("headerbar");
	
// 	var currentScrollPos =  window.pageYOffset; //현재 높이
// 	if(preScrollpos < currentScrollPos ){
// 		headerbar.style.color = "black";
		
// 	}
// }


</script>	
	
<div style="height:20px"></div>

