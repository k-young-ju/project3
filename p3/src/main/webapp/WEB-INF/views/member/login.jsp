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
	if(id.value==''){
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
					<input id="id" name="id" class="loginInput" placeholder="아이디">
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
			<span id="naver_id_login" ><a href="${url}"><img src = "/img/naverLogo.png"  class="apiImg"></a></span>
			<script type="text/javascript">
			  	var naver_id_login = new naver_id_login("네이버 자바스크립트키", "콜백경로");
			  	var state = naver_id_login.getUniqState();
			  	naver_id_login.setButton("green", 1,50);
			   	naver_id_login.setDomain("서비스 로경로");
			  	naver_id_login.setState(state);
			  	naver_id_login.setPopup();
			  	naver_id_login.init_naver_id_login();
		  </script>
			<span onclick="javascript:kakaoLogin();"><img src = "/img/kakaoLogo.png" class="apiImg" onclick=""></span>
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
		<form method="post" action="orderNon">
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
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
 <script>

Kakao.init('b1c205967d7b8b38d1e072e593b2b11a'); // 발급받은 키 중 javascript 키를 사용
console.log(Kakao.isInitialized()); // sdk초기화여부판단

//카카오로그인
function kakaoLogin() {
	Kakao.Auth.login({
		success: function (response) {
			Kakao.API.request({
				url: '/v2/user/me',
				success: function (response) {
					console.log(response); //회원정보
					console.log("식별 아이디:"+response.id);
					//console.log("닉네임:"+response.properties.nickname); 
					console.log("이메일:"+response.kakao_account.email); 
					// 세션에 값 저장
					//sessionStorage.setItem("m_id", response.id);
					location.href="kakaoLogin?id="+response.id;
					
				},
				fail: function (error) {
					console.log(error)
				},
			})
		},
		fail: function (error) {
			console.log(error)
		},
	})
}
</script>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
