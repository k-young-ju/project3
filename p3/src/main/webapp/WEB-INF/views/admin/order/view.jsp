<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/admin/orderView.css">
    
<center>
<div class="menuContainer" >
	<div><%@ include file="/WEB-INF/views/admin/include/left_side.jsp" %></div>
	<div>
			<div class="title">
			<span >주문 상세</span><br>
		</div>
		<div class="od_number">
			<div class="odTitle">주문번호 </div><div class="odContent">${od_number }</div> 
		</div>
		<div class="od_number">
			<div class="odTitle">주문상태 </div><div class="odContent">${vo.od_status }</div> 
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
						<c:if test="${usepointt ==null }">
							0
							<input  type="hidden" id="usepoint" value="0">
						</c:if>
						
					</div>
					<div class="discountDetail">쿠폰 : 
						<c:if test="${cp.point !=null }">
							<fmt:formatNumber value=" ${cp.point }" pattern="#,###"/>
							<input type="hidden" id="usecoupon" value="${cp.point }">
						</c:if>
						<c:if test="${cp.point ==null }">
							0
							<input type="hidden" id="usecoupon" value="0">
						</c:if>
						
					</div>
				</div>
			</div>
			<div class="totalOrderPrice2" id="totalOrderPrice"><fmt:formatNumber value="${vo.total_price }" pattern="#,###"/></div>
		</div>
		</div>
</div>
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


