<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/orderList.css">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<center>
	<div style="height:100px;"></div>
	<div class="title">
		<span >주문조회</span><br>
	</div>
	<div style="height: 50px;"></div>
	<div class="info">주문내역</div>
	<form>
		<div class="dateSearchContainer">
			<div>
				<select name="od_status" class="status" >
					<option value="입금확인중" <c:if test="${od_status=='입금확인중'}">selected</c:if>>입금확인중</option>
					<option value="배송 준비중" <c:if test="${od_status=='배송 준비중'}">selected</c:if>>배송 준비중</option>
					<option value="배송중" <c:if test="${od_status=='배송중'}">selected</c:if>>배송중</option>
					<option value="배송완료" <c:if test="${od_status=='배송완료'}">selected</c:if>>배송완료</option>
					<option value="취소" <c:if test="${od_status=='취소'}">selected</c:if>>취소</option>
				</select>
			</div>
			<div>
				<input type="text" id="datepicker" name="od_date1" class="dateInput" value="${od_date1 }">~
				<input type="text" id="datepicker2" name="od_date2"  class="dateInput" value="${od_date2 }">
			</div>
			<div><button class="dateBtn">조회</button></div>
		</div>
	</form>	
	<div class="info">주문 정보</div>
	<div class="orderTitleContainer">
		<div class="date">주문일자</div>
		<div class="od_number">주문번호</div>
		<div class="totalQty">주문 수량</div>
		<div class="totalPrice">주문 금액</div>
		<div class="ct_status">주문상태</div>
	</div>
	<c:set var="number" value="${0 }"/>
	<c:forEach var="list" items="${list }">
		<div class="orderListContainer">
			<div class="date">${list.od_date }</div>
			<div class="od_number">${list.od_number }</div>
			<div class="totalQty">${list.total_qty }</div>
			<div  class="totalPrice">${list.total_price }</div>
			<div class="ct_status">${list.od_status }</div>
		</div>
	</c:forEach>
</center>

	
<script>
$("#datepicker").datepicker({
    showOn:"both"
    , buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif"
    ,buttonImageOnly: true
    ,changeMonth:true
    ,changeYear:true
    ,dateFormat:"yy-mm-dd"
    ,dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일']
    ,dayNamesMin : ['월','화','수','목','금','토','일']
    ,monthNamesShort:  [ "1월", "2월", "3월", "4월", "5월", "6월","7월", "8월", "9월", "10월", "11월", "12월" ]
});

$("#datepicker2").datepicker({
    showOn:"both"
    , buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif"
    ,buttonImageOnly: true
    ,changeMonth:true
    ,changeYear:true
    ,dateFormat:"yy-mm-dd"
    ,dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일']
    ,dayNamesMin : ['월','화','수','목','금','토','일']
    ,monthNamesShort:  [ "1월", "2월", "3월", "4월", "5월", "6월","7월", "8월", "9월", "10월", "11월", "12월" ]
});
</script>	