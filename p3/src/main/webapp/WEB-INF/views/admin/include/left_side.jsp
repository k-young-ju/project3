<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href ="/css/admin/adminIndex.css">    
    
<div class="menuList">
	<dl>
		<dt>회원관리</dt>
			<li onclick="location.href='/admin/member/join'" id="menu1">회원추가</li>
			<li onclick="location.href='/admin/member/list'" id="menu2">회원목록</li>
			<li onclick="" class="liInfo" id="menu3" id="menu3">회원별 포인트</li>
	</dl>
</div>
<div class="menuList">
	<dl>
		<dt>상품관리</dt>
			<li onclick="location.href='/admin/item/register'" id="menu4">상품등록</li>
			<li onclick="location.href='/admin/item/list'" id="menu5">상품목록</li>
			<li onclick="location.href='/admin/item/jjim_list'"  id="menu6" >관심상품목록</li>
	</dl>
</div>
<div class="menuList">
	<dl>
		<dt>주문관리</dt>
			<li onclick=""  id="menu7">주문처리</li>
			<li onclick=""  id="menu8">배송처리</li>
			<li onclick=""  id="menu9">배송완료 처리</li>
			<li onclick="" id="menu10">주문취소 처리</li>
	</dl>
</div>
<div class="menuList">
	<dl>
		<dt>장바구니관리</dt>
			<li onclick="location.href='/admin/cart/list'" id="menu11">장바구니목록</li>
	</dl>
</div>
<div class="menuList">
	<dl>
		<dt>리뷰관리</dt>
			<li onclick="location.href='/admin/review/list'" id="menu12">리뷰목록</li>
	</dl>
</div>
<div class="menuList">
	<dl>
		<dt>게시물 관리</dt>
			<li onclick="location.href='/admin/notice/list?option=faq'" id="menu13">faq목록</li>
			<li onclick="location.href='/admin/notice/list?option=qna'" id="menu14">문의목록</li>
			<li onclick="location.href='/admin/notice/list?option=gongji'" id="menu15">공지목록</li>
			
	</dl>
</div>
<div class="menuList">
	<dl>
		<dt>배송주소록관리</dt>
			<li onclick="" id="menu16">고객별 주소록</li>
	</dl>
</div>
<div class="menuList">
	<dl>
		<dt>쿠폰 관리</dt>
			<li onclick="" id="menu17">쿠폰목록</li>
	</dl>
</div>
<script>

$(function(){
	$('li').click(function(){
		$('li').removeClass()
			$(this).addClass('on');
	})
})

var menu = "${menu}";
//alert(menu);
if(menu != ''){
	$('li').removeClass()
	$("#"+menu).addClass('on');
}
</script>