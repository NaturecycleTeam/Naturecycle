<%@page import="com.mbc.domain.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- url "userJoinOk.do" 위치가 root에 있기때문에 "js/valid.js" -->
<script type="text/javascript" src="resources/js/valid.js" charset="utf-8"></script>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ include file="../include/header.jsp" %>  

<aside class="question">
	<ul>
		<li><a href='<c:url value="myProfile.do?id=${sessionScope.loginDTO.id}"/>'>내 정보</a></li>
		<li><a href='<c:url value="reservationInfo.do?rid_fk=${sessionScope.loginDTO.id}"/>'>예약 확인</a></li>
		<li><a href='<c:url value="question.do"/>'>문의하기</a></li>
		<li><a
			href='<c:url value="listQ.do?mid=${sessionScope.loginDTO.id}"/>'>문의사항
				확인</a></li>
		<li><a href='<c:url value="pwChange.do"/>'>비밀번호 변경</a></li>
	</ul>
</aside>

<div class="container w-50 mt-5 border shadow p-5">
	<form action="memberUpdate.do" method="post" name="joinForm">
		<h3 class="text-center">회원정보</h3>
		<input type='hidden' name='id' value='${dto.getId()}'>
		<div class="mt-3 mb-2 text-end">
			<b>${dto.getName()} 님의 회원정보</b>
		</div>
		<%-- <div class="mt-2 mb-2">
			<lable for="id">번호 (수정불가)</lable>
			<input type="text" class="form-control" id="no" name="no"
				value="${dto.no}" readonly />
		</div> --%>
		<div class="mb-2">
			<lable for="id">아이디 (수정불가)</lable>
			<input type="text" class="form-control" id="id" name="id" value="${dto.getId()}" readonly/>
		</div>
		<div class="mb-2">
			<lable for="pw">비밀번호</lable>
			<input type="password" class="form-control" id="pw" name="pw" value="${dto.getPw()}"/>
		</div>
		<div class="mb-2">
			<lable for="pwConfirm">비밀번호 확인</lable>
			<input type="password" class="form-control" id="pwConfirm" name="pwConfirm" value="${dto.getPw()}"/>
		</div>
		<div class="mb-2">
			<lable for="name">이름</lable>
			<input type="text" class="form-control" id="name" name="name" value="${dto.getName()}"/>
		</div>
		<%-- <div class="mb-2">
			<lable for="name">나이</lable>
			<input type="text" class="form-control" id="age" name="age"
				value="${dto.age}" />
		</div> --%>
		<div class="mb-2">
			<lable for="email">이메일 (수정불가)</lable>
			<input type="text" class="form-control" id="email" name="email" value="${dto.getEmail()}" readonly/>
		</div>
		<div class="mb-2">
			<lable for="tel">전화번호</lable>
			<input type="text" class="form-control" id="tel" name="tel" value="${dto.getTel()}"/>
		</div>
			

		<!----------------------------------- 주소 ----------------------------------->
		<div class="row mb-2">
			<lable for="addr">주소</lable><br>
			<div class="col-md-6">
				<input class="form-control mb-1" type="text" id="sample6_postcode" name="zipcode" value="${dto.getZipcode()}" readonly/>
			</div>
			<div class="col-md-6">
				<input class="btn btn-secondary mb-1" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
			</div>
		</div>
				<input class="form-control mb-2" type="text" id="sample6_address" name="road_addr" value="${dto.getRoad_addr()}" readonly/>
				<input class="form-control mb-2" type="text" id="sample6_detailAddress" name="detail_addr" value="${dto.getDetail_addr()}"/>

								<!-- 위에는 뷰 // 아래는 로직 -->
		<!-- 포인트 -->
		<div class="mb-2">
			<lable for="point">포인트</lable>
			<input type="text" class="form-control" id="point" name="point" value="${dto.getPoint()}"/>
		</div>
		<!----------->
		
		<div class="text-center mt-3">
			<br> <input type="button" class="btn btn-sm btn-primary" value="회원정보 수정" onclick="inputChk()" /> 
				<input type="reset" class="btn btn-sm btn-warning" value="취소" /> 
				<a href="memberList.do" class="btn btn-sm btn-info">회원 리스트</a>
				<a href="donation.do?id=${sessionScope.loginDTO.id}" class="btn btn-sm btn-info">기부금</a>
		</div>
	</form>
</div>
<%@ include file="../include/footer.jsp"%>

<script	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						if (data.userSelectedType === 'R') {
							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName
										: data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
							// 조합된 참고항목을 해당 필드에 넣는다.  -->> 참고항목을 안넣으면 주석처리
							document
									.getElementById("sample6_extraAddress").value = extraAddr;

						} else {
							// -->> 참고항목을 안넣으면 주석처리
							document
									.getElementById("sample6_extraAddress").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample6_postcode').value = data.zonecode;
						document.getElementById("sample6_address").value = addr;
						// 커서를 상세주소 필드로 이동한다.
						document
								.getElementById("sample6_detailAddress")
								.focus();
					}
				}).open();
	}
</script>
<!----------------------------------------------------------------------------------------------->
		


