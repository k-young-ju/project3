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
			<a href="list?sorted=review&option=${map.option }">상품후기</a>
		</div>
	</div>
	
	<div class="itemContainer">
		<c:forEach var="list" items="${list }">
			<div class="item">
				<div class="imgItem"><a href="view?uid=${list.uid }"><img src = "/upload/${list.file1 }" class="imgDesign"></a></div>
				<div class="itemSubject"><a href="view?uid=${list.uid }">${list.subject }</a></div>
				<div>${list.comment }</div>
				<div class="itemPrice"><fmt:formatNumber value="${list.price }" pattern="#,###"/></div>
			</div>
		</c:forEach>
	</div>
	
	<div style="height:30px;"></div>
	<!-- 페이징 추가 -->
<div style="display: inline-flex;">
		<%-- <c:if test="${pageMaker.prev}"> --%>
			<div>
				<a href="list?page=1"><img src="/img/back2.png"></a>
			</div>
			<div><a href="list${pageMaker.makeQuery(pageMaker.startPage - 1)}"><img src="/img/back1.png"></a></div>
		<%-- </c:if> --%>
		<c:set var="number" value="${pageMaker.totalCount - (pageMaker.cri.page - 1) * pageMaker.cri.perPageNum }" />
		<c:forEach var="idx" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
			<div class="pagingBtn">
				<c:if test="${pageMaker.cri.page == idx}"><b></c:if>
				<%-- <a href="listPage?page=${idx}">${idx}</a> --%>
				<a href="list${pageMaker.makeQuery(idx)}">${idx}</a>
				<c:if test="${pageMaker.cri.page == idx}"></b></c:if>
			</div>
			<c:set var="number" value="${number - 1 }"/> 
		</c:forEach>

		<%-- <c:if test="${pageMaker.next && pageMaker.endPage > 0}"> --%>
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
		<%-- </c:if> --%>
	
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
</script>