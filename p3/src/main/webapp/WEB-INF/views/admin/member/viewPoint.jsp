<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href ="/css/admin/viewPoint.css">  
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>

<center>
<div class="menuContainer" >
	<div><%@ include file="/WEB-INF/views/admin/include/left_side.jsp" %></div>
	<div style="margin: 0 auto">
		<div class="title">
			<span >포인트 사용내역</span><br>
		</div>
		<div class="id" >아이디 : <b>${vo.id }</b></div>
		<div class="name" >고객명 : <b>${vo.name }</b></div>
		<div class="viewtitleContainer" >
			<div class="date">주문일자</div>
			<div class="od_number">주문번호</div>
			<div class="totalQty">주문 수량</div>
			<div class="totalPrice">주문 금액</div>
			<div class="point">사용포인트</div>
		</div>
		<c:set var="number" value="${0 }"/>
		<c:forEach var="list" items="${list }">
		<div class="listContainer" >
			<div class="date">${list.od_date }</div>
			<div class="od_number">${list.od_number }</div>
			<div class="totalQty">${list.total_qty }</div>
			<div class="totalPrice"><fmt:formatNumber value="${list.total_price }" pattern="#,###"/></div>
			<div class="point"><fmt:formatNumber value="${list.usepoint }" pattern="#,###"/></div>
		</div>
		<c:set var="number" value="${number+1 }"/>
		</c:forEach>
	</div>
</div>
</center>		
		