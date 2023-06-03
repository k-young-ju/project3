<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href ="/css/admin/memberList.css">  
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>

<center>
<div class="menuContainer" >
	<div><%@ include file="/WEB-INF/views/admin/include/left_side.jsp" %></div>
	<div>
		<form name="Form1">
		<div class="title">
			<span >회원목록</span><br>
			
		</div>
		
		<div class="selectContainer">
			<div class="selectItem" onclick="location.href='list?option=all'">전체회원</div>
			<div class="selectItem" onclick="location.href='list?option=remain'">기존회원</div>
			<div class="selectItem" onclick="location.href='list?option=delete'">탈퇴한회원</div>
		</div>
		<div class="optionContainer">
			<div class="optionItem" onclick="levelAllChange()">회원등급일괄변경</div>
			<div class="optionItem" onclick="select_delete()">선택삭제</div>
		</div>
		
		<div class="memberCount">회원수 : ${pageMaker.totalCount }명</div>
		
		<div class="listContainer" >
			<div style="background-color: black;"><input type = "checkbox" name = "all" value="checkbox" onclick = "checkall()"></div>
			<div class="memberType">회원타입</div>
			<div class="id" >아이디</div>
			<div class="name" >이름</div>
			<div class="level" >회원등급</div>
			<div class="point">보유 포인트</div>
			<div class="phone">전화번호</div>
			<div class="email">이메일</div>
			<div class="mode">모드</div>
		</div>
		<c:set var="number" value="${0 }"/>
		<c:forEach var="list" items="${list }">
		<div class="listContainer" >
			<div ><input type ="checkbox" name ="ap_check" value="${list.id }"></div>
			<div class="memberType2" >
				<c:if test="${list.level==1}">개인회원</c:if>
				<c:if test="${list.level ==5}">법인회원</c:if>
				<c:if test="${list.level==10 }">관리자</c:if>
			</div>
			<div class="id2"  id="id">${list.id }</div>
			<div class="name2" >${list.name }</div>
			<div class="level2" >
				<select name="level">
					<option value="10" <c:if test="${list.level ==10 }">selected</c:if>>10</option>
					<option value="5" <c:if test="${list.level ==5 }">selected</c:if>>5</option>
					<option value="1" <c:if test="${list.level ==1 }">selected</c:if>>1</option>
				</select>	
			</div>
			<div class="point2">
				<fmt:formatNumber value="${list.point }" pattern="#,###"/>
				<input type="button" value="사용내역조회" class="pointBtn" onclick="location.href='viewPoint?id=${list.id}'"> 
			</div>
			<div class="phone2">${list.phone }</div>
			<div class="email2">${list.email }</div>
			<div class="mode2"  >
				<input type="button" value="수정" class="modifyBtn" onclick="location.href='modify?id=${list.id}'">
			</div>
			
		</div>
		<c:set var="number" value="${number+1 }"/>
		</c:forEach>
		</form>
			<!-- 페이징 추가 -->
		<div style="display: inline-flex;">
			
					<div>
						<a href="list?page=1&option=${option}"><img src="/img/back2.png"></a>
					</div>
					<div><a href="list${pageMaker.makeQuery(pageMaker.startPage - 1)}&option=${option}"><img src="/img/back1.png"></a></div>
		
				<c:set var="number" value="${pageMaker.totalCount - (pageMaker.cri.page - 1) * pageMaker.cri.perPageNum }" />
				<c:forEach var="idx" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
					<div class="pagingBtn" >
						<c:if test="${pageMaker.cri.page == idx}"><b></c:if>
						<%-- <a href="listPage?page=${idx}">${idx}</a> --%>
						<a href="list${pageMaker.makeQuery(idx)}&option=${option}">${idx}</a>
						<c:if test="${pageMaker.cri.page == idx}"></b></c:if>
					</div>
					<c:set var="number" value="${number - 1 }"/> 
					</c:forEach>
					<div><a href="list${pageMaker.makeQuery(pageMaker.endPage +1)}&option=${option}"><img src="/img/front1.png"></a></div>
					<div>
						<c:choose>
							<c:when test="${pageMaker.totalCount % cri.perPageNum ==0}">
								<a href="list${pageMaker.makeQuery(pageMaker.totalCount / cri.perPageNum) }&option=${option}"><img src="/img/front2.png"></a>
							</c:when>
							<c:otherwise>
								<a href="list${pageMaker.makeQuery(pageMaker.totalCount / cri.perPageNum+1) }&option=${option}"><img src="/img/front2.png"></a>
	
							</c:otherwise>
						</c:choose>
					</div>	
				
			</div>
		</div>
</div>
</center>
<script>
	function memberModify_go(id){
		
		//alert(id);
		$.ajax({
			url: "/admin/member/modify", //전송받을 페이지 경로
			type: "get", //데이터 읽어오는 방식
			dataType: "text", //데이터 방식
			data: "id="+id, //데이터 전달
			error:function(){ //실패일 경우
				alert("실패");
			},
			success:function(text){ //성공일 경우
				$("#result").html(text);
			}
		});
	}

function checkall() {//체크박스 전체 선택 , 해제
	if(Form1.all.checked) {
		for(i=1; i < (document.Form1.length); i++){
			document.Form1.elements[i].checked = true;
		}
	}else{
		for(i=1; i < (document.Form1.length); i++){
			document.Form1.elements[i].checked = false;
		}
	}
}

function levelAllChange(){
	var num = ${number}
	//alert(num);
	for(var i=0;i<=num;i++){
		var level = $("select[name=level]:eq("+i+")").val();
		var id = $("div[id=id]:eq("+i+")").text();
		//alert(level);
		//alert(id);
		location.href="level_ch?id="+id+"&level="+level;
	}
}

function select_delete(){
	
	var num=${number}
	//alert(num);		
	
	var list = ""; //list 선언 및 초기화
	
	var con = confirm("삭제하시겠습니까?");
	var ischecked =""; //ischecked 선언 및 초기화
	
	if(con == true){	//확인을 누르면
		
			if(num ==1){//전체 개수가 1일 경우
				
				if(document.Form1.ap_check.checked == true){//ap_check가 선택되어 있다면
						ischecked=1;//체크박스가 선택되어있다면 ischecked에 1을 담는다.
						list = $("input[name=ap_check]").val()+","; // name은 ap_check인 인풋의 value값을 list에 담는다. 
				}
			
			}else{//전체 개수가 2이상일 경우
				for(var i=0;i<num;i++){// 반복문 안의 첫번째 인덱스부터 마지막 인덱스까지 
					if(document.Form1.ap_check[i].checked == true){ //반복문안의 i번째 인덱스가 선택되어 있다면
						ischecked=1; 
						list += $("input[name=ap_check]:eq("+i+")").val()+","; 	// name은 ap_check인 i번째 인풋의 value값을 list에 추가하고 콤마(,)를 추가한다'.
						
					}
				}
			}
			
		if(ischecked==""){//선택된 상품이 없을 경우
			alert("선택된 회원이 없습니다.");
		}
			$.ajax({
				url: "/delete_id", //전송받을 페이지 경로
				type: "post", //데이터 읽어오는 방식
				dataType: "text", //데이터 방식
				data: "lists="+list, //데이터 전달 //uids 값에 list값을 전달
				error:function(){ //실패일 경우
					alert("실패");
				},
				success:function(result){ //성공일 경우
					//alert(result);
					
					
				}	
			});
			
	}else{ //취소를 누르면
		return false;
	}	
}

</script>
