<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/couponList.css">

<center>

	<div style="height:100px;"></div>
	<div class="title">
		<span >마이 쿠폰</span><br>
	</div>
	<div style="height: 50px;">	</div>
	<div class="menuContainer">
		<div>마이쿠폰목록</div>
		<div>사용가능 쿠폰 :${count }장</div>
	</div>
	<div class="titleContainer">
		<div class="number">NO</div>
		<div class="cp_number">쿠폰번호</div>
		<div class="cp_point">쿠폰금액</div>
		<div class="date">사용기한</div>
	</div>
	<c:set var="number" value="${0 }"/>
	<c:forEach var="list" items="${list }">
		<div class="itemContainer">
			<div class="number">${number+1 }</div>
			<div class="cp_number">${list.cp_number }</div>
			<div class="cp_point">
				<fmt:formatNumber value="${list.point }" pattern="#,###"/>
			
			</div>
			<div class="date"></div>
		</div>
		<c:set var="number" value="${number+1 }"/>
	</c:forEach>
	<div class="intro">쿠폰인증번호 등록하기</div>
	<div class="registerContainer">
	<form method="post">
		<input name="cp_number" value="${cp_number }"  class="inputStyle" required>
		<button class="registerBtn">쿠폰인증</button>
	</form>
	</div>
</center>	

<script>
var msg = "${msg}";
if(msg !=''){
	alert(msg);
}
</script>