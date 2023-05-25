<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<table width=100% height=100 border=0>

	<tr>

		<td align=center>

			<span onclick="kakaoLogin()">[카카오 로그인]</span>

			<span onclick="kakaoLogout()">[카카오 로그아웃]</span>

			<span id="naverIdLogin_loginButton">[네이버 로그인]</span>

			<span onclick="naverLogout();">[네이버 로그아웃]</span>

		</td>

	</tr>

</table>



<!-- 네이버 스크립트 -->

<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>

<script>

var naverLogin = new naver.LoginWithNaverId(

	{

		clientId: "RLMCg6dyAd8VfWXA....", //내 애플리케이션 정보에 cliendId를 입력해줍니다.

		callbackUrl: "http://localhost:8080", // 내 애플리케이션 API설정의 Callback URL 을 입력해줍니다.

		isPopup: false,

		callbackHandle: true

	}

);	

naverLogin.init();



window.addEventListener('load', function () {

	naverLogin.getLoginStatus(function (status) {

		if (status) {

			var email = naverLogin.user.getEmail(); // 필수로 설정할것을 받아와 아래처럼 조건문을 줍니다.

    		

			console.log(naverLogin.user); // 체크된 항목 객체로 전달



			console.log(naverLogin.user.id); // 네이버에서 제공하는 식별 아이디

			console.log(naverLogin.user.nickname); // 닉네임

			console.log(naverLogin.user.email); // 이메일  



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