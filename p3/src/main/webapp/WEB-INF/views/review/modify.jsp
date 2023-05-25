<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<link rel="stylesheet" type="text/css" href ="/css/reviewWrite.css">
<script type="text/javascript" src="/smartEditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<center>
<form method="post" enctype="multipart/form-data">
	<div style="height:100px;"></div>
	<div class="title">
		<span >상품 문의</span><br>
	</div>
	<div class="titleCommnet">1:1문의입니다.</div>
	<div class="itemContainer" id="result">
		<div >
			<img src="/upload/${item.file1 }" class="imgStyle">
			
		</div>
		<div class="itemInfo">
			<div class="">${item.subject }</div>
			<div class="priceInfo">${item.price }</div>
			<div class="btnStyle">
				<input type="button" value="상품상세보기" class="viewBtn"   onclick="location.href='/item/view?uid=${item.uid}'">
				<input type="button" value="상품정보선택" class="itemInfoBtn" onclick="itemInfo()">
			</div>
		</div>
	</div >
	
	<div class="subjectContainer">
		<div class="subjectItem">제목</div>
		<div>
			<input name="subject" class="subjectInputStyle" value="${vo.subject }" required>
			<input type="hidden" name="uid" value="${vo.uid }">
		</div>
	</div>
	<div class="scoreContainer">
		<div class="subjectItem">평점</div>
		<div>
			<input type="radio" name="score" value="5" <c:if test="${vo.score==5 }">checked</c:if>>★★★★★
			<input type="radio" name="score" value="4" <c:if test="${vo.score==4 }">checked</c:if>>★★★★
			<input type="radio" name="score" value="3" <c:if test="${vo.score==3 }">checked</c:if>>★★★
			<input type="radio" name="score" value="2" <c:if test="${vo.score==2 }">checked</c:if>>★★
			<input type="radio" name="score" value="1" <c:if test="${vo.score==1 }">checked</c:if>>★
		</div>
	</div>
	<div class="row">
	
		<!-- 네이버 스마트 에디터 적용 -->
	    <textarea name="comment"  id="comment"  rows="10" cols="100" style="width: 1800px;height: 500px;" >${vo.comment }</textarea>
	 	    
	</div>
	<div class="fileContainer">
		<div class="subjectItem">첨부파일</div>
		<c:if test="${vo.file1 !=null }"><img src="/upload/${vo.file1 }"></c:if>
		<div class="fileItem"><input multiple="multiple" type="file" name="file"></div>
	</div>
	<div style="height: 30px;"></div>
	<div class="btnContainer">
		<div class="listBtn">
			<input value="목록" class="listGo" onclick="location.href='list'">
		</div>
		<div class="writeBtn">
			<button class="writeGo">수정</button>
		</div>
	</div>
	
	</form>
	
	
</center>	

<script>
function itemInfo(){
	window.open("/item/itemSearch","a","width=600 height=450");
	
}


</script>

<script type="text/javascript">
// var oEditors = [];
// nhn.husky.EZCreator.createInIFrame({
//  oAppRef: oEditors,
//  elPlaceHolder: "comment",
//  sSkinURI: "/smartEditor/SmartEditor2Skin.html",
//  fCreator: "createSEditor2"
// });
</script>
