<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/noticeView.css">

<center>
	<c:if test="${vo.gongji =='qna' }">
		<div style="height:100px;"></div>
		<div class="title">
			<span >1:1문의</span><br>
		</div>
		<div style="height: 30px;"></div>
		<div class="subjectContainer">
			<div class="itemTitle">제목</div>
			<div class="itemContent">${vo.subject }</div>
		</div>	
			<div class="subjectContainer">
			<div class="itemTitle">작성자</div>
			<div class="itemContent">${vo.name }</div>
		</div>
		<div class="secondContainer">
			<div class="itemTitle2"><b>작성일</b></div>
			<div class="itemIn">${vo.signdate }</div>
			<div class="itemTitle2"><b>조회수</b></div>
			<div class="itemIn">${vo.ref }</div>
		</div>
		<div class="commentStyle">
			${fn:replace(vo.comment , LF, '<br>')}
		</div>
		<div class="btnStyle">
			<input type="button" value="목록" class="btnInputStyle" onclick="location.href='list?option=${vo.gongji}'">
		</div>
		<div style="height: 30px;"></div>	
		<div class="endContainer">
			<div class="endTitle">이전글</div>
			<div>
				<c:choose>
					<c:when test="${front.n_uid == null }">
						<div class="fnn">이전글이 없습니다.</div>
					</c:when>
					<c:otherwise>
						<div class="fnn"><a href="view?n_uid=${front.n_uid }&gongji=${front.gongji}">${front.subject }</a></div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="endContainer">
			<div class="endTitle">다음글</div>
			<div>
				<c:choose>
					<c:when test="${next.n_uid == null }">
						<div class="fnn">다음글이 없습니다.</div>
					</c:when>
					<c:otherwise>
						<div class="fnn"><a href="view?n_uid=${next.n_uid }&gongji=${next.gongji}">${next.subject }</a></div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</c:if>
	<c:if test="${vo.gongji =='gongji' }">
		<div style="height:100px;"></div>
		<div class="title">
			<span >공지사항</span><br>
		</div>
		<div style="height: 30px;"></div>
		<div class="subjectContainer">
			<div class="itemTitle">제목</div>
			<div class="itemContent">${vo.subject }</div>
		</div>	
			<div class="subjectContainer">
			<div class="itemTitle">작성자</div>
			<div class="itemContent">${vo.name }</div>
		</div>
		<div class="secondContainer">
			<div class="itemTitle2"><b>작성일</b></div>
			<div class="itemIn">${vo.signdate }</div>
			<div class="itemTitle2"><b>조회수</b></div>
			<div class="itemIn">${vo.ref }</div>
		</div>
		<div class="commentStyle">
			${fn:replace(vo.comment , LF, '<br>')}
		</div>
		<div class="btnStyle">
			<input type="button" value="목록" class="btnInputStyle" onclick="location.href='list?option=${vo.gongji}'">
		</div>
		<div style="height: 30px;"></div>	
		<div class="endContainer">
			<div class="endTitle">이전글</div>
			<div>
				<c:choose>
					<c:when test="${front.n_uid == null }">
						<div class="fnn">이전글이 없습니다.</div>
					</c:when>
					<c:otherwise>
						<div class="fnn"><a href="view?n_uid=${front.n_uid }&gongji=${front.gongji}">${front.subject }</a></div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="endContainer">
			<div class="endTitle">다음글</div>
			<div>
				<c:choose>
					<c:when test="${next.n_uid == null }">
						<div class="fnn">다음글이 없습니다.</div>
					</c:when>
					<c:otherwise>
						<div class="fnn"><a href="view?n_uid=${next.n_uid }&gongji=${next.gongji}">${next.subject }</a></div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</c:if>
</center>	