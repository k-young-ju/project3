<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/itemView.css">

<center>
<div style="height: 100px;"></div>
<div class="sellContainer">
	<div>
		<div ><img src = "/upload/${vo.file1 }" class="mainImgSize" id="mainImg"></div>
		<div class="detailImgContainer">
			<div onclick="img_ch('1')"><c:if test="${vo.file1 != null }"><img src="/upload/${vo.file1 }" class="detailImg"></c:if></div>
			<div onclick="img_ch('3')"><c:if test="${vo.file3 != null }"><img src="/upload/${vo.file3 }" class="detailImg"></c:if></div>
			<div onclick="img_ch('4')"><c:if test="${vo.file4 != null }"><img src="/upload/${vo.file4 }" class="detailImg"></c:if></div>
			<div onclick="img_ch('5')"><c:if test="${vo.file5 != null }"><img src="/upload/${vo.file5 }" class="detailImg"></c:if></div>
		</div>
	</div>
	<form name="order">
	<div class="itemInfo">
		<div class="viewSubject">${vo.subject }</div>
		<div class="viewComment">${vo.comment }</div>
		<div class="viewPriceInfo">
			<div class="viewPrice">
				<div class="viewInfoContainer">
					<div class="orderInfo">판매가</div>
					<div class="orderInfo">국내/해외 배송</div>
					<div class="orderInfo">배송방법</div>
					<div class="orderInfo">배송비</div>
				</div>
				<div class="viewInfoContainer">
					<div class="viewPriceStyle">
						<fmt:formatNumber value="${vo.price }" pattern="#,###"/>
						<input type="hidden"  id="price" name="price"value="${vo.price }">	
					</div>
					<div class="orderInfo">국내배송</div>
					<div class="orderInfo">택배</div>
					<div class="orderInfo">무료</div>
				</div>
			</div>
		</div>
		<c:if test="${color_list != null }">
		<div class="orderSelect">
			<div class="orderSelect2">컬러</div>
			<div>
				<select class="selectBox" onchange="itemSelect(this.value,'${vo.uid }')">
					<option value="">-[필수] 옵션을 선택해주세요</option>
					<c:forEach var="color_list" items="${color_list }">
						<option value=" ${color_list }">${color_list }</option>
					</c:forEach>
				</select>
			</div>
		</div>
		</c:if>
		<div class="minQty">(최소주문수량 1개이상)</div>
		<div class="introduceOption">위 옵션선택 박스를 선택하시면 아래에 상품이 추가됩니다.</div>
		<c:set var = "number" value="${0 }"/>	
		<c:forEach var="list" items="${list }">
			<div class="selectContainer">
				<div class="detailContainer">
					<div class="detailSubject">
						<div class="optionSelectSubject">${vo.subject }</div>
						<div id ="optionColor" class="optionColor">
							-${list.color}<input type="hidden" id="color" value="${list.color }">
						</div>
					</div>
					<div class="qtyContainer">
						<div><input id ="qty" name="qty" class="qtyStyle"  value="${list.qty }" readonly></div>
						<div class="qtyBtn">
							<div class="btnSize"><img src="/img/qtyPlus.png" class="qtyBtnStyle" onclick="qty_num('+','${number}',${list.s_uid })"></div>
							<div class="btnSize"><img src="/img/qtyMinus.png" class="qtyBtnStyle" onclick="qty_num('-','${number}',${list.s_uid })"></div>
						</div>
					</div>
					<div  class="deleteBtnContainer"><img src="/img/deleteBtn.png" class="deleteBtn" onclick="select_delete('${list.s_uid}')"></div>
					<div class="priceStyle" >
						<fmt:formatNumber value="${list.price*list.qty }" pattern="#,###"/>
						<input type="hidden"  name="total_price" id="total_price" class="priceInputStyle"  value ="${list.price*list.qty}"readonly>
					</div>
			</div>
		</div>
		<c:set var="number" value="${number+1 }"/>
		</c:forEach>
		<div class="totalPrice">
			<div class="totalPriceSubject">total Price</div>
			<div class="wholePrice">
				<span id="wholePriceSpan"></span>
				<input name="wholePrice" id="wholePrice" class="wholePriceStyle" readonly>
			</div>
			<div class="totalQty">
				(<input name="wholeQty" id="wholeQty" value="0" class="wholeQtyStyle" readonly>개)
			</div>
		 </div>
		 <div class="orderBtnContainer">
		 		<div><button class="orderBtnBaro">바로 구매하기</button></div>
		 		<div><input type="button" value="장바구니" class="orderBtnEtc" onclick="cart_go()"></div>
		 		<div><input type="button" value="관심상품" class="orderBtnEtc" onclick="jjim_go()"></div>
		 </div>
		 <div class="payAPI">
		 	<div class="naverPay">네이버페이</div>
		 	<div class="kakaoPay">카카오페이</div>
		 </div>
	</div>
	</form>
	
</div>
<div style="height: 20px;"></div>
<div class="detailItemContainer">
	<div class="detailInfo" id="itemInfo"><a href="#itemInfo"><b>상품상세보기</b></a></div>
	<div class="detailInfo">|</div>
	<div class="detailInfo"><a href="#orderInfo">상품구매안내</a></div>
	<div class="detailInfo">|</div>
	<div class="detailInfo"><a href="#reviewInfo">사용후기</a></div>
	<div class="detailInfo">|</div>
	<div class="detailInfo"><a href="#qna">Q&A</a></div>
</div>

<div class="detialImg"><img src ="/upload/${vo.file2} " class="detialImg"></div>

<div class="detailItemContainer">
	<div class="detailInfo"><a href="#itemInfo">상품상세보기</a></div>
	<div class="detailInfo">|</div>
	<div class="detailInfo" id="orderInfo"><a href="#orderInfo"><b>상품구매안내</b></a></div>
	<div class="detailInfo">|</div>
	<div class="detailInfo"><a href="#reviewInfo">사용후기</a></div>
	<div class="detailInfo">|</div>
	<div class="detailInfo"><a href="#qna">Q&A</a></div>
</div>

<div class="bottomInfo">
	<div class="bottomInfoTitle">상품결제정보</div>
	<div class="bottomInfoContent" >
고액결제의 경우 안전을 위해 카드사에서 확인전화를 드릴 수도 있습니다.
확인과정에서 도난 카드의 사용이나 타인 명의의 주문등 정상적인 주문이 아니라고 판단될 경우 임의로 주문을 보류 또는 취소할 수 있습니다.

무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면 됩니다.  
주문시 입력한 입금자명과 실제입금자의 성명이 반드시 일치하여야 하며, 7일 이내로 입금을 하셔야 하며 입금되지 않은 주문은 자동취소 됩니다.
	</div>
	<div class="bottomInfoTitle">배송정보</div>
	<div  class="bottomInfoContent">
배송 방법 : 택배
배송 지역 : 전국지역
배송 비용 : ${delivery }
배송 기간 : 3일 ~ 7일
배송 안내 : ${deliveryInfo }

제주, 도서지역 추가 배송료 5,000원
(제주 및 도서산간의 경우 별도의 추가금액을 지불하셔야 하는 경우가 있습니다.)
   
고객님께서 주문하신 상품은 입금 확인후 배송해 드립니다. 다만, 상품종류에 따라서 상품의 배송이 다소 지연될 수 있습니다.
	</div>
	<div class="bottomInfoTitle">교환 및 반품정보</div>
	<div class="bottomInfoContent">
<b>교환 및 반품 주소</b>
 - [03922] 서울특별시 마포구 월드컵북로58길 9 (상암동) ES타워 11층 탱그램팩토리
 
<b>교환 및 반품이 가능한 경우</b>
 - 계약내용에 관한 서면을 받은 날부터 7일. 단, 그 서면을 받은 때보다 재화등의 공급이 늦게 이루어진 경우에는 재화등을 공급받거나 재화등의 공급이 시작된 날부터 7일 이내
  - 공급받으신 상품 및 용역의 내용이 표시.광고 내용과 다르거나 계약내용과 다르게 이행된 때에는 당해 재화 등을 공급받은 날 부터 3월이내, 그사실을 알게 된 날 또는 알 수 있었던 날부터 30일이내
 
<b>교환 및 반품이 불가능한 경우</b>
 - 이용자에게 책임 있는 사유로 재화 등이 멸실 또는 훼손된 경우(다만, 재화 등의 내용을 확인하기 위하여 포장 등을 훼손한 경우에는 청약철회를 할 수 있습니다)
  - 이용자의 사용 또는 일부 소비에 의하여 재화 등의 가치가 현저히 감소한 경우
  - 시간의 경과에 의하여 재판매가 곤란할 정도로 재화등의 가치가 현저히 감소한 경우
  - 복제가 가능한 재화등의 포장을 훼손한 경우
  - 개별 주문 생산되는 재화 등 청약철회시 판매자에게 회복할 수 없는 피해가 예상되어 소비자의 사전 동의를 얻은 경우
  - 디지털 콘텐츠의 제공이 개시된 경우, (다만, 가분적 용역 또는 가분적 디지털콘텐츠로 구성된 계약의 경우 제공이 개시되지 아니한 부분은 청약철회를 할 수 있습니다.)
 
※ 고객님의 마음이 바뀌어 교환, 반품을 하실 경우 상품반송 비용은 고객님께서 부담하셔야 합니다.
 (색상 교환, 사이즈 교환 등 포함)
	</div>
</div>

<div class="detailItemContainer">
	<div class="detailInfo"><a href="#itemInfo">상품상세보기</a></div>
	<div class="detailInfo">|</div>
	<div class="detailInfo"><a href="#orderInfo">상품구매안내</a></div>
	<div class="detailInfo">|</div>
	<div class="detailInfo" id="reviewInfo"><a href="#reviewInfo"><b>사용후기</b></a></div>
	<div class="detailInfo">|</div>
	<div class="detailInfo"><a href="#qna">Q&A</a></div>
</div>
<div class="bottomMenuTitle">Reiviews</div>
<div class="bottomMenuContainer">
	<c:forEach var="list" items="${reviewList }">
		<div class="reviewContainer">
			<div class="reviewSubject">${list.subject }</div>
			<c:set var="hiddenId" value="${fn:replace(list.id, fn:substring(list.id, 3, fn:length(name)-1), '***')}" />
			<div class="reviewContent">${list.name }(${hiddenId })</div>
			<div class="reviewScore">
				<c:if test="${list.score==5 }">★★★★★</c:if>
				<c:if test="${list.score==4 }">★★★★☆</c:if>
				<c:if test="${list.score==3 }">★★★☆☆</c:if>
				<c:if test="${list.score==2 }">★★☆☆☆</c:if>
				<c:if test="${list.score==1 }">★☆☆☆☆</c:if>
			</div>
		</div>
	</c:forEach>
</div>
<div>
	<input type="button" value="상품리뷰쓰기" class="writeBtn" onclick="review_go(${vo.uid})">
	<input type="button" value="모든 리뷰 보기" class="viewBtn" onclick="location.href='/review/list'">
</div>

<div class="detailItemContainer">
	<div class="detailInfo"><a href="#itemInfo">상품상세보기</a></div>
	<div class="detailInfo">|</div>
	<div class="detailInfo"><a href="#orderInfo">상품구매안내</a></div>
	<div class="detailInfo">|</div>
	<div class="detailInfo" ><a href="#reviewInfo">사용후기</a></div>
	<div class="detailInfo">|</div>
	<div class="detailInfo" id="qna"><a href="#qna"><b>Q&A</b></a></div>
</div>
<div class="bottomMenuTitle">Q&A</div>
<div class="bottomMenuContainer">
	<c:set var ="num" value="${1 }"/>
	<c:forEach var="noticeList" items="${noticeList}">
		<div class="noticeContainer">
			<div class="noticeNum">${num }</div>
			<div class="noticeSubject">
				<c:if test="${noticeList.secretset =='secret' }"><img src="/img/icon_secret.gif"></c:if>
				<a href="/notice/view?n_uid=${noticeList.n_uid }">${noticeList.subject }</a>
			</div>
			<div class="noticeName">
				<c:set var="hiddenName" value="${fn:replace(noticeList.name, fn:substring(noticeList.name, 1, fn:length(name)-1), '***')}" />
					${ hiddenName}
			</div>
			<div class="noticeSigndate">${fn:substring(noticeList.signdate,0,10) }</div>
			<div class="noticeRef">${noticeList.ref }</div>
		</div>
		
		<c:set  var="num" value="${num+1 }"/>
	</c:forEach>
</div>
<div>
	<input type="button" value="상품 문의하기" class="writeBtn" onclick="qna_go(${vo.uid})">
	<input type="button" value="문의 게시판 가기" class="viewBtn" onclick="location.href='/notice/list?option=qna'">
</div>
</center>
<script>
var msg = "${msg}";
if(msg != ''){
	alert(msg);
}

function review_go(uid){
	var m_id = "${m_id}";
	//alert(m_id);
	if(m_id != null && m_id !=''){
		location.href="/review/write?uid="+uid;
	}else{
		var result = confirm("리뷰는 회원만 작성하실 수 있습니다. \n회원가입 페이지로 이동하시겠습니까?");
		if(result == true){
			location.href="/member/join";
		}else{
			return false;
		}
	}
}

function qna_go(uid){
	var m_id = "${m_id}";
	//alert(m_id);
	if(m_id != null && m_id !=''){
		location.href = "/notice/write?uid="+uid;
	}else{
		var result = confirm("문의글은 회원만 작성하실 수 있습니다. \n회원가입 페이지로 이동하시겠습니까?");
		if(result == true){
			location.href="/member/join";
		}else{
			return false;
		}
	}
}

function img_ch(num){
	//alert(num);
	if(num=='1'){
		document.getElementById("mainImg").src = "/upload/${vo.file1}";	
	}else if(num=='3'){
		document.getElementById("mainImg").src = "/upload/${vo.file3}";
	}else if(num=='4'){
		document.getElementById("mainImg").src = "/upload/${vo.file4}";
	}else if(num=='5'){
		document.getElementById("mainImg").src = "/upload/${vo.file5}";
	}

}

function itemSelect(color,uid){
	var num = ${number};
	//alert(num);
	for(var i=0;i<num;i++){
		var colorCheck = $("input[id=color]:eq("+i+")").val();
		//alert(colorCheck);
		if(colorCheck == color){
			alert("아래 리스트에서 이미 선택된 옵션을 삭제 후 다시 선택해 주세요");
			break;
		}
	}
	
	//alert(uid);
 		$.ajax({
			url: "color_select", //전송받을 페이지 경로
			type: "post", //데이터 읽어오는 방식
			dataType: "text", //데이터 방식
			data: "color="+color+"&uid="+uid, //데이터 전달
			error:function(){ //실패일 경우
				alert("실패");
			},
			success:function(result){ //성공일 경우
// 				$("#result1").html(text);
			console.log("성공");
			location.reload();
			}
			
		});
}


function qty_num(str,index,s_uid){
	//alert(ct_uid);
	var num = parseInt($("input[name=qty]:eq("+index+")").val());
	var one_price = parseInt($("input[id=price]").val());
	var c = 0;
	
	//alert(one_price);
	if(str == '-'){ //차감
		if(num <= 1){
			alert("주문 최소 수량은 1개입니다.");
			$("input[name=qty]:eq("+index+")").val(1);
					
		}else{
			
		var total_number = one_price * (num-1);	
		var regexp = /^[0-9]*$/;
		total_number = total_number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		var num2 = num-1;
		$("input[id=total_price]:eq("+index+")").val(total_number);
		
		$("input[name=qty]:eq("+index+")").val(num -1);
		
		//alert(num);
		$.ajax({
			url: "/updateQty", //전송받을 페이지 경로
			type: "post", //데이터 읽어오는 방식
			dataType: "text", //데이터 방식
			data: "qty="+num2+"&s_uid="+s_uid, //데이터 전달
			error:function(){ //실패일 경우
				alert("실패");
			},
			success:function(result){ //성공일 경우
// 				$("#result1").html(text);
			console.log("성공");
			location.reload();
			}
			
		});
		
				
		}
	}else{ //증가
		
		var total_number = one_price * (num+1);	
		var regexp = /^[0-9]*$/;
		total_number = total_number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		
		$("input[id=total_price]:eq("+index+")").val(total_number);
		$("input[name=qty]:eq("+index+")").val(num + 1);
		var num2= num+1;
		$.ajax({
			url: "/updateQty", //전송받을 페이지 경로
			type: "post", //데이터 읽어오는 방식
			dataType: "text", //데이터 방식
			data: "qty="+num2+"&ct_uid="+ct_uid, //데이터 전달
			error:function(){ //실패일 경우
				alert("실패");
			},
			success:function(result){ //성공일 경우
// 				$("#result1").html(text);
			console.log("성공");
			location.reload();
			}
			
		});
				    
	}
	calWholePrice();
}

function select_delete(s_uid){
	//alert(ct_uid);
	$.ajax({
		url: "/select_delete", //전송받을 페이지 경로
		type: "post", //데이터 읽어오는 방식
		dataType: "text", //데이터 방식
		data: "s_uid="+s_uid, //데이터 전달
		error:function(){ //실패일 경우
			alert("실패");
		},
		success:function(result){ //성공일 경우
//				$("#result1").html(text);
		//console.log("성공");
		location.reload();
		}
		
	});
}

function jjim_go(){
	var m_id ="${m_id}";
	//alert(m_id);
	var uid = "${vo.uid}";
	//alert(uid);
	if(m_id != ""){
		location.href="jjim_insert?uid="+uid;
	}else{
		var result =confirm(
`회원만 이용가능합니다. 
회원가입 페이지로 이동하시겠습니까?`
		);
		if(result == true){
			location.href="/member/join";
		}
	}
}	

function calWholePrice(){
	//총 상품금액
	var nums = ${number}; //상품 갯수
	//alert(nums);
	var order_total = 0; //총 금액
	var total_qty =0; //총 수량

	var uids= "";
	var total_price = 0;
	var qtys = "";
	var stock = "";

	for(i=0;i<nums;i++){
		var one_price = $("input[name=price]").val(); //1개 가격
		var one_qty = $("input[name=qty]:eq("+i+")").val(); //수량
		
		
		order_total += one_price * one_qty; //총 가격
		total_qty += Number(one_qty);
		//$("input[name=total_price]:eq("+i+")").val(total_number);
// 		uids += $("input[name=uid]:eq("+i+")").val()+",";
// 		qtys += $("input[name=qty]:eq("+i+")").val()+",";
		 
	}
	
// 	cart.uids.value =uids;
// 	cart.qtys.value = qtys;
// 	cart.stock.value = stock;
	
	$("#wholePrice").val(order_total.toLocaleString("ko-KR"));
	$("#wholeQty").val(total_qty);

}
calWholePrice();

function cart_go(){
	var colorList = "${color_list}";
	var uid = "${vo.uid}";
	var list = "${list}";
	alert(colorList);
	//alert(uid);
	//alert(list);
	if(colorList ==''){
		alert("c");
 		location.href="/cart/insert?uid="+uid;
	}else{
		if(list == ''){
			alert("b");
			alert("옵션을 선택해주세요");
		}else{
			alert("a");
			location.href="/cart/list";
		}
	}

}

function isEmptyObject(obj) {
	  return Object.keys(obj).length === 0;
	}
</script>