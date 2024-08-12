<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../include/header.jsp"%>


  <div class="tab_menu">
    <ul class="list">
      <li class="is_on">
        <a href="#tab1" class="btn" >제목1</a>
      </li>
      <li>
        <a href="#tab2" class="btn">제목2</a>
      </li>
      <li>
        <a href="#tab3" class="btn">제목3</a>
      </li>
    </ul>
    <div class="cont_area">
      <div id="tab1" class="cont" id="nature_day" style="display:block;">
        <img src="resources/imgs/nature_day.png">
      </div>
      <div id="tab2" class="cont">
      	<p>이주의 책 소개</p>
        <div class="home_card">
			<c:set var="cnt" value="0" />
			<c:set var="doneLoop" value="false" />
				<c:forEach var="pDto" items="${map[key]}" varStatus="status">
					<c:if test="${not doneLoop}">
						<c:set var="cnt" value="${cnt+1}" />
						<!-- 4배수 일 경우 줄내리고 다음포문 새로시작 - 4배수 카운트 +1 -->
						<!-- Card -->
						<%@include file="../product/card.jsp"%>
						<!-- Card End -->
						<c:if test="${cnt%4==0}">
							<c:set var="doneLoop" value="true"/>
						</c:if>
					</c:if>										
				</c:forEach>	
		</div>		
      </div>
      <div id="tab3" class="cont">
        Tab Content3
      </div>
    </div>

  </div>
</div>

<div class="home_body">
	<!-- 유효성검사 메인에서 뜨는 상품 인기,추천,신규상품이 없다면, 있다면 -->
	<c:forEach var="key" items="${key}">
		<c:if test="${map[key].size() != 0 }">
			<%-- <h3 class="mt-3">[${key}] 상품</h3> --%>
			<c:if test="${key eq 'HIT'}">
				<div class="d-flex mt-5">
					<h3>
						<b>베스트셀러</b>
					</h3>
					&nbsp;&nbsp;
					<h6 class="mt-2">이 주의 가장 인기 있는 도서를 만나보세요.</h6>
					&nbsp;&nbsp;
					<h6><a href="UspecList.do?pSpec=HIT">더보기</a></h6>
				</div>
			</c:if>
			<c:if test="${key eq 'NEW'}">
				<div class="d-flex  mt-5">
					<h3>
						<b>기대신간</b>
					</h3>
					&nbsp;&nbsp;
					<h6 class="mt-2">반디앤루니스에서 가장 먼저 만나보세요.</h6>
				</div>
			</c:if>
			<c:if test="${key eq 'RECOMMEND'}">
				<div class="d-flex mt-5">
					<h3>
						<b>오늘의 책</b>
					</h3>
					&nbsp;&nbsp;
					<h6 class="mt-2">오늘 함께할 책을 만나보세요.</h6>
				</div>
			</c:if>
			
			<div class="home_card">
				<c:set var="cnt" value="0" />
				<c:set var="doneLoop" value="false" />
					<c:forEach var="pDto" items="${map[key]}" varStatus="status">
						<c:if test="${not doneLoop}">
							<c:set var="cnt" value="${cnt+1}" />
							<!-- 4배수 일 경우 줄내리고 다음포문 새로시작 - 4배수 카운트 +1 -->
							<!-- Card -->
							<%@include file="../product/card.jsp"%>
							<!-- Card End -->
							<c:if test="${cnt%4==0}">
								<c:set var="doneLoop" value="true"/>
							</c:if>
						</c:if>										
					</c:forEach>	
			</div>		
			<c:if test="${map[key].size() == 0 }">
				<br>${key} 상품이 없습니다!!<br>
			</c:if>
		</c:if>
	</c:forEach>	
	
</div>

<script>
const tabList = document.querySelectorAll('.tab_menu .list li');
const contents = document.querySelectorAll('.tab_menu .cont_area .cont')
let activeCont = ''; // 현재 활성화 된 컨텐츠 (기본:#tab1 활성화)

for(var i = 0; i < tabList.length; i++){
  tabList[i].querySelector('.btn').addEventListener('click', function(e){
    e.preventDefault();
    for(var j = 0; j < tabList.length; j++){
      // 나머지 버튼 클래스 제거
      tabList[j].classList.remove('is_on');

      // 나머지 컨텐츠 display:none 처리
      contents[j].style.display = 'none';
    }

    // 버튼 관련 이벤트
    this.parentNode.classList.add('is_on');

    // 버튼 클릭시 컨텐츠 전환
    activeCont = this.getAttribute('href');
    document.querySelector(activeCont).style.display = 'block';
  });
}
</script>


<%@ include file="../include/footer.jsp"%>