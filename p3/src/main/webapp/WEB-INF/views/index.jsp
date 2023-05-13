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


<div style="width: 100vw; height: 1000px; left: 0; top: 0;">
	<div data-vbg-autoplay="true" data-vbg="https://www.youtube.com/watch?v=v_FDNz0Hk_s"></div>
</div>

<div>
	<span class ="itemTitle">Best Item.</span><span>&nbsp;&nbsp;탱그램의 베스트 상품을 소개합니다.</span>
</div>

<div class ="bestItemContainer">
	<c:forEach var="list" items="${bestList }">
		
	</c:forEach>
</div>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>