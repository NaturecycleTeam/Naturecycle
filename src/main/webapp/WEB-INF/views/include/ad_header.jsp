<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<header>	
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <div class="container-fluid">
    <ul class="navbar-nav mx-5 w-75">
      <li class="nav-item">
        <a class="nav-link active" href="<c:url value="/"/>">ShopHOME</a>
      </li>	
      <li class="nav-item">
        <a class="nav-link active" href="<c:url value="adminMain.do"/>">관리자HOME</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="catInput.do">카테고리 등록</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="catList.do">카테고리 리스트</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="prodInput.do">상품등록</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="prodList.do">상품리스트</a>
      </li> 
       <li class="nav-item">
        <a class="nav-link" href="memberList.do">회원리스트</a>
      </li> 
      <li class="nav-item">
        <a class="nav-link" href="listQT.do">일대일문의사항</a>
      </li> 
      <!-- ms-auto: 왼쪽마진 자동, me-auto:오른쪽마진 자동 -->
      <li class="nav-item ms-auto my-auto">
      	<c:if test="${sessionScope.adLoginDTO.ad_name != null}">
        	<sapn class="text-white">${sessionScope.adLoginDTO.ad_name}님 환영합니다!!</span>
        </c:if>
      	<c:if test="${sessionScope.adLoginDTO.ad_name == null}">
        	<a class="text-white" href="adminLogin.do">로그인</a>
        </c:if>
      	<c:if test="${sessionScope.adLoginDTO.ad_name != null}">
        	<a class="text-white" href="adminLogout.do">로그아웃</a>
        </c:if>
      </li> 
           
    </ul>
  </div>
</nav>
</header>
</body>







