<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href ="/css/admin/addrList.css">  
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>

<center>
<div class="menuContainer" >
	<div><%@ include file="/WEB-INF/views/admin/include/left_side.jsp" %></div>
	<div style="margin: 0 auto;">
	<div class="title">
		<span >배송 주소록 관리</span><br>
	</div>
	<div style="height: 50px;"></div>
	<div class="addrTitleContainer">
		<div class="id">ID</div>
		<div class="subject">배송지명</div>
		<div class="name">수령인</div>
		<div class="phone" >전화</div>
		<div class="addrTitle">주소</div>
		
	</div>
	<c:set var="number" value="${0 }"/>
	<c:forEach var="list" items="${list }">
		<div class="addrItemContainer">
			<div  class="id">${list.id }</div>
			<div class="subject">${list.subject }</div>
			<div  class="name">${list.name }</div>
			<div class="phone">${list.phone }</div>
			<div class="addritem1">${list.zipcode }</div>
			<div class="addritem2">${list.zipcode1 }</div>
			<div class="addritem2">${list.zipcode2 }</div>
			<div class="addritem2">${list.zipcode3 }</div>
			<div class="addritem2">${list.zipcode4 }</div>
			
		</div>
	</c:forEach>
		
	</div>
</div>
</center>