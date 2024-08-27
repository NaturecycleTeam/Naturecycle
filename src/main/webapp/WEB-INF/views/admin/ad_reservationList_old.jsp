<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<c:if test="${requestScope.msg !=null}">
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>

<%@include file="../include/ad_header.jsp" %>

<div class="container mt-5">
	<h3>예약 리스트</h3>
	<!-- 검색 -->
	<div>
		<form action="reservationList.do" id="searchForm" method="get">
			<div class="d-flex">
				<!-- 게시글 개수를 먼저 선택하고 검색할 경우 선택된 게시글 수 넘겨줌 -->
				<input type="hidden" name="cntPerPage" value="${pDto.cntPerPage}">
				<select class="form-select form-select-sm me-2" style="width:100px" 
							name="searchType">
					<option value="">선택</option>
					<option value="S" ${pDto.searchType == 'S' ? 'selected': ''}>예약대기</option>
					<option value="C" ${pDto.searchType == 'C' ? 'selected': ''}>예약확정</option>
					<option value="W" ${pDto.searchType == 'W' ? 'selected': ''}>예약취소</option>
					<%-- <option value="SC" ${pDto.searchType == 'SC' ? 'selected': ''}>제목 + 내용</option>
					<option value="SW" ${pDto.searchType == 'SW' ? 'selected': ''}>제목 + 글쓴이</option>
					<option value="SCW" ${pDto.searchType == 'SCW' ? 'selected': ''}>제목 + 내용 + 글쓴이</option> --%>
				</select>
				<%-- <input type="text" id="keyword" name="keyword" placeholder="검색어입력"
					class="form-control rounded-0 rounded-start" style="width:300px"
					value="${pDto.keyword}"> --%>
				<button class="btn rounded" style="background:#1384aa; color:white"><i class="fa fa-search"></i></button>
			</div>
		</form>
	</div>	
	
	<table class="table">
		<thead>
			<tr>
				<th>예약번호</th>					
				<th>고객 아이디</th>
				<th>예약내용</th>
				<th>날짜</th>
				<th>시간</th>	
				<th>상태</th>				
				<th>check</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${list==null}">
				<tr>
					<td>예약이 존재하지 않습니다!!</td>
				</tr>				
			</c:if>
			<c:if test="${list != null}">
			    <c:forEach var="dto" items="${list}">
			        <tr>
			            <td>${dto.rno}</td>
			            <td>${dto.rid_fk}</td>
			            <td>${dto.contents}</td>                
			            <td>${dto.date}</td>
			            <td>${dto.time}</td>
			            <td>${dto.reservationStatus.getValue()}</td>                    
			            <td>
			                <!-- 예약 상태가 PENDING일 때 -->
			                <c:if test="${dto.reservationStatus == 'PENDING'}"> 
			                    <a href="reservationConfirmed.do?rno=${dto.rno}" class="btn btn-sm btn-info">예약확정</a>
			                    <a href="reservationCancel.do?rno=${dto.rno}" class="btn btn-sm btn-danger">예약취소</a>
			                </c:if>
			                <!-- 예약 상태가 PENDING이 아닐 때 -->
			                <c:if test="${dto.reservationStatus != 'PENDING'}">   
			                    <a href="reservationCancel.do?rno=${dto.rno}" class="btn btn-sm btn-danger">예약취소</a>
			                </c:if>
			            </td>
			        </tr>
			    </c:forEach>
			</c:if>
		</tbody>
	</table> 
	
	<!-- ----------------------페이지 네이션------------------------- -->
	<ul class="pagination justify-content-center">
	  <li class="page-item ${pDto.prevPage <=0 ? 'disabled':''}">
	  	<a class="page-link" href="list.do?viewPage=${pDto.prevPage}&searchType=${pDto.searchType}&cntPerPage=${pDto.cntPerPage}">이전</a>
	  </li>
	  
	  <c:forEach var="i" begin="${pDto.blockStart}" end="${pDto.blockEnd}">
		  <li class="page-item ${pDto.viewPage == i ? 'active':''}">
		  	<a class="page-link" href="list.do?viewPage=${i}&searchType=${pDto.searchType}&cntPerPage=${pDto.cntPerPage}">${i}</a>
		  </li>
	  </c:forEach>
	  
	  <li class="page-item ${pDto.blockEnd >= pDto.totalPage ? 'disabled':''}">
	  	<a class="page-link" href="list.do?viewPage=${pDto.nextPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}">다음</a>
	  </li>
	</ul>	
</div>

<script type="text/javascript">
	// $("#btn-write").click(function(){})
	/* $("#btn-write").click(()=>{
		location.href="<c:url value='register.do'/>";
	}); */
	
	$("#cntPerPage").change(()=>{
		var cntVal = $("#cntPerPage").val();
		/* alert(cntVal); */
		
		location.href="reservationList.do?viewPage=1&searchType=${pDto.searchType}&cntPerPage="+cntVal;
	});
</script>

<%@include file="../include/ad_footer.jsp" %>







