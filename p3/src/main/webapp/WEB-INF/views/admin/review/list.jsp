<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/admin/reviewList.css">

<center>
<div class="menuContainer" >
	<div><%@ include file="/WEB-INF/views/admin/include/left_side.jsp" %></div>
	<div class="contentContainer">
		<div class="title">
			<span >리뷰 목록</span><br>
		</div>
		<div class="TitleContainer">
			<div class="numbering">NO</div>
			<div class="itemImg">상품이미지</div>
			<div class="itemName">상품명</div>
			<div class="score">평점</div>
			<div class="subject">제목</div>
			<div class="writer">작성자</div>
			<div class="date1">작성일</div>
		</div>
		<c:set var="num" value="${1 }" />
		<c:forEach var="list" items="${list }">
		<div class="Container">
			<div class="numbering">${num }</div>
			<div class="itemImg"><img src="/upload/${list.itemimg }" class="itemImgSize"></div>
			<div class="itemName">${list.itemname }</div>
			<div class="score">
				<c:if test="${list.score==5 }">★★★★★</c:if>
				<c:if test="${list.score==4 }">★★★★☆</c:if>
				<c:if test="${list.score==3 }">★★★☆☆</c:if>
				<c:if test="${list.score==2 }">★★☆☆☆</c:if>
				<c:if test="${list.score==1 }">★☆☆☆☆</c:if>
			</div>
			<div class="subject"><a href="reply?n_uid=${list.r_uid }">${list.subject }</a></div>
			<div class="writer">${list.name }</div>
			<div class="date1">${list.signdate }</div>
		</div>
		<c:set var="num" value="${num+1 }"/>
		</c:forEach>
	</div>	
</div>		