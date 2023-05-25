<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/admin/noticeReply.css">

<center>
<div class="menuContainer" >
	<div><%@ include file="/WEB-INF/views/admin/include/left_side.jsp" %></div>
	<div  class="contentContainer">
		<div class="title">
			<span >1:1문의</span><br>
		</div>
		
			<div class="customInfo">고객문의 정보</div>
			<div class="noticeContainerInfo">
				<div class="noticeType">제목</div>
				<div>
					<input value="${one.subject }" class="noticeInput"   readonly>
				</div>
			</div>
			<div class="noticeCommentContainerInfo">
				<div class="commentType">내용</div>
				<div>
					<textarea class="textStyle" readonly>${one.comment }</textarea>
				</div>
			</div>
			<div class="noticeContainerInfo">
				<div class="noticeType">첨부파일</div>
				<div class="radioType">
					<img src="/upload/${one.file1 }" class="imgSize">
					<input type="hidden"  id="file1" name="file1" value="${one.file1 }" >
				</div>
			</div>
			<form name="modify"  method="post"  >
			<div class="customInfo">
				답변기입란
				<input type="hidden" name="fid" value="${one.fid }">
				<input type="hidden" name="secretset" value="${one.secretset }">
				<input type="hidden" name="o_id" value="${one.id }">
				<input type="hidden" name="thread" value="${one.thread }">
				<input  type="hidden" name="gongji" value="${one.gongji }">
			</div>	
			<div class="noticeContainerInfo">
				<div class="noticeType">제목</div>
				<div>
					<input class="noticeInput"  id="subject" name="subject" required>
				</div>
			</div>
			<div class="noticeCommentContainerInfo">
				<div class="commentType">내용</div>
				<div>
					<textarea class="textStyle" id="comment" name="comment" required></textarea>
				</div>
			</div>
			<div>	
				<button class="writeOkBtn">답변등록</button>
				<input type="button" value="취소" class="deleteBtn" onclick="location.href='list?n_uid=${one.n_uid}&option=${one.gongji }'">
			</div>
		</form>
	</div>
</div>
</center>