<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/reviewList.css">
<script>
var msg = "${msg}";
if(msg !=''){
	alert(msg);
}
</script>
<center>
	<div style="height:100px;"></div>
	<div class="title">
		<span >Review</span><br>
	</div>
	<div>상품 사용후기입니다.</div>
	<div style="height: 50px;"></div>
	
	<c:forEach var="list" items="${list }">
	<div class="reviewContainer">
		<div class="score">
			<c:if test="${list.score==5 }">★★★★★</c:if>
			<c:if test="${list.score==4 }">★★★★☆</c:if>
			<c:if test="${list.score==3 }">★★★☆☆</c:if>
			<c:if test="${list.score==2 }">★★☆☆☆</c:if>
			<c:if test="${list.score==1 }">★☆☆☆☆</c:if>
		</div>
		<div class="subject">
			<span><a href="view?r_uid=${list.r_uid }&uid=${list.uid}">${list.subject }</a></span>
			<c:set var="hiddenId" value="${fn:replace(list.id, fn:substring(list.id, 3, fn:length(name)-1), '***')}" />
			<span class="nameInfo">${list.name }(${ hiddenId})</span>
		</div>
		
		<div class="fileInfo">
			<c:if test="${list.file1 !=null }"><img src="/upload/${list.file1 }" class="imgSize"></c:if>
		</div>			
	</div>
	</c:forEach>
	
</center>