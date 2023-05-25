<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/cartList.css">
<script>
var msg = "${msg}";
if(msg !=''){
	alert(msg);
}
</script>
<center>
	<div style="height:100px;"></div>
	<div class="title">
		<span >장바구니</span><br>
	</div>
	<div style="height: 50px;"></div>
	<div class="titleContainer">
		<div><input type="checkbox" id ="all"name="all"></div>
		<div class="imgStyle">이미지</div>
		<div class="itemInfo">상품정보</div>
		<div class="price">판매가</div>
		<div class="qty">수량</div>
		<div class="point">예상적립금</div>
		<div class="delivery">배송비</div>
		<div class="sumPrice">합계</div>
		<div class="selection">선택</div>
	</div>
	<c:forEach var="list" items="${list }">
	<div class="itemContainer">
		<div><input type="checkbox" id ="ap_check"name="ap_check" onclick="checkall()"></div>
		<div class="imgStyle"><img src = "/upload/${list.file1 }" class="imgSize"></div>
		<div class="itemInfo">
			<div><a href="/item/view?uid=${list.uid }">${list.subject }</a></div>
			<div>[옵션 : ${list.color }]</div>
		</div>
		<div class="price">${list.price }</div>
		<div class="qty">${list.qty }</div>
		<div class="point">${list.point }</div>
		<div class="delivery">
			
		</div>
		<div class="sumPrice">
		
		</div>
		<div class="selection">
			<div><input type="button" value="주문하기" class="orderBtn"></div>
			<div><input type="button" value="관심상품등록" onclick="/item/jjim_insert?uid=${list.uid}" class="jjimBtn"></div>
			<div><input type="button" value="장바구니삭제" onclick="delete?ct_uid=${list.ct_uid}" class="deleteBtn"></div>
		</div>
	</div>
	</c:forEach>
</center>
	