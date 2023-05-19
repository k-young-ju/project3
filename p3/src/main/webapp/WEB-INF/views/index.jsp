<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 


<%@ include file="/WEB-INF/views/include/header.jsp" %>

 <link rel="stylesheet" type="text/css" href ="/css/index.css">
<script src="https://unpkg.com/youtube-background@1.0.14/jquery.youtube-background.min.js"></script>

<script>
  $(document).ready(function() {
    $('[data-vbg]').youtube_background(); // 실행
  });
  
  var msg = "${msg}";

  if(msg != ''){
  	alert(msg);
  }
 
</script>

<center>

<div style="width: 100vw; height: 800px; left: 0; top: 0;">
	<div data-vbg-autoplay="true" data-vbg="https://www.youtube.com/watch?v=v_FDNz0Hk_s"></div>
</div>
<div style="height:200px;"></div>
<div class="bestItemTitle">
	<span class ="itemTitle">Best Item.</span><span>&nbsp;&nbsp;탱그램의 베스트 상품을 소개합니다.</span>
</div>

<div class="bestItemContainer">
	<div class="bestItemTitle2">Best 1</div>
	<div class="bestItemTitle2">Best 2</div>
	<div class="bestItemTitle2">Best 3</div>
</div>

<div class ="bestItemContainer">
	<c:forEach var="list" items="${bestList }">
			<div class="bestIteminItem">
				<div><a href="/item/view?uid=${list.uid }"><img src = "/upload/${list.file1 }" class="mainImgSize"></a></div>
				<div class="bestItemSubject"><a href="/item/view?uid=${list.uid}">${list.subject }</a></div>
				<div class="bestItemComment">${list.comment }</div>
				<div class="bestItemPrice"><fmt:formatNumber value="${list.price }" pattern="#,###"/></div>
			</div>
			<div></div>
			<div></div>
	</c:forEach>
</div>

</center>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>