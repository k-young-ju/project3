<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/reviewView.css">

<center>
	
		<div style="height:100px;"></div>
		<div class="title">
			<span >Review</span><br>
		</div>
		<div style="height: 30px;"></div>
		<div class="itemContainer" >
			<div >
				<img src="/upload/${item.file1 }" class="imgStyle">
				<input type="hidden" name="file1" value="${item.file1 }">
			</div>
			<div class="itemInfo">
				<div class="itemSubject">${item.subject }</div>
				<div class="priceInfo">${item.price }</div>
				<div class="btnStyle">
					<input type="button" value="상품상세보기" class="viewBtn"   onclick="location.href='/item/view?uid=${item.uid}'">
					
				</div>
			</div>
		</div >
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
			<div class="itemTitle2"><b>평점</b></div>
			<div class="itemIn">
				<c:if test="${vo.score==5 }">★★★★★</c:if>
			<c:if test="${vo.score==4 }">★★★★☆</c:if>
			<c:if test="${vo.score==3 }">★★★☆☆</c:if>
			<c:if test="${vo.score==2 }">★★☆☆☆</c:if>
			<c:if test="${vo.score==1 }">★☆☆☆☆</c:if>
			</div>
			
			
		</div>
		<div class="commentStyle">
			${fn:replace(vo.comment , LF, '<br>')}
			<c:if test="${vo.file1 !=null }"><img src="/upload/${vo.file1 }" class="commentImg"></c:if>
		</div>
		
		<div class="btnStyle">
			<input type="button" value="목록" class="btnInputStyle" onclick="location.href='list'">
			<c:if test="${vo.id ==sessionScope.m_id }">
				<input type="button" value="수정" class="btnInputStyle" onclick="location.href='modify?r_uid=${vo.r_uid}&uid=${vo.uid }'">
			</c:if>
		</div>
		<div style="height: 30px;"></div>	
				
	
</center>	
<%@ include file="/WEB-INF/views/include/footer.jsp" %>