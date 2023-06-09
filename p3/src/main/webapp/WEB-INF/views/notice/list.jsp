<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<link rel="stylesheet" type="text/css" href ="/css/noticeList.css">

<center>
<c:if test="${option =='faq' }">
	<div style="height:100px;"></div>
	<div class="title">
		<span >FAQ</span><br>
	</div>
	<div style="height: 50px;"></div>
	<div class="tabContainer">
		<div class="tabItem"  onclick="location.href='list?option=faq&faq_type=delivery'" id="delivery">배송·결제·취소</div>
		<div class="tabItem" onclick="location.href='list?option=faq&faq_type=exchange'" id="exchange">교환·반품</div>
		<div class="tabItem" onclick="location.href='list?option=faq&faq_type=as'" id="as">A/S</div>
	</div>
	
	<div  class="tabInContainer">
		<c:set var="n" value="${0 }"/>
		<c:forEach var="list" items="${list }">
			<div class="faqContainer"  onclick="drop_down(${n},${list.fid })">
				<div><b>${list.subject }</b></div>
			</div>
			<div id="drop" name="drop"  class="drop" >${fn:replace(list.comment, LF, '<br>')}</div>
		<c:set var="n" value="${n+1 }"/>
		</c:forEach>
	</div>
	
</c:if>
<c:if test="${option =='qna' }">
	<div style="height:100px;"></div>
	<div class="title">
		<span >1:1문의</span><br>
	</div>
	<div style="height: 40px;border-bottom: 1px solid #E8E8E8;width: 1800px;"></div>

		<c:forEach var="list" items="${list }">
		<div class="qnaContainer">
			<div onclick="view_go(${list.n_uid},'${list.id}','${list.secretset }','${list.o_id }')" style="cursor: pointer;">
				${list.subject }
				<c:if test="${list.secretset =='secret' }">
					<img src="/img/icon_secret.gif" class="lockImg">
				</c:if>
				
				<span class="mnameStyle">
					<c:set var="hiddenName" value="${fn:replace(list.name, fn:substring(list.name, 1, fn:length(name)-1), '***')}" />
					${ hiddenName}
				</span>
			</div>
			<div>
				<c:if test="${list.file1 !=null }"><img src="/upload/${list.file1 }" class="fileImg"></c:if>
			</div>
		</div>
	</c:forEach>
	
</c:if>

<c:if test="${option =='gongji' }">
	<div style="height:100px;"></div>
	<div class="title">
		<span >공지사항</span><br>
	</div>
	<div style="height: 40px;"></div>
	<div class="gongjiTitle">
		<div class="noticeNum">번호</div>
		<div class="noticeSubject">제목</div>
		<div class="noticeWriter">작성자</div>
		<div class="noticeSigndate">작성일</div>
		<div class="noticeRef">조회수</div>
	</div>
	<c:set var = "num" value="${1 }"/>
	<c:forEach var="list" items="${list }">
		<div class="gongjiContent">
			<div class="noticeNum">${num }</div>
			<div class="noticeSubjectContent"><a href="view?n_uid=${list.n_uid }&gongji=${list.gongji}">${list.subject }</a></div>
			<div class="noticeWriter">${list.name }</div>
			<div class="noticeSigndate">${list.signdate }</div>
			<div class="noticeRef">${list.ref }</div>
		</div>
		<c:set var="num" value="${num+1 }" />
	</c:forEach>
</c:if>
</center>	
<script>
var faq_type="${faq_type}";
$(".tabContainer > div").removeClass("tabBtn");
$("#"+faq_type).addClass("tabBtn");


function drop_down(num, fid) {
	//alert(num);
	//alert(fid);
	if($("div[id=drop]:eq("+num+")").css("display") == "none"){
		$("div[id=drop]:eq("+num+")").slideDown();
	
	}else{
		$("div[id=drop]:eq("+num+")").slideUp();
		
	}
}

function view_go(uid, id, secret,o_id) {
	var m_id = "${m_id}";
	var level = ${level};
	var gongji="${gongji}";
	
	if(secret == 'secret'){
		//alert("a");
		if(m_id != null && (m_id == o_id || m_id == id || level == 10)){
			location.href = "view?n_uid=" + uid;
		}else{
			alert("관리자와 작성자만 확인할 수 있습니다.");
			return false;
		}
	}
	location.href = "view?n_uid=" + uid+"&gongji="+gongji;
}

</script>
