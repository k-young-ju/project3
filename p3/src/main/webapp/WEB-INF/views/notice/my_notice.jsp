<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/myNotice.css">
<center>
	<div style="height:100px;"></div>
	<div class="title">
		<span >게시물 관리</span><br>
		
	</div>
	<div style="height: 50px;"></div>
	<div class="titleContainer">
		<div class="number">번호</div>
		<div class="gongji">분류</div>
		<div class="subject">제목</div>
		<div class="writer">작성자</div>
		<div class="date">작성일</div>
		<div class="ref">조회수</div>
	</div>
	<c:set var="number" value="${1 }"/>
	<c:forEach var="list" items="${list }">
		<div class="itemContainer">
			<div class="number">${number }</div>
			<div class="gongji"><a href="/notice/list?option=qna">1:1문의</a></div>
			<div class="subject"><a href="/notice/view?n_uid=${list.n_uid }">${list.subject }</a></div>
			<div class="writer">${list.name }</div>
			<div class="date">${list.signdate }</div>
			<div class="ref">${list.ref }</div>
		</div>
		<c:set var="number" value="${number+1 }"/>
	</c:forEach>
</center>	