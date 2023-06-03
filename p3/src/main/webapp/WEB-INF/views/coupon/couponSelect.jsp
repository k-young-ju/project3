<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<link rel="stylesheet" type="text/css" href ="/css/couponSelectList.css">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.4.1.min.js"></script>

<center>
	<div class="title"> 마이 쿠폰</div>
	<div style="height: 15px;"></div>
	<div class="menuContainer">
			<div>마이쿠폰목록</div>
			<div>사용가능 쿠폰 :${count }장</div>
	</div>
	<div class="titleContainer">
		<div class="number">NO</div>
		<div class="cp_number">쿠폰번호</div>
		<div class="cp_point">쿠폰금액</div>
		<div class="date">사용기한</div>
		<div class="select">선택</div>
	</div>
	<c:set var="number" value="${0 }"/>
	<c:forEach var="list" items="${list }">
		<div class="itemContainer">
			<div class="number">${number+1 }</div>
			<div class="cp_number" id="cp_number">${list.cp_number }</div>
			<div class="cp_point" id="cp_point">
				<fmt:formatNumber value="${list.point }" pattern="#,###"/>
				<input type="hidden" id="cpPoint" value="${list.point }">
			</div>
			<div class="date"></div>
			<div class="select"><input type="button" value="선택" class="selectBtn" onclick="couponSelect('${number}')"></div>
		</div>
		<c:set var="number" value="${number+1 }"/>
	</c:forEach>
</center>

<script>
function couponSelect(num){
	//alert(num);
	var cp_number = document.querySelectorAll("#cp_number")[num].textContent;
	var cp_point =$("input[id=cpPoint]:eq("+num+")").val();
	//alert(cp_point);
	
	opener.coupon.value = cp_point;
	opener.cp_number.value = cp_number;
	opener.parent.couponCal();
	window.close();
}
</script>