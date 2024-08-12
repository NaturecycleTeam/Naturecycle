<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>


<aside class="question">
	<ul>
		<%-- <li><a href='<c:url value="myProfile.do"/>'>내 정보</a></li> --%>
		<li><a href='<c:url value="question.do"/>'>문의하기</a></li>
		<li><a href='<c:url value="listQ.do?mid=${sessionScope.loginDTO.id}"/>'>문의사항 확인</a></li>
		<li><a href='<c:url value="pwChange.do"/>'>비밀번호 변경</a></li>
	</ul>
</aside>


<div class="container w-50 mt-5 p-5">
	<form action="question.do" method="post" >
		<h4>1:1 문의하기</h4>
		<input type="text" class="form-control" 
			id="subject" name="subject" placeholder="글제목" autofocus />
			
		<textarea class="form-control mt-2" name="contents" id="contents"
			 placeholder="글내용"></textarea>
			 
		<input type="text" class="form-control mt-2" 
			id="writer" name="writer" value="${sessionScope.loginDTO.name}"/>	
					
		<input type="text" class="form-control mt-2" 
			id="mid" name="mid" value="${sessionScope.loginDTO.id}"/>		
				
		<div class="text-cener mt-3">
			<button class="btn btn-primary">문의하기</button>			
		</div>		
	</form>
</div>

<!-- <script type="text/javascript">			
	$("#question_check").click(()=>{
		location.href='<c:url value="listQ.do?mid=${sessionScope.loginDTO.id}"/>';		
	});
</script> -->

<%@ include file="../include/footer.jsp" %>