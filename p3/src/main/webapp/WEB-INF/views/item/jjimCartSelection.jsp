<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<link rel="stylesheet" type="text/css" href ="/css/jjimCartSelection.css">

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.4.1.min.js"></script>

<center>
<div class="title">옵션선택</div>
<div style="height: 15px;"></div>
<div class="allContainer">
	<div class="subject">${vo.subject}</div>	
	<div class="itemContainer">
		<div><img src="/upload/${vo.file1 }" class="imgSize"></div>
		<div class="colorName">컬러</div>
		<div class="colorSelect">
		<c:if test="${color_list != null }">
			<select class="selectBox" onchange="itemSelect(this.value,'${vo.uid }')">
				<option value="">-[필수] 옵션을 선택해주세요</option>
				<c:forEach var="color_list" items="${color_list }">
					<option value=" ${color_list }">${color_list }</option>
				</c:forEach>
			</select>
		</c:if>
		<c:if test="${color_list ==null }">
			<div>${vo.color }</div>
		</c:if>
		</div>
	</div>
	<c:if test="${color_list != null }">
		<div class="introduceOption">위 옵션선택 박스를 선택하시면 아래에 상품이 추가됩니다.</div>
	</c:if>
	<c:set var = "number" value="${0 }"/>	
		<c:forEach var="list" items="${list }">
			<div  class="selectContainer">
				<div class="detailContainer">
					<div class="detailSubject">
						<div class="optionSelectSubject">${vo.subject }</div>
						<div id ="optionColor" class="optionColor">
							-${list.color}<input type="hidden" id="color" value="${list.color }">
						</div>
					</div>
					<div class="qtyContainer">
						<div>
							<input type="hidden" id="price" name="price" value="${list.price }"> 
							<input id ="qty" name="qty" class="qtyStyle"  value="${list.qty }" readonly>
						</div>
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
</div>
<c:if test="${color_list !=null }">
	<div class="totalDiv" >
		<span>TOTAL PRICE</span>
		<span id="wholePrice" class="wholePrice">0</span>
		<span id="wholeQty" class="wholeQty">(0개)</span>
	</div>
</c:if>
<c:if test="${color_list ==null }">
	<div class="totalDiv" >
		<span>TOTAL PRICE</span>
		<span id="wholePrice2" class="wholePrice">${price1 }</span>
		<span id="wholeQty2" class="wholeQty">(1개)</span>
	</div>
</c:if>
<div class="orderbtnDiv">
	<input type="button" class="orderBtn" value="바로 구매하기">
	<input type="button" class="cartBtn" value="장바구니 담기">
</div>
</center>

<script>
function itemSelect(color,uid){
	var num = ${number};
	//alert(num);
	for(var i=0;i<num;i++){
		var colorCheck = $("input[id=color]:eq("+i+")").val();
		//alert(colorCheck);
		if(colorCheck == color){
			alert("아래 리스트에서 이미 선택된 옵션을 삭제 후 다시 선택해 주세요");
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
		var one_price = $("input[name=price]:eq("+i+")").val(); //1개 가격
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
	
	$("#wholePrice").text(order_total.toLocaleString("ko-KR"));
	$("#wholeQty").text("("+total_qty+"개)");

}
calWholePrice();
</script>