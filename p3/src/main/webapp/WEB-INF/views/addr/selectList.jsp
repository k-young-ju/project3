<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<link rel="stylesheet" type="text/css" href ="/css/addrSelectList.css">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.4.1.min.js"></script>

<center>
<div class="title">배송 주소록</div>
<div style="height: 15px;"></div>

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
			<div  class="name" id="name">${list.name }</div>
			<div class="phone" id="phone">${list.phone }</div>
			<div class="addritem1" id="zipcode">${list.zipcode }</div>
			<div class="addritem2" id="zipcode1">${list.zipcode1 }</div>
			<div class="addritem2" id="zipcode2">${list.zipcode2 }</div>
			<div class="addritem2" id="zipcode3">${list.zipcode3 }</div>
			<div class="addritem2" id="zipcode4">${list.zipcode4 }</div>
			<div class="mode"><input type="button" value="선택" onclick="addrSelect('${list.ad_uid}','${number }')" class="modeInput"></div>
		</div>
		<c:set var="number" value="${number+1 }"/>
	</c:forEach>
	<c:if test="${count == 0}">
		<div class="nolist">등록된 주소가 없습니다.</div>
	</c:if>
</center>			

<script>


function addrSelect(ad_uid,num){
	var name = document.querySelectorAll("#name")[num].textContent;
	var phone_ch = document.querySelectorAll("#phone")[num].textContent.split("-");
	var phone1 = phone_ch[0];
	var phone2 = phone_ch[1];
	var phone3 = phone_ch[2];
	var zipcode = document.querySelectorAll("#zipcode")[num].textContent;
	var zipcode1 = document.querySelectorAll("#zipcode1")[num].textContent;
	var zipcode2 = document.querySelectorAll("#zipcode2")[num].textContent;
	var zipcode3 = document.querySelectorAll("#zipcode3")[num].textContent;
	var zipcode4 = document.querySelectorAll("#zipcode4")[num].textContent;
	
	opener.name1.value = name;
	opener.phone1.value = phone1;
	opener.phone2.value = phone2;
	opener.phone3.value = phone3;
	opener.sample4_postcode.value = zipcode;
	opener.sample4_roadAddress.value = zipcode1;
	opener.sample4_jibunAddress.value = zipcode2;
	opener.sample4_detailAddress.value = zipcode3;
	opener.sample4_extraAddress.value = zipcode4;
	
	window.close();
	
}
</script>