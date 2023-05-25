<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/admin/adminNoticeWrite.css">

<center>
<div class="menuContainer" >
	<div><%@ include file="/WEB-INF/views/admin/include/left_side.jsp" %></div>
	<div  class="contentContainer">
		<div class="title">
			<span >게시글 수정</span><br>
		</div>
		<form name="modify"  method="post"   enctype="multipart/form-data">
			<div class="noticeContainer">
				<div class="noticeType">게시글 종류</div>
				<div class="radioType">
					<input type="radio" name="gongji" value="gongji"  onclick="faqTypeCh('gongji')" <c:if test="${one.gongji =='gongji' }">checked</c:if>>공지글
					<input 	type="radio" name="gongji" value="faq"  onclick="faqTypeCh('faq')" <c:if test="${one.gongji =='faq' }">checked</c:if>>FAQ
				</div>
			</div>
			
			<div class="faqType" id="faqType" >
				<div class="noticeType">faq 타입</div>
				<div  class="radioType">
					<select name="faq_type">
						<option value="배송·결제·취소" <c:if test="${one.faq_type =='배송·결제·취소' }">selected</c:if>>배송·결제·취소</option>
						<option value="교환·반품" <c:if test="${one.faq_type =='교환·반품' }">selected</c:if>>교환·반품</option>
						<option value="A/S" <c:if test="${one.faq_type =='A/S' }">selected</c:if>>A/S</option>
					</select>
				</div>
			</div>
			<div class="noticeContainerInfo">
				<div class="noticeType">제목</div>
				<div>
					<input id="subject" name="subject" value="${one.subject }" class="noticeInput"   required>
				</div>
			</div>
			<div class="noticeCommentContainerInfo">
				<div class="commentType">내용</div>
				<div>
					<textarea name="comment"  class="textStyle" required>${one.comment }</textarea>
				</div>
			</div>
			<div class="noticeContainerInfo">
				<div class="noticeType">첨부파일</div>
				<div class="radioType">
					<c:if test="${file1 != null }"><img src="/upload/${one.file1 }" class="imgSize"></c:if>
					<input multiple="multiple" type="file" id="file" name="file" >
				</div>
			</div>
			<div style="height: 20px;"></div>	
			<div>
				<button class="writeOkBtn">게시글 수정</button>
				<input type="button" value="글 삭제" class="deleteBtn" onclick="location.href='delete?n_uid=${one.n_uid}&option=${one.gongji }'">
			</div>
		</form>
	</div>
</div>
</center>

<script>
var checkGongji = "${one.gongji}";
if(checkGongji =='faq'){
	faqTypeCh('faq');
}

function faqTypeCh(str){
	
		if(str =='gongji'){
			$("#faqType").removeClass("faqhidden");
		}else{
			$("#faqType").addClass("faqhidden");
		}
}
	


</script>