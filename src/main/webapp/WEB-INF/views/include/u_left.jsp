<%-- <%@page import="java.util.ArrayList"%> --%>
<%-- <%@page import="util.ProdSpec"%>
<%@page import="model.CategoryDTO"%>
<%@page import="model.CategoryDAO"%>
<%@page import="model.BrandDAO"%>
<%@page import="model.BrandDTO"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	li>a{
		color:black;
	}
	
	h4 {
		color:#8f654e;
	}
</style>

<!-- 카테고리 -->
<aside class="border-end sticky-top" style="width:250px;">

	<h4><b>카테고리</b></h4>
		<ul>
			<c:if test="${categoryList.size() != 0}">
				<c:forEach var="dto" items="${categoryList}">
					 <li><a href="UcatList.do?cat_num=${dto.cat_num}&code=${dto.code}&cat_name=${dto.cat_name}">${dto.cat_name}</a></li>
			   	</c:forEach>
			</c:if>
			<c:if test="${categoryList.size() == 0}">
				<li>카테고리 없음</li>
			</c:if>
		</ul>
	<ul class='mt-3'><br></ul>
	
	<!-- <h4>스펙별 상품</h4> -->
	<div class="d-flex">
		<h4><b>스펙별 상품</b></h4>&nbsp;<h6><span class="badge bg-danger mt-1">HOT</span></h6>
	</div>
		<ul>
			<c:forEach var="spec" items="${pdSpecs}">
				<li>
					<a href="UspecList.do?pSpec=${spec.name()}">${spec.value} 상품</a>
                </li>									
          	</c:forEach>
		</ul>
	<ul class='mt-3'><br></ul>
	
	<%-- <h4>브랜드</h4>
		<ul>
			<c:if test="${brandlist.size() != 0}">
				<c:forEach var="dto" items="${brandlist}">
					 <li><a href="UbrandList.do?brand_num=${dto.brand_num}&brand_code=${dto.brand_code}&brand_name=${dto.brand_name}">${dto.brand_name}</a></li>
			   	</c:forEach>
			</c:if>
			<c:if test="${blist.size() == 0}">
				<li>브랜드 없음</li>
			</c:if>
		</ul> --%>
	
	<ul class='mt-3'><br></ul>
	<%--
	<div class="d-flex">
		<h4>스펙별 상품</h4>&nbsp;<h6><span class="badge bg-danger mt-1">HOT</span></h6>
	</div>
	
	<ul>
	<%	ProdSpec[] pdSpecs = ProdSpec.values();
		
		for(ProdSpec ps : pdSpecs){
			pageContext.setAttribute("ps", ps);
		%>
			<li>
				<a href="specList.do?pSpec=${ps.name()}">${ps.value} 상품</a>
			</li>
		<%} // for
		
		out.print("</ul><ul class='mt-3'><br>");   // 카테고리 인기상품 띄어쓰기%>
	</ul>
	
	<h4>브랜드</h4>
	<ul>
		<%
		BrandDAO bDao = BrandDAO.getInstance();
		ArrayList<BrandDTO> bDtos = bDao.brandList();
		
		if(bDtos.size() != 0) {
			//System.out.println(bDtos.size());
			
			for(BrandDTO bDto : bDtos) {
				String brandName = bDto.getBrandName();
				String brandCode = bDto.getBrandCode();				
				
				// 바인딩
				pageContext.setAttribute("brandName", brandName);
				pageContext.setAttribute("brandCode", brandCode);
			%>	
				<li><a href="ubrandList.do?brandCode=${brandCode}&brandName=${brandName}">${brandName}</a></li>
			<%}						// ?code=${code} 파라미터값으로 brandList.do여기서 code를 처리할수있도록 진행
		} else {
			out.print("<li>카테고리 없음</li>");
		}
		out.print("</ul><ul class='mt-3'><br>");   // 카테고리 인기상품 띄어쓰기
		//out.print("</ul><ul class='border-bottom'><br>");   // 가로라인
		out.print("</ul><ul class='mt-3'><br>");   // 카테고리 인기상품 띄어쓰기
		%>
	</ul> --%>
	
	<!-- <h4><a class="text-black" href="boardList.do" style="text-decoration:none">고객센터</a></h4> -->
	<h4><b>고객센터</b></h4>
	<ul>
		<li><a href="boardList.do">공지사항</a></li>
		<li><a href="boardList.do">자주묻는질문</a></li>
		<li><a href="boardList.do">1:1 문의</a></li>
		<li><a href="boardList.do">서비스센터 안내</a></li>
	</ul>
</aside>


