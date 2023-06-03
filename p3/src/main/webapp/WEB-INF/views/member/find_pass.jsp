<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/findMember.css">

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
				<select class="selectBox" name ="member_type" id="member_type" onclick="type_ch(this.value)">
					<option value="p" selected>개인회원</option>
					<option value="s" > 법인 사업자회원</option>
				</select>
			</span>
		</div>
		<div class="container2">
			<span class="item" ></span>
			<span  id="personalRadio">
				<input type="radio" id ="findMethodPhone" name="findMethod"   onclick="method_ch('phone')"checked>전화번호
				<input type="radio" id ="findMethodEmail" name="findMethod"   onclick="method_ch('email')" >이메일
			</span>
			<span id="companyRadio" style="display: none;">
				<input type="radio" id ="findMethodCnumber" name="findMethod"   onclick="method_ch('company')" >법인번호
				<input type="radio" id ="findMethodEmail2" name="findMethod"   onclick="method_ch('email2')" >이메일
			</span>
		</div>
		<div id="personalStyle">
			<div class="container4" >
				<div class="namInfo">
					<span class="item">아이디</span>
					<span>
						<input id="p_id" name="id"  class="findInputName">
					</span>
				</div>
				<div class="namInfo">
					<span class="item">이름</span>
					<span>
						<input id="pname" name="name"  class="findInputName">
					</span>
				</div>
				
				<div class="phoneFind" id="phoneFind" >
					<span class="item">전화번호로 찾기</span>
					<span>
						<input id="phone1"  name="phone1"  class="findInputPhone">&nbsp;-
						<input id="phone2" name="phone2"  class="findInputPhone">&nbsp;-
						<input id="phone3" name="phone3"  class="findInputPhone">
						<input type="hidden" name="phone" id="phone">
						
					</span>
				</div>
				<div id="emailFind" class="emailFind" style="display: none">
					<span class="item">이메일로 찾기</span>
					<span>
						<input type="hidden" id="email_type" value="y">
						<input id="p_email1" name="email1"  class="findInputEmail">@
						<select id="p_email2" name="email2" class="findInputEmail">
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
						</select>
						<input type="hidden" name="email" id="p_email">
						
					</span>
				</div>
			</div>
		</div>
		<div id="companyStyle" style="display: none">
			<div class="container4" >
				<div class="namInfo">
					<span class="item">아이디</span>
					<span>
						<input id="c_id" name="id"  class="findInputName">
					</span>
				</div>
				<div class="namInfo">
					<span class="item">법인명</span>
					<span>
						<input id="cname" name="name"  class="findInputName">
					</span>
				</div>
				
				<div class="phoneFind" id="cnumberFind" >
					<span class="item">법인번호로 찾기</span>
					<span>
						<input id="c_number1"  name="c_number1"  class="c_numberStyle">&nbsp;-
						<input id="c_number2" name="c_number2"  class="c_numberStyle">
						<input type="hidden" name="c_number" id="c_number">
						
					</span>
				</div>
				<div id="emailFind2" class="emailFind" style="display: none">
					<span class="item">이메일로 찾기</span>
					<span>
						<input type="hidden" id="email_type" value="y" >
						<input id="c_email1" name="email1"  class="findInputEmail">@
						<select id="c_email2" name="email2" class="findInputEmail">
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
						</select>
						<input type="hidden" name="email" id="c_email">
						
					</span>
				</div>
			</div>
		</div>
		<div style="height:20px;"></div>
		<div><button class="btnStyle">확인</button></div>	
	</div>
	</form>
</center>

<script>
var msg = "${msg}";

if(msg != ''){
	alert(msg);
}

function type_ch(str){
	//alert(str);
	if(str=='p'){
		document.getElementById('personalStyle').style.display='inline';
		document.getElementById('personalRadio').style.display='inline';
		document.getElementById('companyStyle').style.display='none';
		document.getElementById('companyRadio').style.display='none';
		$("input[id=findMethodCnumber]").prop("checked", false);
		$("input[id=findMethodPhone]").prop("checked", true);

		
	}else{
		document.getElementById('personalStyle').style.display='none';
		document.getElementById('personalRadio').style.display='none';
		document.getElementById('companyStyle').style.display='inline';
		document.getElementById('companyRadio').style.display='inline';
		$("input[id=findMethodCnumber]").prop("checked", true);
		$("input[id=findMethodPhone]").prop("checked", false);

		
	}
}

function method_ch(str){
	//alert(str);
	if(str =='email'){

			$("#emailFind").show();
			$("#phoneFind").hide();
			
		email_type.value = "y";
		
	}else if(str=='phone'){

			$("#emailFind").hide();
			$("#phoneFind").show();
		email_type.value = "n";
		
	}else if(str =='company'){
		
		$("#emailFind2").hide();
		$("#cnumberFind").show();
		
	}else if(str=='email2'){
		$("#emailFind2").show();
		$("#cnumberFind").hide();
	}
}

function find_pass_go(){
	//alert(member_type.value);
	if(member_type.value=='p'){
		if(p_id.value==''){
			alert("아이디를 입력해주세요");
			return false;
		}
		
		if(pname.value ==''){
			alert("이름을 입력해주세요");
			return false;
		}
		
		if(email_type.value=='y'){
			if(p_email1.value =='' || p_email2.value==''){
				alert("이메일을 입력해주세요");
				return false;
			}
		}else{
			if(phone1.value =='' || phone2.value=='' || phone3.value==''){
				alert("전화번호를 입력해주세요");
				return false;
			}
		}
	}else{
		if(c_id.value==''){
			alert("아이디를 입력해주세요");
			return false;
		}
		
		if(cname.value ==''){
			alert("법인명을 입력해주세요");
			return false;
		}
		
		if(email_type.value=='y'){
			if(c_email1.value =='' || c_email2.value==''){
				alert("이메일을 입력해주세요");
				return false;
			}
		}else{
			if(c_number1.value =='' || c_number2.value=='' ){
				alert("법인번호를 입력해주세요");
				return false;
			}
		}
		
	}
			
		p_email.value= p_email1.value+"@"+p_email2.value;
		c_email.value= c_email1.value+"@"+c_email2.value;
		phone.value = phone1.value+"-"+phone2.value+"-"+phone3.value;
		c_number.value = c_number1.value+"-"+c_number2.value;
	}
</script>