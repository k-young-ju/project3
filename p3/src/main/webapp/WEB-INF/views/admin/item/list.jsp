<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
    
<link rel="stylesheet" type="text/css" href ="/css/admin/adminHeader.css"> 
<link rel="stylesheet" type="text/css" href ="/css/admin/itemList.css">  
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
  

<center>
	
<div class="menuContainer" >
	<div><%@ include file="/WEB-INF/views/admin/include/left_side.jsp" %></div>
	<div class="sideContainer">
		<div class="title">
			<span >상품목록</span><br>
			<span style="width:800px;border-bottom: 1px solid black"></span>
		</div>
		<div class="listContainer">
			<div class="listItemTitle">상품종류</div>
			<div class="listItemTitle">이미지</div>
			<div class="listItemTitle">상품명</div>
			<div class="listItemTitle">상품가격</div>
			<div class="listItemTitle">판매자</div>
			<div  class="listItemTitle">재고</div>
			<div  class="listItemTitle">판매량</div>
			<div  class="listItemTitle">판매여부</div>
			<div class="listItemTitle">모드</div>
		</div>
		<c:forEach var="list" items="${list }">
		<div class="listContainer2">
			<div class="listItemTitle">${list.itemtype }</div>
			<div class="listItemTitle"><img src = "/upload/${list.file1 }" class="sumnail"></div>
			<div class="listItemTitle">${list.subject }</div>
			<div class="listItemTitle">${list.price }</div>
			<div class="listItemTitle">${list.s_id }</div>
			<div  class="listItemTitle">${list.qty }</div>
			<div  class="listItemTitle">${list.sellqty }</div>
			<div  class="listItemTitle">${list.useyn }</div>
			<div  class="listItemTitle" onclick="location.href='modify?uid=${list.uid}'">수정</div>
		</div>
	
		</c:forEach>
	</div>
</div>		
</center>

