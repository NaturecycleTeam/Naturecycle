<%@page import="com.mbc.domain.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header.jsp"%>

<aside class="question">
	<ul>
		<li><a href='<c:url value="myProfile.do"/>'>내 정보</a></li>
	</ul>
</aside>

<div class="container w-50 mt-5 border shadow p-5">
	<form action="donation.do" method="post">
		<%-- <h3 class="text-center">기부하기</h3>
		<div class="mt-3 mb-2 text-end">
			<b>${dto.getName()} 님의 포인트</b>
		</div>
		<div class="mb-2">
			<label for="point">현재포인트</label>
			<input type="text" class="form-control" id="cur_point" name="cur_point" value="${dto.getPoint()}" />
		</div>
		<div class="mb-2">
			<label for="id">아이디</label>
			<input  type="text" class="form-control" id="id" name="id" value="${sessionScope.loginDTO.id}" />
		</div>
		<div class="mb-2">
			<label for="point">기부포인트</label>
			<input type="text" class="form-control" id="point" name="point" value="" placeholder="기부하실 금액을 입력하세요" />
		</div>
		<div class="text-center mt-3">
			<a href="donation.do?id=${sessionScope.loginDTO.id}" class="btn btn-sm btn-info">기부하기</a>
		</div> --%>

		<h3 class="text-center">기부하기</h3>
		<div class="mt-3 mb-2 text-end">
			<b>${dto.getName()} 님의 포인트</b>
		</div>
		<div class="mb-2">
			<label for="id"></label> 
				<input type="hidden" class="form-control" id="id" name="id" value="${dto.getId()}"/>
		</div>
		<div class="mb-2">
			<label for="cur_point">현재 포인트</label> 
				<input type="text" class="form-control" id="cur_point" name="cur_point" value="${dto.getPoint()}" readonly />
		</div>
		<div class="mb-2">
			<label for="point">기부 포인트</label> 
				<input type="number"class="form-control" id="point" name="point" placeholder="기부하실 포인트를 입력하세요" required />
		</div>
		<div class="text-center mt-3">
			<button type="submit" class="btn btn-sm btn-info">기부하기</button>
		</div>
	</form>
</div>

<%@ include file="../include/footer.jsp"%>