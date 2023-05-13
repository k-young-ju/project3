<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<script>
var msg = "${msg}";

if(msg != ''){
	alert(msg);
}
</script>


<center>
	<div style="height:100px;"></div>
	<div class="title">
		<span >로그인</span><br>
		<span style="width:800px;border-bottom: 1px solid black"></span>
	</div>
	<div style="width:800px;border-top: 1px solid black;padding-top: 20px;">
		<form method="post">
			<div  class="container" >
				<div class="container_item" style="width:100px;padding-top:12px;">아이디</div>
				<div class="container_item"><input name="m_id" class="loginInput" placeholder="아이디"></div>
			</div>
			<div class="container">
				<div class="container_item" style="width:100px;padding-top: 12px;">비밀번호</div>
				<div class="container_item"><input type="password" name="pass" class="loginInput" placeholder="비밀번호"></div>
			</div>
			<div class="container2">
				<button class="loginButton">로그인</button>
			</div>
		</form>
		
	</div>
	<div class="inp">
		<div><a href="find_id">아이디 찾기</a></div>&nbsp;&nbsp;|&nbsp;&nbsp;
		<div><a href="">비밀번호 찾기</a></div>
	</div>	
	<div  class ="snsLogin">
		<div style="margin-bottom: 10px;">SNS 계정 로그인</div>
		<div>
			<span id="naverIdLogin_loginButton"><img src = "/img/naverLogo.png"  class="apiImg"></span>
			<span onclick="kakaoLogin()"><img src = "/img/kakaoLogo.png" class="apiImg" onclick=""></span>
			
		</div>
	</div>
	<div class="join">
		<div style="font-size: 17px;font-weight: bold;">아직 주식회사 탱그램 팩토리의 회원이 아니신가요?</div>
		<div style="font-size: 15px">회원가입하고 다양한 혜택과 서비스를 이용해보세요</div>
		<div style="margin-top: 12px;"><input type="button"  value="회원가입" class="joinBtn" onclick="location.href='join'">
		</div>
	</div>
	<div class="nonMemberLine">
		<div style="height:40px">비회원의 경우, 주문시의 주문번호로 주문조회가 가능합니다.</div>
		<form method="post">
		<div class="nonMemberOrder">
			<div class="container3">
				<div class="container_item_name">주문자명</div><div class="container_item_input"><input name="orderName" class="nonOdOrder"></div>
			</div>
			<div class="container3">
				<div class="container_item_name">주문번호</div><div class="container_item_input"><input name="orderNum" class="nonOdOrder"></div>
			</div>
		</div>
		<div><button class="nonMemberBtn">조회</button></div>
		</form>
	</div>
	<div style="height:100px;"></div>
</center>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>
