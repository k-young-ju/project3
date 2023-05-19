<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<link rel="stylesheet" type="text/css" href ="/css/admin/adminHeader.css">
<link rel="stylesheet" type="text/css" href ="/css/joinPage.css">
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>

<script>
var msg = "${msg}";

if(msg != ''){
	alert(msg);
}

function join_go(){
	if(pass.value != pass2.value){
		alert("비밀번호가 일치하지않습니다. ");
		pass2.focus();
		return false;
	}
		
	email.value = email1.value+"@"+email2.value;
		
	phone.value = phone1.value+"-"+phone2.value+"-"+phone3.value;
	document.join.submit();
	
}
</script>

<center>
<div class="menuContainer" >
	<div><%@ include file="/WEB-INF/views/admin/include/left_side.jsp" %></div>
	<div>
		<div class="title">
			<span >회원추가</span><br>
		</div>
		<form name="jojn" action="/admin/member/join" method="post" onsubmit="return join_go()">
		<div class="joinContainer">
			<div class="memberType">회원구분</div>
			<div>
				<input type="radio" name="member_type" value="p" checked>개인회원
				<input 	type="radio" name="member_type" value="s">판매회원
			</div>
		</div>
		<div style="height:100px;width:1000px;">
			<div style="text-align: left;padding-top: 75px;font-weight: bold;">기본정보</div>
		
		</div>
		<div class="joinContainerInfo">
			<div class="memberType">아이디</div>
			<div><input id="m_id" name="m_id" class="joinInput"  minlength="4" maxlength="16" onchange="idCheck(this.value)" required></div>
			<div id="checkResult" class="checkResult">(영문소문자/숫자,4~16자)</div>
		</div>
		<div class="joinContainerInfo">
			<div class="memberType">비밀번호</div>
			<div><input type="password" id ="pass" name="pass" class="joinInput" required></div>
		</div>
		<div class="joinContainerInfo">
			<div class="memberType">비밀번호 확인</div>
			<div><input type="password" id ="pass2"name="pass2" class="joinInput" onchange="passCheck(this.value)" required></div><div id="passResult"></div>
		</div>
		<div class="joinContainerInfo">
			<div class="memberType">이름</div>
			<div><input id="m_name" name="m_name" class="joinInput" required></div>
		</div>
		<div class="joinContainerAddr">
			<div class="memberType">주소</div>
			<div class="addrContainer">
				<input type="text" id="sample4_postcode" name="zipcode" placeholder="우편번호"  class="addrInput" required>
		        <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="addrBtn" >
				
				<input type="text" id="sample4_roadAddress" name="zipcode1" placeholder="도로명주소"  class="addrInput" required>
				<input type="text" id="sample4_jibunAddress" name="zipcode2" placeholder="지번주소"  class="addrInput" required>
				<span id="guide" style="color:#999;display:none"></span>
				
				<input type="text" id="sample4_detailAddress" name="zipcode3" placeholder="상세주소"  class="addrInput" required>
				<input type="text" id="sample4_extraAddress" name="zipcode4" placeholder="참고항목"  class="addrInput" required>
				
			</div>
		</div>
		
		<div class="adminJoinContainerEmail" >
			<div class="memberType" >이메일</div>
			<div class="adminEmailContainer"  >
				<input id="email1" name="email1" class="mailInput" required><input value="@" style="width:15px;border:0px;outline: none;padding-top: 0px;margin-top: 0px;" readonly>
				
				<select id="email2" name="email2" class="mailIDomain"  required>
					<option value="">==이메일 선택==</option>
					<option value="naver.com">naver.com</option>
					<option value="gmail.com" >gmail.com</option>
				</select>
						
				<input type="hidden" id = "email" name="email" >
				
			</div>
			
		</div>
		
		<div class="joinContainerInfo">
			<div class="memberType">휴대전화</div>
			<div >
				<select class="phoneInput" id ="phone1" name="phone1" required>
					<option selected>010</option>
					<option>011</option>
					<option>016</option>
				</select>
			</div>
			<div ><input id="phone2" name="phone2" class="phoneInput" maxlength="4" required></div>
			<div >
				<input id="phone3" name="phone3" class="phoneInput" maxlength="4" required>
				<input type="hidden" id ="phone" name="phone">
			</div>
		</div>
		<div><button class="joinOkBtn">회원추가</button></div>
		</form>
	</div>
</div>
</center>


<script>

var menu = "${menu}";
//alert(menu);
if(menu != ''){
	$('li').removeClass()
	$("#"+menu).addClass('on');
}

function idCheck(id){
	///alert(id);
		
	$.ajax({
		url: "/idok", //전송받을 페이지 경로
		type: "post", //데이터 읽어오는 방식
		dataType: "text", //데이터 방식
		data:"m_id="+id,
		success:function(result){ //성공일 경우
			//alert(result);
			$("#checkResult").html(result);
		
		},
		error:function(){ //실패일 경우
			alert("실패");
		}
	});
		
}

function passCheck(pass2){
	
	if(pass2 != pass.value){
		$("#passResult").html("<div style='color:red'>&nbsp;비밀번호가 일치하지 않습니다.</div>");
	}else{
		$("#passResult").text("");	
	}
}

var c_num = 0;

function email_ok(str){
	//alert(str);
	var num = parseInt(Math.random() * 100000);
	$.ajax({
		url: "mailSend", //전송받을 페이지 경로
		type: "post", //데이터 읽어오는 방식
		dataType: "text", //데이터 방식
		data: "num="+num+"&email="+str,
		success:function(text){ //성공일 경우
			//$("#id_result").html(text);
			alert("메일인증 확인하세요.");
			c_num = num;
			
		},
		error:function(){ //실패일 경우
			alert("메일 보내기 실패");
		}
	});
}

function email_confirm(){
	
	if(c_num == num2.value){
		alert("인증되었습니다.");
		e_check.value='y';
	}else{
		alert("인증번호를 다시 확인하세요");
	}
}


</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>