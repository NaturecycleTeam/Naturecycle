<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../include/header.jsp" %>

<body>
<div class="container w-50 mt-5 p-5 shadow">
   <form action="memberInsert.do" method="post" onSubmit="return submitCheck()">
      <h4>회원가입</h4>
      <div class="row">
      	<div class="col-md-8 pe-0">            
     	 	<input class="form-control mb-2" type="text" name="id" id="id" placeholder="아이디" autofocus>    
     	</div>
     	<div class="col-md-4">            
     		<a class="btn btn-outline-info w-100" onclick="idCheck()">중복체크</a> 
     	</div>    
      </div>
      
      <input class="form-control mb-2" type="text" name="pw" placeholder="비밀번호">
      <input class="form-control mb-2" type="text" name="name" placeholder="이름">
      <input class="form-control mb-2" type="text" name="age" placeholder="나이">
      
      <!-- 이메일 인증 -->
      <div class="row">
      	<div class="col-md-8 pe-0">
      		<input class="form-control mb-2" type="text" id="email" name="email" placeholder="이메일">
      	</div>
      	<div class="col-md-4">
      		<input id="code-send" class="btn btn-outline-secondary w-100" type="button" onclick="emailCheck()"
      		value="인증번호발송"/>
      	</div>
      </div>
      
      <!-- 이메일 인증 확인 -->
      <div class="row" id="confirmEmail">  
      	<div class="col-md-8 pe-0 mb-2">
			<input class="input-code" type="text" id="confirmUUID" placeholder="인증코드입력"><input value="" readonly class="time">
		</div>
		<div class="col-md-4">
			<span id="confirm-btn" class="btn btn-outline-secondary w-100" onclick="emailConfirm()">인증코드확인</span>
		</div>    
      </div>
      
      <p class="code-msg"></p>
            
      <input class="form-control mb-2" type="text" name="tel" placeholder="전화번호">
      
      
      <div class="row mb-1">
      		<lable for="addr">주소</lable><br>
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
      
      
      <div class="text-center mt-3">
         <input type="submit" class="btn btn-primary" value="가입">
         <input type="reset" class="btn btn-info" value="취소">
      </div>
      
    </form>      
</div>

<!-- The Modal -->
<div class="modal fade" id="chkModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">중복체크 확인</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body" id="chkMsg"></div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>

<script>
	let responseUUID = "";
	let isEmailCheck = false;
	let isIdCheck = false;
	
	// 이메일 인증코드 발생
	function emailCheck(){
		var uEmail = $("#email").val();
		$("#code-send").addClass("disabled");
		$("#confirm-btn").removeClass("disabled");
		$(".input-code").val("");
		
		$.ajax({
			url:"<c:url value='memberEmailCheck.do'/>",
			type:"get",
			data:{"uEmail":uEmail},
			success:function(uuid){
				if(uuid != "fail"){
					console.log("이메일 인증코드 : " + uuid);
					responseUUID = uuid;
					 	                                                                                                 
					/* $("#confirmEmail").html('<div class="col-md-8 pe-0">'
				      		+'<input class="form-control mb-2" type="text" id="confirmUUID" placeholder="인증코드입력">'
				      		+'</div>'
				          	+'<div class="col-md-4">'
				          	+'<span class="btn btn-outline-secondary w-100" onclick="emailConfirm()">인증코드확인</span></div>'
				     );  */
				     
				     $("#confirmEmail").css({"visibility": "visible", "height":"auto"});
				     $(".code-msg").css({"display":"block", "color":"green"});
				     $(".code-msg").text("인증코드가 발송되었습니다!!");
				     timer_start();
				     
				}else{
					alert("이메일을 다시 확인하세요!!")
					$("#email").select();
				}
			},
			error:function(){
				alert("이메일 인증 실패!!");
				$("#email").select();
			}
		});
	}
	
	// 이메일 인증코드 확인여부 체크
	function emailConfirm(){
		let confirmUUID = $("#confirmUUID").val();
		
		if(confirmUUID == null || confirmUUID == ""){
			// alert("이메일 확인코드를 입력하세요");
			$(".code-msg").css({"display":"block","color":"red"});
	        $(".code-msg").text("인증코드를 다시 확인하세요!!");
			$("#confirmUUID").select();
			return;
		}else if(confirmUUID == responseUUID){
			// alert("이메일 인증 성공");
			$(".code-msg").css({"display":"block","color":"green"});
	        $(".code-msg").text("이메일 인증 성공!!");
	        timer_stop();
	        time_display.val("");
	        $("#confirm-btn").addClass("disabled");
	        $("#code-send").removeClass("disabled");
	        $("#code-send").val("코드 재발송");
	        isEmailCheck = true;			
		}else{ // 인증코드를 잘못 입력한 경우
			// alert("인증코드를 다시 확인하세요!!");
			$(".code-msg").css({"display":"block","color":"red"});
	        $(".code-msg").text("인증코드를 다시 확인하세요!!");
			$("#confirmUUID").select();
			return;
		}
				
	}
	
	/* timer
		timer = setInterval(function, 1000) : 1초마다 function을 호출하는 함수
		clearInterval(timer) : timer 함수를 종료시킴
	*/
	
	// time 표시 변수
	let time_display;
	// timer 변수
	let timer;
		
	function timer_start(){
		let count = 180;
		
		time_display = $(".time");
		// time_display.val("03:00")
		
		timer = setInterval(()=>{
			let minutes = parseInt(count/60); // 정수 변환
			let secounds = parseInt(count%60);
			
			minutes = minutes < 10 ? "0"+minutes : minutes;
			secounds = secounds < 10 ? "0"+secounds : secounds;
			
			time_display.val(minutes + ":" + secounds)
			
			// count 다운
			if(--count < 0){
				// 타이머 종료
				timer_stop();
				time_display.val("시간초과");
				 $(".code-msg").css({"display":"block", "color":"red"});
			     $(".code-msg").text("인증코드 만료되었습니다!!");
			     $("#confirm-btn").addClass("disabled");
			     $("#code-send").removeClass("disabled");
			     $("#input-code").val("");			     
			}
			
			
		}, 1000);			
	}
	function timer_stop(){
		clearInterval(timer);		
	}
	
	
	// submit 조건(아이디 중복확인, 이메일 인증) 만족 여부 체크
	function submitCheck(){
		if(!isEmailCheck){
			alert("이메일 인증확인을 해주세요!!");
			$("#email").select();
			return false;
		}
		
		if(!isIdCheck){
			alert("아이디 중복확인을 해주세요!!");
			$("#id").select();
			return false;
		}
		return true;
	}
	
	// 아이디 체크
	function idCheck(){
		
		$("#chkModal").modal("show");
		
		let uid = $("#id").val();  // 사용자가 입력한 아이디
		
		$.ajax({
			url : "<c:url value='memberIdCheck.do'/>",
			type : "get",
			data : {"uid": uid},  // 서버에 전송할 데이터
			success : function(responseData){
				if(responseData == "yes"){
					// alert("사용가능한 아이디 입니다!!");
					$("#chkMsg").text("사용가능한 아이디 입니다!!");
					$("#chkMsg").css({"color":"blue","font-size":"13px"});
					isIdCheck = true;
				}else{
					// alert("이미 존재하는 아이디 입니다!!");
					$("#chkMsg").text("이미 존재하는 아이디 입니다!!");
					$("#chkMsg").css({"color":"red","font-size":"13px"});
				}
				$("chkModal").modal("show");
			},
			error : function(){
				alert("서버 에러입니다!!");
			}
		});
		
	}	
</script>

<%@ include file="../include/footer.jsp" %>