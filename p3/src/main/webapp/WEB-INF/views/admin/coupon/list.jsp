<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/admin/couponList.css">  
  

<center>
	
<div class="menuContainer" >
	<div><%@ include file="/WEB-INF/views/admin/include/left_side.jsp" %></div>
	<div class="sideContainer">
		<div class="title">
			<span >쿠폰 목록</span><br>
			<span style="width:800px;border-bottom: 1px solid black"></span>
		</div>
		<div class="deleteBtnContainer"><input type="button" value="선택삭제" class="selectDeleteBtn" onclick="selectDelete()"></div>
		<div class="listContainer">
			<div>
				<input type="checkbox" onclick="allCheck()">
			</div>
			<div class="number">NO</div>
			<div class="cp_number">쿠폰번호</div>
			<div class="point">쿠폰 금액</div>
			<div class="id">보유고객</div>
			<div  class="useyn">사용여부</div>
			<div class="mode">모드</div>
		</div>
		<c:set var="number" value="${0 }"/>
		<c:forEach var="list" items="${list }">
		<form  method="post">
		<div class="itemContainer">
			<div>
				<input type="checkbox" id="ap_check" name="ap_check" value="${list.cp_number }">
				
			</div>
			<div class="number">${number+1 }</div>
			<div class="cp_number">
				${list.cp_number }
				<input type="hidden" name="cp_number" value="${list.cp_number }">
			</div>
			<div class="point"> 
				<input id="point" name="pointCommas" value="${list.point }" class="inputStyle">
			</div>
			<div class="id">
				<input name="id"  value="${list.id }" class="inputStyle">
			</div>
			<div  class="useyn">${list.useyn }</div>
			<div class="mode">
				<button class="registerBtn">쿠폰 부여</button>
				<input type="button" value="쿠폰 삭제" onclick="deleteCoupon('${list.cp_number}')" class="deleteBtn">
			</div>
		</div>
		<c:set var="number" value="${number+1 }" />
		</form>
		</c:forEach>
			<!-- 페이징 추가 -->
		<div style="display: inline-flex;">
			
					<div>
						<a href="list?page=1"><img src="/img/back2.png"></a>
					</div>
					<div><a href="list${pageMaker.makeQuery(pageMaker.startPage - 1)}"><img src="/img/back1.png"></a></div>
		
				<c:set var="number" value="${pageMaker.totalCount - (pageMaker.cri.page - 1) * pageMaker.cri.perPageNum }" />
				<c:forEach var="idx" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
					<div class="pagingBtn" >
						<c:if test="${pageMaker.cri.page == idx}"><b></c:if>
						<%-- <a href="listPage?page=${idx}">${idx}</a> --%>
						<a href="list${pageMaker.makeQuery(idx)}">${idx}</a>
						<c:if test="${pageMaker.cri.page == idx}"></b></c:if>
					</div>
					<c:set var="number" value="${number - 1 }"/> 
					</c:forEach>
					<div><a href="list${pageMaker.makeQuery(pageMaker.endPage +1)}"><img src="/img/front1.png"></a></div>
					<div>
						<c:choose>
							<c:when test="${pageMaker.totalCount % cri.perPageNum ==0}">
								<a href="list${pageMaker.makeQuery(pageMaker.totalCount / cri.perPageNum) }"><img src="/img/front2.png"></a>
							</c:when>
							<c:otherwise>
								<a href="list${pageMaker.makeQuery(pageMaker.totalCount / cri.perPageNum+1) }"><img src="/img/front2.png"></a>
	
							</c:otherwise>
						</c:choose>
					</div>	
				
			</div>
	</div>	
</div>
</center>	

<script>
var num =${number};
//alert(num);
for(var i=0;i<=num;i++){
	var point = $("input[id=point]:eq("+i+")").val();
	var pointComma =  commas(point);
	$("input[id=point]:eq("+i+")").val(pointComma);
}
function commas(number) {
	  return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
function deleteCoupon(cp_number){
	//alert(cp_number);
	var result = confirm("쿠폰을 삭제하시겠습니까?");
	if(result == true){
		location.href="delete?cp_number="+cp_number;
	}
}


function isAllChecked(){
    var checkboxes = document.querySelectorAll("input[id=ap_check]");
    for (var i = 0; i<checkboxes.length; i++) {
        if (!checkboxes[i].checked) {
            return false;
        }
    }
    return true;
}

function allCheck(){
	//var number=${number};
   // alert(number);
    
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

function selectDelete() {
	var number ="${cri.perPageNum}";
	//alert(number);
	var result = confirm("선택된 쿠폰을 삭제하시겠습니까?");
	if(result ==true){
		var cp_numbers = "";
		for (var i = 0; i < number; i++) {
			if ($("input[name=ap_check]:eq("+i+")").prop("checked")) {
				cp_numbers += $("input[name=ap_check]:eq(" + i + ")").val() + ",";
			}
		}
		location.href = "select_delete?cp_numbers=" + cp_numbers;
	}
}
</script>