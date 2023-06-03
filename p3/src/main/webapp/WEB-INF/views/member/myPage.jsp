<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" type="text/css" href ="/css/mypage.css">
<center>
	<div style="height:100px;"></div>
	<div class="title">
		<span >마이페이지</span><br>
		
	</div>
	<div style="height: 50px;"></div>
	<div class="myPageFisrtContainer">
		<div  class= "conincontainer" >
		<div  class= "conincon1" >
			<div class="item1">가용적립금</div>
			<div class="item1">사용적립금</div>
			<div class="item1">쿠폰</div>
		</div>
		<div class= "conincon2">
			<div class="item2" >${memberPoint }원</div>
			<div class="item2" >${usepoint }원</div>
			<div class="item2" >${countCoupon }개</div>
		</div>
		<div class= "conincon3">
			<div class="item3" style="padding-top: 5px;"><input type="button" value="조회" class="itemBtn" onclick="location.href='/member/point_list'"> </div>
			<div class="item3" style="padding-top: 20px;"><input type="button" value="조회" class="itemBtn" onclick="location.href='/coupon/list'"></div>
		</div>
		<div  class= "conincontainer2" >
			<div  class= "conincon1" >
				<div class="item1">총적립금</div>
				<div class="item1">총 주문</div>
			</div>
			<div class= "conincon2">
			<div class="item2" >${totalOrderPoint }원</div>
			<div class="item2" >${totalOrderPrice }원</div>
		</div>
		</div>
	</div>
	</div>
	
	<div style="height:30px;"></div>
		
	<div class="myPageSecondContainer">
		<div class="secondContainerTitle" align="left">
		<span class="spanItem" >나의 주문 처리현황</span>
		</div>
		<div class="secondContainerCommnet">
			<div class="commentItem">
				<div class="itemInItem">입금확인중</div>
				<div class="itemInitemNum">${countOrder1 }</div>
			</div>
			<div class="commentItem">
				<div class="itemInItem">배송준비중</div>
				<div class="itemInitemNum">${countOrder2 }</div>
			</div>
			<div class="commentItem">
				<div class="itemInItem">배송중</div>
				<div class="itemInitemNum">${countOrder3 }</div>
			</div>
			<div class="commentItem">
				<div class="itemInItem">배송완료</div>
				<div class="itemInitemNum">${countOrder4 }</div>
			</div>
			<div class="commentItem">
				<div class="itemInItem">
					<span class="cancleEtc">취소 : </span><span class="cancleEtc">${countOrder5 }</span>
				</div>
			</div>
		</div>
	</div>
	
	<div style="height:30px;"></div>
	
	<div class="thirdContainer">
		<div class="thirdContainerItemTop">
			<div class="thirdContainerItemImg"><img src= "/img/orderIcon.png" style="width:60px;heigth:60px;"></div>
			<div><a href="/order/list"><b>Order</b><br>주문내역 조회</a></div>
			<div class="ItemComment">고객님께서 주문하신 상품의 <br>주문내역을 확인하실 수 있습니다.</div>
		</div>
		<div class="thirdContainerItemTop">
			<div class="thirdContainerItemImg"><img src= "/img/profileIcon.png" style="width:80px;height:60px;"></div>
			<div><a href="modify"><b>Profile</b><br>회원 정보</a></div>
			<div class="ItemComment">회원이신 고객님의 개인정보를 <br>관리하는 공간입니다.</div>
		</div>
		<div class="thirdContainerItemTop">
			<div class="thirdContainerItemImg"><img src= "/img/jjimIcon.png" style="width:70px;height:60px;"></div>
			<div><a href="/item/jjim_list"><b>Wishlist</b><br>관심 상품</a></div>
			<div class="ItemComment">관심상품으로 등록하신 <br>상품의 목록을 보여드립니다.</div>
		</div>
		<div class="thirdContainerItemTop">
			<div class="thirdContainerItemImg"><img src= "/img/pointIcon.png" style="width:60px;height:60px;"></div>
			<div><a href="/member/point_list"><b>Mileage</b><br>적립금</a></div>
			<div class="ItemComment">적립금은 상품 구매 시 <br>사용하실 수 있습니다.</div>
		</div>
		<div class="thirdContainerItemBottom">
			<div class="thirdContainerItemImg"><img src= "/img/couponIcon.png" style="width:70px;height:60px;"></div>
			<div><a href="/coupon/list"><b>Coupon</b><br>쿠폰</a></div>
			<div class="ItemComment">고객님이 보유하고 계신 <br>쿠폰 내역을 보여드립니다.</div>
		</div>
		<div class="thirdContainerItemBottom">
			<div class="thirdContainerItemImg"><img src= "/img/noticeIcon.png" style="width:60px;height:60px;"></div>
			<div><a href="/notice/my_notice"><b>Board</b><br>게시물 관리</a></div>
			<div class="ItemComment">고객님께서 작성하신 게시물을<br>관리하는 공간입니다.</div>
		</div>
		<div class="thirdContainerItemBottom">
			<div class="thirdContainerItemImg"><img src= "/img/addrPlaceIcon.png" style="width:70px;height:60px;"></div>
			<div><a href="/addr/list"><b>Address</b><br>배송 주소록 관리</a></div>
			<div class="ItemComment">자주 사용하는 배송지를 등록하고<br>관리하실 수 있습니다.</div>
		</div>
	</div>
	
	<div style="height:30px;"></div>
</center>	

<%@ include file="/WEB-INF/views/include/footer.jsp" %>