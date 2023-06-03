<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<link rel="stylesheet" type="text/css" href ="/css/noticeWrite.css">
<script type="text/javascript" src="/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<center>
<form method="post" onsubmit="write_go()">
	<div style="height:100px;"></div>
	<div class="title">
		<span >상품 문의</span><br>
	</div>
	<div class="titleCommnet">1:1문의입니다.</div>
	<div class="itemContainer" id="result">
		<div >
			<img src="/upload/${vo.file1 }" class="imgStyle">
			<input type="hidden" name="file1" value="${vo.file1 }">
		</div>
		<div class="itemInfo">
			<div class="subjectInfo">${vo.subject }</div>
			<div class="priceInfo"><b>${vo.price }</b></div>
			<div class="btnStyle">
				<input type="button" value="상품상세보기" class="viewBtn"   onclick="location.href='/item/view?uid=${vo.uid}'">
				<input type="button" value="상품정보선택" class="itemInfoBtn" onclick="itemInfo()">
			</div>
		</div>
	</div >
	
	<div class="subjectContainer">
		<div class="subjectItem">제목</div>
		<div>
			<input name="subject" class="subjectInputStyle" required>
			<input type="hidden" name="uid" value="${vo.uid }">
			<input type="hidden" name="gongji" value="qna">
		</div>
	</div>
	<div class="row" >
		<!-- 네이버 스마트 에디터 적용 -->
	    <textarea name="comment"  id="comment"  rows="10" cols="100" style="width: 1800px;height: 500px;"  ></textarea>
	     
	    <div class="radioStyle">
	    	<div class="subjectItem">비밀글 설정</div>
	    	<div>
		    	<input type="radio" name="secretset" value="normal" checked>공개글
		    	<input type="radio" name="secretset" value="secret">비밀글
	    	</div>
	    </div>
	</div>
	<div class="btnContainer">
		<div class="listBtn">
			<input value="목록" class="listGo" onclick="location.href='list?option=qna'">
		</div>
		<div class="writeBtn">
			<button class="writeGo">등록</button>
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
	var oEditors = [];
	
	smartEditor = function(){
		console.log("naver editor");
		nhn.husky.EZCreator.createInIFrame({
			 oAppRef: oEditors,
			 elPlaceHolder: "comment",
			 sSkinURI: "/editor/SmartEditor2Skin.html",
			 fCreator: "createSEditor2"
		});
	}
	$(document).ready(function(){
		smartEditor();
		
	})
	
function write_go(){
		oEditors.getById["comment"].exec("UPDATE_CONTENTS_FIELD", []);  
		//스마트 에디터 값을 텍스트컨텐츠로 전달
		//alert(document.getElementById("comment").value); 
				// 값을 불러올 땐 document.get으로 받아오기
		return; 
}
	
</script>
