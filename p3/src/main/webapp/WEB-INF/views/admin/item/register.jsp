<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
    
<link rel="stylesheet" type="text/css" href ="/css/admin/adminHeader.css"> 
<link rel="stylesheet" type="text/css" href ="/css/admin/register.css">  
 <%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
 

<center>

<div class="menuContainer" >
	<div><%@ include file="/WEB-INF/views/admin/include/left_side.jsp" %></div>
	<div class="sideContainer">
		<div class="title">
			<span >상품등록</span><br>
			<span style="width:800px;border-bottom: 1px solid black"></span>
		</div>
		<form name="register" action="/admin/item/register" method="post" onsubmit ="return register_go()" enctype="multipart/form-data">
			<div class="registerContainer">
				<div class="itemSubject">
					<div class="itemName">상품 종류 :</div>
					<div class="itemContent">
						<select name="itemtype" class="inputStyle">
							<option value="lighting">Lighting AETHER</option>
							<option value="rope">SmartRope</option>
						</select>
					</div>
				</div>
				<div class="itemSubject">
					<div class="itemName">상품 이미지 :</div>
					<div class="itemContent"><input  multiple="multiple" type="file"  id="file1" name="file" ></div>
				</div>
				<div class="itemSubject">
					<div class="detailName">상세 이미지</div>
					<div class="detailContent">
						<input  multiple="multiple" type="file"  id="file2" name="file" >
						<input  multiple="multiple" type="file"   name="file" >
						<input  multiple="multiple" type="file"   name="file" >
						<input  multiple="multiple" type="file"   name="file" >
					</div>
				</div>
				<div class="itemSubject">
					<div class="itemName">상품명 : </div>
					<div class="itemContent"><input name="subject"  id="subject" class="inputStyle" required></div>
				</div>
				<div class="itemSubject">
					<div class="itemName">상품설명 : </div>
					<div class="itemContent"><input name="comment"  id="comment" class="inputStyle" required></div>
				</div>
				<div class="itemSubject">
					<div class="itemName">상품가격 : </div>
					<div class="itemContent"><input name="price" id="price"  class="inputStyle" required></div>
				</div>
				<div class="itemSubject">
					<div class="itemName">배송비 : </div>
					<div class="itemContent">
						<select name="deliveryfee" id="deliveryfee"  class="inputStyle" >
							<option value="0">무료</option>
							<option value="3000">3,000원</option>	
						</select>
					</div>
				</div>
				<div class="introduce">여러 색상을 등록하시고 싶으시면 콤마(,)로 구분해 주세요.</div>
				<div class="itemSubject">
					<div class="itemName">색상 : </div>
					<div class="itemContent"><input name="color"  id="color" class="inputStyle"  required></div>
				</div>
				<div class="itemSubject">
					<div class="itemName">판매자 : </div>
					<div class="itemContent"><input name="s_id"  id="s_id" class="inputStyle" value="${m_name }" readonly></div>
				</div>
				<div class="itemSubject">
					<div class="itemName">상품수량 : </div>
					<div class="itemContent"><input name="qty" id="qty"  class="inputStyle" required></div>
				</div>
				<div class="itemSubject">
					<div  class="itemName">판매여부 :</div>
					<div class="itemContent">
						<input  type="radio" name="useyn"  value="y" checked>여
						<input  type="radio" name="useyn"  value="n">부
					</div> 
				</div>
				<div><button class="registerBtn">등록</button></div>
			</div>
		</form>
	</div>
</div>	
	
</center>	

<script>

function register_go() {
	if(file1.value==''){
		alert("이미지 파일을 등록해주세요");
		return false;
		
	}
		
	document.register.submit();
}

</script>