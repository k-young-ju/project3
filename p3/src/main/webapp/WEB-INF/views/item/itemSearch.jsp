<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<link rel="stylesheet" type="text/css" href ="/css/itemSearch.css">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.4.1.min.js"></script>

<center>
<div class="title">상품검색</div>
<div style="height: 15px;"></div>
<form action="" method="get">
	<div class="searchContainer">
			<div >
				<select name="searchTitle" class="searchSelect">
					<option value="itemName">상품명</option>
				</select>
			</div>
			<div>
				<input name="keyword" class="searchInput" value="${cri.keyword }" required>
			</div>
			<div>
				<button class="searchBtn">검색하기</button>
			</div>
	</div>
</form>	
<div class="middleContainer">
	<div class="countSearch">총<c:if test="${pageMaker.totalCount == null }">0</c:if>${pageMaker.totalCount }개의 상품이 검색되었습니다.</div>
	<div class="pageSelect">
		<select name="perPageNum" onchange="change(this.value)">
			<option value="1" <c:if test="${pageMaker.cri.perPageNum == 1}">selected</c:if>>1개</option>
			<option value="2" <c:if test="${pageMaker.cri.perPageNum == 2}">selected</c:if>>2개</option>
			<option value="4" <c:if test="${pageMaker.cri.perPageNum == 4}">selected</c:if>>4개</option>
			<option value="5" <c:if test="${pageMaker.cri.perPageNum == 5}">selected</c:if>>5개</option>
			<option value="10" <c:if test="${pageMaker.cri.perPageNum == 9}">selected</c:if>>9개</option>
		</select>
		<input type="hidden" name="page" value=1>
	</div>
</div>
<div class="listTitle">
	<div class="itemImg">상품이미지</div>
	<div class="itemInfo">상품정보</div>
	<div class="selectItem">선택</div>
</div>	
<c:forEach var="list" items="${list }">
<div class="listContent">
	<div class="itemImg"><img src="/upload/${list.file1 }" class="imgSize"></div>
	<div class="itemInfo">
		<div>${list.subject }</div>
		<div><b>${list.price }</b></div>
	</div>
	<div class="selectItem">
		<input type="button" value="선택" class="btnStyle" onclick="itemSelect(${list.uid})">
	</div>
</div>
</c:forEach>
<div style="height: 10px;"></div>
<!-- 페이징 추가 -->
<div style="display: inline-flex;">
		<%-- <c:if test="${pageMaker.prev}"> --%>
			<div>
				<a href="itemSearch${pageMaker.makeSearch(pageMaker.startPage)}"><img src="/img/back2.png"></a>
			</div>
			<div><a href="itemSearch${pageMaker.makeSearch(pageMaker.startPage - 1)}"><img src="/img/back1.png"></a></div>
		<%-- </c:if> --%>
		<c:set var="number" value="${count - (pageMaker.cri.page - 1) * pageMaker.cri.perPageNum }" />
		<c:forEach var="idx" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
			<div class="pagingBtn">
				<c:if test="${pageMaker.cri.page == idx}"><b></c:if>
				<%-- <a href="listPage?page=${idx}">${idx}</a> --%>
				<a href="itemSearch${pageMaker.makeSearch(idx)}">${idx}</a>
				<c:if test="${pageMaker.cri.page == idx}"></b></c:if>
			</div>
			<c:set var="number" value="${number - 1 }"/> 
		</c:forEach>

		<%-- <c:if test="${pageMaker.next && pageMaker.endPage > 0}"> --%>
			<div><a href="itemSearch${pageMaker.makeSearch(pageMaker.endPage +1)}"><img src="/img/front1.png"></a></div>
			<div>
				<c:choose>
					<c:when test="${count % cri.perPageNum ==0}">
						<a href="itemSearch${pageMaker.makeSearch(count / cri.perPageNum) }"><img src="/img/front2.png"></a>
					</c:when>
					<c:otherwise>
						<a href="itemSearch${pageMaker.makeSearch(count / cri.perPageNum+1) }"><img src="/img/front2.png"></a>
						
					</c:otherwise>
				</c:choose>
			</div>	
		<%-- </c:if> --%>
	
</div>
</center>

<script>
function itemSelect(uid){
	//alert(uid);
	opener.parent.location="/notice/write?uid="+uid;
	window.close();
}

var searchTitle = "${cri.searchTitle}";
var keyword = "${cri.keyword}";

//alert(searchTitle);
//alert(keyword);

function change(ppn){
		location.href="itemSearch?page=1&perPageNum="+ppn+"&searchTitle="+searchTitle+"&keyword="+keyword;
		
}
</script>