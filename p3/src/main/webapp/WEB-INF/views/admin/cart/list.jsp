<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href ="/css/admin/cartList.css">  
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>    

<center>
<div class="menuContainer" >
	<div><%@ include file="/WEB-INF/views/admin/include/left_side.jsp" %></div>
	<div style="margin: 0 auto;">
	<div class="title">
		<span >장바구니 관리</span><br>
	</div>
	<div style="height: 50px;"></div>
	<div class="cartTitleContainer">
			<div><input type="checkbox" id="all"></div>
			<div class="itemImg">이미지</div>
			<div class="subject">상품명</div>
			<div class="price">상품가격</div>
			<div class="id">고객아이디</div>
			<div  class="qty">수량</div>
			<div  class="color">색상</div>
			<div  class="date">등록일</div>
			<div class="mode">모드</div>
	</div>
	<c:set var="number" value="${0 }"/>
	<c:forEach var="list" items="${list }">
		<div class="cartItemContainer">
			<div><input type="checkbox" id="ap_check"></div>
			<div class="itemImg"><img src = "/upload/${list.file1 }" class="sumnail"></div>
			<div class="subject">${list.subject }</div>
			<div class="price">${list.price }</div>
			<div class="id"> 
				<c:if test="${list.id ==null }">${list.o_id }</c:if>
				<c:if test="${list.id !=null }">${list.id }</c:if>
			</div>
			<div  class="qty">${list.qty }</div>
			<div  class="color">${list.color }</div>
			<div  class="date">${list.signdate }</div>
			<div  class="mode" >
				<input type="button" class="deleteBtn" value="삭제" onclick="deleteCart('${list.ct_uid}')">
			</div>
		</div>
	</c:forEach>
	</div>
</div>
</center>	

<script>
function deleteCart(uid){
	var result =confirm("삭제하시겠습니까?");
	
	if(result == true){
		location.href="delete?ct_uid="+uid;
	}
}
</script>