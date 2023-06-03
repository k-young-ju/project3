<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/addrWrite.css">    
    
<center>
<form method="post" onsubmit="register()">
	<div style="height:100px;"></div>
	<div class="title">
		<span >배송 주소록 관리</span><br>
	</div>
	<div style="height: 50px;"></div>
	<div class="menuContainer">
		<div class="itemTitle">배송지명</div>
		<div><input name="subject" class="subject" required ></div>
	</div>
	<div class="menuContainer">
		<div class="itemTitle">성명</div>
		<div><input name="name" class="subject" required ></div>
	</div>
	<div class="menuContainer">
		<div class="itemTitle">주소</div>
		<div class="addrContainer">
			<input type="text" id="sample4_postcode" name="zipcode" placeholder="우편번호"  class="addrInput" required>
        	<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="addrBtn" >
		
			<input type="text" id="sample4_roadAddress" name="zipcode1" placeholder="도로명주소"  class="addrInput" required>
			<input type="text" id="sample4_jibunAddress" name="zipcode2" placeholder="지번주소"  class="addrInput" required>
			<span id="guide" style="color:#999;display:none"></span><br>
		
			<input type="text" id="sample4_detailAddress" name="zipcode3" placeholder="상세주소"  class="addrInput" required>
			<input type="text" id="sample4_extraAddress" name="zipcode4" placeholder="참고항목"  class="addrInput" required>
		</div>
	</div>
	<div class="menuContainer">
		<div class="itemTitle">전화번호</div>
		<div>
			<input id="phone1" name="phone1" class="phone" required maxlength="3">
			<input id="phone2" name="phone2" class="phone" required  maxlength="4">
			<input id="phone3" name="phone3" class="phone" required  maxlength="4">
			<input type="hidden" id="phone" name="phone">
		</div>
	</div>
	<div class="btnConatainer">
		<div class="listBtnContainer">
			<input type="button" value="목록" class="listBtn" onclick="location.href='list'">
		</div>
		<div>
			<button class="registerBtn">등록</button>
		</div>
	</div>
</form>	
</center>	
<script>
	function register(){
		phone.value = phone1.value+"-"+phone2.value+"-"+phone3.value;
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