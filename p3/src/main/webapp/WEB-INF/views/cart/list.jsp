<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/cartList.css">
<script>
var msg = "${msg}";
if(msg !=''){
	alert(msg);
}
</script>
<center>

	<div style="height:100px;"></div>
	<div class="title">
		<span >장바구니</span><br>
	</div>
	<div style="height: 50px;">	</div>
	<div class="titleContainer">
		<div><input type="checkbox" id ="all"  onclick="allCheck()"></div>
		<div class="imgStyle">이미지</div>
		<div class="itemInfo">상품정보</div>
		<div class="price">판매가</div>
		<div class="qty">수량</div>
		<div class="point">예상적립금</div>
		<div class="delivery">배송비</div>
		<div class="sumPrice">합계</div>
		<div class="selection">선택</div>
	</div>
	<c:set var="number" value="${0 }"></c:set>
	<c:forEach var="list" items="${list }">
	<form name="order" method="post">
	<input type="hidden" name="uid" value="${list.uid }">
	<input type="hidden" name="path" value="baro">
	<input type="hidden" name="ct_uid" value="${list.ct_uid }">
	<div class="itemContainer">
		<div><input type="checkbox" id ="ap_check"name="ap_check" value="${list.ct_uid }" onclick="checkall()"></div>
		<div class="imgStyle"><img src = "/upload/${list.file1 }" class="imgSize"></div>
		<div class="itemInfo">
			<div><a href="/item/view?uid=${list.uid }">${list.subject }</a></div>
			<div>[옵션 : ${list.color }]</div>
		</div>
		<div class="price">
			${list.price }
			<input type="hidden" id="price" value="${list.price }">	
		</div>
		<div class="qtyContainer">
			<div><input id ="qty" name="qty" class="qtyStyle"  value="${list.qty }" readonly></div>
			<div class="qtyBtn">
				<div class="btnSize"><img src="/img/qtyPlus.png" class="qtyBtnStyle" onclick="qty_num('+','${number}',${list.ct_uid })"></div>
				<div class="btnSize"><img src="/img/qtyMinus.png" class="qtyBtnStyle" onclick="qty_num('-','${number}',${list.ct_uid })"></div>
			</div>
		</div>
		<div class="point" id="point">
			<fmt:formatNumber value="${list.price*list.qty*0.1 }" pattern="#,###" />원
			<input type="hidden" name="point" value="${list.price*list.qty*0.1 }">
		</div>
		<div class="delivery" >
			<c:if test="${list.price*list.qty >=30000 }">
				무료
				<input type="hidden" id="delivery" value="0">
			</c:if>
			<c:if test="${list.price*list.qty <30000 }">
				3,000원
				<input type="hidden" id="delivery" value="3000">
			</c:if>
		</div>
		<div class="sumPrice" >
			 <input id="total_price"  name="total_price"  class="total_priceInput" readonly>
		</div>
		<div class="selection">
			<div>
				<button class="orderBtn">주문하기</button>
			</div>
			<div><input type="button" value="관심상품등록" onclick="jjim_go(${list.uid})" class="jjimBtn"></div>
			<div><input type="button" value="장바구니삭제" onclick="location.href='delete?ct_uid=${list.ct_uid}'" class="deleteBtn"></div>
		</div>
	</div>
	<c:set var="number" value="${number+1 }"/>
	</form>	
	</c:forEach>
	<c:if test="${count ==0 }">
		<div class="cartCheck">장바구니에 담긴 상품이 없습니다.</div>
	</c:if>
	<div class="totalProductContainer">
		<div class="allproductPrice">총 상품금액</div>
		<div class="alldelivery">총 배송비</div>
		<div class="wholePrice1">결제 예정금액</div>
	</div>
	<div class="totalProductValue">
		<div class="allproductPrice2">
			<input name="wholePrice" id="wholePrice" class="wholePrice" readonly>
		</div>
		<div class="alldelivery2">
			<input name="alldelivery" id="alldelivery" class="wholePrice" readonly>
		</div>
		<div class="wholePrice2">
			<input name="pricePay" id="pricePay" class="wholePrice" readonly>
		</div>
	</div>
	<div class="bottomBtnContainer">
		<div><input type="button" value="장바구니 비우기" onclick="cartAllDelete()" class="cartAllDelete"></div>
		<div>
			<input type="button" value="전체상품주문" onclick="allOrder()" class="allOrderBtn">
			<input type="button" value="선택상품주문" onclick="selectOrder()" class="selectOrderBtn">
		</div>
	</div>
</center>
	
<script>
function jjim_go(uid){
	var pathname= $(location).attr('pathname');
	//alert(pathname);
	var m_id ="${m_id}";
	//alert(m_id);
	
	if(m_id != ""){
		location.href="/item/jjim_insert?uid="+uid+"&pathname="+pathname;
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

function qty_num(str,index,ct_uid){
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
// 		var regexp = /^[0-9]*$/;
// 		total_number = total_number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		var num2 = num-1;
		//$("input[id=total_price]:eq("+index+")").val(total_number);
		
		$("input[name=qty]:eq("+index+")").val(num -1);
		
		//alert(num);
		$.ajax({
			url: "/updateCartQty", //전송받을 페이지 경로
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
	}else{ //증가
		
		var total_number = one_price * (num+1);	
// 		var regexp = /^[0-9]*$/;
// 		total_number = total_number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		
		//$("input[id=total_price]:eq("+index+")").val(total_number);
		$("input[name=qty]:eq("+index+")").val(num + 1);
		var num2= num+1;
		$.ajax({
			url: "/updateCartQty", //전송받을 페이지 경로
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
	//calWholePrice();
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
	
	if(nums !=0){
		for(i=0;i<nums;i++){
			var one_price =$("input[id=price]:eq("+i+")").val(); //1개 가격
			var one_qty = $("input[name=qty]:eq("+i+")").val(); //수량
			var  total_price = 	one_price * one_qty;	
			
			order_total += one_price * one_qty; //총 가격
			
			total_qty += Number(one_qty);
					
			var delivery = $("input[id=delivery]:eq("+i+")").val();
			if(delivery==3000){
				
				$("input[name=total_price]:eq("+i+")").val((total_price+3000).toLocaleString("ko-KR")+"원");
			}else{
		
				$("input[name=total_price]:eq("+i+")").val(total_price.toLocaleString("ko-KR")+"원");
			}
			
	// 		uids += $("input[name=uid]:eq("+i+")").val()+",";
	// 		qtys += $("input[name=qty]:eq("+i+")").val()+",";
			 
		}
		
	// 	cart.uids.value =uids;
	// 	cart.qtys.value = qtys;
	// 	cart.stock.value = stock;
		
		$("#wholePrice").val(order_total.toLocaleString("ko-KR"));
		//$("#wholeQty").val(total_qty);
		if(order_total >=30000){
			$("#alldelivery").val("+"+0);
		}else{
			$("#alldelivery").val("+3,000");
		}
		//alert(order_total);
		if(order_total >=30000){
			$("#pricePay").val(order_total.toLocaleString("ko-KR"));
		}else{
			$("#pricePay").val((order_total+3000).toLocaleString("ko-KR"));
		}
	}
}
calWholePrice();

function isAllChecked() {
    var checkboxes = document.querySelectorAll("input[id=ap_check]");
    for (var i = 0; i < checkboxes.length; i++) {
        if (!checkboxes[i].checked) {
            return false;
        }
    }
    return true;
}

function allCheck(){
    var num = ${number};
    //alert(num);
    if(isAllChecked() == true){
        for(var i = 0; i<num; i++){
            $("input[name=ap_check]:eq("+i+")").prop("checked", false);
        }
    }else{
   		 for(var i = 0; i<num; i++){
             $("input[name=ap_check]:eq("+i+")").prop("checked", true);
         }
    }
    
}

function cartAllDelete(){
	var pathname= $(location).attr('pathname'); 
	var result = confirm("장바구니를 비우시겠습니까?");
	if(result ==true){
		location.href="allDeleteCart?pathname="+pathname;
	}
}

function allOrder(){
	var num = ${number};
	//alert(num);
	var ct_uids ="";
	for(var i=0;i<num;i++){
		ct_uids+=$("input[name=ct_uid]:eq("+i+")").val()+",";
	}
	location.href="/order/orderForm?ct_uids="+ct_uids;
}

function selectOrder() {
	var num = ${number};
	var ct_uids = "";
	for (var i = 0; i < num; i++) {
		if ($("input[name=ap_check]:eq(" + i + ")").prop("checked")) {
			ct_uids += $("input[name=ap_check]:eq(" + i + ")").val() + ",";
		}
	}
	location.href = "/order/orderForm?ct_uids=" + ct_uids;
}

</script>	
	