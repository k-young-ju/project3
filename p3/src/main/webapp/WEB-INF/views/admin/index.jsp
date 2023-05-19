<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/admin/adminIndex.css">

<center>
<div class="menuContainer" >
	<div><%@ include file="/WEB-INF/views/admin/include/left_side.jsp" %></div>
	<div id="result"></div>
</div>

</center>

<script>


var msg = "${msg}";

if(msg != ''){
	alert(msg);
}


// function menuInfo(str){
// 	if(str =='memberAdd'){
// 		//alert(str);
// 		$.ajax({
// 			url: "/admin/member/join", //전송받을 페이지 경로
// 			type: "get", //데이터 읽어오는 방식
// 			dataType: "text", //데이터 방식
// 			//data: "code="+str, //데이터 전달
// 			error:function(){ //실패일 경우
// 				alert("실패");
// 			},
// 			success:function(text){ //성공일 경우
// 				$("#result").html(text);
// 			}
// 		});
// }
</script>