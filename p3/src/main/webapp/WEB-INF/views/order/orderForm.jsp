<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/orderForm.css">
<script src="https://nsp.pay.naver.com/sdk/js/naverpay.min.js"></script>
<center>
<div style="height:100px;"></div>
<div class="title">
	<span >주문서 작성</span><br>
</div>
<div style="height: 50px;"></div>
<div class="benfitContainer">
	<div class="benefitInfo"><b>혜택정보</b></div>
	<div class="pointInfo">가용적립금: <b><fmt:formatNumber value="${point }" pattern="#,###"/>원</b></div>
	<div class="couponInfo">쿠폰 : <b>${couponCount }개</b></div>
</div>
<div class="qtyChangeInfo">상품의 옵션 및 수량 변경은 상품상세 또는 장바구니에서 가능합니다.</div>
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
			<input type="hidden" id="subject" value="${list.subject }">
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
	<div class="addTitle">배송지 선택</div>
	<div class="addrContent">
		<input type="radio"  name="addrType" checked onclick="addrOption('exist')">회원정보와 동일
		<input type="radio"  name="addrType" onclick="addrOption('new')">새로운 배송지
		<input type="button"  value="주소록 보기" id ="showAddr" class="showAddr" onclick="addrPopUp()">
	</div>
</div>
<div class="addInfo">
	<div class="addTitle">받으시는 분</div>
	<div class="addrContent">
		<input  type="text" id="name1" name="name" class="nameInput" value="${m.name }">
	</div>
</div>
<div class="addInfo">
	<div class="addTitle">주소</div>
		<div class="addrContainer">
			<input type="text" id="sample4_postcode" name="zipcode" placeholder="우편번호"  class="addrInput" value="${m.zipcode }" required>
        	<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="addrBtn" >
		
			<input type="text" id="sample4_roadAddress" name="zipcode1" placeholder="도로명주소"  class="addrInput" value="${m.zipcode1 }" required>
			<input type="text" id="sample4_jibunAddress" name="zipcode2" placeholder="지번주소"  class="addrInput" value="${m.zipcode2 }" required>
			<span id="guide" style="color:#999;display:none"></span><br>
		
			<input type="text" id="sample4_detailAddress" name="zipcode3" placeholder="상세주소"  class="addrInput" value="${m.zipcode3 }" required>
			<input type="text" id="sample4_extraAddress" name="zipcode4" placeholder="참고항목"  class="addrInput" value="${m.zipcode4 }" required>
			<input type="hidden" id="email" name="email">
		</div>
</div>
<div class="addInfo">
	<div class="addTitle">휴대전화</div>
	<div class="addrContent">
		<input  type="text" id="phone1" name="phone1" class="phoneInput" value="${phone1 }">
		<input  type="text" id="phone2" name="phone2" class="phoneInput" value="${phone2 }">
		<input  type="text" id="phone3" name="phone3" class="phoneInput" value="${phone3 }">
		<input type="hidden" id="phone" name="phone">
	</div>
</div>
<div class="addInfo">
	<div class="addTitle">이메일</div>
	<div class="addrContent">
		<input id = "email1" name="email1" class="phoneInput" value="${email1 }">
		<select id ="email2" name="email2" class="phoneInput">
			<option value="">==도메인을 선택해주세요==</option>
			<option value="naver.com" <c:if test="${email2 =='naver.com' }">selected</c:if>>naver.com</option>
			<option value="gmail.com" <c:if test="${email2 =='gmail.com' }">selected</c:if>>gmail.com</option>
		</select>
	</div>
</div>
<div class="addInfo">
	<div class="addTitle">배송메시지</div>
	<div class="addrContent">
		<input id="message" name="message" class="messageInput">
	</div>
</div>
<div style="height: 30px;"></div>
<div class="orderInfo">결제 예정금액</div>
<div class="preOrderContainer">
	<div class="totalItemPrice" >총 주문금액</div>
	<div class="discount">할인금엑</div>
	<div class="totalOrderPrice">총 결제예정금액</div>
</div>
<div class="preOrderContainer2">
	<div class="totalItemPrice2" id="totalItemPrice"></div>
	<input type="hidden" name="totalItemPrice" >
	<div class="discount2" id="discount">-0</div>
	<input type="hidden" name="discount">
	<div class="totalOrderPrice2" id="totalOrderPrice"></div>
	<input type="hidden" id="total_price" name="total_price">
	<input type="hidden" id="total_qty" name="total_qty">
</div>
<div class="discountContainer">
	<div class="discountSubject">총 할인금액</div>
	<div class="discountContent" id="totalDiscount"></div>
</div>
<div class="discountContainer">
	<div class="discountSubject" >포인트</div>
	<div class="discountContent">
		<input name="usepoint" id="point" class="pointInput" onchange="pointCal(this.value)">
		
	</div>
</div>
<div class="discountContainer">
	<div class="discountSubject" >쿠폰</div>
	<div class="discountContent">
		<input name="coupon" id="coupon" class="pointInput"  onchange="couponCal(this.value)"  readonly>
		<input type="button" value="조회" class="pointShowBtn" onclick="couponPopUp()">
		<input type="hidden" id="cp_number" name="cp_number">
	</div>
</div>
<div class="orderInfo">결제수단</div>
<div class="payOption">
	<div class="payInfo">
		<div class="payRadio">
			<input type="radio" name="payOption" checked onclick="pay_option('b')">무통장입금
			<input type="radio" name="payOption" onclick="pay_option('e')">간편결제
		</div>
		<div class="bankPay" id="bankPay">
			<div class="backInfo">
				<div class="bankInfoTitle">농협은행</div><div class="bankInfoContent">302-79292751-21</div>
			</div>
			<div class="backInfo">
				<div class="bankInfoTitle">입금자명</div><div class="bankInfoContent"><input name="bankName" class="bankName" required></div>
			</div>
		</div>
		<div class="easyPay" id="easyPay">
		 	<div class="kakaoPay" >
		 	 		<button type="button" id="check_module" type="button"  class="kakaopayBtn">
		 	 			<img src="/img/kakaoPayLogo.png"">
		 	 		</button>
		 	</div>
		</div>	
	</div>
	<div class="payBtnContainer">
		<div class="payBtnItem1">최종결제금액</div>
		<div id="finalPrice" class="finalPrice"></div>
		<div class="finalBtnDiv"><button  class="finalPayBtn">결제하기</button></div>
		<div class="finalPointDiv">
			<div>적립예정금액</div>
			<div id="finalPoint"></div>
			<input type="hidden" name="point" id="point2">
		</div>
	</div>
</div>
</form>
</center>

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
	var finalPoint = total_price*0.1;
	$("#finalPoint").text(finalPoint.toLocaleString());
	$("input[name=point]").val(finalPoint);
}
calSum();

function addrOption(str){
	
	if(str =='exist'){
		$("#name1").val("${m.name}");
		$("input[name=zipcode]").val("${m.zipcode}");
		$("input[name=zipcode1]").val("${m.zipcode1}");
		$("input[name=zipcode2]").val("${m.zipcode2}");
		$("input[name=zipcode3]").val("${m.zipcode3}");
		$("input[name=zipcode4]").val("${m.zipcode4}");
		$("#phone1").val("${phone1}");
		$("#phone2").val("${phone2}");
		$("#phone3").val("${phone3}");
		
		$("#showAddr").hide();
			
	}else{
		$("#showAddr").show();
		$("input[type=text]").val('');
	}
}
addrOption('exist');
function pay_option(str){
	if(str=='b'){
		$("#bankPay").show();
		$("#easyPay").hide();
		
	}else{
		$("#bankPay").hide();
		$("#easyPay").show();
	}
}
pay_option('b');

function addrPopUp(){
	if(m_id !=''){
	window.open("/addr/selectList","_blank","width=1200, height=600");
	}else{
		alert("회원만 이용가능합니다");
	}
}


function couponPopUp(){
	if(m_id !=''){
	window.open("/coupon/couponSelect","_blank","width=700, height=400");
	}else{
		alert("회원만 이용가능합니다");
	}
}
function pointCal(value2){
	var point = ${point};
	//alert("가용포인트="+point+",&사용포인트="+value2);
	if(value2 >point){
		alert("가용포인트보다 많은 포인트를 입력할 수 없습니다.");
		$("#point").val("");
		
	}else{
		var totalDiscount = Number($("#point").val()) + Number($("#coupon").val());
		$("#totalDiscount").text(totalDiscount.toLocaleString());
		$("input[name=discount]").val(Number($("#point").val()) + Number($("#coupon").val()));
		$("#discount").text("-"+totalDiscount.toLocaleString()); 
		calOrder();
	}

}

function couponCal(value){
	var totalDiscount = Number($("#point").val()) + Number($("#coupon").val());
	$("#totalDiscount").text(totalDiscount.toLocaleString());
	$("input[name=discount]").val(Number($("#point").val()) + Number($("#coupon").val()));
	$("#discount").text("-"+totalDiscount.toLocaleString()); 
	calOrder();
}

function calOrder(){
	var totalDiscount = Number($("#point").val()) + Number($("#coupon").val());
	$("#totalDiscount").text(totalDiscount);
	$("input[name=discount]").val(totalDiscount);
	
	var totalOrderPrice = Number($("input[name=totalItemPrice]").val()) - Number($("input[name=discount]").val())
	$("#totalOrderPrice").text("="+totalOrderPrice.toLocaleString());
	$("input[name=total_price]").val(totalOrderPrice);
	
	$("#finalPrice").text(totalOrderPrice.toLocaleString());	
	
}
calOrder();

function order_go(){
	var num = ${number};
	//alert(num);
	var ct_uids ="";
	var qtys ="";
	var total_qty =0;
	
	for(var i=0;i<num;i++){
	    ct_uids += $("input[name=ct_uid]:eq("+i+")").val() + ",";
	    qtys += $("input[name=qty]:eq("+i+")").val() + ",";
	    total_qty = Number($("input[name=qty]:eq("+i+")").val());
	}
	$("#ct_uids").val(ct_uids);
	$("#qtys").val(qtys);
	$("#total_qty").val(total_qty);
	phone.value = phone1.value+"-"+phone2.value+"-"+phone3.value;
	email.value = email1.value+"@"+email2.value;
	
	document.order.submit();
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
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
 <script>
 var num =${number};
 //alert(num);
 var subjectName = $("input[id=subject]:eq(0)").val()
 if(num>=2){
	 subjectName =  $("input[id=subject]:eq(0)").val()+"외 "+(num-1)+"개";
 }
 
 //alert(subjectName);
	$("#check_module").click(function () {
		var IMP = window.IMP; // 생략가능
		IMP.init('impxxxxxxxxxx'); 
		// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
		// ''안에 띄어쓰기 없이 가맹점 식별코드를 붙여넣어주세요. 안그러면 결제창이 안뜹니다.
		
		var today = new Date();   
        var hours = today.getHours(); // 시
        var minutes = today.getMinutes();  // 분
        var seconds = today.getSeconds();  // 초
        var milliseconds = today.getMilliseconds();
        var makeMerchantUid = hours +  minutes + seconds + milliseconds;
        
		IMP.request_pay({
			pg: 'kakaopay',
			pay_method: 'card',
			merchant_uid: 'merchant_' + makeMerchantUid,
			/* 
			 *  merchant_uid에 경우 
			 *  https://docs.iamport.kr/implementation/payment
			 *  위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
			 */
			name: '상품명 : '+subjectName,
			// 결제창에서 보여질 이름
			// name: '주문명 : ${auction.a_title}',
			// 위와같이 model에 담은 정보를 넣어 쓸수도 있습니다.
			amount: $('input[name=total_price]').val(),
			// amount: ${bid.b_bid},
			// 가격 
			buyer_name: '${m_name}',
			// 구매자 이름, 구매자 정보도 model값으로 바꿀 수 있습니다.
			// 구매자 정보에 여러가지도 있으므로, 자세한 내용은 맨 위 링크를 참고해주세요.
			buyer_postcode: '123-456',
			}, function (rsp) {
				console.log(rsp);
			if (rsp.success) {
				var msg = '결제가 완료되었습니다.';
				msg += '결제 금액 : ' + rsp.paid_amount;
				
				var num = ${number};
				
				var totalQty=1
				for(var i=0;i<num;i++){
					totalQty +=Number($("input[id=qty]:eq("+i+")").val());
				}
												
				var ctUids ="";
				
				for(var i=0;i<num;i++){
				    ctUids += $("input[name=ct_uid]:eq("+i+")").val() + ",";
				}
				var emailsum = $("#email1").val()+"@"+$("#email2").val();
				var phonesum = phone1.value+"-"+phone2.value+"-"+phone3.value;
				
				
				// 폼 데이터를 JSON 형식으로 변환
				var formData = {
				  subject: subjectName,
				  total_price: $('input[name=total_price]').val(),
				  total_qty: totalQty,
				  ct_uids: ctUids,
				  name: $('#name1').val(),  
				  email: emailsum,
				  phone: phonesum,
				  zipcode: $("input[name=zipcode]").val(),
				  zipcode1:$("input[name=zipcode1]").val(),
				  zipcode2:$("input[name=zipcode2]").val(),
				  zipcode3:$("input[name=zipcode3]").val(),
				  zipcode4:$("input[name=zipcode4]").val(),
				  message: $('#message').val(),
				  cp_number: $("#cp_number").val(),
				  usepoint: $("input[name=usepoint]").val(),
				  point: $("#point2").val()
				};
				
				var data = encodeURIComponent(JSON.stringify(formData));
 				var url = "/kakaoPay?data=" + data;
 				location.href = url;

				$.ajax({
					url: "/kakaoPay", //페이지 경로
					type: "get", //전송 방식
					dataType: "text", //데이터 방식
					data: "data="+data, //데이터 전달
					error:function(){ //실패일 경우
						alert("실패");
					},
					success:function(text){ //성공일 경우
						location.href="/kakaoPaySuccess"
						console.log("성공");
					}
				});
								
				// success.submit();
				// 결제 성공 시 정보를 넘겨줘야한다면 body에 form을 만든 뒤 위의 코드를 사용하는 방법이 있습니다.
				// 자세한 설명은 구글링으로 보시는게 좋습니다.
			} else {
				var msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' + rsp.error_msg;
			}
			alert(msg);
		});
	});
</script>
