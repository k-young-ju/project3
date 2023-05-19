<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<link rel="stylesheet" type="text/css" href ="/css/admin/adminHeader.css">
<link rel="stylesheet" type="text/css" href ="/css/admin/memberModify.css">
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>

<center>
<div class="menuContainer" >
	<div><%@ include file="/WEB-INF/views/admin/include/left_side.jsp" %></div>
	<div>
		<div class="title">
			<span >회원 정보 수정</span><br>
		</div>
		<form name="modify" action="/admin/member/modify" method="post" onsubmit="return modify_go()">
		<div style="height:100px;width:1500px;">
			<div style="text-align: left;padding-top: 75px;font-weight: bold;">기본정보</div>
		
		</div>
		<div class="modifyContainerInfo">
			<div class="memberType">아이디</div>
			<div><input id="m_id" name="m_id" class="modifyInput"  value="${m.m_id }" readonly></div>
			
		</div>
		<div class="modifyContainerInfo">
			<div class="memberType">비밀번호</div>
			<div><input type="text" id ="pass" name="pass" class="modifyInput" value="${m.pass }" required></div>
		</div>
		<div class="modifyContainerInfo">
			<div class="memberType">비밀번호 확인</div>
			<div><input type="text" id ="pass2" class="modifyInput" value="${m.pass }" onchange="passCheck(this.value)" required></div><div id="passResult"></div>
		</div>
		<div class="modifyContainerInfo">
			<div class="memberType">이름</div>
			<div><input id="m_name" name="m_name" class="modifyInput" value="${m.m_name }" required></div>
		</div>
		<div class="modifyContainerAddr">
			<div class="memberType">주소</div>
			<div class="addrContainer">
				<input type="text" id="sample4_postcode" name="zipcode" placeholder="우편번호"  class="addrInput" value="${m.zipcode }" required>
		        <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="addrBtn" >
				
				<input type="text" id="sample4_roadAddress" name="zipcode1" placeholder="도로명주소"  class="addrInput" value="${m.zipcode1 }" required>
				<input type="text" id="sample4_jibunAddress" name="zipcode2" placeholder="지번주소"  class="addrInput" value="${m.zipcode2 }" required>
				<span id="guide" style="color:#999;display:none"></span>
				
				<input type="text" id="sample4_detailAddress" name="zipcode3" placeholder="상세주소"  class="addrInput" value="${m.zipcode3 }" required>
				<input type="text" id="sample4_extraAddress" name="zipcode4" placeholder="참고항목"  class="addrInput" value="${m.zipcode4 }" required>
				
			</div>
		</div>
		
		<div class="modifyContainerEmail" >
			<div class="memberType">이메일</div>
			<div class="emailContainer" >
				<input id="email1"  class="mailInput"  value="${email1 }" required>
				<input value="@" style="width:15px;height:40px;border:0px;outline: none;padding-top: 0px;margin-top: 0px;"  readonly>
				
				<select id="email2"  class="mailIDomain"  required>
					<option value="">==이메일 선택==</option>
					<option value="naver.com" <c:if test="${email2 =='naver.com' }">selected</c:if>>naver.com</option>
					<option value="gmail.com" <c:if test="${email2 =='gmail.com' }">selected</c:if>>gmail.com</option>
				</select>
					
				<input type="hidden" id = "email" name="email" >
				
			</div>
			
		</div>
		
		<div class="modifyContainerInfo" style="border-bottom: 1px solid #E9E9E9">
			<div class="memberType" >휴대전화</div>
			<div>
				<select class="phoneInput" id ="phone1"  required>
					<option <c:if test="${phone1 =='010' }">selected</c:if>>010</option>
					<option <c:if test="${phone1 =='011' }">selected</c:if>>011</option>
					<option <c:if test="${phone1 =='016' }">selected</c:if>>016</option>
				</select>
			</div>
			<div><input id="phone2"  class="phoneInput" value="${phone2}" maxlength="4" required></div>
			<div>
				<input id="phone3"  class="phoneInput" value="${phone3 }" maxlength="4" required>
				<input type="hidden" id ="phone" name="phone">
			</div>
		</div>
		<div style="height:10px;"></div>
		<div class="BtnStyle">
			<button class="modifyOkBtn">회원정보수정</button>
			<input type="button" value="취소" class="modifyCancelBtn" onclick = "location.href='/'">
			<input type="button" value="회원탈퇴" class="deleteMember" onclick="delete_go()">
		</div>
		</form>
	</div>
</div>		
</center>

<script>
var msg = "${msg}";

if(msg != ''){
	alert(msg);
}

function modify_go(){
	
	if(pass.value != pass2.value){
		alert("비밀번호가 일치하지않습니다. ");
		pass2.focus();
		return false;
	}
	email.value = email1.value+"@"+email2.value;
	
	phone.value = phone1.value+"-"+phone2.value+"-"+phone3.value;
	//alert(email.value+"+"+phone.value);
	document.modify.submit();
	
	
}

function delete_go(){
	var id = "${m.m_id}";
	
	//alert(id);
	var result = confirm("탈퇴하시면 동일한 아이디로 가입이 불가능합니다. \n정말 탈퇴하시겠습니까?");
	
	if(result ==true){
		location.href="delete?m_id="+id;
	}
	
}
</script>

