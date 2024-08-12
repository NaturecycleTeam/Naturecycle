<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/ad_header.jsp"%>


<%-- <aside class="question">
	<ul>
		<li><a href='<c:url value="myProfile.do"/>'>내 정보</a></li>
		<li><a href='<c:url value="question.do"/>'>문의하기</a></li>
		<li><a href='<c:url value="listQ.do?mid=${sessionScope.loginDTO.id}"/>'>문의사항 확인</a></li>
		<li><a href='<c:url value="pwChange.do"/>'>비밀번호 변경</a></li>
	</ul>
</aside> --%>

<div class="question_checkList">
	<h4>문의사항 확인</h4>

	<table class="table">
		<thead class="table-dark">
			<tr>
				<th>제목</th>
				<th>문의사항</th>
				<th>글쓴이</th>
				<th>등록일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="dto" items="${qList}">
				<tr>
					<td><c:out value="${dto.subject}" /></td>
					<td>${dto.contents}</td>
					<td>${dto.writer}</td>
					<td>${dto.reg_date}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

</div>

<%@ include file="../include/ad_footer.jsp"%>