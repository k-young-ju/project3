<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
    
<link rel="stylesheet" type="text/css" href ="/css/admin/adminHeader.css"> 
<link rel="stylesheet" type="text/css" href ="/css/admin/jjimList.css">  
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
  

<center>
	
<div class="menuContainer" >
	<div><%@ include file="/WEB-INF/views/admin/include/left_side.jsp" %></div>
	<div class="sideContainer">
		<div class="title">
			<span >상품목록</span><br>
		</div>
		<div class="listContainer">
			<div class="itemtype">상품종류</div>
			<div class="itemImg">이미지</div>
			<div class="itemName">상품명</div>
			<div class="itemPrice">상품가격</div>
			<div class="jjimId">등록아이디</div>
			<div class="jjimDate">관심상품 등록일자</div>
			<div  class="itemuseyn">판매여부</div>
			
		</div>
		<c:forEach var="list" items="${list }">
		<div class="listContainer2">
			<div class="itemtype">${list.itemtype }</div>
			<div class="itemImg"><img src = "/upload/${list.file1 }" class="sumnail"></div>
			<div class="itemName">${list.subject }</div>
			<div class="itemPrice">${list.price }</div>
			<div class="jjimId">${list.id }</div>
			<div  class="jjimDate">${list.signdate}</div>
			<div  class="itemuseyn">${list.useyn }</div>
			
		</div>
	
		</c:forEach>
	</div>
</div>		
</center>

<script>

var msg = "${msg}";

if(msg != ''){
	alert(msg);
}
	
</script>