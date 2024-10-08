<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>

<!-- 자바스크립트 불러오기 --> 
<script type="text/javascript" src="resources/js/valid.js" charset="utf-8"></script>

<body>
<div class="container w-50 mt-5 p-5 shadow">
   <form action="memberInsert.do" method="post" name="joinForm" onSubmit="return submitCheck()">
      <h4>회원가입</h4>
      
      <div class="mt-2 mb-2">
         <label for="id">아이디</label>
	       <input class="form-control mb-2" type="text" id="id" name="id" placeholder="아이디" onkeyup="idCheck()">
	     	 	<p id="chkMsg" class="mb-2"></p>
	       <input type="hidden" id="isIdCheck" value="no"> <!-- 아이디 중복체크 submit 기본값 no, 자바스크립트에서 활용 -->
	  </div>
	  
      <div class="mb-2">
         <label for="pw">비밀번호</label>
      	 	<input class="form-control mb-2" type="password" id="pw" name="pw" placeholder="비밀번호" onkeyup="pwCheck()">
      	 	<p id="chkMsg2" class="mb-2"></p>
      </div>
      
      <div class="mb-2">
         <label for="pwConfirm">비밀번호 확인</label>
        	<input class="form-control mb-2" type="password" id="pwConfirm" name="pwConfirm" placeholder="비밀번호 확인" onkeyup="pwCheck()"/>
         	<p id="chkMsg3" class="mb-2"></p>
         	<input type="hidden" id="isPwCheck" value="no">
      </div>
      
      <div class="mb-2">
         <label for="name">이름</label>
      	 	<input class="form-control mb-2" type="text" id="name" name="name" placeholder="이름">
      	 	<input type="hidden" id="isPwCheck" value="no">
      	 	<input type="hidden" id="isNameCheck" value="no">
      </div>
      
      <!-- <div class="mb-2">
         <lable for="age">나이</lable>
      		<input class="form-control mb-2" type="text" id="age" name="age" placeholder="나이">
      </div> -->
      
      <div class="mb-2">
         <label for="tel">전화번호</label>
      		<input class="form-control mb-2" type="text"id="tel" name="tel" placeholder="전화번호" onkeyup="telCheck()">
      			<p id="chkMsg4" class="mb-2"></p>
	        <input type="hidden" id="isTelCheck" value="no"> <!-- 아이디 중복체크 submit 기본값 no, 자바스크립트에서 활용 -->
      </div>
      
      <!-- 이메일 인증을 보내기 위한 내용 // 부트스트랩은 12개의 row로 나뉘어 있음 -->
         <label for="email">이메일</label>
	      <div class="row">
	      	<div class="col-md-8 pe-0"> <!-- pe-0 안쪽여백 제로 -->
	      		<input class="form-control" type="text" id="email" name="email" placeholder="이메일">
	      	</div>
	      	<div class="col-md-4">
	      		<input id="code-send" class="btn btn-outline-secondary w-100" type="button" onclick="emailCheck()" value="인증번호 발송">
	      	</div>
	      		<p class="code-msg0 mt-1 mb-1"></p>
	      </div>
	      
	      <!-- 이메일 인증을 확인하기 위한 내용 -->
	      <div class="row" id="confirmEmail"> 
		      	<div class="col-md-8 pe-0">
		      		<input class="input-code" type="text" id="confirmUUID" placeholder="인증코드 입력"><input class="time" value="" readonly>
		      	</div>
		        <div class="col-md-4">
		      		<span id="confirm-btn" class="btn btn-outline-secondary w-100" onclick="emailConfirm()">인증코드 확인</span>
		      	</div>
		      		<p class="code-msg mt-1 mb-2"></p>
	      </div>
      
 		<!----------------------------------- 주소 ----------------------------------->

      	<div class="row mb-1">
      		<label for="addr">주소</label><br>
    		<div class="col-md-6">
    			<input class="form-control mb-1" type="text" id="sample6_postcode" name="zipcode" placeholder="우편번호" readonly>
    		</div>
		    <div class="col-md-6">
				<input class="btn btn-secondary mb-1" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
			</div>
		</div>
		<input class="form-control mb-2" type="text" id="sample6_address" name="road_addr" placeholder="주소" readonly>
		<input class="form-control mb-2" type="text" id="sample6_detailAddress" name="detail_addr" placeholder="상세주소">
		<input class="form-control mb-2" type="text" id="sample6_extraAddress" name="plus_addr" placeholder="참고항목" readonly>
      
		<!-- 위에는 뷰 // 아래는 로직 -->
      	
	    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script>
		    function sample6_execDaumPostcode() {
		        new daum.Postcode({
		            oncomplete: function(data) {
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
		                if(data.userSelectedType === 'R'){
		                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있고, 공동주택일 경우 추가한다.
		                    if(data.buildingName !== '' && data.apartment === 'Y'){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                    if(extraAddr !== ''){
		                        extraAddr = ' (' + extraAddr + ')';
		                    }
		                    // 조합된 참고항목을 해당 필드에 넣는다.  -->> 참고항목을 안넣으면 주석처리
		                    document.getElementById("sample6_extraAddress").value = extraAddr;
		                
		                } else {
		                	// -->> 참고항목을 안넣으면 주석처리
		                    document.getElementById("sample6_extraAddress").value = '';
		                }
		
		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('sample6_postcode').value = data.zonecode;
		                document.getElementById("sample6_address").value = addr;
		                // 커서를 상세주소 필드로 이동한다.
		                document.getElementById("sample6_detailAddress").focus();
		            }
		        }).open();
		    }
		</script>
      <!----------------------------------------------------------------------------------------------->
      
      <div class="text-center mt-3"><br>
         <input type="submit" class="btn btn-primary" value="회원가입"> <!--  onclick="inputChk()" 대신 위에서 onSubmit="return submitChk()" 사용(같이 사용불가)-->
         <input type="reset" class="btn btn-warning" value="취소">
      </div>
   </form>
</div>

<!-- The Modal -->
<!-- <div class="modal fade" id="chkModal">
  <div class="modal-dialog">
    <div class="modal-content">

      Modal Header
      <div class="modal-header">
        <h4 class="modal-title">중복체크 확인</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      Modal body
      <div class="modal-body" id="chkMsg">
        
      </div>

      Modal footer
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div> -->

<script>

	// 아이디 중복체크
	function idCheck(){
		let uid = $("#id").val(); // 사용자 입력 아이디 가져오기
		
		if(uid.length<4){
			$("#chkMsg").text("아이디 길이는 4자리 이상이어야 합니다!!");
			$("#chkMsg").css({"color":"red", "font-size":"13px"})
			$("#isIdCheck").val("no");		// submitChk()에서 사용
			$("uid").select();
			return;
		}

		$.ajax({
			url : "<c:url value='/memberIdCheck.do'/>", // 접속할 요청주소	// DB에 들어갔다 옴
			type : "get", // 전송방식(get, post)
			data : {"uid":uid}, // 서버에 전송할 데이터
			//dataType : "json", // 서버에서 응답하는 데이터 형식
			success : function(responseData){
				//console.log(responseData);
				if(responseData == "yes"){
					//alert("사용 가능한 아이디 입니다!!");
					$("#chkMsg").text("사용 가능한 아이디 입니다!!");
					$("#chkMsg").css({"color":"blue", "font-size":"13px"})
					$("#isIdCheck").val("yes");		// submitChk()에서 사용
				} else {
					//alert("이미 존재하는 아이디 입니다!!");
					$("#chkMsg").text("사용할 수 없는 아이디 입니다!!");
					$("#chkMsg").css({"color":"red", "font-size":"13px"})
					$("#isIdCheck").val("no");		// submitChk()에서 사용
					$("id").select();
				}
				//$("#chkModal").modal("show");
			}, // 서버에서 성공적으로 요청이 수행되었을때 호출되는 함수(콜백함수)를 지정
			error : function(){alert("Server Error")} // 서버에서 요청처리를 실패했을때 처리되는 함수를 지정
		});
	}
	
	function pwCheck(){
		let upw = $("#pw").val();
		let upw2 = $("#pwConfirm").val();
		
		if(upw.length < 4){
			$("#chkMsg2").text("비밀번호 길이는 4자리 이상이어야 합니다!!");
			$("#chkMsg2").css({"color":"red", "font-size":"13px"})
			$("#isPwCheck").val("no");		// submitChk()에서 사용
			$("upw").select();
			return;
		} else {
			$("#chkMsg2").text("사용 가능한 비밀번호 입니다!!");
			$("#chkMsg2").css({"color":"blue", "font-size":"13px"})
			
			if(upw != upw2){
				$("#chkMsg3").text("비밀번호 재확인을 올바르게 해주세요!!");
				$("#chkMsg3").css({"color":"red", "font-size":"13px"})
				$("#isPwCheck").val("no");		// submitChk()에서 사용
				$("upw2").select();
				return;
			} else {
				$("#chkMsg3").text("비밀번호 재확인 완료입니다!!");
				$("#chkMsg3").css({"color":"blue", "font-size":"13px"})
				$("#isPwCheck").val("yes");		// submitChk()에서 사용
			}
		}
	}
	
	// 전화번호 중복체크
/* 	function telCheck(){
		let utel = $("#tel").val(); // 사용자 입력 아이디 가져오기
		
		if(utel.length<4){
			$("#chkMsg4").text("전화번호 길이는 4자리 이상이어야 합니다!!");
			$("#chkMsg4").css({"color":"red", "font-size":"13px"})
			$("#isTelCheck").val("no");		// submitChk()에서 사용
			$("utel").select();
			return;
		}

		$.ajax({
			url : "<c:url value='/memberTelCheck.do'/>", // 접속할 요청주소	// DB에 들어갔다 옴
			type : "get", // 전송방식(get, post)
			data : {"utel":utel}, // 서버에 전송할 데이터
			//dataType : "json", // 서버에서 응답하는 데이터 형식
			success : function(responseData){
				//console.log(responseData);
				if(responseData == "yes"){
					//alert("사용 가능한 아이디 입니다!!");
					$("#chkMsg4").text("사용 가능한 전화번호 입니다!!");
					$("#chkMsg4").css({"color":"blue", "font-size":"13px"})
					$("#isTelCheck").val("yes");		// submitChk()에서 사용
				} else {
					//alert("이미 존재하는 아이디 입니다!!");
					$("#chkMsg4").text("사용할 수 없는 전화번호 입니다!!");
					$("#chkMsg4").css({"color":"red", "font-size":"13px"})
					$("#isTelCheck").val("no");		// submitChk()에서 사용
					$("#tel").select();
				}
				//$("#chkModal").modal("show");
			}, // 서버에서 성공적으로 요청이 수행되었을때 호출되는 함수(콜백함수)를 지정
			error : function(){alert("Server Error")} // 서버에서 요청처리를 실패했을때 처리되는 함수를 지정
		});
	} */
	
	let time_display;
	let timer;
	// timer 동작 함수
	function timer_start(){
		timer_stop();
		
		let count = 180;
		time_display = $('.time');
		time_display.val("03:00");
		
		// 타이머 설정시 사용하는 함수 
		// timer = setInterval(function, 1000) : 1초마다 function을 주기적으로 호출
		// clearInterval(timer) : timer 함수를 종료시켜주는 역할
		timer = setInterval(()=>{
			let minutes = parseInt(count / 60);	// count/60, 10진수로 변경 // 뒤에 , 10은 생략가능
			let seconds = parseInt(count % 60);
			
			minutes = minutes < 10 ? "0" + minutes : minutes;
			seconds = seconds < 10 ? "0" + seconds : seconds;
			
			time_display.val(minutes + ":" + seconds);
			
			// timer 종료
			if(--count < 0){
				timer_stop();
				time_display.val("시간초과");
				$(".code-msg").css({"display": "block", "color" :"red"});// main.css에서도 사용되기때문에 여러개 중복으로 css가 사용될땐 {} 사용
				$(".code-msg").text("인증코드가 만료되었습니다!!");
				$("#code-send").removeClass("disabled");
				$("#code-send").val("코드 재발송");
				$("#confirm-btn").addClass("disabled");
				$(".input-code").val("");
				$(".input-code").attr("readonly", true);
				$("#email").attr("readonly", false);

			}
		}, 1000)
		
	}
	// timer 종료
	function timer_stop(){
		isEmailCheck = false;
		clearInterval(timer);
	}
	
	// 이메일 인증코드 보내기
	// 모든함수에서 사용하도록 responseUUID를 전역변수로 설정
	let responseUUID = "";
	let isEmailCheck = false; // submitChk()에서 사용, 이메일 체크확인, 기본값 false
	
	function emailCheck(){
		let uEmail = $("#email").val(); // 사용자가 입력한 이메일 id="email"

		if($("#email").val() == ""){
			$(".code-msg0").css({"color":"red", "font-size":"13px"});
			$(".code-msg0").text("이메일을 정확하게 입력하세요.");
		} else {
			$("#code-send").addClass("disabled");
			$("#confirm-btn").removeClass("disabled");
			$("#email").attr("readonly", true);
			$(".code-msg0").css({"color":"red", "font-size":"13px"});
			$(".code-msg0").text("이메일을 전송 중...");
		}
		
		$.ajax({
			url : "<c:url value='/memberEmailCheck.do'/>",
			type : "get",
			data : {"uEmail":uEmail},
			success: function(UUID){	// responseEmail 서버에서 전달된 값(return uuid 또는 return fail)
				responseUUID = UUID
				if(responseUUID != "fail"){
					//console.log("인증코드:"+ responseUUID);
/* 						$("#confirmEmail").html('<div class="col-md-8 pe-0">'
					      		+ '<input class="form-control mb-2" type="text" id="confirmUUID" placeholder="인증코드 입력"></div>'
					          	+ '<div class="col-md-4">'
					      		+ '<span class="btn btn-outline-secondary w-100" onclick="emailConfirm()">인증코드 확인</span></div>'); */
					$(".code-msg0").css({"color":"blue", "font-size":"13px"});     		
					$(".code-msg0").text("이메일 전송 완료!!");      		
					// 인증코드 이메일이 보내지고나서 타이머 시작
					$(".input-code").attr("readonly", false);
					$("#confirmEmail").css({"visibility":"visible", "height":"auto"})
					$(".code-msg").css({"display": "block", "color" :"green"});	// main.css에서도 사용되기때문에 여러개 중복으로 css가 사용될땐 {} 사용
					$(".code-msg").text("인증코드가 발송되었습니다!!");
					timer_start();
					
				} else {
					alert("이메일을 다시 확인하세요!! 처음부터 진행하세요.");
					$(".code-msg0").css({"color":"red", "font-size":"13px"});
					$(".code-msg0").text("이메일 전송 에러 1번!! 처음부터 진행하세요.");
					$("#email").select();
				}
			},
			error : function(){
				alert("메일발송 실패!! 처음부터 진행하세요.");
				$(".code-msg0").css({"color":"red", "font-size":"13px"});
				$(".code-msg0").text("2.이메일 전송 에러 2번!! 처음부터 진행하세요.");
				$("#email").select(); // 실패시 다시 이메일을 입력 할 수 있게 포커스를 주기
			}
		})
	}

	// 이메일 인증코드 일치하는지 확인
	function emailConfirm(){
		let confirmUUID = $("#confirmUUID").val();
		
		if(confirmUUID == null || confirmUUID.trim() == ""){
			alert("이메일 인증코드를 입력하세요");
			$(".code-msg").css({"display": "block", "color" :"red"});
			$(".code-msg").text("이메일 인증코드를 입력하세요");
			$("#confirmUUID").select(); // 실패시 다시 코드를 입력 할 수 있게 포커스를 주기
			isEmailCheck = false;	// submitChk()에서 사용
			return;
		} else if(responseUUID == confirmUUID){ // 서버에서 전송된 uuid(responseUUID)값과 입력한 uuid(confirmUUID)이 같은경우
			alert("이메일 인증 성공!!");
			timer_stop();
			$("#confirm-btn").addClass("disabled");
			$("#code-send").addClass("disabled");
			time_display.val("인증완료");
			$(".code-msg").css({"display": "block", "color" :"green"});
			$(".code-msg").text("이메일 인증이 완료되었습니다.");
			$(".input-code").attr("readonly", true);
			// javaScript의 readonly 속성 제어하기
			// document.querySelector(".input-code").readOnly=true;  단, O가 대문자
			
			isEmailCheck = true;	// submitChk()에서 사용
			return;
		} else {	// 인증코드를 잘못 입력한 경우
			alert("이메일 인증코드를 다시 확인하세요!!");
			$(".code-msg").css({"display": "block", "color" :"red"});
			$(".code-msg").text("이메일 인증코드를 다시 확인하세요!!");
			$("#confirmUUID").select(); // 실패시 다시 코드를 입력 할 수 있게 포커스를 주기
			isEmailCheck = false;	// submitChk()에서 사용
			return;
		}
	}
	
	// 가입버튼 누를시 onSubmit 진행
	function submitChk(){
		let isIdCheck = $("#isIdCheck").val();
		let isPwCheck = $("#isPwCheck").val();
		let isNameCheck = $("#isNameCheck").val();
		let isTelCheck = $("#isTelCheck").val();

		if(isIdCheck == "no" || isPwCheck == "no"){
			alert("아이디 중복체크 또는 비밀번호를 확인해주세요!!")
			$("#id").select();
			return false;
		}
		
		if(isTelCheck == "no"){
			alert("전화번호를 입력해주세요!!")
			$("#tel").select();
			return false;
		}
		
	 	if(!inputChk()){	// inputChk() 함수를 호출하면서 리턴값이 false일때
			alert("inputchk() 실행중");
			return false;
		}
		
		if(!isEmailCheck){
			alert("이메일 인증을 해주세요!!");
			$("#email").select();
			return false;
		}
		
		if(!isEmailCheck){
			alert("이메일 인증을 해주세요!!");
			$("#email").select();
			return false;
		}
		

		if(!isNameCheck){
			alert("이름을 입력해주세요!!");
			$("#name").select();
			return false;
		}
		
		alert("회원가입 완료~ 로그인을 진행해주세요!!");
		return true;
	}
	
</script>

<%@ include file="../include/footer.jsp" %>