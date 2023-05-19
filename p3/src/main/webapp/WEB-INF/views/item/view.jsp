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
		<div class="orderSelect">
			<div class="orderSelect2">컬러</div>
			<div>
				<select class="selectBox" onchange="itemSelect(this.value,'${vo.uid }')">
					<option value="">-[필수] 옵션을 선택해주세요</option>
					<option value="스페이스 그레이">스페이스 그레이</option>
					<option value="로즈 골드">로즈 골드</option>
					<option value="레이싱 그린">레이싱 그린</option>
					<option value="스칼렛 레드">스칼렛 레드</option>
				</select>
			</div>
		</div>
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
						<div><input id ="qty" name="qty" class="qtyStyle"  value="1" readonly></div>
						<div class="qtyBtn">
							<div class="btnSize"><img src="/img/qtyPlus.png" class="qtyBtnStyle" onclick="qty_num('+','${number}')"></div>
							<div class="btnSize"><img src="/img/qtyMinus.png" class="qtyBtnStyle" onclick="qty_num('-','${number}')"></div>
						</div>
					</div>
					<div  class="deleteBtnContainer"><img src="/img/deleteBtn.png" class="deleteBtn" onclick="cart_delete('${list.ct_uid}')"></div>
					<div id="total_price" class="priceStyle">가격</div>
			</div>
		</div>
		<c:set var="number" value="${number+1 }"/>
		</c:forEach>
		<div class="totalPrice">
			<div class="totalPriceSubject">total Price</div>
			<div name="wholePrice" id="wholePrice" class="wholePrice">0</div>
			<div  id="totalQty" name="totalQty" class="totalQty">(0개)</div>
		 </div>
		 <div class="orderBtnContainer">
		 		<div><button class="orderBtnBaro">바로 구매하기</button></div>
		 		<div><input type="button" value="장바구니" class="orderBtnEtc"></div>
		 		<div><input type="button" value="관심상품" class="orderBtnEtc"></div>
		 </div>
		 <div class="payAPI">
		 	<div class="naverPay">네이버페이</div>
		 	<div class="kakaoPay">카카오페이</div>
		 </div>
	</div>
	</form>
	
</div>

<div class="detailItemContainer">
	<div class="detailInfo"><a href=""><b>상품상세보기</b></a></div>
	<div class="detailInfo">|</div>
	<div class="detailInfo"><a href="">상품구매안내</a></div>
	<div class="detailInfo">|</div>
	<div class="detailInfo"><a href="">사용후기</a></div>
	<div class="detailInfo">|</div>
	<div class="detailInfo"><a href="">Q&A</a></div>
</div>

<div class="detialImg"><img src ="/upload/${file2} "></div>

<div class="detailItemContainer">
	<div class="detailInfo"><a href="">상품상세보기</a></div>
	<div class="detailInfo">|</div>
	<div class="detailInfo"><a href=""><b>상품구매안내</b></a></div>
	<div class="detailInfo">|</div>
	<div class="detailInfo"><a href="">사용후기</a></div>
	<div class="detailInfo">|</div>
	<div class="detailInfo"><a href="">Q&A</a></div>
</div>

<div class="itemOrderInfo"></div>

<div class="detailItemContainer">
	<div class="detailInfo"><a href="">상품상세보기</a></div>
	<div class="detailInfo">|</div>
	<div class="detailInfo"><a href="">상품구매안내</a></div>
	<div class="detailInfo">|</div>
	<div class="detailInfo"><a href=""><b>사용후기</b></a></div>
	<div class="detailInfo">|</div>
	<div class="detailInfo"><a href="">Q&A</a></div>
</div>
</center>
<script>
var msg = "${msg}";
if(msg != ''){
	alert(msg);
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


function qty_num(str,num2){

	var num = parseInt($("input[name=qty]:eq("+num2+")").val());
	var one_price = parseInt($("input[id=price]:eq("+num2+")").val());
	var c = 0;
	
	//alert(one_price);
	if(str == '-'){ //차감
		if(num <= 1){
			alert("주문 최소 수량은 1개입니다.");
			$("input[name=qty]:eq("+num2+")").val(1);
		}else{
			
		var total_number = one_price * (num-1);	
		var regexp = /^[0-9]*$/;
		total_number = total_number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		
		$("div[name=total_price]:eq("+num2+")").text(total_number);
		
		$("input[name=qty]:eq("+num2+")").val(num -1);
		
		$("#qty-").click(function() {
	    	window.reload();
	    })
		
		}
	}else{ //증가
		
		var total_number = one_price * (num+1);	
		var regexp = /^[0-9]*$/;
		total_number = total_number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		
		$("input[name=total_price]:eq("+num2+")").val(total_number);
		$("input[name=qty]:eq("+num2+")").val(num + 1);
		
		
	    $("#qty+").click(function() {
	    	window.reload();
	    })
	}
	
}

function cart_delete(ct_uid){
	//alert(ct_uid);
	$.ajax({
		url: "cart_delete", //전송받을 페이지 경로
		type: "post", //데이터 읽어오는 방식
		dataType: "text", //데이터 방식
		data: "ct_uid="+ct_uid, //데이터 전달
		error:function(){ //실패일 경우
			alert("실패");
		},
		success:function(result){ //성공일 경우
//				$("#result1").html(text);
		console.log("성공");
		location.reload();
		}
		
	});
}
</script>