<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/addrList.css">

<center>

	<div style="height:100px;"></div>
	<div class="title">
		<span >배송 주소록 관리</span><br>
	</div>
	<div style="height: 50px;"></div>
	<div class="titleContainer">
		<div class="adStatus">배송지구분</div>
		<div class="subject">배송지명</div>
		<div class="name">수령인</div>
		<div class="phone" >전화</div>
		<div class="addrTitle">주소</div>
		<div class="mode">mode</div>
	</div>
	<c:set var="number" value="${0 }"/>
	<c:forEach var="list" items="${list }">
		<div class="itemContainer">
			<div  class="adStatus">${list.ad_status }</div>
			<div class="subject">${list.subject }</div>
			<div  class="name">${list.name }</div>
			<div class="phone">${list.phone }</div>
			<div class="addritem1">${list.zipcode }</div>
			<div class="addritem2">${list.zipcode1 }</div>
			<div class="addritem2">${list.zipcode2 }</div>
			<div class="addritem2">${list.zipcode3 }</div>
			<div class="addritem2">${list.zipcode4 }</div>
			<div class="mode"><a href="modify?ad_uid=${list.ad_uid }">수정</a></div>
		</div>
		<c:set var="number" value="${number+1 }"/>
	</c:forEach>
	<c:if test="${count == 0}">
		<div class="nolist">등록된 주소가 없습니다.</div>
	</c:if>
	<div class="btnContainer">
		<div ><input type="button" value="배송지등록" class="registerBtn" onclick="location.href='write'"></div>
	</div>	
</center>	
<script>
var msg ="${msg}";
if(msg !=''){
	alert(msg);
}
</script>