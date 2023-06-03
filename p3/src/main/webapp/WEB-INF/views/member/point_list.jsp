<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/pointList.css">
<center>
	<div style="height:100px;"></div>
	<div class="title">
		<span >적립금</span><br>
	</div>
	<div style="height: 50px;"></div>
	<div class="pointContainer">
		<div class="pointSubject">
			<div class="pointDetail">보유 적립금</div>
			<div class="pointDetail">사용 적립금</div>
		</div>
		<div class="pointContent">
			<div class="pointDetail">${point }</div>
			<div class="pointDetail">0</div>
		</div>
	</div>
	<div class="info">사용내역</div>
	<div class="listContainerTitle">
		<div class="date">주문날짜</div>
		<div class="orderNumber">주문번호</div>
		<div class="subject">상품명</div>
		<div class="usepoint">사용포인트</div>
	</div>
	<c:set var="number" value="${0 }"/>
	<c:forEach var="list" items="${list }">
		<div class="listContainerContent">
			<div class="date">${list.od_date }</div>
			<div class="orderNumber">${list.od_number }</div>
			<div class="subject">${list.subject }</div>
			<div class="usepoint">${list.usepoint }</div>
		</div>
		<c:set var="number" value="${number+1 }"/>
	</c:forEach>
</center>