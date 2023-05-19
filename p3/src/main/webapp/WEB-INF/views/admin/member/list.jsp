<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<link rel="stylesheet" type="text/css" href ="/css/admin/adminHeader.css">
<link rel="stylesheet" type="text/css" href ="/css/admin/memberList.css">  
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>

<center>
<div class="menuContainer" >
	<div><%@ include file="/WEB-INF/views/admin/include/left_side.jsp" %></div>
	<div>
		<form name="Form1">
		<div class="title">
			<span >회원목록</span><br>
			
		</div>
		
		<div class="selectContainer">
			<div class="selectItem" onclick="allMember()">전체회원</div>
			<div class="selectItem" onclick="validMember()">기존회원</div>
			<div class="selectItem" onclick="deleteMember()">탈퇴한회원</div>
		</div>
		<div class="optionContainer">
			<div class="optionItem">회원등급일괄변경</div>
			<div class="optionItem">선택삭제</div>
		</div>
		
		<div class="memberCount">회원수 : ${pageMaker.totalCount }명</div>
		
		<div class="listContainer" >
			<div style="background-color: black;"><input type = "checkbox" name = "all" value="checkbox" onclick = "checkall()"></div>
			<div class="itemTitle">회원타입</div>
			<div class="itemTitle" >아이디</div>
			<div class="itemTitle" >이름</div>
			<div class="itemTitle" >회원등급</div>
			<div class="itemTitle">전화번호</div>
			<div class="itemTitle">이메일</div>
			<div class="itemTitle"><b>수정</b></div>
		</div>
		<c:forEach var="list" items="${list }">
		<div class="listContainer" >
			<div ><input type ="checkbox" name ="ap_check" value="${list.m_id }"></div>
			<div class="itemContent" >
				<c:if test="${list.level==1}">개인회원</c:if>
				<c:if test="${list.level ==5}">판매회원</c:if>
				<c:if test="${list.level==10 }">관리자</c:if>
			</div>
			<div class="itemContent" >${list.m_id }</div>
			<div class="itemContent" >${list.m_name }</div>
			<div class="itemContent" >${list.level }</div>
			<div class="itemContent">${list.phone }</div>
			<div class="itemContent">${list.email }</div>
			<div class="itemContent"  onclick="location.href='modify?m_id=${list.m_id}'"><b>수정</b></div>
		</div>
		
		</c:forEach>
		</form>
		</div>
</div>
</center>
<script>
	function memberModify_go(id){
		
		//alert(id);
		$.ajax({
			url: "/admin/member/modify", //전송받을 페이지 경로
			type: "get", //데이터 읽어오는 방식
			dataType: "text", //데이터 방식
			data: "m_id="+id, //데이터 전달
			error:function(){ //실패일 경우
				alert("실패");
			},
			success:function(text){ //성공일 경우
				$("#result").html(text);
			}
		});
	}

function checkall() {//체크박스 전체 선택 , 해제
	if(Form1.all.checked) {
		for(i=1; i < (document.Form1.length); i++){
			document.Form1.elements[i].checked = true;
		}
	}else{
		for(i=1; i < (document.Form1.length); i++){
			document.Form1.elements[i].checked = false;
		}
	}
}
</script>
