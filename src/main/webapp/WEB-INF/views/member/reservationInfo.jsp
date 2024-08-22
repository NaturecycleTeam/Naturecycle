<%@ page import="com.mbc.domain.ReservationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header.jsp"%>

<%-- <%
	ReservationDTO rDto = (ReservationDTO)request.getAttribute("rDto");
%> --%>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<div class="container w-50 mt-5 border shadow p-5">
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
				</tr>			
			</thead>
			<tbody>
				<c:forEach var="dto" items="${list}"> 
					<tr>
						<td>${dto.rid}</td>
						<td>${dto.date}</td>
						<td>${dto.time}</td>
						<td>${dto.contents}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>	
</div>

<%@ include file="../include/footer.jsp"%>