<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>spring study</title>
<meta charset='utf-8'>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.6.0/css/all.css">
<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css' rel='stylesheet'>
<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js'></script>
<link href="<c:url value="/resources/css/main.css"/>" rel="stylesheet" />


</head>

<style>
ul {
	list-style: none; /* - 삭제 */
}

li>a {
	text-decoration: none; /* 밑줄 삭제 */
}
</style>

<body>
	<nav style="z-index:2">
		<div class="container">
			<ul class="navbar-nav w-100">
				<c:if test="${sessionScope.loginDTO.id == null}">
					<li class="nav-item ms-auto d-flex ">
						<a class="nav-link register" href="<c:url value="memberRegister.do"/>">회원가입</a>&nbsp;&nbsp;&nbsp;
						<a class="nav-link login" href="<c:url value="login.do"/>">로그인</a>&nbsp;&nbsp;&nbsp;
						<div class="dropdown">
						  <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown">회원안내</button>
						  <ul class="dropdown-menu">
						    <li><a class="dropdown-item" href="#">신규가입 혜택</a></li>
   							<li><a class="dropdown-item" href="#">멤버쉽 혜택</a></li>
						    <li><a class="dropdown-item" href="#">제휴상품권 결제</a></li>
						  </ul>
						</div>&nbsp;&nbsp;&nbsp; 						
						<a class="nav-link cs"	href="<c:url value="list.do"/>">문의하기</a>
					</li>
				</c:if>

				<c:if test="${sessionScope.loginDTO.id != null}">
					<li class="nav-item ms-auto my-auto d-flex">
						<p class="me-3 welcome my-auto"><i class="fa fa-user-circle">&nbsp;</i>${sessionScope.loginDTO.id}님 환영합니다!!</p>&nbsp;&nbsp;&nbsp; 
						<%-- <a class="nav-link"	href="<c:url value="myProfile.do?no=${sessionScope.loginDTO.no}"/>">내정보관리</a>&nbsp;&nbsp;&nbsp; --%> 
						<a class="nav-link login" href="<c:url value="javascript:logout()"/>">로그아웃</a>&nbsp;&nbsp;&nbsp; 
						<div class="dropdown">
						  <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown">회원안내</button>
						  <ul class="dropdown-menu">
						    <li><a class="dropdown-item" href="#">신규가입 혜택</a></li>
   							<li><a class="dropdown-item" href="#">멤버쉽 혜택</a></li>
						    <li><a class="dropdown-item" href="#">제휴상품권 결제</a></li>
						  </ul>
						</div>&nbsp;&nbsp;&nbsp; 						
						<a class="nav-link cs"	href="<c:url value="list.do"/>">고객센터</a>					
					</li>
				</c:if>				
			</ul>
		</div>
	</nav>
	<nav class="navbar navbar-expand-sm sticky-top" style="z-index:2">
	
		<div class="container">
			<ul class="navbar-nav w-100">
				<li class="nav-item">
					<a class="nav-link" href="<c:url value="userMainForm.do"/>" style="width:300px; color:green"><h2>NATURE CYCLE</h2></a>
				</li>
				<li class="nav-item my-auto">
					<form action="prodSearch.do" id="searchForm" method="post">
					<div class="container d-flex ms-5">			
						<%-- <select class="form-select form-select-sm me-1" style="width: 100px"
							name="searchType">
							<option value="">선택</option>
							<option value="S" ${dto.searchType == 'S' ? 'selected': ''}>책제목</option>
							<option value="C" ${dto.searchType == 'C' ? 'selected': ''}>카테고리</option>
							<option value="W" ${dto.searchType == 'W' ? 'selected': ''}>출판사</option>
							<option value="SC" ${dto.searchType == 'SC' ? 'selected': ''}>책제목 + 카테고리</option>
							<option value="SW" ${dto.searchType == 'SW' ? 'selected': ''}>책제목 + 출판사</option>
							<option value="SCW" ${dto.searchType == 'SCW' ? 'selected': ''}>책제목 + 카테고리 + 출판사</option>
						</select> --%>
						<input type="hidden" id="searchType" name="searchType" value="S">
						<input type="text" id="keyword" name="keyword" placeholder="검색어입력" class="form-control search" value="${pDto.keyword}">
						<button class="search_btn" id="search_btn"><i class="fa fa-search"></i></button>
					</div>
					</form>
				</li>				
				<li class="nav-item w-100 d-flex" style="position: relative">
					
					<%-- <c:if test="${sessionScope.loginDTO.id == null}"> --%>
					<c:if test="${sessionScope.loginDTO.id == null}">
						<p class="shoppingcart_count">0</p>
						<a class="nav-link shoppingcart" href="javascript:alert('로그인이 필요합니다!!')"><i class="fas fa-shopping-cart ps-1"></i></a>&nbsp;&nbsp;				
					</c:if>
					<c:if test="${sessionScope.loginDTO.id != null}">
						<c:if test="${sessionScope.cartPqty == null}">
							<p class="shoppingcart_count">0</p>
						</c:if>
						<c:if test="${sessionScope.cartPqty != null}">
							<p class="shoppingcart_count">${sessionScope.cartPqty}</p>
						</c:if>
						<a class="nav-link shoppingcart" href="<c:url value="cartList.do"/>"><i class="fas fa-shopping-cart ps-1"></i></a>&nbsp;&nbsp;
					</c:if>
					
					<a class="nav-link myinfo" href="<c:url value="myProfile.do"/>"><i class="fas fa-user-edit ps-2"></i></a>&nbsp;&nbsp;			
				</li>
							
			</ul>
		</div>
	
	</nav>	
	<nav class="navbar navbar-expand-sm">

	 	<div class="container">
		    <ul class="navbar-nav w-100">	   	
				<div class="dropdown">
				  	<button type="button" class="btn dropdown-toggle" data-bs-toggle="dropdown"><img src="resources/imgs/menu.png"></button>
					<ul class="dropdown-menu">					
						<c:if test="${categoryList.size() != 0}">
						<div class="ms-3 mt-1">
							<p6><b>도서</b></p6>
						</div>
							<div class="d-flex">
								<div class="mb-2">		
									<c:set var="cnt" value="0" />								   
									<!-- <h class="mt-1 mb-2 ms-2"><b>도서</b></h>	 -->								
									<c:forEach var="dto" items="${categoryList}">									
										<c:set var="cnt" value="${cnt+1}" />
										<li><a class="dropdown-item" href="UcatList.do?cat_num=${dto.cat_num}&code=${dto.code}&cat_name=${dto.cat_name}">${dto.cat_name}</a></li>							   		
										<c:if test="${cnt%9==0}">
									</div>
								<div class="mb-2">
										</c:if>	
									</c:forEach>						   	
								   	
								</div>	
							</div>
						</c:if>
						<c:if test="${categoryList.size() == 0}">
							<li>카테고리 없음</li>
						</c:if>			
					</ul>										    	
				</div>&nbsp;&nbsp;&nbsp; 	  
			  
			    <li class="nav-item">
			      <a class="nav-link" href="UspecList.do?pSpec=STUDY"><b>제품</b></a>
			    </li>&nbsp;&nbsp;&nbsp; 
			   <li class="nav-item">
			      <a class="nav-link" href="UspecList.do?pSpec=HIT"><b>리사이클</b></a>
			    </li>&nbsp;&nbsp;&nbsp; 
			    <li class="nav-item">
			      <a class="nav-link" href="UspecList.do?pSpec=NEW"><b>업사이클</b></a>
			    </li>&nbsp;&nbsp;&nbsp; 
			    <li class="nav-item">
			      <a class="nav-link" href="#"><b>이벤트/혜택</b></a>
			    </li>&nbsp;&nbsp;&nbsp; 
			    <li class="nav-item">
			      <a class="nav-link" href="UspecList.do?pSpec=RECOMMEND"><b>캠페인</b></a>
			    </li>
		  </ul>
	  </div>	
	</nav><hr>
	
	<script type="text/javascript">
		function logout() {
			location.href = "<c:url value='logout.do'/>";
		}		
	</script>	
	

	<main>
		<!-- <div class="container mt-5 d-flex" id="main"> -->
		<div class="wrap">
			<%-- <%@ include file="u_left.jsp"%> --%>

			<!-- </header> -->