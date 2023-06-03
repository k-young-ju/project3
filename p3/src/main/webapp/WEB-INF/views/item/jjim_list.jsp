<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/jjimList.css">
<script>
var msg = "${msg}";
if(msg !=''){
	alert(msg);
}
</script>
<center>

	<div style="height:100px;"></div>
	<div class="title">
		<span >관심상품</span><br>
	</div>
	<div style="height: 50px;">	</div>
	<div class="titleContainer">
		<div class="imgStyle">이미지</div>
		<div class="itemInfo">상품정보</div>
		<div class="price">판매가</div>
		<div class="point">예상적립금</div>
		<div class="delivery">배송비</div>
		<div class="selection">선택</div>
	</div>
	<c:set var="number" value="${0 }"></c:set>
	<c:forEach var="list" items="${list }">
	<form name="order" action="/order/list">
	<div class="itemContainer">
		<div class="imgStyle"><img src = "/upload/${list.file1 }" class="imgSize"></div>
		<div class="itemInfo">
			<div><a href="/item/view?uid=${list.uid }">${list.subject }</a></div>
		</div>
		<div class="price">
			<fmt:formatNumber value="${list.price }" pattern="#,###" />원
			
			<input type="hidden" name="price" value="${list.price }">	
		</div>
		
		<div class="point" id="point">
			<fmt:formatNumber value="${list.price*0.1 }" pattern="#,###" />
			<input type="hidden" name="point" value="${list.price*list.qty*0.1 }">
		</div>
		<div class="delivery">
			<c:if test="${list.price >=30000 }">무료</c:if>
			<c:if test="${list.price <30000 }">3,000원</c:if>
		</div>
		<div class="selection">
			<div><input type="button" value="주문하기" class="orderBtn"></div>
			<div><input type="button" value="장바구니담기" onclick="cart_go(${list.uid})" class="cartBtn"></div>
			<div><input type="button" value="관심상품삭제" onclick="location.href='delete?j_uid=${list.j_uid}'" class="deleteBtn"></div>
		</div>
	</div>
	<c:set var="number" value="${number+1 }"/>
	</form>	
	</c:forEach>
	<div class="bottomBtnContainer">
		<div><input type="button" value="관심상품 비우기" onclick="jjimAllDelete()" class="jjimAllDelete"></div>
		
	</div>
	
<script>
function cart_go(uid){
	 window.open("jjimCartSelection?uid="+uid+"","_blank","width=600, height=600");
}	


function jjimAllDelete(){
	var pathname= $(location).attr('pathname'); 
	var result = confirm("관심상품을 비우시겠습니까?");
	if(result ==true){
		location.href="allDeletejjim?pathname="+pathname;
	}
}

</script>