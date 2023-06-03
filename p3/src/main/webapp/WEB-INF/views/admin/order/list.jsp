<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/admin/adminOrderList.css">
    
<center>
<div class="menuContainer" >
	<div><%@ include file="/WEB-INF/views/admin/include/left_side.jsp" %></div>
	<div class="contentContainer">
		<div class="title">
			<span >주문 목록</span><br>
			
		</div>
		<div class="TitleContainer">
			<div class="numbering">NO</div>
			<div class="subject">주문번호</div>
			<div class="writer">고객ID</div>
			<div class="total_price">총금액</div>
			<div class="total_qty">총 수량</div>
			<div class="date1">주문일자</div>
			<div class="status">상태</div>
			<div class="mode">모드</div>
		</div>
		<c:set var="num" value="${0 }" />
		<c:forEach var="list" items="${list }">
		<div class="listContainer">
			<div class="numbering">${num+1 }</div>
			<div class="subject">${list.od_number }</div>
			<div class="writer">${list.id }</div>
			<div class="total_price">${list.total_price }</div>
			<div class="total_qty">${list.total_qty }</div>
			<div class="date1">${list.od_date }</div>
			<div class="status">${list.od_status }</div>
			<div class="mode">
				<input type="button" value="상세정보" class="viewBtn" onclick="location.href='view?od_number=${list.od_number}'">
				<c:if test="${path=='order' }"><input type="button" value="입금확인" class="confirmBtn" onclick="location.href='update?od_number=${list.od_number}&path=order&id=${list.id }'"></c:if>
				<c:if test="${path=='orderComplete' }"><input type="button" value="배송 처리" class="confirmBtn" onclick="location.href='update?od_number=${list.od_number}&path=orderComplete&id=${list.id }'"></c:if>
				<c:if test="${path=='delivery' }"><input type="button" value="배송완료 처리" class="confirmBtn" onclick="location.href='update?od_number=${list.od_number}&path=delivery&id=${list.id }'"></c:if>
				<c:if test="${path != 'cancel' }"><input type="button" value="주문취소" class="confirmBtn" onclick="location.href='update?od_number=${list.od_number}&path=cancel&id=${list.id }'"></c:if>
			</div>
		</div>
		<c:set var="num" value="${num+1 }"/>
		</c:forEach>
	</div>
</div>
</center>		