<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/orderResult.css">
<center>
<div style="height:100px;"></div>
<div class="title">
	<span >주문 조회</span><br>
</div>
<div style="height: 50px;"></div>
<div class="od_number">
	<div class="odTitle">주문번호 </div><div class="odContent">${od_number }</div> 
</div>
<div class="od_number">
	<div class="odTitle">주문상태 </div><div class="odContent">${od_status }</div> 
</div>
<div class="orderInfo">상품 주문내역</div>
<div class="itemTitleContainer">
	<div class="imgStyle">이미지</div>
	<div class="itemInfo">상품정보</div>
	<div class="price">판매가</div>
	<div class="qty">수량</div>
	<div class="point">적립금</div>
	<div class="delivery">배송비</div>
	<div class="sumPrice">합계</div>
</div>
<c:set var="number" value="${0 }"/>
<form name="order" method="post" onsubmit="order_go()">
<c:forEach var="list" items="${list }">
	<div class="itemContentContainer">
			<div class="imgStyle"><img src = "/upload/${list.file1 }" class="imgSize"></div>
		<div class="itemInfo">
			<div><a href="/item/view?uid=${list.uid }">${list.subject }</a></div>
			<div>[옵션 : ${list.color }]</div>
		</div>
		<div class="price">
			<input type="hidden" name="ct_uid" value="${list.ct_uid }">
			<input type="hidden" id="ct_uids" name="ct_uids" >
			<fmt:formatNumber value="${list.price }" pattern="#,###"/>
			<input type="hidden" id="price" name="price" value="${list.price }">
		</div>
		<div class="qty">
			${list.qty }
			<input type="hidden" name="qty" id="qty" value="${list.qty }">
			<input type="hidden" id="qtys" name="qtys">
		</div>
		<div class="point">
			<fmt:formatNumber value="${list.price*0.1 }" pattern="#,###"/>
		</div>
		<div class="delivery">
			<c:if test="${list.price*list.qty >=30000 }">무료</c:if>
			<c:if test="${list.price*list.qty <30000 }">3,000</c:if>
		</div>
		<div class="sumPrice">
			<c:if test="${list.price*list.qty >=30000 }"><fmt:formatNumber value="${list.price*list.qty }" pattern="#,###"/></c:if>
			<c:if test="${list.price*list.qty <30000 }"><fmt:formatNumber value="${list.price*list.qty+3000 }" pattern="#,###"/></c:if>
		</div>
	</div>
	<c:set var="number" value="${number+1 }"/>
</c:forEach>
<div class="sumCal">
	상품구매금액&nbsp;<div id="total_price"></div>&nbsp;+&nbsp;배송비&nbsp;<div id="delivery"></div>&nbsp;=&nbsp;합계 : &nbsp;<div id="sum" class="sumStyle"></div>
</div>
<div class="orderInfo">배송 정보</div>
<div class="addInfo">
	<div class="addTitle">받으시는 분</div>
	<div class="addrContent">${vo.name }	</div>
</div>
<div class="addInfo">
	<div class="addTitle">주소</div>
		<div class="addrContainer">
			<div>${vo.zipcode }</div>
			<div>${vo.zipcode1 } &nbsp; (지번 : ${vo.zipcode2 })</div>
			<div>${vo.zipcode3 } &nbsp; ${vo.zipcode4 }</div>
   		</div>
</div>
<div class="addInfo">
	<div class="addTitle">휴대전화</div>
	<div class="addrContent">${vo.phone }</div>
</div>
<div class="addInfo">
	<div class="addTitle">이메일</div>
	<div class="addrContent">${vo.email }</div>
</div>
<div class="addInfo">
	<div class="addTitle">배송메시지</div>
	<div class="addrContent">${vo.message }	</div>
</div>
<div style="height: 30px;"></div>
<div class="orderInfo">결제 금액</div>
<div class="preOrderContainer">
	<div class="totalItemPrice" >총 주문금액</div>
	<div class="discount">할인금엑</div>
	<div class="totalOrderPrice">총 결제금액</div>
</div>
<div class="preOrderContainer2">
	<div class="totalItemPrice2" id="totalItemPrice"></div>
	<div class="discount2" id="discount">
		<div id="discount2" class="totalDiscount"></div>
		<div>
			<div class="discountDetail" >포인트 :
				<c:if test="${usepoint !=null }">
					<fmt:formatNumber value="${usepoint }" pattern="#,###"/>
					<input  type="hidden" id="usepoint" value="${usepoint }">
				</c:if>
				<c:if test="${usepoint ==null }">
					0
					<input  type="hidden" id="usepoint" value="0">
				</c:if>
				
			</div>
			<div class="discountDetail">쿠폰 : 
				<c:if test="${couponpoint !=null }">
					<fmt:formatNumber value="${couponpoint }" pattern="#,###"/>
					<input type="hidden" id="usecoupon" value="${couponpoint }">
				</c:if>
				<c:if test="${couponpoint ==null }">
					0
					<input  type="hidden" id="usecoupon" value="0">
				</c:if>			
			</div>
		</div>
	</div>
	<div class="totalOrderPrice2" id="totalOrderPrice"><fmt:formatNumber value="${vo.total_price }" pattern="#,###"/></div>
</div>
<div>
	<div class="btnContainer">
		<input type="button" value="메인으로 가기" class="mainGOBtn" onclick="location.href='/'">
		<c:if test="${od_status =='입금확인중' }">
			<input type="button" value="주문 취소하기" class="cancelBtn" onclick="cancel()">
		</c:if>
	</div>
</div>
</form>
<div style="height: 50px;"></div>
</center>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>

<script>
var m_id ="${m_id}";

var num =${number};
//alert(num);
function calSum(){
	var total_price =0;
	for(var i=0;i<num;i++){
		var one_price = $("input[id=price]:eq("+i+")").val();
		var one_qty = $("input[id=qty]:eq("+i+")").val();
		var itemPrice = one_price*one_qty;
		total_price += itemPrice;
		
	}
	var total_price2 = total_price+3000;
	
	var regexp = /^[0-9]*$/;
	total_priceStr = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	total_priceStr2 = total_price2.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	
	$("div[id=total_price]").text(total_price);
	if(total_price >=30000){
		$("div[id=sum]").text(total_priceStr);
		$("div[id=totalItemPrice]").text(total_priceStr);
		$("input[name=totalItemPrice]").val(total_price);
		$("div[id=delivery]").text(0)
		
	}else{
		$("div[id=sum]").text(total_priceStr2);
		$("div[id=totalItemPrice]").text(total_priceStr2);
		$("input[name=totalItemPrice]").val(total_price2);
		$("div[id=delivery]").text("3,000")
	}
	
	$("#discount2").text(Number($("#usepoint").val()) + Number($("#usecoupon").val()));
}
calSum();

function cancel(){
	var od_number = "${od_number}";
	var result = confirm("주문을 취소하시겠습니까?");
	if(result == true){
		location.href="orderCancel?od_number="+od_number;
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