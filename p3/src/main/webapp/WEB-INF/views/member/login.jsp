<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script>
var msg = "${msg}";

if(msg != ''){
	alert(msg);
}

function login_go(){
	//alert(session_id.value);
	if(m_id.value==''){
		alert("아이디를 입력해주세요");
		return false;
	}
	if(pass.value==''){
		alert("비밀번호를 입력해주세요");
		return false;
	}
	document.login.submit();
}

</script>

<center>
	<div style="height:100px;"></div>
	<div class="title">
		<span >로그인</span><br>
		<span style="width:800px;border-bottom: 1px solid black"></span>
	</div>
	<div style="width:800px;border-top: 1px solid black;padding-top: 20px;">
		<form name = "login" method="post" onsubmit = "return login_go()">
			<div  class="container" >
				<div class="container_item" style="width:100px;padding-top:12px;">아이디</div>
				<div class="container_item">
					<input id="m_id" name="m_id" class="loginInput" placeholder="아이디">
					<input type="hidden" id ="session_id" name="session_id">
				</div>
			</div>
			<div class="container">
				<div class="container_item" style="width:100px;padding-top: 12px;">비밀번호</div>
				<div class="container_item"><input type="password" id="pass" name="pass" class="loginInput" placeholder="비밀번호"></div>
			</div>
			<div class="container2">
				<button class="loginButton">로그인</button>
			</div>
		</form>
		
	</div>
	<div style="height:10px;"></div>
	<div id="inp" >
		<div class="inpItemDiv">
			<span class="inpItem"><a href="find_id">아이디 찾기</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;
			<span class="inpItem"><a href="find_pass">비밀번호 찾기</a></span>
		</div>
	</div>	
	<div  class ="snsLogin">
		<div style="margin-bottom: 10px;">SNS 계정 로그인</div>
		<div>
			<span id="naverIdLogin_loginButton"><a href="${url }"><img src = "/img/naverLogo.png"  class="apiImg"></a></span>
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

<script>

var naverLogin = new naver.LoginWithNaverId(
	{
		clientId: "snwIq2rIuigoLPb9h3Lk", //내 애플리케이션 정보에 cliendId를 입력해줍니다.
		callbackUrl: "http://localhost:8080", // 내 애플리케이션 API설정의 Callback URL 을 입력해줍니다.
		isPopup: false,
		callbackHandle: true
	}
);	
naverLogin.init();

window.addEventListener('load', function () {
	naverLogin.getLoginStatus(function (status) {
		//alert(status);
		if (status) {
			var email = naverLogin.user.getEmail(); // 필수로 설정할것을 받아와 아래처럼 조건문을 줍니다.
    		
			console.log(naverLogin.user); // 체크된 항목 객체로 전달

			console.log(naverLogin.user.id); // 네이버에서 제공하는 식별 아이디
			console.log(naverLogin.user.nickname); // 닉네임
			console.log(naverLogin.user.email); // 이메일  

			location.href="callback?m_id="+naverLogin.user.id+"&email="+naverLogin.user.email;
			if( email == undefined || email == null) {
				alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
				naverLogin.reprompt();
				return;
			}
		} else {
			console.log("callback 처리에 실패하였습니다.");
		}
		
	});
});


function openPopUp() {
    testPopUp= window.open("https://nid.naver.com/nidlogin.logout", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,width=1,height=1");
}
function closePopUp(){
    testPopUp.close();
}
function naverLogout() {
	openPopUp();
	setTimeout(function() {
		closePopUp();
	}, 1000);
}
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
