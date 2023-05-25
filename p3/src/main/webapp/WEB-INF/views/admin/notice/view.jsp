<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/admin/adminNoticeWrite.css">

<center>
<div class="menuContainer" >
	<div><%@ include file="/WEB-INF/views/admin/include/left_side.jsp" %></div>
	<div  class="contentContainer">
		<div class="title">
			<span >1:1문의</span><br>
		</div>
		<form name="modify"  method="post"   enctype="multipart/form-data">
			
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
					<img src="/upload/${one.file1 }" class="imgSize">
					<input type="hidden"  id="file1" name="file1" value="${one.file1 }" >
				</div>
			</div>
			<div style="height: 20px;"></div>	
			<div>
				<input type="button" class="writeOkBtn" value="답변달기"  onclick="location.href='reply?n_uid=${one.n_uid}'">
				<input type="button" value="글 삭제" class="deleteBtn" onclick="location.href='delete?n_uid=${one.n_uid}&option=${one.gongji }'">
			</div>
		</form>
	</div>
</div>
</center>