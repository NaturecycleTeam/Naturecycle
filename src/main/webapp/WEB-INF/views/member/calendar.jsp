<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약을 원하시는 날짜를 선택해 주세요</title>
</head>
<script type="text/javascript">
//---------------- calendar --------------------------

//date객체 획득. 가변
var today = new Date();
//today 보조. 고정
var date = new Date();
//선택되있던 셀 객체 저장
var selectedCell;
//오늘에 해당하는 월
var realMonth = date.getMonth()+1;
var realToDay = date.getDate()
//선택된 월, 일
var selectedMonth = null;
var selectedDate = null;

//예약가능 요일 계산해 배열 (일~월, 가능0 불가능1)
<%-- const possibleDay = "<%=possibleDay%>"; --%>

//전달 달력
function prevCalendar(){
	if (today.getMonth() < realMonth){
		alert("예약은 금일기준 다음날부터 30일 이후까지만 가능합니다.");	
		return false;
	}
	today = new Date(today.getFullYear(), today.getMonth()-1, today.getDate());
	buildCalendar();
}
//다음달 달력
function nextCalendar(){
	if(today.getMonth()+1 == (realMonth + 1)){
		alert("예약은 금일기준 다음날부터 30일 이후까지만 가능합니다.");
		return false;
	}
	today = new Date(today.getFullYear(), today.getMonth()+1, today.getDate());
	buildCalendar();
}
//달력 제작 (이번달 기준)
function buildCalendar(){
	row = null;
	cnt = 0;
	firstDate = new Date(today.getFullYear(), today.getMonth(), 1);
	lastDate = new Date(today.getFullYear(), today.getMonth()+1, 0);
	//현재 참조중인 월 
	nowMonth = today.getMonth()+1;
	//이번달이면 0, 다음달이면 1 리턴
	monthEquals = thisMonth(nowMonth, realMonth);
	//달력 객체
	var calendarTable = document.getElementById("calendar");
	//달력의 타이틀 객체 획득
	var calendarTableTitle = document.getElementById("calendarTitle");
	//타이틀 수정
	calendarTableTitle.innerHTML = today.getFullYear()+"년"+(today.getMonth()+1)+"월";
	
	//테이블 초기화
	while(calendarTable.rows.length > 2){
		calendarTable.deleteRow(calendarTable.rows.length -1);
	}
	
	//셀 입력을 위해 테이블 개행
	row = calendarTable.insertRow();
	
	//달의 첫 날 전까지 빈 셀 생성
	for(i = 0; i < firstDate.getDay(); i++){
		cell = row.insertCell();
		cnt += 1;
	}
	
	//요일 입력 (셀 생성)
	for(i = 1; i <= lastDate.getDate(); i++){
		//예약하지 못하는 조건일경우 +1씩 되므로, noCount가 0일 시에만 클릭함수를 적용
		noCount = 0;
		cell = row.insertCell();
		//cell에 id 부여
		cell.setAttribute('id', i);
		cell.innerHTML = i;
		//cell.innerHTML = '<label onclick="prevCalendar()">' + i + '</label>';
		cell.align = "center";
		
		//셀 생성 후 count 증가
		cnt += 1;
		
		//cnt % 7 == 1이면 일요일이므로 빨갛게
		if (cnt % 7 == 1) {
          cell.innerHTML = "<font color=#F79DC2>" + i + "</font>";
     	 }  
        
		//일주일 입력 완료시 개행
		if (cnt % 7 == 0){
			//cnt % 7 == 0이면 토요일이므로 파랗게
			cell.innerHTML = "<font color=skyblue>" + i + "</font>";
			row = calendar.insertRow();
		}
		//예약불가일 색상변경 (오늘 이전 또는 30일 이후) 및 사용자가 직접 지정한 경우
		etp = exchangeToPosibleDay(cnt)*1;
		
		if (nowMonth == realMonth && i <= realToDay) {
			noCount +=1;
        } else if (nowMonth > realMonth && i > realToDay) {
			noCount +=1;
        } else if (possibleDay[etp] == 1){
			noCount +=1;
        }
		if (noCount > 0){
			cell.style.backgroundColor = "#E0E0E0";
			cell.innerHTML = "<font color='#C6C6C6' >" + i + "</font>";
		} else {
			cell.onclick = function(){
				selectedTimeAndTotalPriceInit();
				//선택된 날의 연, 월, 일 계산 (일자의 경우 id속성 참조)
				clickedYear = today.getFullYear();
				clickedMonth = (1 + today.getMonth());
				clickedMonth = clickedMonth >= 10 ? clickedMonth : '0' + clickedMonth;
				clickedDate = this.getAttribute('id');
				clickedDate = clickedDate >= 10 ? clickedDate : '0' + clickedDate;
				
				clickedYMD = clickedYear + "-" + clickedMonth + "-" + clickedDate;
				
				//하단에 예약일시 표시
				inputField = document.getElementById("selectedDate");
				inputField.value = clickedYMD;
				//선택된 월, 일 변수 저장
				selectedMonth = today.getMonth() + 1;
				selectedDate = this.getAttribute('id');
				
				//선택된 셀 색 변화
				if(selectedCell != null){
					selectedCell.bgColor = "#FFFFFF";
				}
				selectedCell = this;
				this.bgColor = "#fbedaa";
				//time table 생성
				timeTableMaker(today.getMonth() + 1,this.getAttribute('id'));
			}
		}
		
	}
	//예약이 가득찬 날인 경우 cell 비활성화 및 색상 변rud
	checkMonth = thisMonth(nowMonth, realMonth);
	fullDate = [];
	if(checkMonth == 0){
		fullDate = thisMonthFullDateList;
	}
	if(checkMonth == 1){
		fullDate = nextMonthFullDateList;;
	}
	for (var i = 0; i < fullDate.length; i++){
		console.log("꽉 찬날 : " + fullDate[i]);
		cell = document.getElementById(fullDate[i]);
		console.log("꽉 찬날 : " + cell.innerHTML);
		cell.style.backgroundColor = "#E0E0E0";
		cell.style.color = '#C6C6C6';
		cell.onclick = function(){};
	}
	
	//달의 마지막날 뒤 행의 빈 공간을 셀로 채우기
	if(cnt % 7 != 0){
		for(i = 0; i < 7 - (cnt % 7); i++){
			cell = row.insertCell();
		}
	}
}
//사용자가 입력한 예약불가능 일자와 대조하기 위해 0~7의 환형 계산구조
function exchangeToPosibleDay(num){
	result = num % 7;
	result -= 1;
	if (result == -1) {
		result = 6;
	}
	return result; 
}
//이번달이면 0 리턴, 다음달이면 1 리턴
function thisMonth(todayMonth, dateMonth){
	console.log("todayMonth : " + todayMonth + ", dateMonth : " + dateMonth);
	if (todayMonth*1 == dateMonth*1){
		console.log("이번달 이구요")
		return 0;
	} 
	console.log("다음달 이구요")
	return 1;
}

</script>
<body>
<div class="mainBox">
	<div class="contentBox">
		<div class="textLeft"><span style="color: #505050; font-size:40px; font-weight:700">예약하기</span>
		<div class="underline"></div></div>
		<form action="payment" method="post" name="paymentForm">
		<table id="reservation_share" align="center">
			<tr>
				<td class="top" colspan="3" align="left">공간명 ${DETAIL.title}</td>
			</tr>
			<tr>
				<td rowspan="3">
				<div class="share"><img class="sharePhoto" src="${DETAIL.filePath }"/></div></td>
				<td class="title" align="left" style="border-top:1px solid #dcdcdc;"> 공간 유형 </td>
				<c:if test="${DETAIL.category == 1 }"><td class="content" align="left" style="border-top:1px solid #dcdcdc;">휴식</td></c:if>
				<c:if test="${DETAIL.category == 2 }"><td class="content" align="left" style="border-top:1px solid #dcdcdc;">파티</td></c:if>
				<c:if test="${DETAIL.category == 3 }"><td class="content" align="left" style="border-top:1px solid #dcdcdc;">공부</td></c:if>
				<c:if test="${DETAIL.category == 4 }"><td class="content" align="left" style="border-top:1px solid #dcdcdc;">회의</td></c:if>
			</tr>
			<tr>
				<td class="title" align="left">최대 인원</td>
				<td class="content" align="left">1 ~ ${DETAIL.capacity}명</td>
			</tr>
			<tr>
				<td class="title" align="left">주소</td>
				<td class="content" align="left">${DETAIL.address1}<br>${DETAIL.address2}</td>
			</tr>
		</table>
		<table id="reservation_user">
				<tr>
					<input type="hidden" name="productName" value="${DETAIL.title}"></input>
					<input type="hidden" name="placeNo" value="${DETAIL.place_no}"></input>
					<td class="top" align="left">예약자 정보</td>
					<td class="content" align="right">
					<input type="checkbox" onclick="checkboxEvent(this)">계정과 동일</td>
				</tr>
				<tr>
					<td class="title" align="right">예약자</td>
					<td class="content" align="left"> <input type="text" id="userName" name="userName" size="20"> </td>
				</tr>
				<tr>
					<td class="title" align="right">전화번호</td>
					<td class="content" align="left"> <input type="text" id="userPhone" name="userPhone" size="20"> </td>
				</tr>
				<tr>
					<td class="title" align="right">이메일</td>
					<td class="content" align="left"> <input type="text" id="userEmail" name="userEmail" size="20"> </td>
				</tr>
				<tr>
					<td class="title" align="right">인원수</td>
					<td class="content" align="left"> <input type="text" id="capacity" name="capacity" size="20"> </td>
				</tr>
		</table>
	
		<table id="reservation_time">
			<tr>
				<td class="top" align="left">시간선택</td>
				<td class="top" align="right"><button class="btnTime" type="button" onclick="tableinit()">초기화</button></td>
			</tr>
			<tr>
				<td>
					<table id="calendar">
						<tr>
							<td align="center"><label onclick="prevCalendar()"> ◀ </label></td>
							<td colspan="5" align="center" id="calendarTitle">yyyy년 m월</td>
							<td align="center"><label onclick="nextCalendar()"> ▶ </label></td>
						</tr>
						<tr>
							<td align="center"><font color ="#F79DC2">일</td>
							<td align="center">월</td>
							<td align="center">화</td>
							<td align="center">수</td>
							<td align="center">목</td>
							<td align="center">금</td>
							<td align="center"><font color ="skyblue">토</td>
						</tr>
					</table>
				</td>
				<td>
					<table id = "timeTable">	</table>
				</td>
			</tr>
			<tr> 
				<td class="top" align="left" colspan="2">예약일시</td>
			</tr>
			<tr>
				<td class="content" colspan="2" align="left">
					<input id="selectedDate" style="border:none; width:100px"  name="selectedDate" value="" readonly="readonly" ></input>
					<input id="selectedTime" style="border:none"  name="selectedTime" value="" readonly="readonly"></input>
				</td>
			</tr>
			<tr>
				<td class="top" align="left">결제정보</td>
			</tr>
			<tr>
				<td class="content" align="left" colspan="2">
					<input id="totalPrice"  style="border:none; text-align:right; width:100px" name="totalPrice" value="" readonly="readonly">원</input>
				</td>
			</tr>
			<tr>
				<td class="content" align="left" colspan="2">
				<input id="btn_submit" type="button" value="결제하기" onclick="submitRes()"></td>
			<tr>
		</table>
		</form>
	</div>
</div>

<script type="text/javascript">buildCalendar();</script>
</body>
</html>