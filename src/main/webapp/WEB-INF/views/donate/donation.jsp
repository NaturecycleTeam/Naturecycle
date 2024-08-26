<%@page import="com.mbc.domain.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header.jsp"%>


<div class="container w-50 mt-5 border shadow p-5">
	<form action="donation.do" method="post">

		<h3 class="text-center">기부하기</h3>
		<div class="mt-3 mb-2 text-end">
			<b>${dto.name} 님의 포인트</b>
		</div>
		<div class="mb-2">
			<label for="id"></label> 
				<input type="hidden" class="form-control" id="id" name="id" value="${dto.id}"/>
		</div>
		<div class="mb-2">
			<label for="cur_point">현재 포인트</label> 
				<input type="text" class="form-control" id="cur_point" name="cur_point" value="${dto.point}" readonly />
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