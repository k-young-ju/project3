<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/admin/adminNoticeList.css">

<center>
<div class="menuContainer" >
	<div><%@ include file="/WEB-INF/views/admin/include/left_side.jsp" %></div>
	<div class="contentContainer">
		<c:if test="${option =='faq' }">
		<div class="title">
			<span >FAQ 목록</span><br>
			
		</div>
		<div class="faqTitleContainer">
			<div class="numbering">NO</div>
			<div class="faqType">faq 유형</div>
			<div class="subject">제목</div>
			<div class="writer">작성자</div>
			<div class="date1">작성일</div>
		</div>
		<c:set var="num" value="${1 }" />
		<c:forEach var="list" items="${list }">
		<div class="faqContainer">
			<div class="numbering">${num }</div>
			<div class="faqType">${list.faq_type }</div>
			<div class="subject"><a href="modify?n_uid=${list.n_uid }">${list.subject }</a></div>
			<div class="writer">${list.id }</div>
			<div class="date1">${list.signdate }</div>
		</div>
		<c:set var="num" value="${num+1 }"/>
		</c:forEach>
		</c:if>
		<c:if test="${option =='qna' }">
			<div class="title" >
			<span >Q&A 목록</span><br>
			
			</div>
			<div class="faqTitleContainer" >
				<div class="numbering">NO</div>
				<div class="subject">제목</div>
				<div class="writer">작성자</div>
				<div class="date1">작성일</div>
				<div class="status">처리여부</div>
				<div class="redate">처리일자</div>
			</div>
			<c:set var="num" value="${1 }" />
			<c:forEach var="list" items="${list }">
			<div class="faqContainer">
				<div class="numbering">${num }</div>
				<div class="subject">
					<a href="view?n_uid=${list.n_uid }">${list.subject }</a>
					<c:if test="${list.secretset =='secret' }">
						<img src="/img/icon_secret.gif" class="lockImg">
					</c:if>
				</div>
				<div class="writer">${list.id }</div>
				<div class="date1">${fn:substring(list.signdate,0,10) }</div>
				<div class="status">${list.status }</div>
				<div class="redate">${fn:substring(list.re_date,0,10) }</div>
			</div>
			<c:set var="num" value="${num+1 }"/>
		</c:forEach>
		</c:if>
		<c:if test="${option =='gongji' }">
			<div class="title" >
				<span >공지 목록</span><br>
			</div>
			<div class="faqTitleContainer" >
				<div class="numbering">NO</div>
				<div class="subject">제목</div>
				<div class="writer">작성자</div>
				<div class="date1">작성일</div>
		</div>
		<c:set var="num" value="${1 }" />
		<c:forEach var="list" items="${list }">
		<div class="faqContainer">
			<div class="numbering">${num }</div>
			<div class="subject"><a href="modify?n_uid=${list.n_uid }">${list.subject }</a></div>
			<div class="writer">${list.name }</div>
			<div class="date1">${list.signdate }</div>
		</div>
		<c:set var="num" value="${num+1 }"/>
		</c:forEach>
		</c:if>
		<c:if test="${option != 'qna' }">
		<div class="btnContainer">
			<input type="button" value="글쓰기" class="writeBtn" onclick="location.href='write?option=${option}'">
		</div>
		</c:if>
	</div>
</div>
</center>	

<script>
var msg ="${msg}"
if(msg !=''){
	alert(msg);
}
</script>