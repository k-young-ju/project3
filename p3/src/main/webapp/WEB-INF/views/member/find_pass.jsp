<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/findMember.css">

<script>
var msg = "${msg}";

if(msg != ''){
	alert(msg);
}

function method_ch(str){
	
	//alert(str);
	if(str =='email'){

			$("#emailFind").show();
			$("#phoneFind").hide();
		email_type.value = "y";
		
	}else{

			$("#emailFind").hide();
			$("#phoneFind").show();
		email_type.value = "n";
		
	}
}

function find_pass_go(){

	if(m_id.value==''){
		alert("아이디를 입력해주세요");
		return false;
	}
	
	if(m_name.value ==''){
		alert("이름을 입력해주세요");
		return false;
	}
	
	if(email_type.value=='y'){
		if(email1.value =='' || email2.value==''){
			alert("이메일을 입력해주세요");
			return false;
		}
	}else{
		if(phone1.value =='' || phone2.value=='' || phone3.value==''){
			alert("전화번호를 입력해주세요");
			return false;
		}
	}
		
	email.value= email1.value+"@"+email2.value;
	phone.value = phone1.value+"-"+phone2.value+"-"+phone3.value;
}
</script>

<center>
	<div style="height:100px;"></div>
	<div class="title">
		<span >비밀번호 찾기</span><br>
		<span style="width:800px;border-bottom: 1px solid black"></span>
	</div>
	<div class="introduce">
		<div class="introduceItem">가입하신 방법에 따라 비밀번호 찾기가 가능합니다.</div>
	</div>
	
	<div style="height:50px;"></div>
	<form method="post" onsubmit="return find_pass_go()">
	<div class = "findContainer">
		<div class="container2">
			<span class="item">회원유형</span>
			<span>
				<select class="selectBox">
					<option value="p" selected>개인회원</option>
					<option value="s" >판매회원</option>
				</select>
			</span>
		</div>
		<div class="container2">
			<span class="item" ></span>
			<span>
				<input type="radio" id = " findMethod" name="findMethod"   onclick="method_ch('email')" checked>이메일
				<input type="radio" id = " findMethod" name="findMethod"   onclick="method_ch('phone')">전화번호
			</span>
		</div>
		<div class="container4" >
			<div class="namInfo">
				<span class="item">아이디</span>
				<span>
					<input id="m_id" name="m_id"  class="findInputName">
				</span>
			</div>
			<div class="namInfo">
				<span class="item">이름</span>
				<span>
					<input id="m_name" name="m_name"  class="findInputName">
				</span>
			</div>
			<div id="emailFind" class="emailFind">
				<span class="item">이메일로 찾기</span>
				<span>
					<input type="hidden" id="email_type" value="y">
					<input id="email1" name="email1"  class="findInputEmail">@
					<select id="email2" name="email2" class="findInputEmail">
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
					</select>
					<input type="hidden" name="email" id="email">
					
				</span>
			</div>
			<div class="phoneFind" id="phoneFind" style="display: none">
				<span class="item">전화번호로 찾기</span>
				<span>
					<input id="phone1"  name="phone1"  class="findInputPhone">&nbsp;-
					<input id="phone2" name="phone2"  class="findInputPhone">&nbsp;-
					<input id="phone3" name="phone3"  class="findInputPhone">
					<input type="hidden" name="phone" id="phone">
					
				</span>
			</div>
		</div>
		
		<div style="height:20px;"></div>
		<div><button class="btnStyle">확인</button></div>	
	</div>
	</form>
</center>