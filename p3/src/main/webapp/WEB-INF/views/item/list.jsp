<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<link rel="stylesheet" type="text/css" href ="/css/itemList.css">


<center>

	<div style="height:100px;"></div>
	<div class="title">
		<span >Product</span><br>
	</div>
	
	<div class="menuContainer">
		<div><input type="button"  id="all" name="All" value="All" class="allDesign" onclick="location.href='list'"></div>
		<div><input type="button" id="L" name="Lighting" value="Lighting AETHER" class="LightingDesign" onclick="location.href='list?option=L'"></div>
		<div><input type="button" id="R" name="SmartRope" value="SmartRope" class="SmartRopeDesign" onclick="location.href='list?option=R'"></div>
	</div>
	<div style="height:70px;"></div>
	
	<div id="container" >
		<div class="countItem" ><b>${pageMaker.totalCount }</b>&nbsp;ITEMS</div>
		<div class="sortBtn">
			<a href="list?sorted=new&option=${map.option }">신상품</a>&nbsp;|
			<a href="list?sorted=named&option=${map.option }">상품명</a>&nbsp;|
			<a href="list?sorted=rowPrice&option=${map.option }">낮은가격</a>&nbsp;|
			<a href="list?sorted=highPrice&option=${map.option }">높은가격</a>&nbsp;|
		</div>
	</div>
	
	<div class="itemContainer">
		<c:set var="num" value="${0 }"/>
		<c:forEach var="list" items="${list }">
			<div class="item">
				<div class="imgItem"><a href="view?uid=${list.uid }"><img src = "/upload/${list.file1 }" class="imgDesign"></a></div>
				<div class="itemSubject"><a href="view?uid=${list.uid }">${list.subject }</a></div>
				<div>${list.comment }</div>
				<div class="itemPrice"  >
					<div id="itemPrice"><fmt:formatNumber value="${list.price }" pattern="#,###"/>
					<input type="hidden" id="qty" name="qty" value="${list.qty }"></div>
					<div><c:if test="${list.qty ==0}">품절</c:if></div>
				</div>
			</div>
			<c:set var="num" value="${num+1 }"/>
		</c:forEach>
	</div>
	
	<div style="height:30px;"></div>
	<!-- 페이징 추가 -->
<div style="display: inline-flex;">
	<div>
		<a href="list?page=1"><img src="/img/back2.png"></a>
	</div>
	<div><a href="list${pageMaker.makeQuery(pageMaker.startPage - 1)}"><img src="/img/back1.png"></a></div>
	
	<c:set var="number" value="${pageMaker.totalCount - (pageMaker.cri.page - 1) * pageMaker.cri.perPageNum }" />
	<c:forEach var="idx" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
		<div class="pagingBtn">
			<c:if test="${pageMaker.cri.page == idx}"><b></c:if>
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

</center>

<script>
var option ="${option}";

if(option =='R'){
	$("#R").addClass("active");
}else if(option =='L'){
	$("#L").addClass("active");	
}else{
	$("#all").addClass("active");
}

var num = ${num};
//alert(num);
for (var i = 0; i < num; i++) {
	var qty = $("input[name=qty]:eq("+i+")").val();
	if (qty == 0) {
	 $("div[id=itemPrice]:eq("+i+")").css("text-decoration", "line-through");
	}
}

</script>