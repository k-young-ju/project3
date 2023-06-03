<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
    
<link rel="stylesheet" type="text/css" href ="/css/admin/adminHeader.css"> 
<link rel="stylesheet" type="text/css" href ="/css/admin/itemModify.css">  
 <%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
  
<center>
<div class="menuContainer" >
	<div><%@ include file="/WEB-INF/views/admin/include/left_side.jsp" %></div>
	<div class="sideContainer">
		<div class="title">
			<span >상품수정</span><br>
			<span style="width:800px;border-bottom: 1px solid black"></span>
		</div>
		<form name="modify" action="/admin/item/modify" method="post"  enctype="multipart/form-data">
			<input type="hidden" name="uid" value="${oneItem.uid} ">
			<div class="modifyContainer">
				<div class="itemSubject">
					<div class="itemName">상품 종류 :</div>
					<div class="itemContent">
						<select name="itemtype" class="inputStyle">
							<option value="lighting" <c:if test="${oneItem.itemtype =='lighting' }">checked</c:if>>Lighting AETHER</option>
							<option value="rope" <c:if test="${oneItem.itemtype =='rope' }">checked</c:if>>SmartRope</option>
						</select>
					</div>
				</div>
				<div class="introduce">아래의 이미지는 등록되어 있는 이미지이며, 새로등록한 이미지는 보이지않습니다.</div>
				<div class="itemSubject">
					<div class="itemName">상품 이미지 :</div>
					<div class="itemContent">
						<c:if test="${oneItem.file1 !=null}"><img src="/upload/${oneItem.file1 }" class="imgSize"></c:if>
						<input  multiple="multiple" type="file"  id="file1" name="file"  value="${oneItem.file1 }">
					</div>
				</div>
				
				<div class="itemSubject">
					<div class="detailFileName">상세 이미지</div>
					<div class="detailFileContent">
						<c:if test="${oneItem.file2 !=null}"><img src="/upload/${oneItem.file2 }" class="imgSize"></c:if>
						<input  multiple="multiple" type="file"  id="file2" name="file" value="${oneItem.file2 }">
						<c:if test="${oneItem.file3 !=null}"><img src="/upload/${oneItem.file3 }" class="imgSize"></c:if>
						<input  multiple="multiple" type="file"   name="file"  value="${oneItem.file3 }">
						<c:if test="${oneItem.file4 !=null}"><img src="/upload/${oneItem.file4 }" class="imgSize"></c:if>
						<input  multiple="multiple" type="file"   name="file" value="${oneItem.file4 }">
						<c:if test="${oneItem.file5 !=null}"><img src="/upload/${oneItem.file5 }" class="imgSize"></c:if>
						<input  multiple="multiple" type="file"   name="file" value="${oneItem.file5 }">
					</div>
				</div>
				<div class="itemSubject">
					<div class="itemName">상품명 : </div>
					<div class="itemContent"><input name="subject"  id="subject" class="inputStyle" value="${oneItem.subject }" required></div>
				</div>
				<div class="itemSubject">
					<div class="itemName">상품설명 : </div>
					<div class="itemContent"><input name="comment"  id="comment" class="inputStyle" value="${oneItem.comment }" required></div>
				</div>
				<div class="itemSubject">
					<div class="itemName">상품가격 : </div>
					<div class="itemContent"><input name="price" id="price"  class="inputStyle" value="${oneItem.price }" required></div>
				</div>
				<div class="itemSubject">
					<div class="itemName">배송비 : </div>
					<div class="itemContent">
						<select name="deliveryfee" id="deliveryfee"  class="inputStyle" >
							<option value="0" <c:if test="${oneItem.deliveryfee ==0 }">selected</c:if>>무료</option>
							<option value="3000" <c:if test="${oneItem.deliveryfee ==3000 }">selected</c:if>>3,000원</option>	
						</select>
					</div>
				</div>
				<div class="introduce">여러 색상을 등록하시고 싶으시면 콤마(,)로 구분해 주세요.</div>
				<div class="itemSubject">
					<div class="itemName">색상 : </div>
					<div class="itemContent"><input name="color"  id="color" class="inputStyle"  value="${oneItem.color }"required></div>
				</div>
				<div class="itemSubject">
					<div class="itemName">판매자 : </div>
					<div class="itemContent"><input name="s_id"  id="s_id" class="inputStyle" value="${oneItem.s_id }" readonly></div>
				</div>
				<div class="itemSubject">
					<div class="itemName">상품수량 : </div>
					<div class="itemContent"><input name="qty" id="qty"  class="inputStyle"  value="${oneItem.qty }" required></div>
				</div>
				<div class="itemSubject">
					<div  class="itemName">판매여부 :</div>
					<div class="itemContent">
						<input  type="radio" name="useyn"  value="y" <c:if test="${oneItem.useyn =='y' }">checked</c:if>>여
						<input  type="radio" name="useyn"  value="n" <c:if test="${oneItem.useyn =='n' }">checked</c:if>>부
					</div> 
				</div>
				<div><button class="modifyBtn">수정</button></div>
			</div>
		</form>
	</div>
</div>		
</center>	
<<script>

var msg = "${msg}";

if(msg != ''){
	alert(msg);
}
</script>
