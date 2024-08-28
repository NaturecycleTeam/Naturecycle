<%@ page import="com.mbc.domain.ReservationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header.jsp"%>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style>
.reservationInfo li {
    display: inline; /* Aligns list items in a row */
    margin-right: 20px; /* Adds space between list items */
}

/* .myprofile li:hover{
	color: white;
	background: #30622f;
}
 */
</style>

<div class="container w-75 p-5">
	<div class="reservationInfo">
		<ul>
			<li><a href='<c:url value="myProfile.do?id=${sessionScope.loginDTO.id}"/>'>내 정보</a></li>
			<li><a href='<c:url value="reservationInfo.do?rid_fk=${sessionScope.loginDTO.id}"/>'>예약 확인</a></li>
			<li><a href='<c:url value="myQuestion.do?mid_fk=${sessionScope.loginDTO.id}"/>'>문의하기</a></li>
			<li><a href='<c:url value="myQuestionList.do?mid_fk=${sessionScope.loginDTO.id}"/>'>문의사항 확인</a></li>
		</ul>
	</div><hr>
	
	<div class="container w-75 p-5">
		<form action="reservation.do" method="post">
			<h3 class="text-center">예약 시스템</h3>
		</form>
		<div>
			<b>예약정보</b>
			<table class="table">
				<thead class="table-dark">
					<tr>
						<th>아이디</th>
						<th>예약날짜</th>
						<th>예약시간</th>
						<th>요청사항</th>
						<th>예약상태</th>					
					</tr>			
				</thead>
				<tbody>
					<c:forEach var="dto" items="${list}">
						<tr>
							<td>${dto.rid_fk}</td>
							<td>${dto.date}</td>
							<td>${dto.time}</td>
							<td>${dto.contents}</td>
							<td>${dto.reservationStatus.getValue()}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>	
	</div>
</div>
<%@ include file="../include/footer.jsp"%>