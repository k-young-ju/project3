<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/findMember.css">
<center>
	<div style="height:100px;"></div>
	<div class="title">
		<span >비밀번호 찾기</span><br>
		<span style="width:800px;border-bottom: 1px solid black"></span>
	</div>
	<div >
		<b>고객님 비밀번호 찾기가 완료돠었습니다.</b>
	</div>
	<div style="height:40px;"></div>
	<div class="idResultContainer">
		<div class="idResultItem">저희 쇼핑몰을 이용해주셔서 감사합니다.</div>
			<div class="idResultItem2">
				<div class="idResultTitle">비밀번호 :</div>
				<div class="idResultContent">${member.pass }</div>
			</div>
			<div class="idResultItem2">
				<div class="idResultTitle">이름 :</div>
				<div class="idResultContent">${member.name }</div>
			</div>
			<div class="idResultItem2">
				<div class="idResultTitle">이메일 :</div>
				<div class="idResultContent">${member.email }</div>
			</div>
			<div class="idResultItem2">
				<div class="idResultTitle">전화번호 :</div>
				<div class="idResultContent">${member.phone }</div>
			</div>
		</div>	
		
		<div class="resultMsg">
			고객님의 비밀번호 찾기가 성공적으로 이루어졌습니다. 항상 고객님의<br>즐겁고 편리한 쇼핑을 위해 최선의 노력을 다하는 쇼핑몰이 되도록 하겠습니다.
		</div>
		<div class="locationBtn">
			<input type="button" value="로그인" class="loginBtn" onclick="location.href='login'">
			<input type="button" value="메인으로 가기" class="findPassBtn" onclick="location.href='/'">
		</div>
	
</center>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>