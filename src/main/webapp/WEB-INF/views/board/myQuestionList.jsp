<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<style>
.myQuestionInfo li {
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
	<div class="myQuestionInfo">
		<ul>
			<li><a href='<c:url value="myProfile.do?id=${sessionScope.loginDTO.id}"/>'>내 정보</a></li>
			<li><a href='<c:url value="reservationInfo.do?rid_fk=${sessionScope.loginDTO.id}"/>'>예약 확인</a></li>
			<li><a href='<c:url value="myQuestion.do?mid_fk=${sessionScope.loginDTO.id}"/>'>문의하기</a></li>
			<li><a
				href='<c:url value="myQuestionList.do?mid_fk=${sessionScope.loginDTO.id}"/>'>문의사항
					확인</a></li>
			<li><a href='<c:url value="pwChange.do"/>'>비밀번호 변경</a></li>
		</ul>
	</div><hr>
	
	<div class="container w-75 p-5">
		<h4>문의사항 확인</h4>
	
		<table class="table">
			<thead class="table-dark">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>조회수</th>
					<th>글쓴이</th>
					<th>등록일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dto" items="${questionPosts}">
					<tr>
						<td>${dto.bid}</td>
						<td><a href='<c:url value="view.do?bid=${dto.bid}
							&viewPage=${pDto.viewPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}
							&cntPerPage=${pDto.cntPerPage}"/>'><c:out value="${dto.subject}"/> <b>[${dto.replyCnt}]</b> </a></td>
						<td>${dto.hit}</td>
						<td>${dto.writer}</td>
						<td>${dto.reg_date}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<%@ include file="../include/footer.jsp"%>