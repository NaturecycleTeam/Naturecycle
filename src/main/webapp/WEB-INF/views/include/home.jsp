<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../include/header.jsp"%>

<c:if test="${requestScope.msg !=null}">
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>

<div class="home_body w-100">
   <!-- 유효성검사 메인에서 뜨는 상품 인기,추천,신규상품이 없다면, 있다면 -->
   <c:forEach var="key" items="${key}">
      <c:if test="${map[key].size() != 0 }">
         <c:if test="${key eq 'ECO'}">
            <div class="d-flex mt-5">
               <h3>
                  <b>ECO-FRIENDLY</b>
               </h3>
               &nbsp;&nbsp;
               <h6 class="mt-2">친환경 제품을 만나보세요.</h6>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <h6 class="mt-2 morebooks"><a href="UspecList.do?pSpec=ECO">+더보기</a></h6>
            </div>
         </c:if>
         <c:if test="${key eq 'ORGANIC'}">
            <div class="d-flex mt-5">
               <h3>
                  <b>ORGANIC</b>
               </h3>
               &nbsp;&nbsp;
               <h6 class="mt-2">유기농 제품을 만나보세요.</h6>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <h6 class="mt-2 morebooks"><a href="UspecList.do?pSpec=ORGANIC">+더보기</a></h6>
            </div>
         </c:if>
         <c:if test="${key eq 'REFILL'}">
            <div class="d-flex mt-5">
               <h3>
                  <b>REFILL 리필</b>
               </h3>
               &nbsp;&nbsp;
               <h6 class="mt-2">리필 제품을 만나보세요.</h6>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <h6 class="mt-2 morebooks"><a href="UspecList.do?pSpec=REFILL">+더보기</a></h6>
            </div>
         </c:if>
         
         <div class="home_card overflow-hidden" style="max-width: 100%; height: auto;">
               <c:set var="cnt" value="0" />
               <c:set var="doneLoop" value="false" />
                  <c:forEach var="pDto" items="${map[key]}" varStatus="status">
                     <c:if test="${not doneLoop}">
                        <c:set var="cnt" value="${cnt+1}" />
                        <!-- Card -->
                        <%@include file="../product/card.jsp"%>
                        <!-- Card End -->
                        <c:if test="${cnt%5==0}">  
                           <c:set var="doneLoop" value="true"/>
                        </c:if>
                     </c:if>                              
                  </c:forEach>   
             </div>      
         
         <%-- <div class="home_card">
            <c:set var="cnt" value="0" />
            <!-- 4배수 일 경우 줄내리고 다음포문 새로시작 - 4배수 카운트 -->
            <c:forEach var="pDto" items="${map[key]}">
               <c:set var="cnt" value="${cnt+1}" />
               <!-- 4배수 일 경우 줄내리고 다음포문 새로시작 - 4배수 카운트 +1 -->
               <!-- Card -->
               <%@include file="../product/card.jsp"%>
               <!-- Card End -->
               <c:if test="${cnt%4==0}">
         </div>
         <div class="home_card">
            <!-- div테그 종료/재시작, 4배수 일 경우 줄내리고 다음포문 새로시작 -->
               </c:if>
            </c:forEach>

         </div> --%>
      </c:if>
      <c:if test="${map[key].size() == 0 }">
         <br>${key} 상품이 없습니다!!<br>
      </c:if>
      <hr>
   </c:forEach>
   
</div>


<%@ include file="../include/footer.jsp"%>
