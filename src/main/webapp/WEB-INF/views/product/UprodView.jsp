<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../include/header.jsp" %>	
<!-- u_left ==>> 상품클릭시 또는 u_메인에서 상품클릭시~~~ 나타나는 것, ""상품 상세정보"" -->

<div class="w-75 ps-5">
	<h3>[${pSpecName}] 상품정보</h3><br>
	<ul class="d-flex" style="list-style:none">
		<!-- 상품이미지 -->
		<li class="me-5">
			<img src="<c:url value="/resources/fileRepo/${pDto.pimage}"/>" width="220px"/>
		</li>
		<!-- 상품 상세내용 -->
		<li>
			<form name="prodForm" method="post">
				상품번호 : ${pDto.pnum}<br>
				상품이름 : ${pDto.pname}<br>
				상품가격 : <fmt:formatNumber value="${pDto.price}"/><br> <!-- 천단위로 변경 -->
				상품포인트 : <fmt:formatNumber value="${pDto.point}"/><br> <!-- 천단위로 변경 -->
				상품수량 : <input type="text" name="pqty" size=3 value="1"/>개<br>
							
				<p class="mt-3"><b>[상품 소개]</b><br>
					${pDto.pcontent}
				</p>
				<!-- 로그인이 되어있을경우 -->
			    <c:if test="${sessionScope.loginDTO.id != null}">
			    	<a href="javascript:goCart(${pDto.pnum})"
			    		class="btn btn-sm btn-primary">장바구니 담기</a>
			    </c:if>
			    <!-- 로그인이 안되어있을경우 -->
			    <c:if test="${sessionScope.loginDTO.id == null}">
			    	<a href="javascript:alert('로그인이 필요합니다')"
			    		 class="btn btn-sm" style="background:#e9dccf; color:#8f654e">장바구니 담기</a>
			    </c:if>		
<!-- 			<a href="javascript:history.back()" 
					class="btn btn-sm btn-outline-primary">계속 쇼핑하기</a>  -->
				<a href="<c:url value="/"/>" 
					class="btn btn-sm btn-outline-primary">계속 쇼핑하기</a>			
			</form>
		</li>
	</ul>

</div>

<script>
	function goCart(pnum){
		document.prodForm.action="addCart.do?pnum="+pnum;
		document.prodForm.submit();
	}
</script>

<%@ include file="../include/footer.jsp" %>
