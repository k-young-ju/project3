<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<link rel="stylesheet" type="text/css" href ="/css/colorSelect.css">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<div class="selectContainer">
	<div class="detailContainer">
		<div class="detailSubject">
			<div>제목</div>
			<div>-색상</div>
		</div>
		<div class="qtyContainer">
			<div><input id ="qty" name="qty" class="qtyStyle"  value="1"></div>
			<div class="qtyBtn">
				<div><img src="/img/qtyPlus.png" class="qtyBtnStyle" onclick="qty_num('+')"></div>
				<div><img src="/img/qtyMinus.png" class="qtyBtnStyle" onclick="qty_num('-')"></div>
			</div>
		</div>
		<div class="priceStyle">가격</div>
	</div>
</div>

<script>

var num =parseInt(qty.value);
//alert(num);
	
	function qty_num(str){
		if(str =='-'){
			if(num==1){
				alert("최소 주문수량은 1개입니다.");
				
			}else{
			qty.value = num-1;
				
			}
		}else{
		qty.value= num+1;
		}
	}
</script>