<%@ page import="com.mbc.domain.ReservationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header.jsp"%>

<%-- <%
	ReservationDTO rDto = (ReservationDTO)request.getAttribute("rDto");
%> --%>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style>
#datepicker {
    padding-right: 30px; /* Add space for the icon inside the input */
}

.ui-datepicker-trigger {
    position: relative;
    left: 155px; /* Adjust this value based on the input width */
    bottom: 33px;
    cursor: pointer; /* Make the icon clickable */
}
</style>

<div class="container w-50 mt-5 border shadow p-5">
	<form action="reservation.do" method="post">
		<h3 class="text-center">예약하기</h3>
		<div class="mb-2">
			<label for="rid">아이디</label> 
				<input type="text" class="form-control" id="id" name="rid" value="${sessionScope.loginDTO.id}" />
		</div>
		<div class="mb-2">
		    <label for="date">예약날짜</label>
		    <input type="text" class="form-control" id="datepicker" name="date" style="width: 150px;" placeholder="예약일 선택" onkeyup="dateCheck()"/>
		    <p id="chkMsgDate" class="mb-2"></p>
		    <input type="hidden" id="isDateCheck" value="no"> <!-- 아이디 중복체크 submit 기본값 no, 자바스크립트에서 활용 -->
		</div>
		
		<div class="mb-2">
		    <label for="time">예약시간</label>
		    <table>
		        <tr>
		            <td><p class="form-control time-select" id="time1">10:00</p></td>
		            <td><p class="form-control time-select" id="time2">11:00</p></td>
		            <td><p class="form-control time-select" id="time3">12:00</p></td>
		            <td><p class="form-control time-select" id="time4">13:00</p></td>
		        </tr>
		        <tr>
		            <td><p class="form-control time-select" id="time5">14:00</p></td>
		            <td><p class="form-control time-select" id="time6">15:00</p></td>
		            <td><p class="form-control time-select" id="time7">16:00</p></td>
		            <td><p class="form-control time-select" id="time8">17:00</p></td>
		        </tr>
		    </table>
		    <input type="text" class="form-control" id="selectedTime" name="time" onkeyup="timeCheck()" readonly />
		    <p id="chkMsgTime" class="mb-2"></p>
		    <input type="hidden" id="isTimeCheck" value="no"> <!-- 아이디 중복체크 submit 기본값 no, 자바스크립트에서 활용 -->
		</div>
		
		<div class="mb-2">
		    <label for="contents">요청사항</label>
		    <textarea rows="5" cols="50" name="contents" placeholder="추가 요청사항을 입력하세요"></textarea>
		</div>
		
		<div class="text-center mt-3">
		    <button type="submit" class="btn btn-sm btn-info" onclick="handleSubmit()">예약하기</button>
		</div>
	</form>
</div>

<script>
	

   $(function() {
       //input을 datepicker로 선언
       $("#datepicker").datepicker({
           dateFormat: 'yy-mm-dd' //달력 날짜 형태
           ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
           ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
           ,changeYear: true //option값 년 선택 가능
           ,changeMonth: true //option값  월 선택 가능                
           ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
           ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
           ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
           ,buttonText: "선택" //버튼 호버 텍스트              
           ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
           ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
           ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
           ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
           ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
           ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
           ,maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
       });                    
       
       //초기값을 오늘 날짜로 설정해줘야 합니다.
       /* $('#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후) */            
   });
</script>

<!-- 선택 예약시간 -->
<script>
    // Add event listeners to all time-select paragraphs
    document.querySelectorAll('.time-select').forEach(function(element) {
        element.addEventListener('click', function() {
            // Set the selected time in the input field with id="selectedTime"
            document.getElementById('selectedTime').value = this.textContent;

            // Optional: Highlight the selected time
            document.querySelectorAll('.time-select').forEach(function(el) {
                el.style.backgroundColor = ""; // Reset background color for all
            });
            this.style.backgroundColor = "#d0e6ff"; // Highlight selected time
        });
    });
</script>

<script>
	//시간 중복체크
	function dateCheck(){
		let chkDate = $("#date").val(); 
	
		$.ajax({
			url : "<c:url value='/reservationTimeCheck.do'/>", // 접속할 요청주소	// DB에 들어갔다 옴
			type : "get", // 전송방식(get, post)
			data : {"date":chkDate}, // 서버에 전송할 데이터
			//dataType : "json", // 서버에서 응답하는 데이터 형식
			success : function(responseData){
				//console.log(responseData);
				if(responseData == "no"){
					
					// 띄우면 안됨(시간선택 불가)
					
					
					$("#chkMsg").css({"color":"blue", "font-size":"13px"})
					
				} else {
					// 시간 선택 가능하도록 표시
				}
				
			}, 
			error : function(){alert("Server Error")} 
		});
	}
	
	
</script>

<%@ include file="../include/footer.jsp"%>