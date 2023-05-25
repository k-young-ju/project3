<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/admin/adminNoticeWrite.css">

<center>
<div class="menuContainer" >
	<div><%@ include file="/WEB-INF/views/admin/include/left_side.jsp" %></div>
	<div>
		<div class="title">
			<span >게시글 작성</span><br>
		</div>
		<form name="write"  method="post"  enctype="multipart/form-data">
			<div class="noticeContainer">
				<div class="noticeType">게시글 종류</div>
				<div class="radioType">
					<input type="radio" name="gongji" value="gongji" onclick="faqTypeCh('gongji')" checked >공지글
					<input 	type="radio" name="gongji" value="faq" onclick="faqTypeCh('faq')">FAQ
				</div>
			</div>
			
			<div class="faqType" id="faqType">
				<div class="noticeType">faq 타입</div>
				<div  class="radioType">
					<select name="faq_type">
						<option value="배송·결제·취소" selected>배송·결제·취소</option>
						<option value="교환·반품">교환·반품</option>
						<option value="A/S">A/S</option>
					</select>
				</div>
			</div>
			<div class="noticeContainerInfo">
				<div class="noticeType">제목</div>
				<div>
					<input id="subject" name="subject" class="noticeInput"   required>
				</div>
			</div>
			<div class="noticeCommentContainerInfo">
				<div class="commentType">내용</div>
				<div>
					<textarea name="comment" class="textStyle" required></textarea>
				</div>
			</div>
			<div class="noticeContainerInfo">
				<div class="noticeType">첨부파일</div>
				<div class="radioType">
					<input multiple="multiple" type="file" id="file" name="file" >
				</div>
			</div>
			<div style="height: 20px;"></div>	
			<div>
				<button class="writeOkBtn">게시글 등록</button>
			</div>
		</form>
	</div>
</div>
</center>
<script>
function faqTypeCh(str){
	//alert(str);
	if(str =='gongji'){
		$("#faqType").removeClass("faqhidden");
	}else{
		$("#faqType").addClass("faqhidden");
	}
}
</script>